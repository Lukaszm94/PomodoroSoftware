#ifndef POMODORO_TIMER_H
#define POMODORO_TIMER_H

//struct PomodoroTimer
//{
//	LedBar ledBar;
	/*Button button1;
	Led workLed;
	Led breakLed;
	Buzzer buzzer;*/
//}

void PM_update(void); // called every 1 second
void PM_buttonShortPress(void); // should be called when short button press is detected
void PM_buttonLongPress(void); // should be called when long button press is detected

#endif