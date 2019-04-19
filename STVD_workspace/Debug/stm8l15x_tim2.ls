   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  42                     ; 160 void TIM2_DeInit(void)
  42                     ; 161 {
  44                     	switch	.text
  45  0000               _TIM2_DeInit:
  49                     ; 162   TIM2->CR1 = TIM_CR1_RESET_VALUE;
  51  0000 725f5250      	clr	21072
  52                     ; 163   TIM2->CR2 = TIM_CR2_RESET_VALUE;
  54  0004 725f5251      	clr	21073
  55                     ; 164   TIM2->SMCR = TIM_SMCR_RESET_VALUE;
  57  0008 725f5252      	clr	21074
  58                     ; 165   TIM2->ETR = TIM_ETR_RESET_VALUE;
  60  000c 725f5253      	clr	21075
  61                     ; 166   TIM2->IER = TIM_IER_RESET_VALUE;
  63  0010 725f5255      	clr	21077
  64                     ; 167   TIM2->SR2 = TIM_SR2_RESET_VALUE;
  66  0014 725f5257      	clr	21079
  67                     ; 170   TIM2->CCER1 = TIM_CCER1_RESET_VALUE;
  69  0018 725f525b      	clr	21083
  70                     ; 172   TIM2->CCMR1 = 0x01;/*TIM2_ICxSource_TIxFPx */
  72  001c 35015259      	mov	21081,#1
  73                     ; 173   TIM2->CCMR2 = 0x01;/*TIM2_ICxSource_TIxFPx */
  75  0020 3501525a      	mov	21082,#1
  76                     ; 176   TIM2->CCER1 = TIM_CCER1_RESET_VALUE;
  78  0024 725f525b      	clr	21083
  79                     ; 177   TIM2->CCMR1 = TIM_CCMR1_RESET_VALUE;
  81  0028 725f5259      	clr	21081
  82                     ; 178   TIM2->CCMR2 = TIM_CCMR2_RESET_VALUE;
  84  002c 725f525a      	clr	21082
  85                     ; 180   TIM2->CNTRH = TIM_CNTRH_RESET_VALUE;
  87  0030 725f525c      	clr	21084
  88                     ; 181   TIM2->CNTRL = TIM_CNTRL_RESET_VALUE;
  90  0034 725f525d      	clr	21085
  91                     ; 183   TIM2->PSCR = TIM_PSCR_RESET_VALUE;
  93  0038 725f525e      	clr	21086
  94                     ; 185   TIM2->ARRH = TIM_ARRH_RESET_VALUE;
  96  003c 35ff525f      	mov	21087,#255
  97                     ; 186   TIM2->ARRL = TIM_ARRL_RESET_VALUE;
  99  0040 35ff5260      	mov	21088,#255
 100                     ; 188   TIM2->CCR1H = TIM_CCR1H_RESET_VALUE;
 102  0044 725f5261      	clr	21089
 103                     ; 189   TIM2->CCR1L = TIM_CCR1L_RESET_VALUE;
 105  0048 725f5262      	clr	21090
 106                     ; 190   TIM2->CCR2H = TIM_CCR2H_RESET_VALUE;
 108  004c 725f5263      	clr	21091
 109                     ; 191   TIM2->CCR2L = TIM_CCR2L_RESET_VALUE;
 111  0050 725f5264      	clr	21092
 112                     ; 194   TIM2->OISR = TIM_OISR_RESET_VALUE;
 114  0054 725f5266      	clr	21094
 115                     ; 195   TIM2->EGR = 0x01;/* TIM_EGR_UG */
 117  0058 35015258      	mov	21080,#1
 118                     ; 196   TIM2->BKR = TIM_BKR_RESET_VALUE;
 120  005c 725f5265      	clr	21093
 121                     ; 197   TIM2->SR1 = TIM_SR1_RESET_VALUE;
 123  0060 725f5256      	clr	21078
 124                     ; 198 }
 127  0064 81            	ret
 290                     ; 223 void TIM2_TimeBaseInit(TIM2_Prescaler_TypeDef TIM2_Prescaler,
 290                     ; 224                        TIM2_CounterMode_TypeDef TIM2_CounterMode,
 290                     ; 225                        uint16_t TIM2_Period)
 290                     ; 226 {
 291                     	switch	.text
 292  0065               _TIM2_TimeBaseInit:
 294  0065 89            	pushw	x
 295       00000000      OFST:	set	0
 298                     ; 228   assert_param(IS_TIM2_PRESCALER(TIM2_Prescaler));
 300  0066 9e            	ld	a,xh
 301  0067 4d            	tnz	a
 302  0068 2723          	jreq	L21
 303  006a 9e            	ld	a,xh
 304  006b a101          	cp	a,#1
 305  006d 271e          	jreq	L21
 306  006f 9e            	ld	a,xh
 307  0070 a102          	cp	a,#2
 308  0072 2719          	jreq	L21
 309  0074 9e            	ld	a,xh
 310  0075 a103          	cp	a,#3
 311  0077 2714          	jreq	L21
 312  0079 9e            	ld	a,xh
 313  007a a104          	cp	a,#4
 314  007c 270f          	jreq	L21
 315  007e 9e            	ld	a,xh
 316  007f a105          	cp	a,#5
 317  0081 270a          	jreq	L21
 318  0083 9e            	ld	a,xh
 319  0084 a106          	cp	a,#6
 320  0086 2705          	jreq	L21
 321  0088 9e            	ld	a,xh
 322  0089 a107          	cp	a,#7
 323  008b 2603          	jrne	L01
 324  008d               L21:
 325  008d 4f            	clr	a
 326  008e 2010          	jra	L41
 327  0090               L01:
 328  0090 ae00e4        	ldw	x,#228
 329  0093 89            	pushw	x
 330  0094 ae0000        	ldw	x,#0
 331  0097 89            	pushw	x
 332  0098 ae0000        	ldw	x,#L111
 333  009b cd0000        	call	_assert_failed
 335  009e 5b04          	addw	sp,#4
 336  00a0               L41:
 337                     ; 229   assert_param(IS_TIM2_COUNTER_MODE(TIM2_CounterMode));
 339  00a0 0d02          	tnz	(OFST+2,sp)
 340  00a2 2718          	jreq	L02
 341  00a4 7b02          	ld	a,(OFST+2,sp)
 342  00a6 a110          	cp	a,#16
 343  00a8 2712          	jreq	L02
 344  00aa 7b02          	ld	a,(OFST+2,sp)
 345  00ac a120          	cp	a,#32
 346  00ae 270c          	jreq	L02
 347  00b0 7b02          	ld	a,(OFST+2,sp)
 348  00b2 a140          	cp	a,#64
 349  00b4 2706          	jreq	L02
 350  00b6 7b02          	ld	a,(OFST+2,sp)
 351  00b8 a160          	cp	a,#96
 352  00ba 2603          	jrne	L61
 353  00bc               L02:
 354  00bc 4f            	clr	a
 355  00bd 2010          	jra	L22
 356  00bf               L61:
 357  00bf ae00e5        	ldw	x,#229
 358  00c2 89            	pushw	x
 359  00c3 ae0000        	ldw	x,#0
 360  00c6 89            	pushw	x
 361  00c7 ae0000        	ldw	x,#L111
 362  00ca cd0000        	call	_assert_failed
 364  00cd 5b04          	addw	sp,#4
 365  00cf               L22:
 366                     ; 234   TIM2->ARRH = (uint8_t)(TIM2_Period >> 8) ;
 368  00cf 7b05          	ld	a,(OFST+5,sp)
 369  00d1 c7525f        	ld	21087,a
 370                     ; 235   TIM2->ARRL = (uint8_t)(TIM2_Period);
 372  00d4 7b06          	ld	a,(OFST+6,sp)
 373  00d6 c75260        	ld	21088,a
 374                     ; 238   TIM2->PSCR = (uint8_t)(TIM2_Prescaler);
 376  00d9 7b01          	ld	a,(OFST+1,sp)
 377  00db c7525e        	ld	21086,a
 378                     ; 241   TIM2->CR1 &= (uint8_t)((uint8_t)(~TIM_CR1_CMS)) & ((uint8_t)(~TIM_CR1_DIR));
 380  00de c65250        	ld	a,21072
 381  00e1 a48f          	and	a,#143
 382  00e3 c75250        	ld	21072,a
 383                     ; 242   TIM2->CR1 |= (uint8_t)(TIM2_CounterMode);
 385  00e6 c65250        	ld	a,21072
 386  00e9 1a02          	or	a,(OFST+2,sp)
 387  00eb c75250        	ld	21072,a
 388                     ; 245   TIM2->EGR = TIM2_EventSource_Update;
 390  00ee 35015258      	mov	21080,#1
 391                     ; 246 }
 394  00f2 85            	popw	x
 395  00f3 81            	ret
 502                     ; 261 void TIM2_ITConfig(TIM2_IT_TypeDef TIM2_IT, FunctionalState NewState)
 502                     ; 262 {
 503                     	switch	.text
 504  00f4               _TIM2_ITConfig:
 506  00f4 89            	pushw	x
 507       00000000      OFST:	set	0
 510                     ; 264   assert_param(IS_TIM2_IT(TIM2_IT));
 512  00f5 9e            	ld	a,xh
 513  00f6 4d            	tnz	a
 514  00f7 2703          	jreq	L62
 515  00f9 4f            	clr	a
 516  00fa 2010          	jra	L03
 517  00fc               L62:
 518  00fc ae0108        	ldw	x,#264
 519  00ff 89            	pushw	x
 520  0100 ae0000        	ldw	x,#0
 521  0103 89            	pushw	x
 522  0104 ae0000        	ldw	x,#L111
 523  0107 cd0000        	call	_assert_failed
 525  010a 5b04          	addw	sp,#4
 526  010c               L03:
 527                     ; 265   assert_param(IS_FUNCTIONAL_STATE(NewState));
 529  010c 0d02          	tnz	(OFST+2,sp)
 530  010e 2706          	jreq	L43
 531  0110 7b02          	ld	a,(OFST+2,sp)
 532  0112 a101          	cp	a,#1
 533  0114 2603          	jrne	L23
 534  0116               L43:
 535  0116 4f            	clr	a
 536  0117 2010          	jra	L63
 537  0119               L23:
 538  0119 ae0109        	ldw	x,#265
 539  011c 89            	pushw	x
 540  011d ae0000        	ldw	x,#0
 541  0120 89            	pushw	x
 542  0121 ae0000        	ldw	x,#L111
 543  0124 cd0000        	call	_assert_failed
 545  0127 5b04          	addw	sp,#4
 546  0129               L63:
 547                     ; 267   if (NewState != DISABLE)
 549  0129 0d02          	tnz	(OFST+2,sp)
 550  012b 270a          	jreq	L361
 551                     ; 270     TIM2->IER |= (uint8_t)TIM2_IT;
 553  012d c65255        	ld	a,21077
 554  0130 1a01          	or	a,(OFST+1,sp)
 555  0132 c75255        	ld	21077,a
 557  0135 2009          	jra	L561
 558  0137               L361:
 559                     ; 275     TIM2->IER &= (uint8_t)(~(uint8_t)TIM2_IT);
 561  0137 7b01          	ld	a,(OFST+1,sp)
 562  0139 43            	cpl	a
 563  013a c45255        	and	a,21077
 564  013d c75255        	ld	21077,a
 565  0140               L561:
 566                     ; 277 }
 569  0140 85            	popw	x
 570  0141 81            	ret
 606                     ; 285 void TIM2_Cmd(FunctionalState NewState)
 606                     ; 286 {
 607                     	switch	.text
 608  0142               _TIM2_Cmd:
 610  0142 88            	push	a
 611       00000000      OFST:	set	0
 614                     ; 288   assert_param(IS_FUNCTIONAL_STATE(NewState));
 616  0143 4d            	tnz	a
 617  0144 2704          	jreq	L44
 618  0146 a101          	cp	a,#1
 619  0148 2603          	jrne	L24
 620  014a               L44:
 621  014a 4f            	clr	a
 622  014b 2010          	jra	L64
 623  014d               L24:
 624  014d ae0120        	ldw	x,#288
 625  0150 89            	pushw	x
 626  0151 ae0000        	ldw	x,#0
 627  0154 89            	pushw	x
 628  0155 ae0000        	ldw	x,#L111
 629  0158 cd0000        	call	_assert_failed
 631  015b 5b04          	addw	sp,#4
 632  015d               L64:
 633                     ; 291   if (NewState != DISABLE)
 635  015d 0d01          	tnz	(OFST+1,sp)
 636  015f 2706          	jreq	L502
 637                     ; 293     TIM2->CR1 |= TIM_CR1_CEN;
 639  0161 72105250      	bset	21072,#0
 641  0165 2004          	jra	L702
 642  0167               L502:
 643                     ; 297     TIM2->CR1 &= (uint8_t)(~TIM_CR1_CEN);
 645  0167 72115250      	bres	21072,#0
 646  016b               L702:
 647                     ; 299 }
 650  016b 84            	pop	a
 651  016c 81            	ret
 736                     ; 312 ITStatus TIM2_GetITStatus(TIM2_IT_TypeDef TIM2_IT)
 736                     ; 313 {
 737                     	switch	.text
 738  016d               _TIM2_GetITStatus:
 740  016d 88            	push	a
 741  016e 89            	pushw	x
 742       00000002      OFST:	set	2
 745                     ; 314   ITStatus bitstatus = RESET;
 747                     ; 316   uint8_t TIM2_itStatus = 0x0, TIM2_itEnable = 0x0;
 751                     ; 319   assert_param(IS_TIM2_GET_IT(TIM2_IT));
 753  016f a101          	cp	a,#1
 754  0171 2710          	jreq	L45
 755  0173 a102          	cp	a,#2
 756  0175 270c          	jreq	L45
 757  0177 a104          	cp	a,#4
 758  0179 2708          	jreq	L45
 759  017b a140          	cp	a,#64
 760  017d 2704          	jreq	L45
 761  017f a180          	cp	a,#128
 762  0181 2603          	jrne	L25
 763  0183               L45:
 764  0183 4f            	clr	a
 765  0184 2010          	jra	L65
 766  0186               L25:
 767  0186 ae013f        	ldw	x,#319
 768  0189 89            	pushw	x
 769  018a ae0000        	ldw	x,#0
 770  018d 89            	pushw	x
 771  018e ae0000        	ldw	x,#L111
 772  0191 cd0000        	call	_assert_failed
 774  0194 5b04          	addw	sp,#4
 775  0196               L65:
 776                     ; 321   TIM2_itStatus = (uint8_t)(TIM2->SR1 & (uint8_t)TIM2_IT);
 778  0196 c65256        	ld	a,21078
 779  0199 1403          	and	a,(OFST+1,sp)
 780  019b 6b01          	ld	(OFST-1,sp),a
 782                     ; 323   TIM2_itEnable = (uint8_t)(TIM2->IER & (uint8_t)TIM2_IT);
 784  019d c65255        	ld	a,21077
 785  01a0 1403          	and	a,(OFST+1,sp)
 786  01a2 6b02          	ld	(OFST+0,sp),a
 788                     ; 325   if ((TIM2_itStatus != (uint8_t)RESET ) && (TIM2_itEnable != (uint8_t)RESET))
 790  01a4 0d01          	tnz	(OFST-1,sp)
 791  01a6 270a          	jreq	L352
 793  01a8 0d02          	tnz	(OFST+0,sp)
 794  01aa 2706          	jreq	L352
 795                     ; 327     bitstatus = (ITStatus)SET;
 797  01ac a601          	ld	a,#1
 798  01ae 6b02          	ld	(OFST+0,sp),a
 801  01b0 2002          	jra	L552
 802  01b2               L352:
 803                     ; 331     bitstatus = (ITStatus)RESET;
 805  01b2 0f02          	clr	(OFST+0,sp)
 807  01b4               L552:
 808                     ; 333   return ((ITStatus)bitstatus);
 810  01b4 7b02          	ld	a,(OFST+0,sp)
 813  01b6 5b03          	addw	sp,#3
 814  01b8 81            	ret
 851                     ; 347 void TIM2_ClearITPendingBit(TIM2_IT_TypeDef TIM2_IT)
 851                     ; 348 {
 852                     	switch	.text
 853  01b9               _TIM2_ClearITPendingBit:
 855  01b9 88            	push	a
 856       00000000      OFST:	set	0
 859                     ; 350   assert_param(IS_TIM2_IT(TIM2_IT));
 861  01ba 4d            	tnz	a
 862  01bb 2703          	jreq	L26
 863  01bd 4f            	clr	a
 864  01be 2010          	jra	L46
 865  01c0               L26:
 866  01c0 ae015e        	ldw	x,#350
 867  01c3 89            	pushw	x
 868  01c4 ae0000        	ldw	x,#0
 869  01c7 89            	pushw	x
 870  01c8 ae0000        	ldw	x,#L111
 871  01cb cd0000        	call	_assert_failed
 873  01ce 5b04          	addw	sp,#4
 874  01d0               L46:
 875                     ; 353   TIM2->SR1 = (uint8_t)(~(uint8_t)TIM2_IT);
 877  01d0 7b01          	ld	a,(OFST+1,sp)
 878  01d2 43            	cpl	a
 879  01d3 c75256        	ld	21078,a
 880                     ; 354 }
 883  01d6 84            	pop	a
 884  01d7 81            	ret
 897                     	xdef	_TIM2_ClearITPendingBit
 898                     	xdef	_TIM2_GetITStatus
 899                     	xdef	_TIM2_ITConfig
 900                     	xdef	_TIM2_Cmd
 901                     	xdef	_TIM2_TimeBaseInit
 902                     	xdef	_TIM2_DeInit
 903                     	xref	_assert_failed
 904                     .const:	section	.text
 905  0000               L111:
 906  0000 73746d386c31  	dc.b	"stm8l15x_tim2.c",0
 926                     	end
