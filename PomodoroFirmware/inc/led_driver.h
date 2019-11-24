#ifndef LED_DRIVER_H
#define LED_DRIVER_H
#include "stm8l15x.h"

void led_initDriver(void);
void led_setBarProgress(uint16_t progress);
void led_setModeLeds(uint16_t greenLedPwm, uint16_t redLedPwm);
void led_test(uint8_t channelNo);
void led_sendPwmBuffer(void);

#endif

