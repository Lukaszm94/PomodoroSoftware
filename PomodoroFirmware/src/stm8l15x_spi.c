/**
  ******************************************************************************
  * @file    stm8l15x_spi.c
  * @author  MCD Application Team
  * @version V1.6.1
  * @date    30-September-2014
  * @brief   This file provides firmware functions to manage the following 
  *          functionalities of the Serial peripheral interface (SPI):           
  *           - Initialization and Configuration
  *           - Data transfers functions
  *           - Hardware CRC Calculation
  *           - DMA transfers management
  *           - Interrupts and flags management 
  *           
  *  @verbatim
  *          
  *          ===================================================================
  *                                 How to use this driver
  *          ===================================================================
  *          1. Enable peripheral clock using CLK_PeripheralClockConfig(CLK_Peripheral_SPIx,
  *             ENABLE) function (Refer to the product datasheet for the available SPI
  *           	peripherals)
  *
  *          2.  Enable the external Pull-up on the used SPI Pins using the
  *              GPIO_ExternalPullUpConfig() function or an eternal pull-up equivalent resistor
	*              (RPU = 45 KOhm typical value). 
  *
  *        
  *          3. Program the Polarity, Phase, First Data, Baud Rate Prescaler, Slave 
  *             Management, Peripheral Mode and CRC Polynomial values using the SPI_Init()
  *             function.
  *
  *          4. Enable the corresponding interrupt using the function SPI_ITConfig() if you
  *           	need to use interrupt mode. 
  *
  *          5. When using the DMA mode 
  *                   - Configure the DMA using DMA_Init() function
  *                   - Active the needed channel Request using SPI_DMACmd() function
  * 
  *          6. Enable the SPI using the SPI_Cmd() function.
  * 
  *          7. Enable the DMA using the DMA_Cmd() function when using DMA mode. 
  *
  *          8. Optionally you can enable/configure the following parameters without
  *             re-initialization (i.e there is no need to call again SPI_Init() function):
  *              - When bidirectional mode (SPI_Direction_1Line_Rx or SPI_Direction_1Line_Tx)
  *                is programmed as Data direction parameter using the SPI_Init() function
  *                it can be possible to switch between SPI_Direction_Tx or SPI_Direction_Rx
  *                using the SPI_BiDirectionalLineConfig() function.
  *              - When SPI_NSS_Soft is selected as Slave Select Management parameter 
  *                using the SPI_Init() function it can be possible to manage the 
  *                NSS internal signal using the SPI_NSSInternalSoftwareConfig() function.
  *          
  *          9. To use the CRC Hardware calculation feature refer to the Peripheral 
  *              CRC hardware Calculation subsection.
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
#include "stm8l15x_spi.h"

/** @addtogroup STM8L15x_StdPeriph_Driver
  * @{
  */
	
/** @defgroup SPI 
  * @brief SPI driver modules
  * @{
  */ 
	
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/** @defgroup SPI_Private_Functions
  * @{
  */

/** @defgroup SPI_Group1 Initialization and Configuration functions
 *  @brief   Initialization and Configuration functions 
 *
@verbatim   
 ===============================================================================
                  Initialization and Configuration functions
 ===============================================================================  

  This section provides a set of functions allowing to initialize the SPI Direction,
  SPI Mode, SPI Data Size, SPI Polarity, SPI Phase, SPI NSS Management, SPI Baud
  Rate Prescaler, SPI First Bit and SPI CRC Polynomial.
  
  The SPI_Init() function follows the SPI configuration procedures for Master mode
  and Slave mode (details for these procedures are available in reference manual
  (RM0031)).
  
@endverbatim
  * @{
  */

/**
  * @brief  Initializes the SPI according to the specified parameters.
  * @param  SPIx: where x can be 1 to select the specified SPI peripheral.
  * @param  SPI_FirstBit: This parameter can be any of the
  *          This parameter can be one of the following values:
  *            @arg SPI_FirstBit_MSB: MSB bit will be transmitted first
  *            @arg SPI_FirstBit_LSB: LSB bit will be transmitted first  
  * @param  SPI_BaudRatePrescaler: This parameter can be any of the
  *          This parameter can be one of the following values:
  *            @arg SPI_BaudRatePrescaler_2: SPI frequency = frequency(CPU)/2
  *            @arg SPI_BaudRatePrescaler_4: SPI frequency = frequency(CPU)/4
  *            @arg SPI_BaudRatePrescaler_8: SPI frequency = frequency(CPU)/8
  *            @arg SPI_BaudRatePrescaler_16: SPI frequency = frequency(CPU)/16
  *            @arg SPI_BaudRatePrescaler_32: SPI frequency = frequency(CPU)/32
  *            @arg SPI_BaudRatePrescaler_64: SPI frequency = frequency(CPU)/64
  *            @arg SPI_BaudRatePrescaler_128: SPI frequency = frequency(CPU)/128
  *            @arg SPI_BaudRatePrescaler_256: SPI frequency = frequency(CPU)/256            
  * @param  SPI_Mode: Mode
  *          This parameter can be one of the following values:
  *            @arg SPI_Mode_Master: SPI Master configuration
  *            @arg SPI_Mode_Slave: SPI Slave configuration
  * @param  SPI_CPOL: Clock Polarity
  *          This parameter can be one of the following values:
  *            @arg SPI_CPOL_Low: Clock to 0 when idle
  *            @arg SPI_CPOL_High: Clock to 1 when idle
  * @param  SPI_CPHA: Clock Phase
  *          This parameter can be one of the following values:
  *            @arg SPI_CPHA_1Edge: The first clock transition is the first data capture edge
  *            @arg SPI_CPHA_2Edge: The second clock transition is the first data capture edge
  * @param  SPI_Data_Direction: Data direction
  *          This parameter can be one of the following values:
  *            @arg SPI_Direction_Rx: Select Rx receive direction in bi-directional mode
  *            @arg SPI_Direction_Tx: Select Tx transmission direction in bi-directional mode
  * @param  SPI_Slave_Management: Slave management
  *          This parameter can be one of the following values:
  *            @arg SPI_NSS_Soft: Software slave management disabled
  *            @arg SPI_NSS_Hard: Software slave management enabled
  * @param  CRCPolynomial: Configures the CRC polynomial.
  * @retval None
  */
void SPI_Init(SPI_TypeDef* SPIx, SPI_FirstBit_TypeDef SPI_FirstBit,
              SPI_BaudRatePrescaler_TypeDef SPI_BaudRatePrescaler,
              SPI_Mode_TypeDef SPI_Mode, SPI_CPOL_TypeDef SPI_CPOL,
              SPI_CPHA_TypeDef SPI_CPHA, SPI_DirectionMode_TypeDef SPI_Data_Direction,
              SPI_NSS_TypeDef SPI_Slave_Management, uint8_t CRCPolynomial)
{
  /* Check structure elements */
  assert_param(IS_SPI_FIRSTBIT(SPI_FirstBit));
  assert_param(IS_SPI_BAUDRATE_PRESCALER(SPI_BaudRatePrescaler));
  assert_param(IS_SPI_MODE(SPI_Mode));
  assert_param(IS_SPI_POLARITY(SPI_CPOL));
  assert_param(IS_SPI_PHASE(SPI_CPHA));
  assert_param(IS_SPI_DATA_DIRECTION(SPI_Data_Direction));
  assert_param(IS_SPI_SLAVEMANAGEMENT(SPI_Slave_Management));
  assert_param(IS_SPI_CRC_POLYNOMIAL(CRCPolynomial));

  /* Frame Format, BaudRate, Clock Polarity and Phase configuration */
  SPIx->CR1 = (uint8_t)((uint8_t)((uint8_t)SPI_FirstBit |
                                  (uint8_t)SPI_BaudRatePrescaler) |
                        (uint8_t)((uint8_t)SPI_CPOL |
                                  SPI_CPHA));

  /* Data direction configuration: BDM, BDOE and RXONLY bits */
  SPIx->CR2 = (uint8_t)((uint8_t)(SPI_Data_Direction) | (uint8_t)(SPI_Slave_Management));

  if (SPI_Mode == SPI_Mode_Master)
  {
    SPIx->CR2 |= (uint8_t)SPI_CR2_SSI;
  }
  else
  {
    SPIx->CR2 &= (uint8_t)~(SPI_CR2_SSI);
  }

  /* Master/Slave mode configuration */
  SPIx->CR1 |= (uint8_t)(SPI_Mode);

  /* CRC configuration */
  SPIx->CRCPR = (uint8_t)CRCPolynomial;
}

/**
  * @brief  Enables or disables the SPI peripheral.
  * @param  SPIx: where x can be 1 to select the specified SPI peripheral.
  * @param  NewState New state of the SPI peripheral.
  *         This parameter can be: ENABLE or DISABLE
  * @retval None
  */
void SPI_Cmd(SPI_TypeDef* SPIx, FunctionalState NewState)
{
  /* Check function parameters */
  assert_param(IS_FUNCTIONAL_STATE(NewState));

  if (NewState != DISABLE)
  {
    SPIx->CR1 |= SPI_CR1_SPE; /* Enable the SPI peripheral*/
  }
  else
  {
    SPIx->CR1 &= (uint8_t)(~SPI_CR1_SPE); /* Disable the SPI peripheral*/
  }
}

/**
  * @}
  */

/** @defgroup SPI_Group2 Data transfers functions
 *  @brief   Data transfers functions
 *
@verbatim   
 ===============================================================================
                         Data transfers functions
 ===============================================================================  

  This section provides a set of functions allowing to manage the SPI data transfers
  
  In reception, data are received and then stored into an internal Rx buffer while 
  In transmission, data are first stored into an internal Tx buffer before being 
  transmitted.

  The read access of the SPI_DR register can be done using the SPI_ReceiveData()
  function and returns the Rx buffered value. Whereas a write access to the SPI_DR 
  can be done using SPI_SendData() function and stores the written data into 
  Tx buffer.

@endverbatim
  * @{
  */
	
/**
  * @brief  Transmits a Data through the SPI peripheral.
  * @param  SPIx: where x can be 1 to select the specified SPI peripheral.
  * @param  Data: Byte to be transmitted.
  * @retval None
  */
void SPI_SendData(SPI_TypeDef* SPIx, uint8_t Data)
{
  SPIx->DR = Data; /* Write in the DR register the data to be sent*/
}

/**
  * @brief  Returns the most recent received data by the SPI peripheral.
  * @param  SPIx: where x can be 1 to select the specified SPI peripheral.
  * @retval The value of the received data.
  */
uint8_t SPI_ReceiveData(SPI_TypeDef* SPIx)
{
  return ((uint8_t)SPIx->DR); /* Return the data in the DR register*/
}

/**
  * @brief  Enables or disables the SPI DMA interface.
  * @param  SPIx: where x can be 1 to select the specified SPI peripheral.
  * @param  SPI_DMAReq Specifies the SPI DMA transfer request to be enabled or disabled.
  *          This parameter can be one of the following values:
  *            @arg SPI_DMAReq_RX: SPI DMA Rx transfer requests
  *            @arg SPI_DMAReq_TX: SPI DMA Tx transfer requests
  * @param  NewState Indicates the new state of the SPI DMA request.
  *         This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void SPI_DMACmd(SPI_TypeDef* SPIx, SPI_DMAReq_TypeDef SPI_DMAReq, FunctionalState NewState)
{
  /* Check the parameters */
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  assert_param(IS_SPI_DMAREQ(SPI_DMAReq));

  if (NewState != DISABLE)
  {
    /* Enable the selected SPI DMA requests */
    SPIx->CR3 |= (uint8_t) SPI_DMAReq;
  }
  else
  {
    /* Disable the selected SPI DMA requests */
    SPIx->CR3 &= (uint8_t)~SPI_DMAReq;
  }
}

/**
  * @}
  */

/** @defgroup SPI_Group5 Interrupts and flags management functions
 *  @brief   Interrupts and flags management functions
  *
@verbatim   
 ===============================================================================
                         Interrupts and flags management functions
 ===============================================================================  

  This section provides a set of functions allowing to configure the SPI Interrupts 
  sources and check or clear the flags or pending bits status.
  The user should identify which mode will be used in his application to manage 
  the communication: Polling mode, Interrupt mode or DMA mode. 
    
  Polling Mode
  =============
  In Polling Mode, the SPI communication can be managed by 6 flags:
     1. SPI_FLAG_TXE: to indicate the status of the transmit buffer register
     2. SPI_FLAG_RXNE: to indicate the status of the receive buffer register
     3. SPI_FLAG_WKUP: to indicate the state of the Wakeup event.
     4. SPI_FLAG_CRCERR: to indicate if a CRC Calculation error occurs              
     5. SPI_FLAG_MODF: to indicate if a Mode Fault error occurs
     6. SPI_FLAG_OVR: to indicate if an Overrun error occurs

  In this Mode it is advised to use the following functions:
     - FlagStatus SPI_GetFlagStatus(SPI_TypeDef* SPIx, SPI_FLAG_TypeDef SPI_FLAG);
     - void SPI_ClearFlag(SPI_TypeDef* SPIx, SPI_FLAG_TypeDef SPI_FLAG);

  Interrupt Mode
  ===============
  In Interrupt Mode, the SPI communication can be managed by 4 interrupt sources
  and 6 pending bits: 
  Pending Bits:
  ------------- 
     1. SPI_IT_TXE: to indicate the status of the transmit buffer register
     2. SPI_IT_RXNE: to indicate the status of the receive buffer register
     3. SPI_IT_CRCERR: to indicate if a CRC Calculation error occurs              
     4. SPI_IT_MODF: to indicate if a Mode Fault error occurs
     5. SPI_IT_OVR: to indicate if an Overrun error occurs
     6. SPI_IT_WKUP: to indicate if an Wake_up event occurs
  Interrupt Source:
  -----------------
     1. SPI_IT_TXE: specifies the interrupt source for the Tx buffer empty 
                        interrupt.  
     2. SPI_IT_RXNE: specifies the interrupt source for the Rx buffer not 
                          empty interrupt.
     3. SPI_IT_ERR: specifies the interrupt source for the errors interrupt.
		 4. SPI_IT_WKUP: specifies the interrupt source for the Wake-up interrupt.

  In this Mode it is advised to use the following functions:
     - void SPI_ITConfig(SPI_TypeDef* SPIx, SPI_IT_TypeDef SPI_IT, FunctionalState NewState);
     - ITStatus SPI_GetITStatus(SPI_TypeDef* SPIx, SPI_IT_TypeDef SPI_IT);
     - void SPI_ClearITPendingBit(SPI_TypeDef* SPIx, SPI_IT_TypeDef SPI_IT);

  DMA Mode
  ========
  In DMA Mode, the SPI communication can be managed by 2 DMA Channel requests:
     1. SPI_DMAReq_Tx: specifies the Tx buffer DMA transfer request
     2. SPI_DMAReq_Rx: specifies the Rx buffer DMA transfer request

  In this Mode it is advised to use the following function:
    - void SPI_DMACmd(SPI_TypeDef* SPIx, SPI_DMAReq_TypeDef SPI_DMAReq, FunctionalState NewState);

@endverbatim
  * @{
  */
	

/**
  * @brief  Checks whether the specified SPI flag is set or not.
  * @param  SPIx: where x can be 1 to select the specified SPI peripheral.
  * @param  SPI_FLAG: Specifies the flag to check.
  *          This parameter can be one of the following values:
  *            @arg SPI_FLAG_BSY: Busy
  *            @arg SPI_FLAG_OVR: Overrun
  *            @arg SPI_FLAG_MODF: Mode fault
  *            @arg SPI_FLAG_CRCERR: CRC error
  *            @arg SPI_FLAG_WKUP: Wake-up 
  *            @arg SPI_FLAG_TXE: Transmit buffer empty
  *            @arg SPI_FLAG_RXNE: Receive buffer empty
  * @retval Indicates the state of SPI_FLAG.
  *         This parameter can be SET or RESET.
  */
FlagStatus SPI_GetFlagStatus(SPI_TypeDef* SPIx, SPI_FLAG_TypeDef SPI_FLAG)
{
  FlagStatus status = RESET;
  /* Check parameters */
  assert_param(IS_SPI_FLAG(SPI_FLAG));

  /* Check the status of the specified SPI flag */
  if ((SPIx->SR & (uint8_t)SPI_FLAG) != (uint8_t)RESET)
  {
    status = SET; /* SPI_FLAG is set */
  }
  else
  {
    status = RESET; /* SPI_FLAG is reset*/
  }

  /* Return the SPI_FLAG status */
  return status;
}

/**
  * @brief  Clears the SPI flags.
  * @param  SPIx: where x can be 1 to select the specified SPI peripheral.
  * @param  SPI_FLAG: Specifies the flag to clear.
  *         This parameter can be one of the following values:
  *            @arg SPI_FLAG_CRCERR
  *            @arg SPI_FLAG_WKUP
  * @note   OVR (OverRun Error) interrupt pending bit is cleared by software
  *         sequence: a read operation to SPI_DR register (SPI_ReceiveData()) followed by
  *         a read operation to SPI_SR register (SPI_GetFlagStatus()).
  * @note   MODF (Mode Fault) interrupt pending bit is cleared by software sequence:
  *         a read/write operation to SPI_SR register (SPI_GetFlagStatus()) followed by
  *         a write operation to SPI_CR1 register (SPI_Cmd() to enable the SPI).
  * @retval None
  */
void SPI_ClearFlag(SPI_TypeDef* SPIx, SPI_FLAG_TypeDef SPI_FLAG)
{
  assert_param(IS_SPI_CLEAR_FLAG(SPI_FLAG));
  /* Clear the flag bit */
  SPIx->SR = (uint8_t)(~SPI_FLAG);
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
