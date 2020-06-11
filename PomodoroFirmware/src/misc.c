#include "misc.h"
#include "config.h"
#include "stm8l15x_adc.h"
#include <string.h>

extern volatile uint32_t millis;

void configUSART(void)
{
	CLK_PeripheralClockConfig(CLK_Peripheral_USART1, ENABLE);
	USART_Init(USART1, UART_BAUDRATE, USART_WordLength_8b, USART_StopBits_1, USART_Parity_No, USART_Mode_Tx);
	USART_Cmd(USART1, ENABLE);
}

void configADC(void)
{
	CLK_PeripheralClockConfig(CLK_Peripheral_ADC1, ENABLE);
	ADC_Init(ADC1, ADC_ConversionMode_Single, ADC_Resolution_12Bit, ADC_Prescaler_2);
	ADC_Cmd(ADC1, ENABLE);
	ADC_ChannelCmd(ADC1, ADC_Channel_0, ENABLE);
	//ADC_ITConfig(ADC1, ADC_IT_EOC, ENABLE);
	
}

uint16_t readADCBlocking(void)
{
	uint32_t timeout = 0;
	ADC_SoftwareStartConv(ADC1);
	timeout = getMillis() + 10;
	while(ADC_GetFlagStatus(ADC1, ADC_FLAG_EOC) == RESET) {
		if(getMillis() > timeout) {
			serialSendStringBlocking("ADC TIMEOUT\n\r");
			return 0;
		}
	}
	return ADC_GetConversionValue(ADC1);
}

uint16_t readBatteryVoltage(void)
{
	uint32_t adcVoltage = (readADCBlocking() * (uint32_t)VCC_VOLTAGE_MV) / 4096; // [mV]
	uint16_t batteryVoltage = (BAT_DIV_R1 + BAT_DIV_R2) * adcVoltage / BAT_DIV_R2;
	return batteryVoltage;
}

// call only from non-ISR code
uint32_t getMillis(void)
{
	uint32_t millisLocal = millis;
	disableInterrupts();
	millisLocal = millis;
	enableInterrupts();
	return millisLocal;
}

void log_timestamp(void)
{
	serialSendStringBlocking("[");
	log_u32(millis);
	serialSendStringBlocking("]: ");
}

void log_int(int n)
{
	char buffer[16];
	itoa(n, buffer);
	serialSendStringBlocking(buffer);
}

void log_u32(uint32_t n)
{
	char buffer[16];
	u32toa(n, buffer);
	serialSendStringBlocking(buffer);
}

void serialSendByteBlocking(uint8_t byte)
{
	while(USART_GetFlagStatus(USART1, USART_FLAG_TXE) != SET);
	USART_SendData8(USART1, byte);
}

void serialSendStringBlocking(char *buffer)
{
	while(*buffer != 0x00) {
		serialSendByteBlocking(*buffer);
		buffer++;
	}
}



// source: https://en.wikibooks.org/wiki/C_Programming/stdlib.h/itoa
/* itoa:  convert n to characters in s */
void itoa(int n, char s[])
{
	 int i, sign;

	 if ((sign = n) < 0)  /* record sign */
			 n = -n;          /* make n positive */
	 i = 0;
	 do {       /* generate digits in reverse order */
			 s[i++] = n % 10 + '0';   /* get next digit */
	 } while ((n /= 10) > 0);     /* delete it */
	 if (sign < 0)
			 s[i++] = '-';
	 s[i] = '\0';
	 reverse(s);
}

void u32toa(uint32_t n, char s[])
{
	 int i;
	 i = 0;
	 do {       /* generate digits in reverse order */
			 s[i++] = n % 10 + '0';   /* get next digit */
	 } while ((n /= 10) > 0);     /* delete it */
	 s[i] = '\0';
	 reverse(s);
}
 
/* reverse:  reverse string s in place */
void reverse(char s[])
{
	 int i, j;
	 char c;

	 for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
			 c = s[i];
			 s[i] = s[j];
			 s[j] = c;
	 }
}