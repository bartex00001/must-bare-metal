if(FIND_RISCV64_INCLUDED)
    return()
endif()
set(FIND_RISCV64_INCLUDED true)

# Stolen from 'github.com/Operacja-System/BigOS' - finds riscv64 gcc on most sane distributions
foreach(PREFIX "riscv64-unknown-elf" "riscv64-elf" "riscv64-none-elf" "riscv64-unknown-none-elf")
    find_program(PREFIX_TOOLCHAIN_GCC "${PREFIX}-gcc")
    if (PREFIX_TOOLCHAIN_GCC)
        set(DEFAULT_RISCV_TOOLCHAIN_PREFIX "${PREFIX}-")
        break()
    endif()
endforeach()

set(RISCV_TOOLCHAIN_PREFIX "${DEFAULT_RISCV_TOOLCHAIN_PREFIX}" CACHE STRING "RISC-V toolchain prefix")

if (NOT RISCV_TOOLCHAIN_PREFIX)
    message(SEND_ERROR "Toolchain prefix is invalid not specified")
endif()

find_program(CMAKE_C_COMPILER "${RISCV_TOOLCHAIN_PREFIX}gcc" REQUIRED)
