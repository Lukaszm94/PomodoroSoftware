   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
 162                     ; 148 void USART_DeInit(USART_TypeDef* USARTx)
 162                     ; 149 {
 164                     	switch	.text
 165  0000               _USART_DeInit:
 169                     ; 153   (void) USARTx->SR;
 171  0000 f6            	ld	a,(x)
 172                     ; 154   (void) USARTx->DR;
 174  0001 e601          	ld	a,(1,x)
 175                     ; 156   USARTx->BRR2 = USART_BRR2_RESET_VALUE;  /* Set USART_BRR2 to reset value 0x00 */
 177  0003 6f03          	clr	(3,x)
 178                     ; 157   USARTx->BRR1 = USART_BRR1_RESET_VALUE;  /* Set USART_BRR1 to reset value 0x00 */
 180  0005 6f02          	clr	(2,x)
 181                     ; 159   USARTx->CR1 = USART_CR1_RESET_VALUE;  /* Set USART_CR1 to reset value 0x00 */
 183  0007 6f04          	clr	(4,x)
 184                     ; 160   USARTx->CR2 = USART_CR2_RESET_VALUE;  /* Set USART_CR2 to reset value 0x00 */
 186  0009 6f05          	clr	(5,x)
 187                     ; 161   USARTx->CR3 = USART_CR3_RESET_VALUE;  /* Set USART_CR3 to reset value 0x00 */
 189  000b 6f06          	clr	(6,x)
 190                     ; 162   USARTx->CR4 = USART_CR4_RESET_VALUE;  /* Set USART_CR4 to reset value 0x00 */
 192  000d 6f07          	clr	(7,x)
 193                     ; 163 }
 196  000f 81            	ret
 389                     .const:	section	.text
 390  0000               L21:
 391  0000 00098969      	dc.l	625001
 392                     ; 192 void USART_Init(USART_TypeDef* USARTx, uint32_t BaudRate, USART_WordLength_TypeDef
 392                     ; 193                 USART_WordLength, USART_StopBits_TypeDef USART_StopBits,
 392                     ; 194                 USART_Parity_TypeDef USART_Parity,  USART_Mode_TypeDef USART_Mode)
 392                     ; 195 {
 393                     	switch	.text
 394  0010               _USART_Init:
 396  0010 89            	pushw	x
 397  0011 5204          	subw	sp,#4
 398       00000004      OFST:	set	4
 401                     ; 196   uint32_t BaudRate_Mantissa = 0;
 403                     ; 199   assert_param(IS_USART_BAUDRATE(BaudRate));
 405  0013 96            	ldw	x,sp
 406  0014 1c0009        	addw	x,#OFST+5
 407  0017 cd0000        	call	c_ltor
 409  001a ae0000        	ldw	x,#L21
 410  001d cd0000        	call	c_lcmp
 412  0020 2403          	jruge	L01
 413  0022 4f            	clr	a
 414  0023 2010          	jra	L41
 415  0025               L01:
 416  0025 ae00c7        	ldw	x,#199
 417  0028 89            	pushw	x
 418  0029 ae0000        	ldw	x,#0
 419  002c 89            	pushw	x
 420  002d ae0004        	ldw	x,#L522
 421  0030 cd0000        	call	_assert_failed
 423  0033 5b04          	addw	sp,#4
 424  0035               L41:
 425                     ; 201   assert_param(IS_USART_WORDLENGTH(USART_WordLength));
 427  0035 0d0d          	tnz	(OFST+9,sp)
 428  0037 2706          	jreq	L02
 429  0039 7b0d          	ld	a,(OFST+9,sp)
 430  003b a110          	cp	a,#16
 431  003d 2603          	jrne	L61
 432  003f               L02:
 433  003f 4f            	clr	a
 434  0040 2010          	jra	L22
 435  0042               L61:
 436  0042 ae00c9        	ldw	x,#201
 437  0045 89            	pushw	x
 438  0046 ae0000        	ldw	x,#0
 439  0049 89            	pushw	x
 440  004a ae0004        	ldw	x,#L522
 441  004d cd0000        	call	_assert_failed
 443  0050 5b04          	addw	sp,#4
 444  0052               L22:
 445                     ; 203   assert_param(IS_USART_STOPBITS(USART_StopBits));
 447  0052 0d0e          	tnz	(OFST+10,sp)
 448  0054 270c          	jreq	L62
 449  0056 7b0e          	ld	a,(OFST+10,sp)
 450  0058 a130          	cp	a,#48
 451  005a 2706          	jreq	L62
 452  005c 7b0e          	ld	a,(OFST+10,sp)
 453  005e a120          	cp	a,#32
 454  0060 2603          	jrne	L42
 455  0062               L62:
 456  0062 4f            	clr	a
 457  0063 2010          	jra	L03
 458  0065               L42:
 459  0065 ae00cb        	ldw	x,#203
 460  0068 89            	pushw	x
 461  0069 ae0000        	ldw	x,#0
 462  006c 89            	pushw	x
 463  006d ae0004        	ldw	x,#L522
 464  0070 cd0000        	call	_assert_failed
 466  0073 5b04          	addw	sp,#4
 467  0075               L03:
 468                     ; 205   assert_param(IS_USART_PARITY(USART_Parity));
 470  0075 0d0f          	tnz	(OFST+11,sp)
 471  0077 270c          	jreq	L43
 472  0079 7b0f          	ld	a,(OFST+11,sp)
 473  007b a104          	cp	a,#4
 474  007d 2706          	jreq	L43
 475  007f 7b0f          	ld	a,(OFST+11,sp)
 476  0081 a106          	cp	a,#6
 477  0083 2603          	jrne	L23
 478  0085               L43:
 479  0085 4f            	clr	a
 480  0086 2010          	jra	L63
 481  0088               L23:
 482  0088 ae00cd        	ldw	x,#205
 483  008b 89            	pushw	x
 484  008c ae0000        	ldw	x,#0
 485  008f 89            	pushw	x
 486  0090 ae0004        	ldw	x,#L522
 487  0093 cd0000        	call	_assert_failed
 489  0096 5b04          	addw	sp,#4
 490  0098               L63:
 491                     ; 207   assert_param(IS_USART_MODE(USART_Mode));
 493  0098 7b10          	ld	a,(OFST+12,sp)
 494  009a a5f3          	bcp	a,#243
 495  009c 2607          	jrne	L04
 496  009e 0d10          	tnz	(OFST+12,sp)
 497  00a0 2703          	jreq	L04
 498  00a2 4f            	clr	a
 499  00a3 2010          	jra	L24
 500  00a5               L04:
 501  00a5 ae00cf        	ldw	x,#207
 502  00a8 89            	pushw	x
 503  00a9 ae0000        	ldw	x,#0
 504  00ac 89            	pushw	x
 505  00ad ae0004        	ldw	x,#L522
 506  00b0 cd0000        	call	_assert_failed
 508  00b3 5b04          	addw	sp,#4
 509  00b5               L24:
 510                     ; 210   USARTx->CR1 &= (uint8_t)(~(USART_CR1_PCEN | USART_CR1_PS | USART_CR1_M));
 512  00b5 1e05          	ldw	x,(OFST+1,sp)
 513  00b7 e604          	ld	a,(4,x)
 514  00b9 a4e9          	and	a,#233
 515  00bb e704          	ld	(4,x),a
 516                     ; 213   USARTx->CR1 |= (uint8_t)((uint8_t)USART_WordLength | (uint8_t)USART_Parity);
 518  00bd 1e05          	ldw	x,(OFST+1,sp)
 519  00bf 7b0d          	ld	a,(OFST+9,sp)
 520  00c1 1a0f          	or	a,(OFST+11,sp)
 521  00c3 ea04          	or	a,(4,x)
 522  00c5 e704          	ld	(4,x),a
 523                     ; 216   USARTx->CR3 &= (uint8_t)(~USART_CR3_STOP);
 525  00c7 1e05          	ldw	x,(OFST+1,sp)
 526  00c9 e606          	ld	a,(6,x)
 527  00cb a4cf          	and	a,#207
 528  00cd e706          	ld	(6,x),a
 529                     ; 218   USARTx->CR3 |= (uint8_t)USART_StopBits;
 531  00cf 1e05          	ldw	x,(OFST+1,sp)
 532  00d1 e606          	ld	a,(6,x)
 533  00d3 1a0e          	or	a,(OFST+10,sp)
 534  00d5 e706          	ld	(6,x),a
 535                     ; 221   USARTx->BRR1 &= (uint8_t)(~USART_BRR1_DIVM);
 537  00d7 1e05          	ldw	x,(OFST+1,sp)
 538  00d9 6f02          	clr	(2,x)
 539                     ; 223   USARTx->BRR2 &= (uint8_t)(~USART_BRR2_DIVM);
 541  00db 1e05          	ldw	x,(OFST+1,sp)
 542  00dd e603          	ld	a,(3,x)
 543  00df a40f          	and	a,#15
 544  00e1 e703          	ld	(3,x),a
 545                     ; 225   USARTx->BRR2 &= (uint8_t)(~USART_BRR2_DIVF);
 547  00e3 1e05          	ldw	x,(OFST+1,sp)
 548  00e5 e603          	ld	a,(3,x)
 549  00e7 a4f0          	and	a,#240
 550  00e9 e703          	ld	(3,x),a
 551                     ; 227   BaudRate_Mantissa  = (uint32_t)(CLK_GetClockFreq() / BaudRate );
 553  00eb cd0000        	call	_CLK_GetClockFreq
 555  00ee 96            	ldw	x,sp
 556  00ef 1c0009        	addw	x,#OFST+5
 557  00f2 cd0000        	call	c_ludv
 559  00f5 96            	ldw	x,sp
 560  00f6 1c0001        	addw	x,#OFST-3
 561  00f9 cd0000        	call	c_rtol
 564                     ; 229   USARTx->BRR2 = (uint8_t)((BaudRate_Mantissa >> (uint8_t)8) & (uint8_t)0xF0);
 566  00fc 7b03          	ld	a,(OFST-1,sp)
 567  00fe a4f0          	and	a,#240
 568  0100 1e05          	ldw	x,(OFST+1,sp)
 569  0102 e703          	ld	(3,x),a
 570                     ; 231   USARTx->BRR2 |= (uint8_t)(BaudRate_Mantissa & (uint8_t)0x0F);
 572  0104 1e05          	ldw	x,(OFST+1,sp)
 573  0106 7b04          	ld	a,(OFST+0,sp)
 574  0108 a40f          	and	a,#15
 575  010a ea03          	or	a,(3,x)
 576  010c e703          	ld	(3,x),a
 577                     ; 233   USARTx->BRR1 = (uint8_t)(BaudRate_Mantissa >> (uint8_t)4);
 579  010e 96            	ldw	x,sp
 580  010f 1c0001        	addw	x,#OFST-3
 581  0112 cd0000        	call	c_ltor
 583  0115 a604          	ld	a,#4
 584  0117 cd0000        	call	c_lursh
 586  011a b603          	ld	a,c_lreg+3
 587  011c 1e05          	ldw	x,(OFST+1,sp)
 588  011e e702          	ld	(2,x),a
 589                     ; 236   USARTx->CR2 &= (uint8_t)~(USART_CR2_TEN | USART_CR2_REN);
 591  0120 1e05          	ldw	x,(OFST+1,sp)
 592  0122 e605          	ld	a,(5,x)
 593  0124 a4f3          	and	a,#243
 594  0126 e705          	ld	(5,x),a
 595                     ; 238   USARTx->CR2 |= (uint8_t)USART_Mode;
 597  0128 1e05          	ldw	x,(OFST+1,sp)
 598  012a e605          	ld	a,(5,x)
 599  012c 1a10          	or	a,(OFST+12,sp)
 600  012e e705          	ld	(5,x),a
 601                     ; 239 }
 604  0130 5b06          	addw	sp,#6
 605  0132 81            	ret
 672                     ; 249 void USART_Cmd(USART_TypeDef* USARTx, FunctionalState NewState)
 672                     ; 250 {
 673                     	switch	.text
 674  0133               _USART_Cmd:
 676  0133 89            	pushw	x
 677       00000000      OFST:	set	0
 680                     ; 251   if (NewState != DISABLE)
 682  0134 0d05          	tnz	(OFST+5,sp)
 683  0136 2708          	jreq	L362
 684                     ; 253     USARTx->CR1 &= (uint8_t)(~USART_CR1_USARTD); /**< USART Enable */
 686  0138 e604          	ld	a,(4,x)
 687  013a a4df          	and	a,#223
 688  013c e704          	ld	(4,x),a
 690  013e 2008          	jra	L562
 691  0140               L362:
 692                     ; 257     USARTx->CR1 |= USART_CR1_USARTD;  /**< USART Disable (for low power consumption) */
 694  0140 1e01          	ldw	x,(OFST+1,sp)
 695  0142 e604          	ld	a,(4,x)
 696  0144 aa20          	or	a,#32
 697  0146 e704          	ld	(4,x),a
 698  0148               L562:
 699                     ; 259 }
 702  0148 85            	popw	x
 703  0149 81            	ret
 740                     ; 298 uint8_t USART_ReceiveData8(USART_TypeDef* USARTx)
 740                     ; 299 {
 741                     	switch	.text
 742  014a               _USART_ReceiveData8:
 746                     ; 300   return USARTx->DR;
 748  014a e601          	ld	a,(1,x)
 751  014c 81            	ret
 797                     ; 308 void USART_SendData8(USART_TypeDef* USARTx, uint8_t Data)
 797                     ; 309 {
 798                     	switch	.text
 799  014d               _USART_SendData8:
 801  014d 89            	pushw	x
 802       00000000      OFST:	set	0
 805                     ; 311   USARTx->DR = Data;
 807  014e 7b05          	ld	a,(OFST+5,sp)
 808  0150 1e01          	ldw	x,(OFST+1,sp)
 809  0152 e701          	ld	(1,x),a
 810                     ; 312 }
 813  0154 85            	popw	x
 814  0155 81            	ret
 963                     ; 332 FlagStatus USART_GetFlagStatus(USART_TypeDef* USARTx, USART_FLAG_TypeDef USART_FLAG)
 963                     ; 333 {
 964                     	switch	.text
 965  0156               _USART_GetFlagStatus:
 967  0156 89            	pushw	x
 968  0157 88            	push	a
 969       00000001      OFST:	set	1
 972                     ; 334   FlagStatus status = RESET;
 974                     ; 337   assert_param(IS_USART_FLAG(USART_FLAG));
 976  0158 1e06          	ldw	x,(OFST+5,sp)
 977  015a a30080        	cpw	x,#128
 978  015d 2738          	jreq	L65
 979  015f 1e06          	ldw	x,(OFST+5,sp)
 980  0161 a30040        	cpw	x,#64
 981  0164 2731          	jreq	L65
 982  0166 1e06          	ldw	x,(OFST+5,sp)
 983  0168 a30020        	cpw	x,#32
 984  016b 272a          	jreq	L65
 985  016d 1e06          	ldw	x,(OFST+5,sp)
 986  016f a30010        	cpw	x,#16
 987  0172 2723          	jreq	L65
 988  0174 1e06          	ldw	x,(OFST+5,sp)
 989  0176 a30008        	cpw	x,#8
 990  0179 271c          	jreq	L65
 991  017b 1e06          	ldw	x,(OFST+5,sp)
 992  017d a30004        	cpw	x,#4
 993  0180 2715          	jreq	L65
 994  0182 1e06          	ldw	x,(OFST+5,sp)
 995  0184 a30002        	cpw	x,#2
 996  0187 270e          	jreq	L65
 997  0189 1e06          	ldw	x,(OFST+5,sp)
 998  018b a30001        	cpw	x,#1
 999  018e 2707          	jreq	L65
1000  0190 1e06          	ldw	x,(OFST+5,sp)
1001  0192 a30101        	cpw	x,#257
1002  0195 2603          	jrne	L45
1003  0197               L65:
1004  0197 4f            	clr	a
1005  0198 2010          	jra	L06
1006  019a               L45:
1007  019a ae0151        	ldw	x,#337
1008  019d 89            	pushw	x
1009  019e ae0000        	ldw	x,#0
1010  01a1 89            	pushw	x
1011  01a2 ae0004        	ldw	x,#L522
1012  01a5 cd0000        	call	_assert_failed
1014  01a8 5b04          	addw	sp,#4
1015  01aa               L06:
1016                     ; 339   if (USART_FLAG == USART_FLAG_SBK)
1018  01aa 1e06          	ldw	x,(OFST+5,sp)
1019  01ac a30101        	cpw	x,#257
1020  01af 2612          	jrne	L124
1021                     ; 341     if ((USARTx->CR2 & (uint8_t)USART_FLAG) != (uint8_t)0x00)
1023  01b1 1e02          	ldw	x,(OFST+1,sp)
1024  01b3 e605          	ld	a,(5,x)
1025  01b5 1507          	bcp	a,(OFST+6,sp)
1026  01b7 2706          	jreq	L324
1027                     ; 344       status = SET;
1029  01b9 a601          	ld	a,#1
1030  01bb 6b01          	ld	(OFST+0,sp),a
1033  01bd 2013          	jra	L724
1034  01bf               L324:
1035                     ; 349       status = RESET;
1037  01bf 0f01          	clr	(OFST+0,sp)
1039  01c1 200f          	jra	L724
1040  01c3               L124:
1041                     ; 354     if ((USARTx->SR & (uint8_t)USART_FLAG) != (uint8_t)0x00)
1043  01c3 1e02          	ldw	x,(OFST+1,sp)
1044  01c5 f6            	ld	a,(x)
1045  01c6 1507          	bcp	a,(OFST+6,sp)
1046  01c8 2706          	jreq	L134
1047                     ; 357       status = SET;
1049  01ca a601          	ld	a,#1
1050  01cc 6b01          	ld	(OFST+0,sp),a
1053  01ce 2002          	jra	L724
1054  01d0               L134:
1055                     ; 362       status = RESET;
1057  01d0 0f01          	clr	(OFST+0,sp)
1059  01d2               L724:
1060                     ; 366   return status;
1062  01d2 7b01          	ld	a,(OFST+0,sp)
1065  01d4 5b03          	addw	sp,#3
1066  01d6 81            	ret
1114                     ; 390 void USART_ClearFlag(USART_TypeDef* USARTx, USART_FLAG_TypeDef USART_FLAG)
1114                     ; 391 {
1115                     	switch	.text
1116  01d7               _USART_ClearFlag:
1118  01d7 89            	pushw	x
1119       00000000      OFST:	set	0
1122                     ; 393   assert_param(IS_USART_CLEAR_FLAG(USART_FLAG));
1124  01d8 1e05          	ldw	x,(OFST+5,sp)
1125  01da a30040        	cpw	x,#64
1126  01dd 2603          	jrne	L46
1127  01df 4f            	clr	a
1128  01e0 2010          	jra	L66
1129  01e2               L46:
1130  01e2 ae0189        	ldw	x,#393
1131  01e5 89            	pushw	x
1132  01e6 ae0000        	ldw	x,#0
1133  01e9 89            	pushw	x
1134  01ea ae0004        	ldw	x,#L522
1135  01ed cd0000        	call	_assert_failed
1137  01f0 5b04          	addw	sp,#4
1138  01f2               L66:
1139                     ; 395   USARTx->SR = (uint8_t)((uint16_t)~((uint16_t)USART_FLAG));
1141  01f2 7b06          	ld	a,(OFST+6,sp)
1142  01f4 43            	cpl	a
1143  01f5 1e01          	ldw	x,(OFST+1,sp)
1144  01f7 f7            	ld	(x),a
1145                     ; 396 }
1148  01f8 85            	popw	x
1149  01f9 81            	ret
1162                     	xdef	_USART_ClearFlag
1163                     	xdef	_USART_GetFlagStatus
1164                     	xdef	_USART_ReceiveData8
1165                     	xdef	_USART_SendData8
1166                     	xdef	_USART_Cmd
1167                     	xdef	_USART_Init
1168                     	xdef	_USART_DeInit
1169                     	xref	_assert_failed
1170                     	xref	_CLK_GetClockFreq
1171                     	switch	.const
1172  0004               L522:
1173  0004 73746d386c31  	dc.b	"stm8l15x_usart.c",0
1174                     	xref.b	c_lreg
1175                     	xref.b	c_x
1195                     	xref	c_lursh
1196                     	xref	c_rtol
1197                     	xref	c_ludv
1198                     	xref	c_lcmp
1199                     	xref	c_ltor
1200                     	end
