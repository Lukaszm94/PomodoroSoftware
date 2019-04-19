/* Includes ------------------------------------------------------------------*/
#include "stm8l15x.h"

/** @addtogroup STM8L15x_StdPeriph_Template
  * @{
  */

// global variables (used in main program flow and interrupts)
volatile uint32_t millis;

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
#define UART_BAUDRATE 57600
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/

/* Private functions ---------------------------------------------------------*/

/*static inline*/ void delay_ms(uint16_t ms) {
    uint32_t i;
    for (i = 0; i < ((2000000UL / 18000UL) * ms); i++) {
			#asm
			nop
			#endasm
		}
}

void configTIM2(void)
{
	CLK_PeripheralClockConfig(CLK_Peripheral_TIM2, ENABLE); // enable passing clock to TIM2 module
	TIM2_TimeBaseInit(TIM2_Prescaler_1, TIM2_CounterMode_Up, 2000); // setup time-base
	TIM2_ITConfig(TIM2_IT_Update, ENABLE); // setup interrupts
	TIM2_Cmd(ENABLE);
	enableInterrupts(); // global interrupts enable
}

void configUSART(void)
{
	CLK_PeripheralClockConfig(CLK_Peripheral_USART1, ENABLE);
	USART_Init(USART1, UART_BAUDRATE, USART_WordLength_8b, USART_StopBits_1, USART_Parity_No, USART_Mode_Tx);
	USART_Cmd(USART1, ENABLE);
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


/**
  * @brief  Main program.
  * @param  None
  * @retval None
  */
void main(void)
{
	delay_ms(100);
	GPIO_Init(GPIOE, GPIO_Pin_5, GPIO_Mode_Out_PP_Low_Slow);
	GPIO_Init(GPIOE, GPIO_Pin_7, GPIO_Mode_Out_PP_Low_Slow);
	configTIM2();
	configUSART();
	
  /* Infinite loop */
  while (1)
  {
		GPIO_WriteBit(GPIOE, GPIO_Pin_5, SET);
		delay_ms(100);
		GPIO_WriteBit(GPIOE, GPIO_Pin_5, RESET);
		delay_ms(100);
		serialSendStringBlocking("Hello!\n\r");
  }
}

#ifdef  USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t* file, uint32_t line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
