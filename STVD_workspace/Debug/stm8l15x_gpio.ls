   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
 108                     ; 96 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
 108                     ; 97 {
 110                     	switch	.text
 111  0000               _GPIO_DeInit:
 115                     ; 98   GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 117  0000 6f04          	clr	(4,x)
 118                     ; 99   GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 120  0002 7f            	clr	(x)
 121                     ; 100   GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 123  0003 6f02          	clr	(2,x)
 124                     ; 101   GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 126  0005 6f03          	clr	(3,x)
 127                     ; 102 }
 130  0007 81            	ret
 287                     ; 133 void GPIO_Init(GPIO_TypeDef* GPIOx, uint8_t GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
 287                     ; 134 {
 288                     	switch	.text
 289  0008               _GPIO_Init:
 291  0008 89            	pushw	x
 292       00000000      OFST:	set	0
 295                     ; 139   assert_param(IS_GPIO_MODE(GPIO_Mode));
 297  0009 0d06          	tnz	(OFST+6,sp)
 298  000b 2742          	jreq	L21
 299  000d 7b06          	ld	a,(OFST+6,sp)
 300  000f a140          	cp	a,#64
 301  0011 273c          	jreq	L21
 302  0013 7b06          	ld	a,(OFST+6,sp)
 303  0015 a120          	cp	a,#32
 304  0017 2736          	jreq	L21
 305  0019 7b06          	ld	a,(OFST+6,sp)
 306  001b a160          	cp	a,#96
 307  001d 2730          	jreq	L21
 308  001f 7b06          	ld	a,(OFST+6,sp)
 309  0021 a1a0          	cp	a,#160
 310  0023 272a          	jreq	L21
 311  0025 7b06          	ld	a,(OFST+6,sp)
 312  0027 a1e0          	cp	a,#224
 313  0029 2724          	jreq	L21
 314  002b 7b06          	ld	a,(OFST+6,sp)
 315  002d a180          	cp	a,#128
 316  002f 271e          	jreq	L21
 317  0031 7b06          	ld	a,(OFST+6,sp)
 318  0033 a1c0          	cp	a,#192
 319  0035 2718          	jreq	L21
 320  0037 7b06          	ld	a,(OFST+6,sp)
 321  0039 a1b0          	cp	a,#176
 322  003b 2712          	jreq	L21
 323  003d 7b06          	ld	a,(OFST+6,sp)
 324  003f a1f0          	cp	a,#240
 325  0041 270c          	jreq	L21
 326  0043 7b06          	ld	a,(OFST+6,sp)
 327  0045 a190          	cp	a,#144
 328  0047 2706          	jreq	L21
 329  0049 7b06          	ld	a,(OFST+6,sp)
 330  004b a1d0          	cp	a,#208
 331  004d 2603          	jrne	L01
 332  004f               L21:
 333  004f 4f            	clr	a
 334  0050 2010          	jra	L41
 335  0052               L01:
 336  0052 ae008b        	ldw	x,#139
 337  0055 89            	pushw	x
 338  0056 ae0000        	ldw	x,#0
 339  0059 89            	pushw	x
 340  005a ae0000        	ldw	x,#L541
 341  005d cd0000        	call	_assert_failed
 343  0060 5b04          	addw	sp,#4
 344  0062               L41:
 345                     ; 140   assert_param(IS_GPIO_PIN(GPIO_Pin));
 347  0062 0d05          	tnz	(OFST+5,sp)
 348  0064 2703          	jreq	L61
 349  0066 4f            	clr	a
 350  0067 2010          	jra	L02
 351  0069               L61:
 352  0069 ae008c        	ldw	x,#140
 353  006c 89            	pushw	x
 354  006d ae0000        	ldw	x,#0
 355  0070 89            	pushw	x
 356  0071 ae0000        	ldw	x,#L541
 357  0074 cd0000        	call	_assert_failed
 359  0077 5b04          	addw	sp,#4
 360  0079               L02:
 361                     ; 143   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 363  0079 1e01          	ldw	x,(OFST+1,sp)
 364  007b 7b05          	ld	a,(OFST+5,sp)
 365  007d 43            	cpl	a
 366  007e e404          	and	a,(4,x)
 367  0080 e704          	ld	(4,x),a
 368                     ; 149   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
 370  0082 7b06          	ld	a,(OFST+6,sp)
 371  0084 a580          	bcp	a,#128
 372  0086 271f          	jreq	L741
 373                     ; 151     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
 375  0088 7b06          	ld	a,(OFST+6,sp)
 376  008a a510          	bcp	a,#16
 377  008c 2708          	jreq	L151
 378                     ; 153       GPIOx->ODR |= GPIO_Pin;
 380  008e 1e01          	ldw	x,(OFST+1,sp)
 381  0090 f6            	ld	a,(x)
 382  0091 1a05          	or	a,(OFST+5,sp)
 383  0093 f7            	ld	(x),a
 385  0094 2007          	jra	L351
 386  0096               L151:
 387                     ; 156       GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
 389  0096 1e01          	ldw	x,(OFST+1,sp)
 390  0098 7b05          	ld	a,(OFST+5,sp)
 391  009a 43            	cpl	a
 392  009b f4            	and	a,(x)
 393  009c f7            	ld	(x),a
 394  009d               L351:
 395                     ; 159     GPIOx->DDR |= GPIO_Pin;
 397  009d 1e01          	ldw	x,(OFST+1,sp)
 398  009f e602          	ld	a,(2,x)
 399  00a1 1a05          	or	a,(OFST+5,sp)
 400  00a3 e702          	ld	(2,x),a
 402  00a5 2009          	jra	L551
 403  00a7               L741:
 404                     ; 163     GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 406  00a7 1e01          	ldw	x,(OFST+1,sp)
 407  00a9 7b05          	ld	a,(OFST+5,sp)
 408  00ab 43            	cpl	a
 409  00ac e402          	and	a,(2,x)
 410  00ae e702          	ld	(2,x),a
 411  00b0               L551:
 412                     ; 170   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 414  00b0 7b06          	ld	a,(OFST+6,sp)
 415  00b2 a540          	bcp	a,#64
 416  00b4 270a          	jreq	L751
 417                     ; 172     GPIOx->CR1 |= GPIO_Pin;
 419  00b6 1e01          	ldw	x,(OFST+1,sp)
 420  00b8 e603          	ld	a,(3,x)
 421  00ba 1a05          	or	a,(OFST+5,sp)
 422  00bc e703          	ld	(3,x),a
 424  00be 2009          	jra	L161
 425  00c0               L751:
 426                     ; 175     GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 428  00c0 1e01          	ldw	x,(OFST+1,sp)
 429  00c2 7b05          	ld	a,(OFST+5,sp)
 430  00c4 43            	cpl	a
 431  00c5 e403          	and	a,(3,x)
 432  00c7 e703          	ld	(3,x),a
 433  00c9               L161:
 434                     ; 182   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 436  00c9 7b06          	ld	a,(OFST+6,sp)
 437  00cb a520          	bcp	a,#32
 438  00cd 270a          	jreq	L361
 439                     ; 184     GPIOx->CR2 |= GPIO_Pin;
 441  00cf 1e01          	ldw	x,(OFST+1,sp)
 442  00d1 e604          	ld	a,(4,x)
 443  00d3 1a05          	or	a,(OFST+5,sp)
 444  00d5 e704          	ld	(4,x),a
 446  00d7 2009          	jra	L561
 447  00d9               L361:
 448                     ; 187     GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 450  00d9 1e01          	ldw	x,(OFST+1,sp)
 451  00db 7b05          	ld	a,(OFST+5,sp)
 452  00dd 43            	cpl	a
 453  00de e404          	and	a,(4,x)
 454  00e0 e704          	ld	(4,x),a
 455  00e2               L561:
 456                     ; 190 }
 459  00e2 85            	popw	x
 460  00e3 81            	ret
 538                     ; 209 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, uint8_t GPIO_Pin, FunctionalState NewState)
 538                     ; 210 {
 539                     	switch	.text
 540  00e4               _GPIO_ExternalPullUpConfig:
 542  00e4 89            	pushw	x
 543       00000000      OFST:	set	0
 546                     ; 212   assert_param(IS_GPIO_PIN(GPIO_Pin));
 548  00e5 0d05          	tnz	(OFST+5,sp)
 549  00e7 2703          	jreq	L42
 550  00e9 4f            	clr	a
 551  00ea 2010          	jra	L62
 552  00ec               L42:
 553  00ec ae00d4        	ldw	x,#212
 554  00ef 89            	pushw	x
 555  00f0 ae0000        	ldw	x,#0
 556  00f3 89            	pushw	x
 557  00f4 ae0000        	ldw	x,#L541
 558  00f7 cd0000        	call	_assert_failed
 560  00fa 5b04          	addw	sp,#4
 561  00fc               L62:
 562                     ; 213   assert_param(IS_FUNCTIONAL_STATE(NewState));
 564  00fc 0d06          	tnz	(OFST+6,sp)
 565  00fe 2706          	jreq	L23
 566  0100 7b06          	ld	a,(OFST+6,sp)
 567  0102 a101          	cp	a,#1
 568  0104 2603          	jrne	L03
 569  0106               L23:
 570  0106 4f            	clr	a
 571  0107 2010          	jra	L43
 572  0109               L03:
 573  0109 ae00d5        	ldw	x,#213
 574  010c 89            	pushw	x
 575  010d ae0000        	ldw	x,#0
 576  0110 89            	pushw	x
 577  0111 ae0000        	ldw	x,#L541
 578  0114 cd0000        	call	_assert_failed
 580  0117 5b04          	addw	sp,#4
 581  0119               L43:
 582                     ; 215   if (NewState != DISABLE) /* External Pull-Up Set*/
 584  0119 0d06          	tnz	(OFST+6,sp)
 585  011b 270a          	jreq	L722
 586                     ; 217     GPIOx->CR1 |= GPIO_Pin;
 588  011d 1e01          	ldw	x,(OFST+1,sp)
 589  011f e603          	ld	a,(3,x)
 590  0121 1a05          	or	a,(OFST+5,sp)
 591  0123 e703          	ld	(3,x),a
 593  0125 2009          	jra	L132
 594  0127               L722:
 595                     ; 220     GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 597  0127 1e01          	ldw	x,(OFST+1,sp)
 598  0129 7b05          	ld	a,(OFST+5,sp)
 599  012b 43            	cpl	a
 600  012c e403          	and	a,(3,x)
 601  012e e703          	ld	(3,x),a
 602  0130               L132:
 603                     ; 222 }
 606  0130 85            	popw	x
 607  0131 81            	ret
 653                     ; 248 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t GPIO_PortVal)
 653                     ; 249 {
 654                     	switch	.text
 655  0132               _GPIO_Write:
 657  0132 89            	pushw	x
 658       00000000      OFST:	set	0
 661                     ; 250   GPIOx->ODR = GPIO_PortVal;
 663  0133 7b05          	ld	a,(OFST+5,sp)
 664  0135 1e01          	ldw	x,(OFST+1,sp)
 665  0137 f7            	ld	(x),a
 666                     ; 251 }
 669  0138 85            	popw	x
 670  0139 81            	ret
 831                     ; 270 void GPIO_WriteBit(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, BitAction GPIO_BitVal)
 831                     ; 271 {
 832                     	switch	.text
 833  013a               _GPIO_WriteBit:
 835  013a 89            	pushw	x
 836       00000000      OFST:	set	0
 839                     ; 273   assert_param(IS_GPIO_PIN(GPIO_Pin));
 841  013b 0d05          	tnz	(OFST+5,sp)
 842  013d 2703          	jreq	L24
 843  013f 4f            	clr	a
 844  0140 2010          	jra	L44
 845  0142               L24:
 846  0142 ae0111        	ldw	x,#273
 847  0145 89            	pushw	x
 848  0146 ae0000        	ldw	x,#0
 849  0149 89            	pushw	x
 850  014a ae0000        	ldw	x,#L541
 851  014d cd0000        	call	_assert_failed
 853  0150 5b04          	addw	sp,#4
 854  0152               L44:
 855                     ; 274   assert_param(IS_STATE_VALUE(GPIO_BitVal));
 857  0152 7b06          	ld	a,(OFST+6,sp)
 858  0154 a101          	cp	a,#1
 859  0156 2704          	jreq	L05
 860  0158 0d06          	tnz	(OFST+6,sp)
 861  015a 2603          	jrne	L64
 862  015c               L05:
 863  015c 4f            	clr	a
 864  015d 2010          	jra	L25
 865  015f               L64:
 866  015f ae0112        	ldw	x,#274
 867  0162 89            	pushw	x
 868  0163 ae0000        	ldw	x,#0
 869  0166 89            	pushw	x
 870  0167 ae0000        	ldw	x,#L541
 871  016a cd0000        	call	_assert_failed
 873  016d 5b04          	addw	sp,#4
 874  016f               L25:
 875                     ; 276   if (GPIO_BitVal != RESET)
 877  016f 0d06          	tnz	(OFST+6,sp)
 878  0171 2708          	jreq	L153
 879                     ; 278     GPIOx->ODR |= GPIO_Pin;
 881  0173 1e01          	ldw	x,(OFST+1,sp)
 882  0175 f6            	ld	a,(x)
 883  0176 1a05          	or	a,(OFST+5,sp)
 884  0178 f7            	ld	(x),a
 886  0179 2007          	jra	L353
 887  017b               L153:
 888                     ; 283     GPIOx->ODR &= (uint8_t)(~GPIO_Pin);
 890  017b 1e01          	ldw	x,(OFST+1,sp)
 891  017d 7b05          	ld	a,(OFST+5,sp)
 892  017f 43            	cpl	a
 893  0180 f4            	and	a,(x)
 894  0181 f7            	ld	(x),a
 895  0182               L353:
 896                     ; 285 }
 899  0182 85            	popw	x
 900  0183 81            	ret
 946                     ; 303 void GPIO_SetBits(GPIO_TypeDef* GPIOx, uint8_t GPIO_Pin)
 946                     ; 304 {
 947                     	switch	.text
 948  0184               _GPIO_SetBits:
 950  0184 89            	pushw	x
 951       00000000      OFST:	set	0
 954                     ; 305   GPIOx->ODR |= GPIO_Pin;
 956  0185 f6            	ld	a,(x)
 957  0186 1a05          	or	a,(OFST+5,sp)
 958  0188 f7            	ld	(x),a
 959                     ; 306 }
 962  0189 85            	popw	x
 963  018a 81            	ret
1009                     ; 324 void GPIO_ResetBits(GPIO_TypeDef* GPIOx, uint8_t GPIO_Pin)
1009                     ; 325 {
1010                     	switch	.text
1011  018b               _GPIO_ResetBits:
1013  018b 89            	pushw	x
1014       00000000      OFST:	set	0
1017                     ; 326   GPIOx->ODR &= (uint8_t)(~GPIO_Pin);
1019  018c 7b05          	ld	a,(OFST+5,sp)
1020  018e 43            	cpl	a
1021  018f f4            	and	a,(x)
1022  0190 f7            	ld	(x),a
1023                     ; 327 }
1026  0191 85            	popw	x
1027  0192 81            	ret
1073                     ; 336 void GPIO_ToggleBits(GPIO_TypeDef* GPIOx, uint8_t GPIO_Pin)
1073                     ; 337 {
1074                     	switch	.text
1075  0193               _GPIO_ToggleBits:
1077  0193 89            	pushw	x
1078       00000000      OFST:	set	0
1081                     ; 338   GPIOx->ODR ^= GPIO_Pin;
1083  0194 f6            	ld	a,(x)
1084  0195 1805          	xor	a,	(OFST+5,sp)
1085  0197 f7            	ld	(x),a
1086                     ; 339 }
1089  0198 85            	popw	x
1090  0199 81            	ret
1127                     ; 347 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
1127                     ; 348 {
1128                     	switch	.text
1129  019a               _GPIO_ReadInputData:
1133                     ; 349   return ((uint8_t)GPIOx->IDR);
1135  019a e601          	ld	a,(1,x)
1138  019c 81            	ret
1176                     ; 358 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
1176                     ; 359 {
1177                     	switch	.text
1178  019d               _GPIO_ReadOutputData:
1182                     ; 360   return ((uint8_t)GPIOx->ODR);
1184  019d f6            	ld	a,(x)
1187  019e 81            	ret
1236                     ; 378 BitStatus GPIO_ReadInputDataBit(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
1236                     ; 379 {
1237                     	switch	.text
1238  019f               _GPIO_ReadInputDataBit:
1240  019f 89            	pushw	x
1241       00000000      OFST:	set	0
1244                     ; 380   return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
1246  01a0 e601          	ld	a,(1,x)
1247  01a2 1405          	and	a,(OFST+5,sp)
1250  01a4 85            	popw	x
1251  01a5 81            	ret
1300                     ; 389 BitStatus GPIO_ReadOutputDataBit(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
1300                     ; 390 {
1301                     	switch	.text
1302  01a6               _GPIO_ReadOutputDataBit:
1304  01a6 89            	pushw	x
1305       00000000      OFST:	set	0
1308                     ; 391   return ((BitStatus)(GPIOx->ODR & (uint8_t)GPIO_Pin));
1310  01a7 f6            	ld	a,(x)
1311  01a8 1405          	and	a,(OFST+5,sp)
1314  01aa 85            	popw	x
1315  01ab 81            	ret
1328                     	xdef	_GPIO_ReadOutputDataBit
1329                     	xdef	_GPIO_ReadInputDataBit
1330                     	xdef	_GPIO_ReadOutputData
1331                     	xdef	_GPIO_ReadInputData
1332                     	xdef	_GPIO_ToggleBits
1333                     	xdef	_GPIO_ResetBits
1334                     	xdef	_GPIO_SetBits
1335                     	xdef	_GPIO_WriteBit
1336                     	xdef	_GPIO_Write
1337                     	xdef	_GPIO_ExternalPullUpConfig
1338                     	xdef	_GPIO_Init
1339                     	xdef	_GPIO_DeInit
1340                     	xref	_assert_failed
1341                     .const:	section	.text
1342  0000               L541:
1343  0000 73746d386c31  	dc.b	"stm8l15x_gpio.c",0
1363                     	end
