# Serial Communication Between Two 8051 Microcontrollers

This project demonstrates serial communication between two 8051 microcontrollers: a transmitter and a receiver. The transmitter sends a character to the receiver, which processes the data and performs an action based on the received character.

## Table of Contents
- [Introduction](#introduction)
- [Hardware Requirements](#hardware-requirements)
- [Software Requirements](#software-requirements)
- [Circuit Diagram](#circuit-diagram)
- [How It Works](#how-it-works)
- [Code Explanation](#code-explanation)
- [How to Use](#how-to-use)
- [License](#license)

## Introduction
This project involves two 8051 microcontrollers communicating over a serial link. The transmitter sends a character ("J") repeatedly, and the receiver checks the received data. If the received character matches the expected value, it performs a specific operation by setting certain pins high or low.

## Hardware Requirements
- Two 8051 Microcontroller Boards
- Serial Communication Module (e.g., MAX232 for level conversion)
- Jumper Wires
- Power Supply

## Software Requirements
- Keil uVision IDE
- Proteus (for simulation)

## Circuit Diagram
The circuit consists of two 8051 microcontrollers connected via their TX (transmit) and RX (receive) pins through a MAX232 IC for serial communication. Ensure that the grounds of both microcontrollers are connected.

## How It Works
1. **Transmitter:**
   - Configures Timer 1 in Mode 2 (auto-reload) for generating the baud rate.
   - Continuously sends the character "J" through the serial port.

2. **Receiver:**
   - Configures Timer 1 similarly to the transmitter.
   - Waits to receive a character via the serial port.
   - Compares the received character with the expected value ("J").
   - If the received character matches, it sets the output port to a specific value; otherwise, it sets a different value.

## Code Explanation

### Transmitter Code

```assembly
	mov TMOD,#20h       ; Set Timer 1 in mode 2 (8-bit auto-reload)
	mov TH1,#-3         ; Set baud rate to 9600
	mov SCON,#50h       ; Configure serial mode 1, 8-bit data, 1 stop bit, REN enabled
	setb TR1            ; Start Timer 1
	
AGAIN:	
	MOV SBUF,#"J"       ; Load SBUF with character 'J'
	
HERE:	
	JNB TI,HERE         ; Wait for transmission to complete
	CLR TI              ; Clear TI flag
	
	mov r1, #10         ; Delay loop
xx:	
	mov r2, #200
yy:	
	mov r3, #200
ss:	
	djnz r3, ss
	djnz r2, yy
	djnz r1, xx
	
	SJMP AGAIN          ; Repeat the process
```

### Receiver Code

```assembly
org 000h
	
	mov tmod,#20h       ; Set Timer 1 in mode 2 (8-bit auto-reload)
	mov th1,#-3         ; Set baud rate to 9600
	mov scon,#50h       ; Configure serial mode 1, 8-bit data, 1 stop bit, REN enabled
	setb tr1            ; Start Timer 1
	clr ri              ; Clear the RI flag
	
here:	
	jnb ri,here         ; Wait for a character to be received
	mov a,sbuf          ; Move received data to accumulator
	mov r1,a            ; Store received data in R1
	
	acall sev           ; Call subroutine to process data
	sjmp here           ; Repeat the process
	
sev:	
	nop                 ; No operation
	mov a,r1            ; Load received data from R1
	xrl a,#74h          ; XOR with 'J' (ASCII 74h)
	jnz aa              ; If not 'J', jump to aa
	
	mov p1,#0e0h        ; If 'J', set port P1 to 0xE0
	sjmp en
	
aa: 
	mov p1,#0c0h        ; If not 'J', set port P1 to 0xC0
	
en:	
	nop                 ; No operation
	ret                 ; Return from subroutine
```

## How to Use
1. Connect the two 8051 microcontrollers using the TX and RX pins.
2. Load the transmitter code into one microcontroller and the receiver code into the other.
3. Power on both microcontrollers.
4. Observe the output on the receiver's port based on the received character.

## License
This project is open-source and available under the MIT License. Feel free to use, modify, and distribute the code as needed.