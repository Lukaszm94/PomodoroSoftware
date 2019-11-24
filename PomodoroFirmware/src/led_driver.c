#include "led_driver.h"
#include "stm8l15x_clk.h"
#include "stm8l15x_spi.h"
#include "stm8l15x_gpio.h"
#include "stm8l15x_dma.h"
#include "config.h"

#define LED_DOT_CORRECTION_BUFFER_SIZE (9+1)
#define LED_PWM_BUFFER_SIZE (18+1)
#define LED_PWM_CHANNELS 12
#define PROGRESS_BAR_LEDS 10
#define PROGRESS_PER_LED (LED_BAR_PROGRESS_BAR_MAX_VALUE / PROGRESS_BAR_LEDS)
#define PROGRESS_BAR_BUFFER_OFFSET 2
#define PWM_MAX_VALUE 255

extern volatile uint32_t millis;
volatile uint8_t led_buffer[LED_PWM_BUFFER_SIZE];
volatile uint16_t led_pwmBuffer[LED_PWM_CHANNELS];

void led_convert2ChannelsInto3Bytes(uint16_t value1, uint16_t value2, uint8_t* buffer);
void led_sendPwmBuffer(void);

void led_initDriver(void)
{
	uint32_t waitUntil;
	uint8_t i;
	
	GPIO_Init(GPIOB, GPIO_Pin_0, GPIO_Mode_Out_PP_Low_Slow); // enable high-side LEDs transistor
	GPIO_Init(GPIOB, GPIO_Pin_4, GPIO_Mode_Out_PP_Low_Slow); // set RESET signal to LOW (enable chip)
	
	CLK_PeripheralClockConfig(CLK_Peripheral_SPI1, ENABLE);
	SPI_Init(SPI1, SPI_FirstBit_MSB, SPI_BaudRatePrescaler_4, SPI_Mode_Master, SPI_CPOL_Low, SPI_CPHA_1Edge, SPI_Direction_2Lines_FullDuplex, SPI_NSS_Soft, 0x07);
	
	CLK_PeripheralClockConfig(CLK_Peripheral_DMA1, ENABLE);
	DMA_Init(DMA1_Channel2, (uint32_t)led_buffer, (uint16_t)(&(SPI1->DR)), 2, DMA_DIR_MemoryToPeripheral, DMA_Mode_Normal, DMA_MemoryIncMode_Inc, DMA_Priority_Low, DMA_MemoryDataSize_Byte);
	SPI_DMACmd(SPI1, SPI_DMAReq_TX, ENABLE);
	DMA_GlobalCmd(ENABLE);
	
	SPI_Cmd(SPI1, ENABLE);
	GPIO_ExternalPullUpConfig(GPIOB, GPIO_Pin_5 | GPIO_Pin_6, ENABLE);
	
	led_buffer[0] = 0xC1; // Dot Correction identifier
	for(i = 1; i < LED_PWM_BUFFER_SIZE; i++) {
		led_buffer[i] = 0xFF;
	}
	DMA_Init(DMA1_Channel2, (uint32_t)led_buffer, (uint16_t)(&(SPI1->DR)), LED_DOT_CORRECTION_BUFFER_SIZE, DMA_DIR_MemoryToPeripheral, DMA_Mode_Normal, DMA_MemoryIncMode_Inc, DMA_Priority_Low, DMA_MemoryDataSize_Byte);
	DMA_Cmd(DMA1_Channel2, ENABLE);
}

void led_setBarProgress(uint16_t progress) // progress: 0 to 1500
{
	uint8_t ledsFullyOn = 0;
	uint16_t i, dimmedLedPwm;
	if(progress > LED_BAR_PROGRESS_BAR_MAX_VALUE) {
		progress = LED_BAR_PROGRESS_BAR_MAX_VALUE;
	}
	ledsFullyOn = (progress * PROGRESS_BAR_LEDS) / LED_BAR_PROGRESS_BAR_MAX_VALUE;
	for(i = 0; i < ledsFullyOn; i++) {
		led_pwmBuffer[i+PROGRESS_BAR_BUFFER_OFFSET] = PWM_MAX_VALUE;
	}
	if(ledsFullyOn == PROGRESS_BAR_LEDS) { // all LEDs fully on
		return;
	}
	dimmedLedPwm = (((uint32_t)(progress % PROGRESS_PER_LED)) * PWM_MAX_VALUE) / PROGRESS_PER_LED; // uint16_t overflow possible here
	led_pwmBuffer[ledsFullyOn+PROGRESS_BAR_BUFFER_OFFSET] = dimmedLedPwm;
	for(i = (ledsFullyOn+1); i < PROGRESS_BAR_LEDS; i++) {
		led_pwmBuffer[i+PROGRESS_BAR_BUFFER_OFFSET] = 0;
	}
	
	led_sendPwmBuffer();
}

/**
  * @brief  converts PWM values (uint16_ts ranged 0-4095 - located in led_pwmBuffer) into AS1122 register values
  * @retval None
  */
//FIXME: this function is accessing memory outside led_buffer!!! (overwrites millis value)
void led_sendPwmBuffer(void)
{
	uint8_t i;
	//return;
	led_buffer[0] = 0xC2; // PWM packet identifier
	
	for(i = 0; i < (LED_PWM_CHANNELS/2); i++) {
		uint8_t index1 = i*2;
		uint8_t index2 = i*2 + 1;
		uint8_t* led_buffer_address = led_buffer + LED_PWM_BUFFER_SIZE - 3 * (i+1);
		led_convert2ChannelsInto3Bytes(led_pwmBuffer[index2], led_pwmBuffer[index1], led_buffer_address); // lower PWM channels foes into higher addredd area
	}
	while(DMA_GetFlagStatus(DMA1_FLAG_BUSY2) == SET); // wait for previous DMA transfer to finish
	DMA_Init(DMA1_Channel2, (uint32_t)led_buffer, (uint16_t)(&(SPI1->DR)), LED_PWM_BUFFER_SIZE, DMA_DIR_MemoryToPeripheral, DMA_Mode_Normal, DMA_MemoryIncMode_Inc, DMA_Priority_Low, DMA_MemoryDataSize_Byte);
	DMA_Cmd(DMA1_Channel2, ENABLE);
}

void led_setModeLeds(uint16_t greenLedPwm, uint16_t redLedPwm)
{
	led_pwmBuffer[10] = redLedPwm;
	led_pwmBuffer[11] = greenLedPwm;
	
	//led_pwmBuffer[10] = redLedPwm;
	//led_pwmBuffer[11] = greenLedPwm;
	led_sendPwmBuffer();
}

void led_test(uint8_t channelNo)
{
	uint16_t i;
	for(i = 0; i < LED_PWM_CHANNELS; i++) {
		if(i == channelNo) {
			led_pwmBuffer[i] = PWM_MAX_VALUE;
		} else {
			led_pwmBuffer[i] = 0;
		}
	}
	led_sendPwmBuffer();
}

/**
  * @brief  Converts 12-bit PWM values of two channels into 3 byte buffer
  * @param  value1 first PWM value (ranges 0 to 4095).
	* @param  value2 second PWM value (ranges 0 to 4095).
  * @param  buffer pointer to three byte buffer into which PWM values are put
  * @retval None
  */
void led_convert2ChannelsInto3Bytes(uint16_t value1, uint16_t value2, uint8_t* buffer)
{
	uint8_t firstNibble, secondNibble;
	
	//first and last bytes are easy to calculate
	buffer[0] = (uint8_t)((value1 & 0x0FF0) >> 4);
	buffer[2] = (uint8_t)(value2 & 0x00FF);
	
	firstNibble = (uint8_t)((value1 & 0x000F) << 4);
	secondNibble = (uint8_t)((value2 & 0x0F00) >> 8);
	buffer[1] = firstNibble | secondNibble;
}
