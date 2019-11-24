#include "button.h"
#include "config.h"
#include "pomodoro_timer.h"

#define BUTTON_BUFFER_SIZE 8
enum {BUTTON_IDLE, BUTTON_PRESSED}; // button state

volatile uint8_t button_buffer[BUTTON_BUFFER_SIZE]; // buffer to eliminate contacts bouncing
volatile uint8_t button_buffer_index;
volatile uint8_t button_filtered_state;
volatile uint32_t button_press_timestamp;
extern volatile uint32_t millis;

uint8_t isButtonPressed(void);
uint8_t checkBuffer(uint8_t state, uint8_t detectCompleteBuffer);


void configButton(void)
{
	int i;
	for(i = 0; i < BUTTON_BUFFER_SIZE; i++) {
		button_buffer[i] = 0;
	}
	button_buffer_index = 0;
	button_filtered_state = BUTTON_IDLE;
	GPIO_Init(BUTTON_PORT, BUTTON_PIN, GPIO_Mode_In_PU_No_IT);
}

void buttonUpdate(void)
{
	button_buffer[button_buffer_index] = isButtonPressed();
	button_buffer_index ++;
	button_buffer_index = button_buffer_index % BUTTON_BUFFER_SIZE;
	
	if((button_filtered_state == BUTTON_IDLE) && checkBuffer(BUTTON_PRESSED, 0)) { // transition IDLE -> PRESSED
		button_press_timestamp = millis;
		button_filtered_state = BUTTON_PRESSED;
	} else if((button_filtered_state == BUTTON_PRESSED) && checkBuffer(BUTTON_IDLE,1)) { // transition PRESSED -> IDLE
		uint32_t button_press_length = millis - button_press_timestamp;
		button_filtered_state = BUTTON_IDLE;
		if(button_press_length < BUTTON_PRESS_SHORT_MAX_LENGTH_MS) {
			PM_buttonShortPress();
		} else {
			PM_buttonLongPress();
		}
	}
	
	
}

uint8_t isButtonPressed(void)
{
	if(GPIO_ReadInputDataBit(BUTTON_PORT, BUTTON_PIN) == RESET) {
		return BUTTON_PRESSED;
	}
	return BUTTON_IDLE;
}


// checks if button_buffer contains state value
// if detectCompleteBuffer is 0, then all buffer values has to be equal to 'state'
// if detectCompleteBuffer is 1, then one of the buffer values has to be equal to 'state'
uint8_t checkBuffer(uint8_t state, uint8_t detectCompleteBuffer)
{
	int i;
	for(i = 0; i < BUTTON_BUFFER_SIZE; i++) {
		if(button_buffer[i] != state) {
			return 0;
		} else if(detectCompleteBuffer) {
			return 1;
		}
	}
	return 1;
}