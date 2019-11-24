/* Includes ------------------------------------------------------------------*/
#include "stm8l15x.h"
#include "led_driver.h"
#include "interrupt_manager.h"
#include "pomodoro_timer.h"
#include "config.h"
#include "misc.h"
#include "button.h"

/** @addtogroup STM8L15x_StdPeriph_Template
  * @{
  */
	
#define LED_PWM_CHANNELS 12
// global variables (used in main program flow and interrupts)
volatile uint32_t millis;
extern volatile uint16_t led_pwmBuffer[LED_PWM_CHANNELS];

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
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

void configTIM2(void) // 1ms timer
{
	millis = 0;
	CLK_PeripheralClockConfig(CLK_Peripheral_TIM2, ENABLE); // enable passing clock to TIM2 module
	// f_interrupt = f_clk / (prescaler * (period-1))
	TIM2_TimeBaseInit(TIM2_Prescaler_16, TIM2_CounterMode_Up, 10000); // setup time-base, interrupt every 10ms
	TIM2_ITConfig(TIM2_IT_Update, ENABLE); // setup interrupts
	TIM2_Cmd(ENABLE);
	enableInterrupts(); // global interrupts enable
}

/**
  * @brief  Main program.
  * @param  None
  * @retval None
  */
void main(void)
{
	uint16_t progress = 0;
	uint8_t i = 0;
	CLK_SYSCLKDivConfig(CLK_SYSCLKDiv_1); // 16MHz
	delay_ms(100);
	GPIO_Init(GPIOA, GREEN_LED_PIN, GPIO_Mode_Out_PP_Low_Slow);
	GPIO_Init(GPIOE, DEBUG_1_CHANNEL_PIN, GPIO_Mode_Out_PP_Low_Slow);
	GPIO_Init(GPIOE, DEBUG_2_CHANNEL_PIN, GPIO_Mode_Out_PP_Low_Slow);
	GPIO_Init(GPIOE, DEBUG_3_CHANNEL_PIN, GPIO_Mode_Out_PP_Low_Slow);
	configTIM2();
	configUSART();
	configButton();
	led_initDriver();
	PM_init();
	//led_setBarProgress(1500);
	
	//led_test();
	/*for(i = 1; i < LED_PWM_CHANNELS; i++) {
		led_pwmBuffer[i] = 0x00;
	}*/
  /* Infinite loop */
  while (1)
  {
		//led_setBarProgress(progress);
		/*for(i = 1; i < LED_PWM_CHANNELS; i++) {
			led_pwmBuffer[i] = 0x0FFF;
			led_pwmBuffer[i-1] = 0x0000;
			led_sendPwmBuffer();
			delay_ms(5000);
		}
		led_pwmBuffer[LED_PWM_CHANNELS-1] = 0x0000;
		led_pwmBuffer[0] = 0x0FFF;
		led_sendPwmBuffer();
		delay_ms(5000);*/
		
		progress = (progress+10) % 1500;
		GPIO_WriteBit(GPIOA, GREEN_LED_PIN, SET);
		delay_ms(100);
		GPIO_WriteBit(GPIOA, GREEN_LED_PIN, RESET);
		delay_ms(100);
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
