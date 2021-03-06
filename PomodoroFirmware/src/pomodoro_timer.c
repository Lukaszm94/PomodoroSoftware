#include "pomodoro_timer.h"
#include "config.h"
#include "stm8l15x.h"
#include "led_driver.h"
#include "misc.h"
#include "buzzer.h"

enum {PM_STATE_RUNNING, PM_STATE_PAUSED, PM_MODE_WORK, PM_MODE_BREAK};

volatile uint16_t counterSeconds;
volatile uint8_t PM_state = PM_STATE_PAUSED;
volatile uint8_t PM_mode = PM_MODE_WORK;
volatile uint8_t toggledLedState = 0;\
uint32_t pm_showingBatteryStatusTimeout = 0;

void PM_performModeTransition(void);
void PM_toggleModeLED(void);
void PM_changeStateToRunning(void);
void PM_changeStateToPaused(void);
void PM_displayBatteryStatus(void);


void PM_init(void)
{
	PM_displayBatteryStatus();
	//led_setBarProgress(LED_BAR_PROGRESS_BAR_MAX_VALUE);
	led_setModeLeds(0, PWM_MAX_VALUE);
	counterSeconds = POMODORO_TIMER_WORK_MODE_TIME_S;
}

void PM_update(void)
{
	uint16_t progress = 0;
	uint32_t tmp = 0;
	uint16_t batteryVoltage = readBatteryVoltage();
	log_timestamp();
	serialSendStringBlocking("PM_update, counter= ");
	log_int(counterSeconds);
	serialSendStringBlocking(", BATT [mV]: ");
	log_int(batteryVoltage);
	serialSendStringBlocking("\n\r");
	
	// update LED bar
	progress = counterSeconds;
	if(PM_mode == PM_MODE_BREAK) {
		//serialSendStringBlocking("break mode, calculate progress\n\r");
		progress = counterSeconds * POMODORO_TIMER_BREAK_TIME_TO_PROGRESS;
	}
	//serialSendStringBlocking("update progress\n\r");
	if(getMillis() > pm_showingBatteryStatusTimeout) {
		led_setBarProgress(progress);
	}
	
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
}

// called from button.c
void PM_buttonShortPress(void)
{
	serialSendStringBlocking("PM short button press\n\r");
	buzzer_addBeepSimple(SHORT_BEEP_DURATION);
	if(PM_state == PM_STATE_PAUSED) {
		PM_changeStateToRunning();
	} else {
		PM_changeStateToPaused();
	}
}

// called from button.c
void PM_buttonLongPress(void)
{
	serialSendStringBlocking("PM long button press\n\r");
	buzzer_addBeepSimple(MEDIUM_BEEP_DURATION);
	// reset to power-on state
	PM_state = PM_STATE_PAUSED;
	PM_mode = PM_MODE_WORK;
	//led_setBarProgress(LED_BAR_PROGRESS_BAR_MAX_VALUE);
	PM_displayBatteryStatus();
	led_setModeLeds(0, PWM_MAX_VALUE);
	counterSeconds = POMODORO_TIMER_WORK_MODE_TIME_S;
}



// private functions
void PM_performModeTransition(void)
{
	if(PM_mode == PM_MODE_WORK) { // transition WORK -> BREAK
		buzzer_addBeepSimple(MEDIUM_BEEP_DURATION);
		buzzer_addBeepSimple(MEDIUM_BEEP_DURATION);
		buzzer_addBeepSimple(LONG_BEEP_DURATION);
		led_setModeLeds(PWM_MAX_VALUE, 0); //turn off red mode LED, turn on green mode LED
		counterSeconds = POMODORO_TIMER_BREAK_MODE_TIME_S;
		serialSendStringBlocking("PM work->break\n\r");
		PM_mode = PM_MODE_BREAK;
	} else { // transition BREAK -> WORK
		buzzer_addBeepSimple(LONG_BEEP_DURATION);
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
		redLedPwm = toggledLedState * PWM_MAX_VALUE;
	} else { // break mode, toggle green LED
		greenLedPwm = toggledLedState * PWM_MAX_VALUE;
	}
	toggledLedState = !toggledLedState;
	led_setModeLeds(greenLedPwm, redLedPwm);
	//led_setModeLeds(0x0ABC, 0x0123);
}

void PM_changeStateToRunning(void)
{
	PM_state = PM_STATE_RUNNING;
	if(PM_mode == PM_MODE_WORK) {
		led_setModeLeds(0, PWM_MAX_VALUE);
	} else {
		led_setModeLeds(PWM_MAX_VALUE, 0);
	}
}

void PM_changeStateToPaused(void)
{
	led_setModeLeds(0, 0);
	PM_state = PM_STATE_PAUSED;
}

void PM_displayBatteryStatus(void)
{
	uint16_t batteryVoltage = readBatteryVoltage();
	uint16_t batteryCharge = 0;
	if(batteryVoltage > BATTERY_VOLTAGE_MAX) {
		batteryCharge = LED_BAR_PROGRESS_BAR_MAX_VALUE;
	} else if(batteryVoltage < BATTERY_VOLTAGE_MIN) {
		batteryCharge = 0;
	} else {
		batteryCharge = ((uint32_t)(batteryVoltage - BATTERY_VOLTAGE_MIN) * LED_BAR_PROGRESS_BAR_MAX_VALUE) / (BATTERY_VOLTAGE_MAX - BATTERY_VOLTAGE_MIN);
	}
	led_setBarProgress(batteryCharge);
	pm_showingBatteryStatusTimeout = getMillis() + SHOW_BATTERY_STATUS_TIME_MS;
}
