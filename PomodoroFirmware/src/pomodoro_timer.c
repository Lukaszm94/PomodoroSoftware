#include "pomodoro_timer.h"
#include "config.h"
#include "stm8l15x.h"
#include "led_driver.h"
#include "misc.h"

enum {PM_STATE_RUNNING, PM_STATE_PAUSED, PM_MODE_WORK, PM_MODE_BREAK};

volatile uint16_t counterSeconds;
volatile uint8_t PM_state = PM_STATE_RUNNING;
volatile uint8_t PM_mode = PM_MODE_WORK;
volatile uint8_t toggledLedState = 0;

void PM_performModeTransition(void);
void PM_toggleModeLED(void);

void PM_init(void)
{
	led_setBarProgress(LED_BAR_PROGRESS_BAR_MAX_VALUE);
	led_setModeLeds(0, PWM_MAX_VALUE);
	counterSeconds = 100;//POMODORO_TIMER_WORK_MODE_TIME_S;
}

void PM_update(void)
{
	uint16_t progress = 0;
	uint32_t tmp = 0;
	log_timestamp();
	serialSendStringBlocking("PM_update, counter= ");
	log_int(counterSeconds);
	serialSendStringBlocking("\n\r");
	if(PM_state == PM_STATE_PAUSED) {
		GPIO_WriteBit(GPIOE, DEBUG_3_CHANNEL_PIN, SET);
		PM_toggleModeLED();
		GPIO_WriteBit(GPIOE, DEBUG_3_CHANNEL_PIN, RESET);
		serialSendStringBlocking("paused\n\r");
		return;
	}
	counterSeconds--;
	
	if(counterSeconds == 0) { // end of current mode
		serialSendStringBlocking("mode transition\n\r");
		PM_performModeTransition();
	}
	
	// update LED bar
	progress = counterSeconds;
	if(PM_mode == PM_MODE_BREAK) {
		//serialSendStringBlocking("break mode, calculate progress\n\r");
		progress = counterSeconds * POMODORO_TIMER_BREAK_TIME_TO_PROGRESS;
	}
	//serialSendStringBlocking("update progress\n\r");
	led_setBarProgress(progress);
}

void PM_buttonShortPress(void)
{
	serialSendStringBlocking("PM short button press\n\r");
	// TODO pause or resume
}

void PM_buttonLongPress(void)
{
	serialSendStringBlocking("PM long button press\n\r");
	// TODO reset to power-on state
}



// private functions
void PM_performModeTransition(void)
{
	if(PM_mode == PM_MODE_WORK) { // transition WORK -> BREAK
		//TODO send command to buzzer
		led_setModeLeds(0xPWM_MAX_VALUE, 0); //turn off red mode LED, turn on green mode LED
		counterSeconds = POMODORO_TIMER_BREAK_MODE_TIME_S;
		serialSendStringBlocking("PM work->break\n\r");
		PM_mode = PM_MODE_BREAK;
	} else { // transition BREAK -> WORK
		//TODO send command to buzzer
		led_setModeLeds(0, PWM_MAX_VALUE); //turn off green mode LED, turn on red mode LED
		serialSendStringBlocking("PM break->work\n\r");
		counterSeconds = POMODORO_TIMER_WORK_MODE_TIME_S;
		PM_mode = PM_MODE_WORK;
	}
}

void PM_toggleModeLED(void)
{
	uint16_t redLedPwm = 0, greenLedPwm = 0;
	if(PM_mode == PM_MODE_WORK) { // toggle red LED
		redLedPwm = toggledLedState * 0x0FFF;
	} else { // break mode, toggle green LED
		greenLedPwm = toggledLedState * 0x0FFF;
	}
	toggledLedState = !toggledLedState;
	led_setModeLeds(greenLedPwm, redLedPwm);
	//led_setModeLeds(0x0ABC, 0x0123);
}

