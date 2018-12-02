/**
  ******************************************************************************
  * @file    stm8l15x_usart.c
  * @author  MCD Application Team
  * @version V1.6.1
  * @date    30-September-2014
  * @brief   This file provides firmware functions to manage the following 
  *          functionalities of the Universal synchronous asynchronous receiver
  *          transmitter (USART):           
  *           - Initialization and Configuration
  *           - Data transfers
  *           - Multi-Processor Communication
  *           - Half-duplex mode
  *           - Smartcard mode
  *           - IrDA mode
  *           - DMA transfers management
  *           - Interrupts and flags management 
  *           
  *  @verbatim
  *      
  *          ===================================================================
  *                                 How to use this driver
  *          ===================================================================
  *          1. Enable peripheral clock using CLK_PeripheralClockConfig(CLK_Peripheral_USARTx,
  *             ENABLE) function (Refer to the product datasheet for the available USART
  *           	peripherals)
  *
  *          2.  Enable the external Pull-up on the used USART Pins using the
  *              GPIO_ExternalPullUpConfig() function or an external pull-up equivalent resistor
	*              (RPU = 45 KOhm typical value). 
	*
  *          3. Program the Baud Rate, Word Length , Stop Bit, Parity and Mode (Receiver/Transmitter)
  *           	using the USART_Init() function.
  *
  *          4. For synchronous mode, enable the clock and program the polarity,
  *             phase and last bit using the USART_ClockInit() function.
  *
  *          5. Enable the corresponding interrupt using the function USART_ITConfig() if you need 
	*             to use interrupt mode. 
  *
  *          6. When using the DMA mode 
  *                   - Configure the DMA using DMA_Init() function
  *                   - Activate the needed channel Request using USART_DMACmd() function
  * 
  *          7. Enable the USART using the USART_Cmd() function.
  * 
  *          8. Enable the DMA using the DMA_Cmd() function, when using DMA mode. 
  *
  *          Refer to Multi-Processor, half-duplex, Smartcard, IrDA sub-sections for more details.
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
#include "stm8l15x_usart.h"

/** @addtogroup STM8L15x_StdPeriph_Driver
  * @{
  */

/** @defgroup USART 
  * @brief USART driver modules
  * @{
  */
	
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/** @defgroup USART_Private_Functions
  * @{
  */

/** @defgroup USART_Group1 Initialization and Configuration functions
 *  @brief   Initialization and Configuration functions 
 *
@verbatim   
 ===============================================================================
                  Initialization and Configuration functions
 ===============================================================================  

  This subsection provides a set of functions allowing to initialize the USART 
  in asynchronous and in synchronous modes.
   - For the asynchronous mode only these parameters can be configured: 
        - Baud Rate
        - Word Length 
        - Stop Bit
        - Parity: If the parity is enabled, then the MSB bit of the data written
          in the data register is transmitted but is changed by the parity bit.
          Depending on the frame length defined by the M bit (8-bits or 9-bits),
          the possible USART frame formats are as listed in the following table:
   +-------------------------------------------------------------+     
   |   M bit |  PCE bit  |            USART frame                |
   |---------------------|---------------------------------------|             
   |    0    |    0      |    | SB | 8 bit data | STB |          |
   |---------|-----------|---------------------------------------|  
   |    0    |    1      |    | SB | 7 bit data | PB | STB |     |
   |---------|-----------|---------------------------------------|  
   |    1    |    0      |    | SB | 9 bit data | STB |          |
   |---------|-----------|---------------------------------------|  
   |    1    |    1      |    | SB | 8 bit data | PB | STB |     |
   +-------------------------------------------------------------+            
        - Receiver/transmitter modes

  The USART_Init() function follows the USART  asynchronous configuration procedure
  (details for the procedure are available in reference manual (RM0031)).

  - For the synchronous mode in addition to the asynchronous mode parameters these 
    parameters should be also configured:
        - USART Clock Enabled
        - USART polarity
        - USART phase
        - USART LastBit
  
  These parameters can be configured using the USART_ClockInit() function.

@endverbatim
  * @{
  */

/**
  * @brief   Deinitializes the USART peripheral.
  * @param  USARTx: where x can be 1, 2 or 3 to select the specified USART peripheral.
  * @retval None
  */
void USART_DeInit(USART_TypeDef* USARTx)
{

  /* Clear the Idle Line Detected bit in the status register by a read
      to the USART_SR register followed by a Read to the USART_DR register */
  (void) USARTx->SR;
  (void) USARTx->DR;

  USARTx->BRR2 = USART_BRR2_RESET_VALUE;  /* Set USART_BRR2 to reset value 0x00 */
  USARTx->BRR1 = USART_BRR1_RESET_VALUE;  /* Set USART_BRR1 to reset value 0x00 */

  USARTx->CR1 = USART_CR1_RESET_VALUE;  /* Set USART_CR1 to reset value 0x00 */
  USARTx->CR2 = USART_CR2_RESET_VALUE;  /* Set USART_CR2 to reset value 0x00 */
  USARTx->CR3 = USART_CR3_RESET_VALUE;  /* Set USART_CR3 to reset value 0x00 */
  USARTx->CR4 = USART_CR4_RESET_VALUE;  /* Set USART_CR4 to reset value 0x00 */
}

/**
  * @brief  Initializes the USART according to the specified parameters.
  * @note   Configure in Push Pull or Open Drain mode the Tx pin by setting the
  *         correct I/O Port register according the product package and line
  *         configuration
  * @param  USARTx: where x can be 1 to select the specified USART peripheral.
  * @param  BaudRate: The baudrate.
  * @param  USART_WordLength: the word length
  *           This parameter can be one of the following values:
  *            @arg USART_WordLength_8b: 8 bits Data
  *            @arg USART_WordLength_9b: 9 bits Data  
  * @param  USART_StopBits: Stop Bit
  *           This parameter can be one of the following values:
  *            @arg USART_StopBits_1: One stop bit is transmitted at the end of frame
  *            @arg USART_StopBits_2: Two stop bits are transmitted at the end of frame
  *            @arg USART_StopBits_1_5: One and half stop bits
  * @param  USART_Parity: Parity
  *           This parameter can be one of the following values:
  *            @arg USART_Parity_No: No Parity
  *            @arg USART_Parity_Even: Even Parity
  *            @arg USART_Parity_Odd: Odd Parity    
  * @param  USART_Mode: Mode
  *           This parameter can be one of the following values:
  *            @arg USART_Mode_Rx: Receive Enable
  *            @arg USART_Mode_Tx: Transmit Enable  
  * @retval None
  */
void USART_Init(USART_TypeDef* USARTx, uint32_t BaudRate, USART_WordLength_TypeDef
                USART_WordLength, USART_StopBits_TypeDef USART_StopBits,
                USART_Parity_TypeDef USART_Parity,  USART_Mode_TypeDef USART_Mode)
{
  uint32_t BaudRate_Mantissa = 0;

  /* Check the parameters */
  assert_param(IS_USART_BAUDRATE(BaudRate));

  assert_param(IS_USART_WORDLENGTH(USART_WordLength));

  assert_param(IS_USART_STOPBITS(USART_StopBits));

  assert_param(IS_USART_PARITY(USART_Parity));

  assert_param(IS_USART_MODE(USART_Mode));

  /* Clear the word length and Parity Control bits */
  USARTx->CR1 &= (uint8_t)(~(USART_CR1_PCEN | USART_CR1_PS | USART_CR1_M));
  /* Set the word length bit according to USART_WordLength value */
  /* Set the Parity Control bit to USART_Parity value */
  USARTx->CR1 |= (uint8_t)((uint8_t)USART_WordLength | (uint8_t)USART_Parity);

  /* Clear the STOP bits */
  USARTx->CR3 &= (uint8_t)(~USART_CR3_STOP);
  /* Set the STOP bits number according to USART_StopBits value */
  USARTx->CR3 |= (uint8_t)USART_StopBits;

  /* Clear the LSB mantissa of USARTDIV */
  USARTx->BRR1 &= (uint8_t)(~USART_BRR1_DIVM);
  /* Clear the MSB mantissa of USARTDIV */
  USARTx->BRR2 &= (uint8_t)(~USART_BRR2_DIVM);
  /* Clear the Fraction bits of USARTDIV */
  USARTx->BRR2 &= (uint8_t)(~USART_BRR2_DIVF);

  BaudRate_Mantissa  = (uint32_t)(CLK_GetClockFreq() / BaudRate );
  /* Set the fraction of USARTDIV */
  USARTx->BRR2 = (uint8_t)((BaudRate_Mantissa >> (uint8_t)8) & (uint8_t)0xF0);
  /* Set the MSB mantissa of USARTDIV */
  USARTx->BRR2 |= (uint8_t)(BaudRate_Mantissa & (uint8_t)0x0F);
  /* Set the LSB mantissa of USARTDIV */
  USARTx->BRR1 = (uint8_t)(BaudRate_Mantissa >> (uint8_t)4);

  /* Disable the Transmitter and Receiver */
  USARTx->CR2 &= (uint8_t)~(USART_CR2_TEN | USART_CR2_REN);
  /* Set TEN and REN bits according to USART_Mode value */
  USARTx->CR2 |= (uint8_t)USART_Mode;
}


/**
  * @brief  Enable the USART peripheral.
  * @param  USARTx: where x can be 1 to select the specified USART peripheral.
  * @param  NewState: The new state of the USART Communication.
    *         This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void USART_Cmd(USART_TypeDef* USARTx, FunctionalState NewState)
{
  if (NewState != DISABLE)
  {
    USARTx->CR1 &= (uint8_t)(~USART_CR1_USARTD); /**< USART Enable */
  }
  else
  {
    USARTx->CR1 |= USART_CR1_USARTD;  /**< USART Disable (for low power consumption) */
  }
}

/**
  * @}
  */

/** @defgroup USART_Group2 Data transfers functions
 *  @brief   Data transfers functions 
 *
@verbatim   
 ===============================================================================
                            Data transfers functions
 ===============================================================================  

  This subsection provides a set of functions allowing to manage the USART data 
  transfers.
  
  During an USART reception, data shifts in least significant bit first through 
  the RX pin. In this mode, the USART_DR register is similar to a buffer (RDR) 
  between the internal bus and the received shift register.

  When a transmission is taking place, a write instruction to the USART_DR register 
  stores the data in the TDR register which is copied in the shift register 
  at the end of the current transmission.

  The read access of the USART_DR register can be done using the USART_ReceiveData8()
  or USART_ReceiveData9() functions and returns the RDR buffered value. Whereas a write
	access to the USART_DR can be done using USART_SendData8() or USART_SendData9() 
	functions and stores the written data into TDR buffer.

@endverbatim
  * @{
  */

/**
  * @brief  Returns the most recent received data by the USART peripheral.
  * @param  USARTx: where x can be 1 to select the specified USART peripheral.
  * @retval The received data.
  */
uint8_t USART_ReceiveData8(USART_TypeDef* USARTx)
{
  return USARTx->DR;
}

/**
  * @brief  Transmits 8 bit data through the USART peripheral.
  * @param  Data: The data to transmit.
  * @retval None
  */
void USART_SendData8(USART_TypeDef* USARTx, uint8_t Data)
{
  /* Transmit Data */
  USARTx->DR = Data;
}



/**
  * @brief  Checks whether the specified USART flag is set or not.
  * @param  USARTx: Select the USARTx peripheral.
  * @param  USART_FLAG specifies the flag to check.
  *         This parameter can be one of the following values:
  *            @arg USART_FLAG_TXE: Transmit Data Register empty
  *            @arg USART_FLAG_TC: Transmission Complete 
  *            @arg USART_FLAG_RXNE: Read Data Register Not Empty
  *            @arg USART_FLAG_IDLE: Idle line detected
  *            @arg USART_FLAG_OR: OverRun error
  *            @arg USART_FLAG_NF: Noise error
  *            @arg USART_FLAG_FE: Framing Error
  *            @arg USART_FLAG_PE: Parity Error
  *            @arg USART_FLAG_SBK: Send Break characters               
  * @retval FlagStatus (SET or RESET)
  */
FlagStatus USART_GetFlagStatus(USART_TypeDef* USARTx, USART_FLAG_TypeDef USART_FLAG)
{
  FlagStatus status = RESET;

  /* Check parameters */
  assert_param(IS_USART_FLAG(USART_FLAG));

  if (USART_FLAG == USART_FLAG_SBK)
  {
    if ((USARTx->CR2 & (uint8_t)USART_FLAG) != (uint8_t)0x00)
    {
      /* USART_FLAG is set*/
      status = SET;
    }
    else
    {
      /* USART_FLAG is reset*/
      status = RESET;
    }
  }
  else
  {
    if ((USARTx->SR & (uint8_t)USART_FLAG) != (uint8_t)0x00)
    {
      /* USART_FLAG is set*/
      status = SET;
    }
    else
    {
      /* USART_FLAG is reset*/
      status = RESET;
    }
  }
  /* Return the USART_FLAG status*/
  return status;
}

/**
  * @brief  Clears the USARTx's pending flags.
  * @param  USARTx: where x can be 1 to select the specified USART peripheral.
  * @param  USART_FLAG: specifies the flag to clear.
  *         This parameter can be any combination of the following values:
  *            @arg USART_FLAG_TC:   Transmission Complete flag.
  *            @arg USART_FLAG_RXNE: Receive data register not empty flag.
  * @note   PE (Parity error), FE (Framing error), NE (Noise error), OR (OverRun error)
  *         and IDLE (Idle line detected) flags are cleared by software sequence: a read
  *         operation to USART_SR register (USART_GetFlagStatus())followed by a read
  *         operation to USART_DR register(USART_ReceiveData8() or USART_ReceiveData9()).
  * @note   RXNE flag can be also cleared by a read to the USART_DR register
  *         (USART_ReceiveData8()or USART_ReceiveData9()).
  * @note   TC flag can be also cleared by software sequence: a read operation to USART_SR
  *         register (USART_GetFlagStatus()) followed by a write operation to USART_DR
  *         register (USART_SendData8() or USART_SendData9()).
  * @note    TXE flag is cleared only by a write to the USART_DR register
  *         (USART_SendData8() or USART_SendData9()).
  * @note   SBK flag is cleared during the stop bit of break.
  * @retval None
  */
void USART_ClearFlag(USART_TypeDef* USARTx, USART_FLAG_TypeDef USART_FLAG)
{
  /* Check the parameters */
  assert_param(IS_USART_CLEAR_FLAG(USART_FLAG));
  /*< Clear RXNE or TC flags */
  USARTx->SR = (uint8_t)((uint16_t)~((uint16_t)USART_FLAG));
}




/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
