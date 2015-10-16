#!/bin/bash
## 
## Made by Glastis
## 
## Last update Fri Oct 16 19:32:31 2015 glastis
##

CFLAG="-Wall -Wextra -Werror -ansi -pedantic"

## If an old makefile exist
if [ -e Makefile ];then
    TMP=`mktemp Makefile_old_XXXXX`
    rm $TMP
    mv Makefile $TMP
fi

## Detect and add c files
SRC=$(ls -R | grep -F ".c")
printf "SRC=" >> Makefile
for line in $SRC;do
    printf "\t\t\t%s %c\n" "`find -name $line`" "\\" >> Makefile
    printf "."
done
printf "\n" >> Makefile
printf "\n"

## Add targets
printf "OBJ=\t\t\t \$(SRC:.c=.o)\n\n" >> Makefile

## Add name
printf "NAME=\t\t\t a.out\n\n" >> Makefile

## Add compilation flags
printf "CFLAGS=\t\t\t%s\n\n" "$CFLAG" >> Makefile

## Add rules
printf "all:\t\t\t\$(NAME)\n\n" >> Makefile
printf "\$(NAME):\t\t\$(OBJ)\n\tgcc -o \$(NAME) \$(OBJ)\n\n" >> Makefile
printf "clean:\n\trm -f \$(OBJ)\n\n" >> Makefile
printf "fclean:\t\t\tclean\n\trm -f \$(NAME)\n\n" >> Makefile
printf "re:\t\t\tfclean all\n\n" >> Makefile
printf ".PHONY:\tall clean fclean re\n" >> Makefile
