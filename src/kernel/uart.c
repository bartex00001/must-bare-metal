#include "uart.h"

volatile u8* UART = (volatile u8*)0x10000000;
volatile u8* UART_LSR = (volatile u8*)0x10000005;

void uart_putchar(u8 c) { *UART = c; }

void uart_putstr(u8 str[]) {
    while (*str) {
        uart_putchar(*str);
        str++;
    }
}

u8 uart_getchar() {
    while ((*UART_LSR & 0x01) == 0)
        ;
    return *UART;
}
