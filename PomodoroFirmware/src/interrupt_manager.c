#include "interrupt_manager.h"
#include "stm8l15x.h"
#include "pomodoro_timer.h"
#include "config.h"

//extern volatile PomodoroTimer pomodoroTimer;

uint16_t pomodoroTimerCounter;
uint16_t buttonCounter;
uint16_t signalLedsCounter;
uint16_t buzzerCounter;

void IM_incrementCounters(void);
void IM_resetCounter(uint16_t *counterPointer);

void volatile IM_update(void)
{
	if(pomodoroTimerCounter == POMODORO_TIMER_UPDATE_INTERVAL_MS * 8U) {
		IM_resetCounter(&pomodoroTimerCounter);
		PM_update();
	}
	/*if(buttonCounter == pomodoroTimer.button1.updateIntervalMs * 8U) {
		resetCounter(&buttonCounter);
		//pomodoroTimer.button1.update();
	}
	if(signalLedsCounter == pomodoroTimer.breakLed.updateIntervalMs * 8U) {
		resetCounter(&signalLedsCounter);
		//pomodoroTimer.breakLed.update();
		//pomodoroTimer.workLed.update();
	}
	if(buzzerCounter == pomodoroTimer.buzzer.updateIntervalMs * 8U) {
		resetCounter(&buzzerCounter);
		//pomodoroTimer.buzzer.update();
	}
	//pomodoroTimer.ledBar.ledsController.update();*/
	IM_incrementCounters();
}

void IM_incrementCounters(void)
{
	pomodoroTimerCounter++;
	buttonCounter++;
	signalLedsCounter++;
	buzzerCounter++;
}

void IM_resetCounter(uint16_t *counterPointer)
{
	*counterPointer = 0;
}


