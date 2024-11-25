# Detect operating system and set commands accordingly
ifeq ($(OS),Windows_NT)
    DETECTED_OS := Windows
    TARGET_EXTENSION := .exe
    RM := del /Q
    MKDIR := mkdir
    CP := copy
    PATHSEP := \\
else
    DETECTED_OS := $(shell uname -s)
    TARGET_EXTENSION :=
    RM := rm -rf
    MKDIR := mkdir -p
    CP := cp
    PATHSEP := /
endif

# Compiler settings
CFLAGS = -Wall -Wextra -std=c11 -Wimplicit-function-declaration -g

# Directories
SRC_DIR = src
BUILD_DIR = build

# Source files
SOURCES = $(SRC_DIR)/main.c

# Executable name
TARGET = quickfall$(TARGET_EXTENSION)

# Default target
all: check_commands $(TARGET)
bench: check_commands $(BENCH_TARGET)

OBJECTS = $(SOURCES:%.c=$(BUILD_DIR)/%.o)

# Check commands target
check_commands:
	@echo "Using compiler: gcc"
	@echo "Operating System: $(DETECTED_OS)"
	$(CHECK_COMMANDS)
	@echo "Sources: $(SOURCES)"

# Create build directory structure
$(BUILD_DIR):
	$(MKDIR) $(BUILD_DIR)

# Compile source files
$(BUILD_DIR)/%.o: %.c | $(BUILD_DIR)
	gcc $(CFLAGS) -c $< -o $@

# Link object files
$(TARGET): $(OBJECTS):
	gcc build/src/cli/main.o $(OBJECTS) -g -o $@

# Clean build files
clean:
	$(RM) $(BUILD_DIR)
	$(RM) $(TARGET)

# Phony targets
.PHONY: all clean check_commands
