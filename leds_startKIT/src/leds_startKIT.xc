/*
 *  leds_startKIT.xc
 *
 *  Created on: Feb 21, 2014
 *  Author: Mourice Wandera
 */

#include <xs1.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <xscope.h>
#include <timer.h>

#define delay 1000
#define states 4

// Declaring the Ports to be used
port led_1 = XS1_PORT_1A;
port led_2 = XS1_PORT_1D;
port line = XS1_PORT_32A;

int vector[states] = {0xA1680,0xC1580,0xE0380,0x61700}; // States of the 3*3 LEDs

void blink(port type, int frequency); // For blinking led_1 & led_2
void spin(); // Loops through the states of 3*3 LEDs

int main(){

    par{
        blink(led_1, 4);
        blink(led_2, 4);
        spin();
    }


    return 0;
}

void blink(port type, int frequency){ // For Blinking the two other LEDs on the board
    //chan led;
    while(1){
        type <: 0; // Switches off the LED
        delay_milliseconds(delay/frequency); // Time taken while the LED is off
        type <: 1; // Switches on the LED
        delay_milliseconds(delay/frequency); // Time taken while the LED is on
    }

}

void spin(){ // For Spinning the 3x3 LEDs like a bar
    //chan led;
    int i=0;
    while(1){
        line <: vector[i]; // Assigns the current state to the 3x3 LEDs
        i++; // Drives the LEDs to the next state
        delay_milliseconds(delay/20); // Time taken in the current state
        line <: 0xE1F80; // Switches off all the LEDs
        delay_milliseconds(delay/40); // Time taken while all LEDs are off
        if(i==states){i=0;} // Drives the LEDs state back to the initial
    }
}
