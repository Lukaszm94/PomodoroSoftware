#ifndef BUZZER_H
#define BUZZER_H
#include "stm8l15x.h"

typedef struct BeepParameters {
	uint16_t timeOn; // [ms]
	uint16_t timeOff; // [ms]
} BeepParameters;

void buzzer_init(void);
void buzzer_addBeepSimple(uint16_t timeOn);
void buzzer_addBeep(BeepParameters newBeep);
void buzzer_update(void); // called from 'systick' ISR

// private
void buzzer_enablePWM(void);
void buzzer_disablePWM(void);

#endif