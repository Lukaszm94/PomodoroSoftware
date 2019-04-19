   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  62                     ; 20 /*static inline*/ void delay_ms(uint16_t ms) {
  64                     	switch	.text
  65  0000               _delay_ms:
  67  0000 89            	pushw	x
  68  0001 5204          	subw	sp,#4
  69       00000004      OFST:	set	4
  72                     ; 22     for (i = 0; i < ((2000000UL / 18000UL) * ms); i++) {
  74  0003 ae0000        	ldw	x,#0
  75  0006 1f03          	ldw	(OFST-1,sp),x
  76  0008 ae0000        	ldw	x,#0
  77  000b 1f01          	ldw	(OFST-3,sp),x
  80  000d 200a          	jra	L73
  81  000f               L33:
  82                     ; 24 			nop
  85  000f 9d            nop
  87                     ; 22     for (i = 0; i < ((2000000UL / 18000UL) * ms); i++) {
  89  0010 96            	ldw	x,sp
  90  0011 1c0001        	addw	x,#OFST-3
  91  0014 a601          	ld	a,#1
  92  0016 cd0000        	call	c_lgadc
  95  0019               L73:
  98  0019 1e05          	ldw	x,(OFST+1,sp)
  99  001b a66f          	ld	a,#111
 100  001d cd0000        	call	c_cmulx
 102  0020 96            	ldw	x,sp
 103  0021 1c0001        	addw	x,#OFST-3
 104  0024 cd0000        	call	c_lcmp
 106  0027 22e6          	jrugt	L33
 107                     ; 27 }
 110  0029 5b06          	addw	sp,#6
 111  002b 81            	ret
 139                     ; 29 void configTIM2(void)
 139                     ; 30 {
 140                     	switch	.text
 141  002c               _configTIM2:
 145                     ; 31 	CLK_PeripheralClockConfig(CLK_Peripheral_TIM2, ENABLE); // enable passing clock to TIM2 module
 147  002c ae0001        	ldw	x,#1
 148  002f cd0000        	call	_CLK_PeripheralClockConfig
 150                     ; 32 	TIM2_TimeBaseInit(TIM2_Prescaler_1, TIM2_CounterMode_Up, 2000); // setup time-base
 152  0032 ae07d0        	ldw	x,#2000
 153  0035 89            	pushw	x
 154  0036 5f            	clrw	x
 155  0037 cd0000        	call	_TIM2_TimeBaseInit
 157  003a 85            	popw	x
 158                     ; 33 	TIM2_ITConfig(TIM2_IT_Update, ENABLE); // setup interrupts
 160  003b ae0101        	ldw	x,#257
 161  003e cd0000        	call	_TIM2_ITConfig
 163                     ; 34 	TIM2_Cmd(ENABLE);
 165  0041 a601          	ld	a,#1
 166  0043 cd0000        	call	_TIM2_Cmd
 168                     ; 35 	enableInterrupts(); // global interrupts enable
 171  0046 9a            rim
 173                     ; 36 }
 177  0047 81            	ret
 203                     ; 38 void configUSART(void)
 203                     ; 39 {
 204                     	switch	.text
 205  0048               _configUSART:
 209                     ; 40 	CLK_PeripheralClockConfig(CLK_Peripheral_USART1, ENABLE);
 211  0048 ae0501        	ldw	x,#1281
 212  004b cd0000        	call	_CLK_PeripheralClockConfig
 214                     ; 41 	USART_Init(USART1, UART_BAUDRATE, USART_WordLength_8b, USART_StopBits_1, USART_Parity_No, USART_Mode_Tx);
 216  004e 4b08          	push	#8
 217  0050 4b00          	push	#0
 218  0052 4b00          	push	#0
 219  0054 4b00          	push	#0
 220  0056 aee100        	ldw	x,#57600
 221  0059 89            	pushw	x
 222  005a ae0000        	ldw	x,#0
 223  005d 89            	pushw	x
 224  005e ae5230        	ldw	x,#21040
 225  0061 cd0000        	call	_USART_Init
 227  0064 5b08          	addw	sp,#8
 228                     ; 42 	USART_Cmd(USART1, ENABLE);
 230  0066 4b01          	push	#1
 231  0068 ae5230        	ldw	x,#21040
 232  006b cd0000        	call	_USART_Cmd
 234  006e 84            	pop	a
 235                     ; 43 }
 238  006f 81            	ret
 275                     ; 45 void serialSendByteBlocking(uint8_t byte)
 275                     ; 46 {
 276                     	switch	.text
 277  0070               _serialSendByteBlocking:
 279  0070 88            	push	a
 280       00000000      OFST:	set	0
 283  0071               L301:
 284                     ; 47 	while(USART_GetFlagStatus(USART1, USART_FLAG_TXE) != SET);
 286  0071 ae0080        	ldw	x,#128
 287  0074 89            	pushw	x
 288  0075 ae5230        	ldw	x,#21040
 289  0078 cd0000        	call	_USART_GetFlagStatus
 291  007b 85            	popw	x
 292  007c a101          	cp	a,#1
 293  007e 26f1          	jrne	L301
 294                     ; 48 	USART_SendData8(USART1, byte);
 296  0080 7b01          	ld	a,(OFST+1,sp)
 297  0082 88            	push	a
 298  0083 ae5230        	ldw	x,#21040
 299  0086 cd0000        	call	_USART_SendData8
 301  0089 84            	pop	a
 302                     ; 49 }
 305  008a 84            	pop	a
 306  008b 81            	ret
 343                     ; 51 void serialSendStringBlocking(char *buffer)
 343                     ; 52 {
 344                     	switch	.text
 345  008c               _serialSendStringBlocking:
 347  008c 89            	pushw	x
 348       00000000      OFST:	set	0
 351  008d 200c          	jra	L721
 352  008f               L521:
 353                     ; 54 		serialSendByteBlocking(*buffer);
 355  008f 1e01          	ldw	x,(OFST+1,sp)
 356  0091 f6            	ld	a,(x)
 357  0092 addc          	call	_serialSendByteBlocking
 359                     ; 55 		buffer++;
 361  0094 1e01          	ldw	x,(OFST+1,sp)
 362  0096 1c0001        	addw	x,#1
 363  0099 1f01          	ldw	(OFST+1,sp),x
 364  009b               L721:
 365                     ; 53 	while(*buffer != 0x00) {
 367  009b 1e01          	ldw	x,(OFST+1,sp)
 368  009d 7d            	tnz	(x)
 369  009e 26ef          	jrne	L521
 370                     ; 57 }
 373  00a0 85            	popw	x
 374  00a1 81            	ret
 403                     ; 65 void main(void)
 403                     ; 66 {
 404                     	switch	.text
 405  00a2               _main:
 409                     ; 67 	delay_ms(100);
 411  00a2 ae0064        	ldw	x,#100
 412  00a5 cd0000        	call	_delay_ms
 414                     ; 68 	GPIO_Init(GPIOE, GPIO_Pin_5, GPIO_Mode_Out_PP_Low_Slow);
 416  00a8 4bc0          	push	#192
 417  00aa 4b20          	push	#32
 418  00ac ae5014        	ldw	x,#20500
 419  00af cd0000        	call	_GPIO_Init
 421  00b2 85            	popw	x
 422                     ; 69 	GPIO_Init(GPIOE, GPIO_Pin_7, GPIO_Mode_Out_PP_Low_Slow);
 424  00b3 4bc0          	push	#192
 425  00b5 4b80          	push	#128
 426  00b7 ae5014        	ldw	x,#20500
 427  00ba cd0000        	call	_GPIO_Init
 429  00bd 85            	popw	x
 430                     ; 70 	configTIM2();
 432  00be cd002c        	call	_configTIM2
 434                     ; 71 	configUSART();
 436  00c1 ad85          	call	_configUSART
 438  00c3               L341:
 439                     ; 76 		GPIO_WriteBit(GPIOE, GPIO_Pin_5, SET);
 441  00c3 4b01          	push	#1
 442  00c5 4b20          	push	#32
 443  00c7 ae5014        	ldw	x,#20500
 444  00ca cd0000        	call	_GPIO_WriteBit
 446  00cd 85            	popw	x
 447                     ; 77 		delay_ms(100);
 449  00ce ae0064        	ldw	x,#100
 450  00d1 cd0000        	call	_delay_ms
 452                     ; 78 		GPIO_WriteBit(GPIOE, GPIO_Pin_5, RESET);
 454  00d4 4b00          	push	#0
 455  00d6 4b20          	push	#32
 456  00d8 ae5014        	ldw	x,#20500
 457  00db cd0000        	call	_GPIO_WriteBit
 459  00de 85            	popw	x
 460                     ; 79 		delay_ms(100);
 462  00df ae0064        	ldw	x,#100
 463  00e2 cd0000        	call	_delay_ms
 465                     ; 80 		serialSendStringBlocking("Hello!\n");
 467  00e5 ae0000        	ldw	x,#L741
 468  00e8 ada2          	call	_serialSendStringBlocking
 471  00ea 20d7          	jra	L341
 506                     ; 93 void assert_failed(uint8_t* file, uint32_t line)
 506                     ; 94 { 
 507                     	switch	.text
 508  00ec               _assert_failed:
 512  00ec               L761:
 513  00ec 20fe          	jra	L761
 537                     	xdef	_main
 538                     	xdef	_serialSendStringBlocking
 539                     	xdef	_serialSendByteBlocking
 540                     	xdef	_configUSART
 541                     	xdef	_configTIM2
 542                     	xdef	_delay_ms
 543                     	switch	.ubsct
 544  0000               _millis:
 545  0000 00000000      	ds.b	4
 546                     	xdef	_millis
 547                     	xdef	_assert_failed
 548                     	xref	_USART_GetFlagStatus
 549                     	xref	_USART_SendData8
 550                     	xref	_USART_Cmd
 551                     	xref	_USART_Init
 552                     	xref	_TIM2_ITConfig
 553                     	xref	_TIM2_Cmd
 554                     	xref	_TIM2_TimeBaseInit
 555                     	xref	_GPIO_WriteBit
 556                     	xref	_GPIO_Init
 557                     	xref	_CLK_PeripheralClockConfig
 558                     .const:	section	.text
 559  0000               L741:
 560  0000 48656c6c6f21  	dc.b	"Hello!",10,0
 580                     	xref	c_lcmp
 581                     	xref	c_cmulx
 582                     	xref	c_lgadc
 583                     	end
