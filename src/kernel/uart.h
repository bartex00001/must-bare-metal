#pragma once
#include "types.h"


void uart_putchar(u8 c);

void uart_putstr(u8 str[]);

u8 uart_getchar();
