#include "interrupt_manager.h"
#include "stm8l15x.h"
#include "pomodoro_timer.h"
#include "config.h"
#include "button.h"

//extern volatile PomodoroTimer pomodoroTimer;

volatile uint16_t pomodoroTimerCounter;
volatile uint16_t buttonCounter;
volatile uint16_t signalLedsCounter;
volatile uint16_t buzzerCounter;

void IM_incrementCounters(void);
void IM_resetCounter(uint16_t *counterPointer);

void IM_update(void)
{
	if(pomodoroTimerCounter == (POMODORO_TIMER_UPDATE_INTERVAL_MS / INTERRUPT_MANAGER_UPDATE_INTERVAL_MS)) {
		GPIO_WriteBit(GPIOE, DEBUG_2_CHANNEL_PIN, SET);
		IM_resetCounter(&pomodoroTimerCounter);
		PM_update();
		GPIO_WriteBit(GPIOE, DEBUG_2_CHANNEL_PIN, RESET);
	}
	buttonUpdate();
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


