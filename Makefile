ifeq ($(strip $(V)),)
	E = @echo
	Q = @
else
	E = @\#
	Q =
endif
export E Q

PROGRAM	= kernel

OBJS	+= boot.o 
OBJS	+= copy.o
OBJS	+= monitor.o
OBJS	+= io/gdt.o 
OBJS	+= io/idt.o
OBJS	+= io/isrs.o
OBJS	+= kernel.o 

CFLAGS	= -m32 -Iinclude -nostdlib -nostdinc -fno-builtin -fno-stack-protector -g

$(PROGRAM):	$(OBJS)
	$(E) "  LINK	  " $@
	$(Q) $(CC) $(OBJS) $(CFLAGS) -T kernel.ld -o $@

$(OBJS):
%.o: %.c 
	$(E) "  CC      " $@
	$(Q) $(CC) -c $(CFLAGS) $< -o $@	

boot.o: boot.s 
	$(E) "  CC      " $@
	$(Q) $(CC) -m32 -c boot.s -o boot.o

copy.o: copy.S
	$(E) "  CC      " $@
	$(Q) $(CC) -m32 -c -Iinclude copy.S -o copy.o

clean:
	$(E) "  CLEAN"
	$(Q) rm -f *.o 
	$(Q) rm -f io/*.o 
	$(Q) rm -f kernel
.PHONY: clean