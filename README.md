
## Dependencies

- `CMake` > 3.13
- gcc riscv64 toolchain for crosscompilation

## How To Build

Choose a preset to generate build files:
```sh
cmake --list-presets
# Available configure presets:
#
#   "bare-metal-debug" - Debug Configuration for bare metal riscv64

cmake --preset=<your-preset>
```

Build the project:
```sh
# Just build
cmake --build build
```

Run specific target:
```sh
cmake --build build --target help
# The following are some of the valid targets for this Makefile:
# ... all (the default if no target is provided)
# ... clean
# ... depend
# ... run-...

cmake --target=<your-target>
```
