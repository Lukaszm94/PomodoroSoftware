#include "buzzer.h"
#include "stm8l15x_tim3.h"
#include "config.h"
#include "ringbuffer.h"

// buzzer state
enum {IDLE = 0, BUZZER_ON, BUZZER_OFF};

volatile ring_buffer_t ring_buffer;
volatile uint8_t buzzer_state = IDLE;
volatile uint32_t buzzer_timeout = 0;
volatile BeepParameters currentBeep;
extern volatile uint32_t millis;

void buzzer_init(void)
{
	// GPIO config
	GPIO_Init(BUZZER_PORT, BUZZER_PIN, GPIO_Mode_Out_PP_Low_Slow);
	// buzzer PWM timer
	CLK_PeripheralClockConfig(CLK_Peripheral_TIM3, ENABLE);
	TIM3_TimeBaseInit(TIM3_Prescaler_16, TIM3_CounterMode_Up, 1000);
	TIM3_OC1Init(TIM3_OCMode_PWM1, TIM3_OutputState_Enable, 100, TIM3_OCPolarity_High, TIM3_OCIdleState_Reset);
	TIM3_OC1PreloadConfig(DISABLE);
	TIM3_ARRPreloadConfig(ENABLE);
	TIM3_Cmd(ENABLE);
	
	ring_buffer_init(&ring_buffer);
}

void buzzer_addBeepSimple(uint16_t timeOn)
{
	BeepParameters newBeep = {timeOn, DEFAULT_BUZZER_OFF_DELAY};
	buzzer_addBeep(newBeep);
}

void buzzer_addBeep(BeepParameters newBeep)
{
	ring_buffer_queue_arr(&ring_buffer, (char*)(&newBeep), sizeof(newBeep));
}

void buzzer_update(void)
{
	switch(buzzer_state) {
		case IDLE:
			if(!ring_buffer_is_empty(&ring_buffer)) {
				ring_buffer_dequeue_arr(&ring_buffer, (char*)(&currentBeep), sizeof(currentBeep));
				buzzer_enablePWM();
				buzzer_state = BUZZER_ON;
				buzzer_timeout = millis + currentBeep.timeOn;
			}
			break;
		case BUZZER_ON:
			if(millis >= buzzer_timeout) {
				buzzer_disablePWM();
				buzzer_state = BUZZER_OFF;
				buzzer_timeout = millis + currentBeep.timeOff;
			}
			break;
		case BUZZER_OFF:
			if(millis >= buzzer_timeout) {
				buzzer_state = IDLE;
			}
			break;
		default:
			//TODO report error
			break;
	}
	
}

void buzzer_enablePWM(void)
{
	TIM3_CtrlPWMOutputs(ENABLE);
}

void buzzer_disablePWM(void)
{
	TIM3_CtrlPWMOutputs(DISABLE);
}