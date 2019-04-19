#include "pomodoro_timer.h"
#include "config.h"
#include "stm8l15x.h"
#include "led_driver.h"

enum {PM_STATE_RUNNING, PM_STATE_PAUSED, PM_MODE_WORK, PM_MODE_BREAK};

uint16_t counterSeconds;
uint8_t PM_state = PM_STATE_PAUSED;
uint8_t PM_mode = PM_MODE_WORK;

void PM_performModeTransition(void);

void PM_update(void)
{
	uint16_t progress = 0;
	if(PM_state == PM_STATE_PAUSED) {
		// toggle LED
		return;
	}
	counterSeconds--;
	
	if(counterSeconds == 0) { // end of current mode
		PM_performModeTransition();
	}
	
	// update LED bar
	progress = counterSeconds;
	if(PM_mode == PM_MODE_BREAK) {
		progress = progress * POMODORO_TIMER_WORK_MODE_TIME_S / POMODORO_TIMER_BREAK_MODE_TIME_S;
	}
	led_setBarProgress(progress);
}

void PM_buttonShortPress(void)
{
	
}

void PM_buttonLongPress(void)
{
	
}



// private functions
void PM_performModeTransition(void)
{
	if(PM_mode == PM_MODE_WORK) { // transition WORK -> BREAK
		//TODO send command to buzzer
		//TODO turn off red mode LED, turn on green mode LED
		counterSeconds = POMODORO_TIMER_BREAK_MODE_TIME_S;
		PM_mode = PM_MODE_BREAK;
	} else { // transition BREAK -> WORK
		//TODO send command to buzzer
		//TODO turn off green mode LED, turn on red mode LED
		counterSeconds = POMODORO_TIMER_WORK_MODE_TIME_S;
		PM_mode = PM_MODE_WORK;
	}
}

