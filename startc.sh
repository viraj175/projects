#!/bin/bash

# Creating folders with project name
if [ -z "$1" ]; then
    echo "No folder name provided!"
    echo "usage: $0 <folder_name>"
    exit 1
fi

folder_name=$1

if [ -d "$1" ]; then
    echo "Folder "$folder_name" already exist"
    exit 1
fi

mkdir "$folder_name"

# Now initilizing c Directories
touch ./"$folder_name"/makefile
mkdir ./"$folder_name"/src ./"$folder_name"/lib ./"$folder_name"/binary
touch ./"$folder_name"/src/main.c ./"$folder_name"/src/foo.c
touch ./"$folder_name"/lib/functions.h

# Providing basic code template to main.c
cat << EOF > "./$folder_name/src/main.c"
#include "functions.h"

int main (int argc, char **argv) {

    return 0;
}
EOF

# Providing basic code template to foo.c
cat << EOF > "./$folder_name/src/foo.c"
#include "functions.h"

EOF

# Providing basic code template to main.c
cat << EOF > "./$folder_name/lib/functions.h"
#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include <stdio.h>
// Define your functions here

#endif /* FUNCTIONS_H */
EOF

# Providing basic code template to makefile
cat << EOF > "./$folder_name/makefile"
CFLAGS = -Wno-implicit-function-declaration

run: ./binary/final
	@echo "compiled successfully now running!"
	@echo ""
	@./binary/final \$(args)
	@echo ""
	@echo "process returned with exit status \$\$?" 

final: ./binary/main.o ./binary/foo.o
	@echo "Your binary is built, type \"make run\" to execute!"
	@gcc \$(CFLAGS) ./binary/main.o ./binary/foo.o -o final
	@mv final ./binary/

./binary/main.o: ./src/main.c
	@gcc \$(CFLAGS) -c ./src/main.c
	@mv main.o ./binary/

./binary/foo.o: ./src/foo.c
	@gcc \$(CFLAGS) -c ./src/foo.c
	@mv foo.o ./binary/

clean: 
	@echo "Removing object files"
	rm ./binary/*.o
EOF

