# Compiler settings
CC = gcc
CFLAGS = -Wall 
LDFLAGS =

# Directories
SRC_DIR = .
BUILD_DIR = build
OBJ_DIR = $(BUILD_DIR)/obj

# Target executable
TARGET = clox

# Source files
SRCS = main.c chunk.c memory.c value.c debug.c vm.c
OBJS = $(SRCS:%.c=$(OBJ_DIR)/%.o)

# Header files
HEADERS = common.h chunk.h memory.h value.h debug.h

# Default target
all: $(TARGET)

# Link object files to create executable
$(TARGET): $(OBJS)
	$(CC) $(OBJS) $(LDFLAGS) -o $(TARGET)

# Compile source files to object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(HEADERS) | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Create object directory
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR) $(TARGET)

# Rebuild everything
rebuild: clean all

# Run the program
run: $(TARGET)
	./$(TARGET)

# Debug build
debug: CFLAGS += -g -DDEBUG
debug: clean all

.PHONY: all clean rebuild run debug
