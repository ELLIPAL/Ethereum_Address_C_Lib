# Makefile 
# (c)ELLIPAL
# Ethereum address from private key CLang lib

SRC = bignum256.c ecdsa.c endian.c  \
hash.c hmac_drbg.c hmac_sha512.c \
ripemd160.c sha256.c keccak.c etherkeys.c test.c


#Maester
TESTLIST = ether

# Define programs and commands.
CC = gcc
REMOVE = rm -f
REMOVEDIR = rm -rf

# Define flags for C compiler.
GENDEPFLAGS = -MMD -MP -MF .dep/$(@F).d
CCFLAGS = -DTEST -DFIXMATH_NO_64BIT -ggdb -O0 -Wall -Wstrict-prototypes \
-Wundef -Wunreachable-code -Wsign-compare -Wextra -Wconversion -std=gnu99 \
$(GENDEPFLAGS)


################################################################
# Below this point is stuff which is generally non-customisable.
################################################################

# Get the list of object files for each target.
OBJ = $(SRC:%.c=%.o)

# Get the list of target names.
TARGETLIST = $(addprefix test_,$(TESTLIST))

# Get the list of object directories.
OBJDIRLIST = $(addsuffix _obj,$(TARGETLIST))

# Get the list of all possible object files.
# This basically calculates the Cartesian product of the OBJDIRLIST and
# OBJ lists, inserting a "/" for each item.
OBJEXPAND = $(foreach OBJDIR,$(OBJDIRLIST),$(addprefix $(OBJDIR)/,$(OBJ)))

.PHONY: all clean

all: $(TARGETLIST)

# Make object directory.
$(OBJDIRLIST):
	$(shell mkdir $@ 2>/dev/null)

.SECONDEXPANSION:

# Link object files together to form an executable.
$(TARGETLIST): $(addprefix $$@_obj/,$(OBJ))
	$(CC) $^ $(LIBS) -o $@

# Compile a C source file into an object file.
# What does $(shell echo $(@D:%_obj=%) | tr '[:lower:]' '[:upper:]') do?
# It gets the name of the object directory, removes _obj from the end and
# converts it to uppercase.
$(OBJEXPAND): $$(subst .o,.c,$$(@F)) | $$(@D)
	$(CC) $(CCFLAGS) -c -o $@ -D$(shell echo $(@D:%_obj=%) | tr '[:lower:]' '[:upper:]') $<

clean:
	$(REMOVEDIR) $(OBJDIRLIST)
	$(REMOVE) $(addsuffix *,$(TARGETLIST))
	$(REMOVEDIR) .dep

# Include the dependency files.
-include $(shell mkdir .dep 2>/dev/null) $(wildcard .dep/*)
