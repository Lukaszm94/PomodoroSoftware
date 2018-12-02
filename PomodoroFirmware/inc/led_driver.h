#ifndef LED_DRIVER_H
#define LED_DRIVER_H
#include "stm8l15x.h"

void led_initDriver(void);
void led_setBarProgress(uint16_t progress);
void led_test(void);

#endif

