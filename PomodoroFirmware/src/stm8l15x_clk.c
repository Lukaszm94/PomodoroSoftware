/**
  ******************************************************************************
  * @file    stm8l15x_clk.c
  * @author  MCD Application Team
  * @version V1.6.1
  * @date    30-September-2014
  * @brief   This file provides firmware functions to manage the following 
  *          functionalities of the clock controller (CLK) peripheral:
  *           - Internal/external clocks, CSS and CCO configuration
  *           - System clocks configuration
  *           - Peripheral clocks configuration
  *           - CSS on LSE configuration 
  *           - Low power clock configuration  
  *           - Interrupts and flags management
  *
  *  @verbatim
  *               
  *          ===================================================================
  *                               CLK specific features
  *          ===================================================================
  *    
  *          After reset the device is running from Internal High Speed oscillator
  *          divided by 8 (HSI/8 = 2MHz) with all peripherals off.
  *           - The clock for all peripherals is switched off, except for the BootROM 
  *             clock used for bootloader, in which case, the software should be properly 
  *             written to switch off that clock after the bootloader execution.     
  *
  *          Once the device starts from reset, the user application has to:
  *           - Configure the clock source to be used to drive the System clock
  *             (if the application needs higher frequency/performance)
  *           - Configure the System clock frequency  
  *           - Enable the clock for the peripheral(s) to be used
  *           - Configure the clock source(s) for peripherals which clocks are not
  *             derived from the System clock (RTC/LCD, BEEP)
  *
  *  @endverbatim
  *    
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/

#include "stm8l15x_clk.h"

/** @addtogroup STM8L15x_StdPeriph_Driver
  * @{
  */

/** @defgroup CLK 
  * @brief CLK driver modules
  * @{
  */ 
/* Private typedef -----------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private Variables ---------------------------------------------------------*/
/* Private Constant ---------------------------------------------------------*/
CONST uint8_t SYSDivFactor[5] = {1, 2, 4, 8, 16}; /*!< Holds the different Master clock Divider factors */
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/** @defgroup CLK_Private_Functions
  * @{
  */ 

/** @defgroup CLK_Group1 Internal and external clocks, CSS and CCO configuration functions
 *  @brief   Internal and external clocks, CSS and CCO configuration functions 
 *
@verbatim   
 ===============================================================================
      Internal/external clocks, CSS and CCO configuration functions
 ===============================================================================  

  This section provides functions allowing to configure the internal/external clocks,
  CSS and CCO pins.
  
  1. HSI (high-speed internal), 16 MHz factory-trimmed RC used directly as System 
     clock source.

  2. LSI (low-speed internal), 32 KHz low consumption RC used as IWDG and/or RTC
     and/or BEEP clock source.

  3. HSE (high-speed external), 1 to 16 MHz crystal oscillator used directly as 
     System clock source. Can be used also as RTC/LCD clock source.

  4. LSE (low-speed external), 32 KHz oscillator used as RTC/LCD and/or BEEP clock source.

  5. CSS (Clock security system), once enabled and if a HSE clock failure occurs 
     (HSE used as System clock source), the System clock is automatically switched
     to HSI and an interrupt is generated if enabled. 

  6. CCO (configurable clock output), used to output HSI, LSE, HSE, HSI, LSI
     clock (through a configurable prescaler) on PC4 pin.

@endverbatim
  * @{
  */
/**
* @brief  Enables or disables the specified peripheral clock.
  * @note   After reset, the peripheral clock (used for registers read/write access)
  *         is disabled and the application software has to enable this clock before 
  *         using it.   
  * @param  CLK_Peripheral: specifies the peripheral to gate its clock.
  *          This parameter can be any combination of the following values:
  *            @arg CLK_Peripheral_TIM2:       TIM2 clock
  *            @arg CLK_Peripheral_TIM3:       TIM3 clock 
  *            @arg CLK_Peripheral_TIM4:       TIM4 clock
  *            @arg CLK_Peripheral_I2C1:       I2C1 clock
  *            @arg CLK_Peripheral_SPI1:       SPI1 clock
  *            @arg CLK_Peripheral_USART1:     USART1 clock
  *            @arg CLK_Peripheral_BEEP:       BEEP clock
  *            @arg CLK_Peripheral_DAC:        DAC clock
  *            @arg CLK_Peripheral_ADC1:       ADC1 clock
  *            @arg CLK_Peripheral_TIM1:       TIM1 clock
  *            @arg CLK_Peripheral_RTC:        RTC clock
  *            @arg CLK_Peripheral_LCD:        LCD clock
  *            @arg CLK_Peripheral_DMA1:       DMA1 clock
  *            @arg CLK_Peripheral_COMP:       COMP clock
  *            @arg CLK_Peripheral_BOOTROM:    BOOTROM clock
  *            @arg CLK_Peripheral_AES:        AES clock
  *            @arg CLK_Peripheral_TIM5:       TIM5 clock
  *            @arg CLK_Peripheral_SPI2:       SPI2 clock
  *            @arg CLK_Peripheral_USART2:     USART2 clock
  *            @arg CLK_Peripheral_USART3:     USART3 clock
  *            @arg CLK_Peripheral_CSSLSE:     CSS on LSE clock
  * @param  NewState: new state of the specified peripheral clock.
  *          This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
{
  uint8_t reg = 0;

  /* Check the parameters */
  assert_param(IS_CLK_PERIPHERAL(CLK_Peripheral));
  assert_param(IS_FUNCTIONAL_STATE(NewState));

  /* get flag register */
  reg = (uint8_t)((uint8_t)CLK_Peripheral & (uint8_t)0xF0);

  if ( reg == 0x00)
  {
    if (NewState != DISABLE)
    {
      /* Enable the peripheral Clock */
      CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
    }
    else
    {
      /* Disable the peripheral Clock */
      CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
    }
  }
  else if (reg == 0x10)
  {
    if (NewState != DISABLE)
    {
      /* Enable the peripheral Clock */
      CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
    }
    else
    {
      /* Disable the peripheral Clock */
      CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
    }
  }
  else
  {
    if (NewState != DISABLE)
    {
      /* Enable the peripheral Clock */
      CLK->PCKENR3 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
    }
    else
    {
      /* Disable the peripheral Clock */
      CLK->PCKENR3 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
    }
  }
}

/**
  * @brief  Returns the frequencies of different the SYSCLK
  * 
  * @note   The system frequency computed by this function is not the real 
  *         frequency in the chip. It is calculated based on the predefined 
  *         constant and the selected clock source:
  * @note     If SYSCLK source is HSI, function returns values based on HSI_VALUE(*)
  * @note     If SYSCLK source is HSE, function returns values based on HSE_VALUE(**)
  * @note     If SYSCLK source is LSE, function returns values based on LSE_VALUE(***) 
  * @note     If SYSCLK source is LSI, function returns values based on LSI_VALUE(****)
  * @note     (*) HSI_VALUE is a constant defined in stm8l15x.h file (default value
  *               16 MHz) but the real value may vary depending on the variations
  *               in voltage and temperature.
  * @note     (**) HSE_VALUE is a constant defined in stm8l15x.h file (default value
  *                16 MHz), user has to ensure that HSE_VALUE is same as the real
  *                frequency of the crystal used. Otherwise, this function may
  *                have wrong result.
  * @note     (***) LSI_VALUE is a constant defined in stm8l15x.h file (default value
  *               38 KHz) but the real value may vary depending on the variations
  *               in voltage and temperature.
  * @note     (****) LSE_VALUE is a constant defined in stm8l15x.h file (default value
  *                32,768 KHz), user has to ensure that LSE_VALUE is same as the real
  *                frequency of the crystal used. Otherwise, this function may
  *                have wrong result.
  *
  * @note   The result of this function could be not correct when using fractional
  *         value for HSE crystal.
  *   
  * @param  None
  *
  * @note   This function can be used by the user application to compute the 
  *         baudrate for the communication peripherals or configure other parameters.
  * @note   Each time SYSCLK clock changes, this function must be called to update
  *         the returned value. Otherwise, any configuration based on this 
  *         function will be incorrect.
  *
  * @retval System Clock frequency value
  */
uint32_t CLK_GetClockFreq(void)
{
  uint32_t clockfrequency = 0;
  uint32_t sourcefrequency = 0;
  CLK_SYSCLKSource_TypeDef clocksource = CLK_SYSCLKSource_HSI;
  uint8_t tmp = 0, presc = 0;

  /* Get SYSCLK source. */
  clocksource = (CLK_SYSCLKSource_TypeDef)CLK->SCSR;

  if ( clocksource == CLK_SYSCLKSource_HSI)
  {
    sourcefrequency = HSI_VALUE;
  }
  else if ( clocksource == CLK_SYSCLKSource_LSI)
  {
    sourcefrequency = LSI_VALUE;
  }
  else if ( clocksource == CLK_SYSCLKSource_HSE)
  {
    sourcefrequency = HSE_VALUE;
  }
  else
  {
    clockfrequency = LSE_VALUE;
  }

  /* Get System clock divider factor*/
  tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_CKM);
  presc = SYSDivFactor[tmp];

  /* Get System clock frequency */
  clockfrequency = sourcefrequency / presc;

  return((uint32_t)clockfrequency);
}

/**
  * @brief  Configures the System clock (SYSCLK) dividers.
  * @param  CLK_SYSCLKDiv : Specifies the system clock divider to apply.
  *          This parameter can be one of the following values:
  *            @arg CLK_SYSCLKDiv_1 
  *            @arg CLK_SYSCLKDiv_2
  *            @arg CLK_SYSCLKDiv_4
  *            @arg CLK_SYSCLKDiv_8
  *            @arg CLK_SYSCLKDiv_16
  *            @arg CLK_SYSCLKDiv_64
  *            @arg CLK_SYSCLKDiv_128
  * @retval None
  */
void CLK_SYSCLKDivConfig(CLK_SYSCLKDiv_TypeDef CLK_SYSCLKDiv)
{
  /* check the parameters */
  assert_param(IS_CLK_SYSTEM_DIVIDER(CLK_SYSCLKDiv));

  CLK->CKDIVR = (uint8_t)(CLK_SYSCLKDiv);
}
