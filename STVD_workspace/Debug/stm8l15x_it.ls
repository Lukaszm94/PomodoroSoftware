   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  42                     ; 70 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  42                     ; 71 {
  43                     	switch	.text
  44  0000               f_TRAP_IRQHandler:
  48                     ; 75 }
  51  0000 80            	iret
  73                     ; 81 INTERRUPT_HANDLER(FLASH_IRQHandler,1)
  73                     ; 82 {
  74                     	switch	.text
  75  0001               f_FLASH_IRQHandler:
  79                     ; 86 }
  82  0001 80            	iret
 105                     ; 92 INTERRUPT_HANDLER(DMA1_CHANNEL0_1_IRQHandler,2)
 105                     ; 93 {
 106                     	switch	.text
 107  0002               f_DMA1_CHANNEL0_1_IRQHandler:
 111                     ; 97 }
 114  0002 80            	iret
 137                     ; 103 INTERRUPT_HANDLER(DMA1_CHANNEL2_3_IRQHandler,3)
 137                     ; 104 {
 138                     	switch	.text
 139  0003               f_DMA1_CHANNEL2_3_IRQHandler:
 143                     ; 108 }
 146  0003 80            	iret
 169                     ; 114 INTERRUPT_HANDLER(RTC_CSSLSE_IRQHandler,4)
 169                     ; 115 {
 170                     	switch	.text
 171  0004               f_RTC_CSSLSE_IRQHandler:
 175                     ; 119 }
 178  0004 80            	iret
 201                     ; 125 INTERRUPT_HANDLER(EXTIE_F_PVD_IRQHandler,5)
 201                     ; 126 {
 202                     	switch	.text
 203  0005               f_EXTIE_F_PVD_IRQHandler:
 207                     ; 130 }
 210  0005 80            	iret
 232                     ; 137 INTERRUPT_HANDLER(EXTIB_G_IRQHandler,6)
 232                     ; 138 {
 233                     	switch	.text
 234  0006               f_EXTIB_G_IRQHandler:
 238                     ; 142 }
 241  0006 80            	iret
 263                     ; 149 INTERRUPT_HANDLER(EXTID_H_IRQHandler,7)
 263                     ; 150 {
 264                     	switch	.text
 265  0007               f_EXTID_H_IRQHandler:
 269                     ; 154 }
 272  0007 80            	iret
 294                     ; 161 INTERRUPT_HANDLER(EXTI0_IRQHandler,8)
 294                     ; 162 {
 295                     	switch	.text
 296  0008               f_EXTI0_IRQHandler:
 300                     ; 166 }
 303  0008 80            	iret
 325                     ; 173 INTERRUPT_HANDLER(EXTI1_IRQHandler,9)
 325                     ; 174 {
 326                     	switch	.text
 327  0009               f_EXTI1_IRQHandler:
 331                     ; 178 }
 334  0009 80            	iret
 356                     ; 185 INTERRUPT_HANDLER(EXTI2_IRQHandler,10)
 356                     ; 186 {
 357                     	switch	.text
 358  000a               f_EXTI2_IRQHandler:
 362                     ; 190 }
 365  000a 80            	iret
 387                     ; 197 INTERRUPT_HANDLER(EXTI3_IRQHandler,11)
 387                     ; 198 {
 388                     	switch	.text
 389  000b               f_EXTI3_IRQHandler:
 393                     ; 202 }
 396  000b 80            	iret
 418                     ; 209 INTERRUPT_HANDLER(EXTI4_IRQHandler,12)
 418                     ; 210 {
 419                     	switch	.text
 420  000c               f_EXTI4_IRQHandler:
 424                     ; 214 }
 427  000c 80            	iret
 449                     ; 221 INTERRUPT_HANDLER(EXTI5_IRQHandler,13)
 449                     ; 222 {
 450                     	switch	.text
 451  000d               f_EXTI5_IRQHandler:
 455                     ; 226 }
 458  000d 80            	iret
 480                     ; 233 INTERRUPT_HANDLER(EXTI6_IRQHandler,14)
 480                     ; 234 {
 481                     	switch	.text
 482  000e               f_EXTI6_IRQHandler:
 486                     ; 238 }
 489  000e 80            	iret
 511                     ; 245 INTERRUPT_HANDLER(EXTI7_IRQHandler,15)
 511                     ; 246 {
 512                     	switch	.text
 513  000f               f_EXTI7_IRQHandler:
 517                     ; 250 }
 520  000f 80            	iret
 542                     ; 256 INTERRUPT_HANDLER(LCD_AES_IRQHandler,16)
 542                     ; 257 {
 543                     	switch	.text
 544  0010               f_LCD_AES_IRQHandler:
 548                     ; 261 }
 551  0010 80            	iret
 574                     ; 267 INTERRUPT_HANDLER(SWITCH_CSS_BREAK_DAC_IRQHandler,17)
 574                     ; 268 {
 575                     	switch	.text
 576  0011               f_SWITCH_CSS_BREAK_DAC_IRQHandler:
 580                     ; 272 }
 583  0011 80            	iret
 606                     ; 279 INTERRUPT_HANDLER(ADC1_COMP_IRQHandler,18)
 606                     ; 280 {
 607                     	switch	.text
 608  0012               f_ADC1_COMP_IRQHandler:
 612                     ; 284 }
 615  0012 80            	iret
 643                     ; 291 INTERRUPT_HANDLER(TIM2_UPD_OVF_TRG_BRK_USART2_TX_IRQHandler,19)
 643                     ; 292 {
 644                     	switch	.text
 645  0013               f_TIM2_UPD_OVF_TRG_BRK_USART2_TX_IRQHandler:
 647  0013 8a            	push	cc
 648  0014 84            	pop	a
 649  0015 a4bf          	and	a,#191
 650  0017 88            	push	a
 651  0018 86            	pop	cc
 652  0019 3b0002        	push	c_x+2
 653  001c be00          	ldw	x,c_x
 654  001e 89            	pushw	x
 655  001f 3b0002        	push	c_y+2
 656  0022 be00          	ldw	x,c_y
 657  0024 89            	pushw	x
 660                     ; 296 		if(TIM2_GetITStatus(TIM2_IT_Update) == SET) {
 662  0025 a601          	ld	a,#1
 663  0027 cd0000        	call	_TIM2_GetITStatus
 665  002a a101          	cp	a,#1
 666  002c 261a          	jrne	L152
 667                     ; 298 			millis++;
 669  002e ae0000        	ldw	x,#_millis
 670  0031 a601          	ld	a,#1
 671  0033 cd0000        	call	c_lgadc
 673                     ; 299 			TIM2_ClearITPendingBit(TIM2_IT_Update);
 675  0036 a601          	ld	a,#1
 676  0038 cd0000        	call	_TIM2_ClearITPendingBit
 679                     ; 305 }
 682  003b 85            	popw	x
 683  003c bf00          	ldw	c_y,x
 684  003e 320002        	pop	c_y+2
 685  0041 85            	popw	x
 686  0042 bf00          	ldw	c_x,x
 687  0044 320002        	pop	c_x+2
 688  0047 80            	iret
 689  0048               L152:
 690                     ; 302 			GPIO_WriteBit(GPIOE, GPIO_Pin_5, SET);
 692  0048 4b01          	push	#1
 693  004a 4b20          	push	#32
 694  004c ae5014        	ldw	x,#20500
 695  004f cd0000        	call	_GPIO_WriteBit
 697  0052 85            	popw	x
 698  0053               L552:
 699                     ; 303 			while(1);
 701  0053 20fe          	jra	L552
 724                     ; 312 INTERRUPT_HANDLER(TIM2_CC_USART2_RX_IRQHandler,20)
 724                     ; 313 {
 725                     	switch	.text
 726  0055               f_TIM2_CC_USART2_RX_IRQHandler:
 730                     ; 317 }
 733  0055 80            	iret
 757                     ; 325 INTERRUPT_HANDLER(TIM3_UPD_OVF_TRG_BRK_USART3_TX_IRQHandler,21)
 757                     ; 326 {
 758                     	switch	.text
 759  0056               f_TIM3_UPD_OVF_TRG_BRK_USART3_TX_IRQHandler:
 763                     ; 330 }
 766  0056 80            	iret
 789                     ; 336 INTERRUPT_HANDLER(TIM3_CC_USART3_RX_IRQHandler,22)
 789                     ; 337 {
 790                     	switch	.text
 791  0057               f_TIM3_CC_USART3_RX_IRQHandler:
 795                     ; 341 }
 798  0057 80            	iret
 821                     ; 347 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_COM_IRQHandler,23)
 821                     ; 348 {
 822                     	switch	.text
 823  0058               f_TIM1_UPD_OVF_TRG_COM_IRQHandler:
 827                     ; 352 }
 830  0058 80            	iret
 852                     ; 358 INTERRUPT_HANDLER(TIM1_CC_IRQHandler,24)
 852                     ; 359 {
 853                     	switch	.text
 854  0059               f_TIM1_CC_IRQHandler:
 858                     ; 363 }
 861  0059 80            	iret
 884                     ; 370 INTERRUPT_HANDLER(TIM4_UPD_OVF_TRG_IRQHandler,25)
 884                     ; 371 {
 885                     	switch	.text
 886  005a               f_TIM4_UPD_OVF_TRG_IRQHandler:
 890                     ; 375 }
 893  005a 80            	iret
 915                     ; 381 INTERRUPT_HANDLER(SPI1_IRQHandler,26)
 915                     ; 382 {
 916                     	switch	.text
 917  005b               f_SPI1_IRQHandler:
 921                     ; 386 }
 924  005b 80            	iret
 948                     ; 393 INTERRUPT_HANDLER(USART1_TX_TIM5_UPD_OVF_TRG_BRK_IRQHandler,27)
 948                     ; 394 {
 949                     	switch	.text
 950  005c               f_USART1_TX_TIM5_UPD_OVF_TRG_BRK_IRQHandler:
 954                     ; 398 }
 957  005c 80            	iret
 980                     ; 405 INTERRUPT_HANDLER(USART1_RX_TIM5_CC_IRQHandler,28)
 980                     ; 406 {
 981                     	switch	.text
 982  005d               f_USART1_RX_TIM5_CC_IRQHandler:
 986                     ; 410 }
 989  005d 80            	iret
1012                     ; 417 INTERRUPT_HANDLER(I2C1_SPI2_IRQHandler,29)
1012                     ; 418 {
1013                     	switch	.text
1014  005e               f_I2C1_SPI2_IRQHandler:
1018                     ; 422 }
1021  005e 80            	iret
1033                     	xref.b	_millis
1034                     	xdef	f_I2C1_SPI2_IRQHandler
1035                     	xdef	f_USART1_RX_TIM5_CC_IRQHandler
1036                     	xdef	f_USART1_TX_TIM5_UPD_OVF_TRG_BRK_IRQHandler
1037                     	xdef	f_SPI1_IRQHandler
1038                     	xdef	f_TIM4_UPD_OVF_TRG_IRQHandler
1039                     	xdef	f_TIM1_CC_IRQHandler
1040                     	xdef	f_TIM1_UPD_OVF_TRG_COM_IRQHandler
1041                     	xdef	f_TIM3_CC_USART3_RX_IRQHandler
1042                     	xdef	f_TIM3_UPD_OVF_TRG_BRK_USART3_TX_IRQHandler
1043                     	xdef	f_TIM2_CC_USART2_RX_IRQHandler
1044                     	xdef	f_TIM2_UPD_OVF_TRG_BRK_USART2_TX_IRQHandler
1045                     	xdef	f_ADC1_COMP_IRQHandler
1046                     	xdef	f_SWITCH_CSS_BREAK_DAC_IRQHandler
1047                     	xdef	f_LCD_AES_IRQHandler
1048                     	xdef	f_EXTI7_IRQHandler
1049                     	xdef	f_EXTI6_IRQHandler
1050                     	xdef	f_EXTI5_IRQHandler
1051                     	xdef	f_EXTI4_IRQHandler
1052                     	xdef	f_EXTI3_IRQHandler
1053                     	xdef	f_EXTI2_IRQHandler
1054                     	xdef	f_EXTI1_IRQHandler
1055                     	xdef	f_EXTI0_IRQHandler
1056                     	xdef	f_EXTID_H_IRQHandler
1057                     	xdef	f_EXTIB_G_IRQHandler
1058                     	xdef	f_EXTIE_F_PVD_IRQHandler
1059                     	xdef	f_RTC_CSSLSE_IRQHandler
1060                     	xdef	f_DMA1_CHANNEL2_3_IRQHandler
1061                     	xdef	f_DMA1_CHANNEL0_1_IRQHandler
1062                     	xdef	f_FLASH_IRQHandler
1063                     	xdef	f_TRAP_IRQHandler
1064                     	xref	_TIM2_ClearITPendingBit
1065                     	xref	_TIM2_GetITStatus
1066                     	xref	_GPIO_WriteBit
1067                     	xref.b	c_x
1068                     	xref.b	c_y
1087                     	xref	c_lgadc
1088                     	end
