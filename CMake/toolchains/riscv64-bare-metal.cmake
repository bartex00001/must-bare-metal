cmake_minimum_required(VERSION 3.13)

if(RISCV_BARE_METAL_TOOLCHAIN_INCLUDED)
    return()
endif()
set(RISCV_BARE_METAL_TOOLCHAIN_INCLUDED true)

# Based on common riscv64 setup
include(${CMAKE_CURRENT_LIST_DIR}/riscv64-common.cmake)


find_program(QEMU_FOUND_PATH "qemu-system-riscv64")
set(QEMU_PATH "${QEMU_FOUND_PATH}" CACHE PATH "path to qemu")
set(QEMU_OPTIONS "-machine virt -nographic -kernel" CACHE STRING "options for qemu")
separate_arguments(QEMU_OPTIONS_LIST UNIX_COMMAND "${QEMU_OPTIONS}")

function(SETUP_EXECUTABLE name)
    add_executable(${name})
    target_compile_options(${name} PRIVATE -Wall -Wextra -Wno-unknown-pragmas)

    file(GLOB_RECURSE SOURCES CONFIGURE_DEPENDS *.c)
    file(GLOB_RECURSE AS_SOURCES CONFIGURE_DEPENDS *s)
    file(GLOB_RECURSE HEADERS CONFIGURE_DEPENDS "${PROJECT_SOURCE_DIR}/include/${name}/*.h")

    target_sources(${name}
        PRIVATE
            ${SOURCES}
            ${AS_SOURCES}
        PRIVATE
            FILE_SET HEADERS
            BASE_DIRS .
            FILES ${HEADERS}
    )

    add_custom_command(
            TARGET ${name} POST_BUILD
            COMMAND ${CMAKE_OBJCOPY}
                        -O binary
                        "$<TARGET_FILE:${name}>"
                        "$<TARGET_FILE:${name}>.bin"
            VERBATIM
        )

    install(PROGRAMS "${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/${name}.bin" TYPE BIN)

    set(CMD "${QEMU_PATH}" ${QEMU_OPTIONS_LIST}
        "$<TARGET_FILE:${name}>.bin"
    )

    add_custom_target(run-${name}
        COMMAND ${CMD}
        DEPENDS ${name}
        VERBATIM
        USES_TERMINAL
    )

    set(CMD_GDB ${QEMU_PATH} ${QEMU_OPTIONS_LIST}
        "$<TARGET_FILE:${name}>.bin" "-S" "-s")

    add_custom_target(run-gdb-${name}
        COMMAND ${CMD_GDB}
        DEPENDS ${name}
        VERBATIM
        USES_TERMINAL
    )
endfunction()
