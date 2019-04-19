   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  14                     .const:	section	.text
  15  0000               _SYSDivFactor:
  16  0000 01            	dc.b	1
  17  0001 02            	dc.b	2
  18  0002 04            	dc.b	4
  19  0003 08            	dc.b	8
  20  0004 10            	dc.b	16
 272                     ; 146 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 272                     ; 147 {
 274                     	switch	.text
 275  0000               _CLK_PeripheralClockConfig:
 277  0000 89            	pushw	x
 278  0001 88            	push	a
 279       00000001      OFST:	set	1
 282                     ; 148   uint8_t reg = 0;
 284                     ; 151   assert_param(IS_CLK_PERIPHERAL(CLK_Peripheral));
 286  0002 9e            	ld	a,xh
 287  0003 a107          	cp	a,#7
 288  0005 2763          	jreq	L01
 289  0007 9e            	ld	a,xh
 290  0008 a110          	cp	a,#16
 291  000a 275e          	jreq	L01
 292  000c 9e            	ld	a,xh
 293  000d a114          	cp	a,#20
 294  000f 2759          	jreq	L01
 295  0011 9e            	ld	a,xh
 296  0012 a112          	cp	a,#18
 297  0014 2754          	jreq	L01
 298  0016 9e            	ld	a,xh
 299  0017 a113          	cp	a,#19
 300  0019 274f          	jreq	L01
 301  001b 9e            	ld	a,xh
 302  001c a115          	cp	a,#21
 303  001e 274a          	jreq	L01
 304  0020 9e            	ld	a,xh
 305  0021 a111          	cp	a,#17
 306  0023 2745          	jreq	L01
 307  0025 9e            	ld	a,xh
 308  0026 a105          	cp	a,#5
 309  0028 2740          	jreq	L01
 310  002a 9e            	ld	a,xh
 311  002b a104          	cp	a,#4
 312  002d 273b          	jreq	L01
 313  002f 9e            	ld	a,xh
 314  0030 a103          	cp	a,#3
 315  0032 2736          	jreq	L01
 316  0034 9e            	ld	a,xh
 317  0035 a102          	cp	a,#2
 318  0037 2731          	jreq	L01
 319  0039 9e            	ld	a,xh
 320  003a a101          	cp	a,#1
 321  003c 272c          	jreq	L01
 322  003e 9e            	ld	a,xh
 323  003f a106          	cp	a,#6
 324  0041 2727          	jreq	L01
 325  0043 9e            	ld	a,xh
 326  0044 a117          	cp	a,#23
 327  0046 2722          	jreq	L01
 328  0048 9e            	ld	a,xh
 329  0049 a120          	cp	a,#32
 330  004b 271d          	jreq	L01
 331  004d 9e            	ld	a,xh
 332  004e a121          	cp	a,#33
 333  0050 2718          	jreq	L01
 334  0052 9e            	ld	a,xh
 335  0053 a122          	cp	a,#34
 336  0055 2713          	jreq	L01
 337  0057 9e            	ld	a,xh
 338  0058 a123          	cp	a,#35
 339  005a 270e          	jreq	L01
 340  005c 9e            	ld	a,xh
 341  005d a124          	cp	a,#36
 342  005f 2709          	jreq	L01
 343  0061 9e            	ld	a,xh
 344  0062 a125          	cp	a,#37
 345  0064 2704          	jreq	L01
 346  0066 9e            	ld	a,xh
 347  0067 4d            	tnz	a
 348  0068 2603          	jrne	L6
 349  006a               L01:
 350  006a 4f            	clr	a
 351  006b 2010          	jra	L21
 352  006d               L6:
 353  006d ae0097        	ldw	x,#151
 354  0070 89            	pushw	x
 355  0071 ae0000        	ldw	x,#0
 356  0074 89            	pushw	x
 357  0075 ae0005        	ldw	x,#L521
 358  0078 cd0000        	call	_assert_failed
 360  007b 5b04          	addw	sp,#4
 361  007d               L21:
 362                     ; 152   assert_param(IS_FUNCTIONAL_STATE(NewState));
 364  007d 0d03          	tnz	(OFST+2,sp)
 365  007f 2706          	jreq	L61
 366  0081 7b03          	ld	a,(OFST+2,sp)
 367  0083 a101          	cp	a,#1
 368  0085 2603          	jrne	L41
 369  0087               L61:
 370  0087 4f            	clr	a
 371  0088 2010          	jra	L02
 372  008a               L41:
 373  008a ae0098        	ldw	x,#152
 374  008d 89            	pushw	x
 375  008e ae0000        	ldw	x,#0
 376  0091 89            	pushw	x
 377  0092 ae0005        	ldw	x,#L521
 378  0095 cd0000        	call	_assert_failed
 380  0098 5b04          	addw	sp,#4
 381  009a               L02:
 382                     ; 155   reg = (uint8_t)((uint8_t)CLK_Peripheral & (uint8_t)0xF0);
 384  009a 7b02          	ld	a,(OFST+1,sp)
 385  009c a4f0          	and	a,#240
 386  009e 6b01          	ld	(OFST+0,sp),a
 388                     ; 157   if ( reg == 0x00)
 390  00a0 0d01          	tnz	(OFST+0,sp)
 391  00a2 2635          	jrne	L721
 392                     ; 159     if (NewState != DISABLE)
 394  00a4 0d03          	tnz	(OFST+2,sp)
 395  00a6 2719          	jreq	L131
 396                     ; 162       CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 398  00a8 7b02          	ld	a,(OFST+1,sp)
 399  00aa a40f          	and	a,#15
 400  00ac 5f            	clrw	x
 401  00ad 97            	ld	xl,a
 402  00ae a601          	ld	a,#1
 403  00b0 5d            	tnzw	x
 404  00b1 2704          	jreq	L22
 405  00b3               L42:
 406  00b3 48            	sll	a
 407  00b4 5a            	decw	x
 408  00b5 26fc          	jrne	L42
 409  00b7               L22:
 410  00b7 ca50c3        	or	a,20675
 411  00ba c750c3        	ld	20675,a
 413  00bd ac430143      	jpf	L531
 414  00c1               L131:
 415                     ; 167       CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 417  00c1 7b02          	ld	a,(OFST+1,sp)
 418  00c3 a40f          	and	a,#15
 419  00c5 5f            	clrw	x
 420  00c6 97            	ld	xl,a
 421  00c7 a601          	ld	a,#1
 422  00c9 5d            	tnzw	x
 423  00ca 2704          	jreq	L62
 424  00cc               L03:
 425  00cc 48            	sll	a
 426  00cd 5a            	decw	x
 427  00ce 26fc          	jrne	L03
 428  00d0               L62:
 429  00d0 43            	cpl	a
 430  00d1 c450c3        	and	a,20675
 431  00d4 c750c3        	ld	20675,a
 432  00d7 206a          	jra	L531
 433  00d9               L721:
 434                     ; 170   else if (reg == 0x10)
 436  00d9 7b01          	ld	a,(OFST+0,sp)
 437  00db a110          	cp	a,#16
 438  00dd 2633          	jrne	L731
 439                     ; 172     if (NewState != DISABLE)
 441  00df 0d03          	tnz	(OFST+2,sp)
 442  00e1 2717          	jreq	L141
 443                     ; 175       CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 445  00e3 7b02          	ld	a,(OFST+1,sp)
 446  00e5 a40f          	and	a,#15
 447  00e7 5f            	clrw	x
 448  00e8 97            	ld	xl,a
 449  00e9 a601          	ld	a,#1
 450  00eb 5d            	tnzw	x
 451  00ec 2704          	jreq	L23
 452  00ee               L43:
 453  00ee 48            	sll	a
 454  00ef 5a            	decw	x
 455  00f0 26fc          	jrne	L43
 456  00f2               L23:
 457  00f2 ca50c4        	or	a,20676
 458  00f5 c750c4        	ld	20676,a
 460  00f8 2049          	jra	L531
 461  00fa               L141:
 462                     ; 180       CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 464  00fa 7b02          	ld	a,(OFST+1,sp)
 465  00fc a40f          	and	a,#15
 466  00fe 5f            	clrw	x
 467  00ff 97            	ld	xl,a
 468  0100 a601          	ld	a,#1
 469  0102 5d            	tnzw	x
 470  0103 2704          	jreq	L63
 471  0105               L04:
 472  0105 48            	sll	a
 473  0106 5a            	decw	x
 474  0107 26fc          	jrne	L04
 475  0109               L63:
 476  0109 43            	cpl	a
 477  010a c450c4        	and	a,20676
 478  010d c750c4        	ld	20676,a
 479  0110 2031          	jra	L531
 480  0112               L731:
 481                     ; 185     if (NewState != DISABLE)
 483  0112 0d03          	tnz	(OFST+2,sp)
 484  0114 2717          	jreq	L741
 485                     ; 188       CLK->PCKENR3 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 487  0116 7b02          	ld	a,(OFST+1,sp)
 488  0118 a40f          	and	a,#15
 489  011a 5f            	clrw	x
 490  011b 97            	ld	xl,a
 491  011c a601          	ld	a,#1
 492  011e 5d            	tnzw	x
 493  011f 2704          	jreq	L24
 494  0121               L44:
 495  0121 48            	sll	a
 496  0122 5a            	decw	x
 497  0123 26fc          	jrne	L44
 498  0125               L24:
 499  0125 ca50d0        	or	a,20688
 500  0128 c750d0        	ld	20688,a
 502  012b 2016          	jra	L531
 503  012d               L741:
 504                     ; 193       CLK->PCKENR3 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 506  012d 7b02          	ld	a,(OFST+1,sp)
 507  012f a40f          	and	a,#15
 508  0131 5f            	clrw	x
 509  0132 97            	ld	xl,a
 510  0133 a601          	ld	a,#1
 511  0135 5d            	tnzw	x
 512  0136 2704          	jreq	L64
 513  0138               L05:
 514  0138 48            	sll	a
 515  0139 5a            	decw	x
 516  013a 26fc          	jrne	L05
 517  013c               L64:
 518  013c 43            	cpl	a
 519  013d c450d0        	and	a,20688
 520  0140 c750d0        	ld	20688,a
 521  0143               L531:
 522                     ; 196 }
 525  0143 5b03          	addw	sp,#3
 526  0145 81            	ret
 636                     ; 236 uint32_t CLK_GetClockFreq(void)
 636                     ; 237 {
 637                     	switch	.text
 638  0146               _CLK_GetClockFreq:
 640  0146 5209          	subw	sp,#9
 641       00000009      OFST:	set	9
 644                     ; 238   uint32_t clockfrequency = 0;
 646                     ; 239   uint32_t sourcefrequency = 0;
 648  0148 ae0000        	ldw	x,#0
 649  014b 1f07          	ldw	(OFST-2,sp),x
 650  014d ae0000        	ldw	x,#0
 651  0150 1f05          	ldw	(OFST-4,sp),x
 653                     ; 240   CLK_SYSCLKSource_TypeDef clocksource = CLK_SYSCLKSource_HSI;
 655                     ; 241   uint8_t tmp = 0, presc = 0;
 659                     ; 244   clocksource = (CLK_SYSCLKSource_TypeDef)CLK->SCSR;
 661  0152 c650c7        	ld	a,20679
 662  0155 6b09          	ld	(OFST+0,sp),a
 664                     ; 246   if ( clocksource == CLK_SYSCLKSource_HSI)
 666  0157 7b09          	ld	a,(OFST+0,sp)
 667  0159 a101          	cp	a,#1
 668  015b 260c          	jrne	L522
 669                     ; 248     sourcefrequency = HSI_VALUE;
 671  015d ae2400        	ldw	x,#9216
 672  0160 1f07          	ldw	(OFST-2,sp),x
 673  0162 ae00f4        	ldw	x,#244
 674  0165 1f05          	ldw	(OFST-4,sp),x
 677  0167 2022          	jra	L722
 678  0169               L522:
 679                     ; 250   else if ( clocksource == CLK_SYSCLKSource_LSI)
 681  0169 7b09          	ld	a,(OFST+0,sp)
 682  016b a102          	cp	a,#2
 683  016d 260c          	jrne	L132
 684                     ; 252     sourcefrequency = LSI_VALUE;
 686  016f ae9470        	ldw	x,#38000
 687  0172 1f07          	ldw	(OFST-2,sp),x
 688  0174 ae0000        	ldw	x,#0
 689  0177 1f05          	ldw	(OFST-4,sp),x
 692  0179 2010          	jra	L722
 693  017b               L132:
 694                     ; 254   else if ( clocksource == CLK_SYSCLKSource_HSE)
 696  017b 7b09          	ld	a,(OFST+0,sp)
 697  017d a104          	cp	a,#4
 698  017f 260a          	jrne	L532
 699                     ; 256     sourcefrequency = HSE_VALUE;
 701  0181 ae2400        	ldw	x,#9216
 702  0184 1f07          	ldw	(OFST-2,sp),x
 703  0186 ae00f4        	ldw	x,#244
 704  0189 1f05          	ldw	(OFST-4,sp),x
 707  018b               L532:
 708                     ; 260     clockfrequency = LSE_VALUE;
 710  018b               L722:
 711                     ; 264   tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_CKM);
 713  018b c650c0        	ld	a,20672
 714  018e a407          	and	a,#7
 715  0190 6b09          	ld	(OFST+0,sp),a
 717                     ; 265   presc = SYSDivFactor[tmp];
 719  0192 7b09          	ld	a,(OFST+0,sp)
 720  0194 5f            	clrw	x
 721  0195 97            	ld	xl,a
 722  0196 d60000        	ld	a,(_SYSDivFactor,x)
 723  0199 6b09          	ld	(OFST+0,sp),a
 725                     ; 268   clockfrequency = sourcefrequency / presc;
 727  019b 7b09          	ld	a,(OFST+0,sp)
 728  019d b703          	ld	c_lreg+3,a
 729  019f 3f02          	clr	c_lreg+2
 730  01a1 3f01          	clr	c_lreg+1
 731  01a3 3f00          	clr	c_lreg
 732  01a5 96            	ldw	x,sp
 733  01a6 1c0001        	addw	x,#OFST-8
 734  01a9 cd0000        	call	c_rtol
 737  01ac 96            	ldw	x,sp
 738  01ad 1c0005        	addw	x,#OFST-4
 739  01b0 cd0000        	call	c_ltor
 741  01b3 96            	ldw	x,sp
 742  01b4 1c0001        	addw	x,#OFST-8
 743  01b7 cd0000        	call	c_ludv
 745  01ba 96            	ldw	x,sp
 746  01bb 1c0005        	addw	x,#OFST-4
 747  01be cd0000        	call	c_rtol
 750                     ; 270   return((uint32_t)clockfrequency);
 752  01c1 96            	ldw	x,sp
 753  01c2 1c0005        	addw	x,#OFST-4
 754  01c5 cd0000        	call	c_ltor
 758  01c8 5b09          	addw	sp,#9
 759  01ca 81            	ret
 784                     	xdef	_SYSDivFactor
 785                     	xdef	_CLK_PeripheralClockConfig
 786                     	xdef	_CLK_GetClockFreq
 787                     	xref	_assert_failed
 788                     	switch	.const
 789  0005               L521:
 790  0005 73746d386c31  	dc.b	"stm8l15x_clk.c",0
 791                     	xref.b	c_lreg
 792                     	xref.b	c_x
 812                     	xref	c_ludv
 813                     	xref	c_rtol
 814                     	xref	c_ltor
 815                     	end
