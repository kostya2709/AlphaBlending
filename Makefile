FNAME=hash_table
#LIBNAME=List_Funcs.cpp
CFLAGS= -c -Wall -msse4.2 -msse -O3
LFLAGS= -o

all: $(FNAME) clean

$(FNAME): $(FNAME).o
	@g++ $(LFLAGS) $(FNAME) main.o -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio
	@./$(FNAME)

$(FNAME).o:
	@g++ $(CFLAGS)  main.cpp

callgrind:
	@valgrind --tool=callgrind ./$(FNAME)

clean:
	@rm -rf *.o