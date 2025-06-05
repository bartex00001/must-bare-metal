#include "err.h"
#include "io.h"

void panic(u8* reason) {
    print((u8*)"Kernel panicked! Reason: ");
    print_line(reason);
    while (true)
        ;
}
