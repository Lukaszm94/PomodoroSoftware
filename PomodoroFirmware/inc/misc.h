#ifndef MISC_H
#define MISC_H
#include "stm8l15x.h"

void configUSART(void);
void configADC(void);
uint16_t readADCBlocking(void);
uint16_t readBatteryVoltage(void); // [mV]
uint32_t getMillis(void);
void log_timestamp(void);
void log_int(int n);
void log_u32(uint32_t n);
void serialSendByteBlocking(uint8_t byte);
void serialSendStringBlocking(char *buffer);

void itoa(int n, char s[]);
void u32toa(uint32_t n, char s[]);
void reverse(char s[]);

#endif