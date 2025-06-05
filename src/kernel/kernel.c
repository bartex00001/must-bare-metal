
#include "err.h"
#include "io.h"
#include "types.h"
#include "uart.h"

typedef enum { SET, ADD } Command;

typedef enum { IMM, VAR } AtomType;

typedef struct {
    AtomType t;
    union {
        i32 imm;
        u8 var;
    };
} Atom;

typedef struct {
    Command c;
    Atom a0;
    Atom a1;
} Instruction;

i32 dec(u8 c) {
    switch (c) {
    case '0':
        return 0;
    case '1':
        return 1;
    case '2':
        return 2;
    case '3':
        return 3;
    case '4':
        return 4;
    case '5':
        return 5;
    case '6':
        return 6;
    case '7':
        return 7;
    case '8':
        return 8;
    case '9':
        return 9;
    default:
        panic((u8*)"Can't parse character into a digit (dec function)");
        return -1;
    };
}

void put_int(i32 n, u8* buf) {
    i32 i = 0;
    while (n > 0) {
        buf[i++] = (n & 1) + '0';
        n >>= 1;
    }
    buf[i] = '\0';
}

Instruction parse(u8 buf[]) {
    Instruction i;
    switch (buf[0]) {
    case 'S':
        break;
    case 'A':
        i.c = ADD;
        Atom a0 = {.t = IMM, .imm = dec(buf[4])};
        i.a0 = a0;
        Atom a1 = {.t = IMM, .imm = dec(buf[6])};
        i.a1 = a1;
        break;
    default:
        panic((u8*)"Unknown instruction");
    };
    return i;
}

i32 main() {
    u8 buf[255];
    for (i32 i = 0; i < 500000; i++)
        ;
    print_line((u8*)"Welcome to the glorious MUST kernel...");
    uart_getchar();

    while (true) {
        print((u8*)"> ");
        get_line(buf);
        Instruction i = parse(buf);
        switch (i.c) {
        case ADD:
            put_int(i.a0.imm + i.a1.imm, buf);
            print_line(buf);
            break;
        case SET:
            break;
        }
    }
}
