# These make commands rely on the problem ID
#   Run: make command pid=number
# Quickly create a new directory
#   Run: make new pid=number
# Astyle main file in a new directory
#   Run: make astyle pid=number
# Compile main file in a new directory
#   Run: make pid=number


.DEFAULT_GOAL = $(pid)

DIRECTORY := problem$(pid)
CHECKDIRECTORY:
ifeq ($(DIRECTORY),problem)
	@echo "make command pid=number"
	@exit 1
endif
	@:

.PHONY: astyle clean new run $(pid)

CC     := gcc
CFLAGS := -std=gnu99 -Wall -Wextra -Werror
$(pid): $(DIRECTORY)/main.c CHECKDIRECTORY 
	$(CC) $(CFLAGS) $< -o output

new: CHECKDIRECTORY
	@if [ ! -d $(DIRECTORY) ]; then  \
		mkdir $(DIRECTORY); \
		echo -e "#include <stdio.h>\n\nint main ( void )\n{\n    return 0;\n}" > $(DIRECTORY)/main.c; \
	fi

run: CHECKDIRECTORY $(pid)
	@./output

astyle: CHECKDIRECTORY
	astyle --options=.astylerc $(DIRECTORY)/main.c

clean:
	@rm -f output
