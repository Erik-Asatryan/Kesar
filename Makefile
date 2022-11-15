all: clean create_directories lib/libencoder_shared.so lib/libdecoder_shared.so bin/encoder_shared bin/decoder_shared

CLEAN = rm -rf lib bin obj
LIB := src/
SRC := $(wildcard $(LIB)*.cpp)
OBJ := $(patsubst src/%.cpp,obj/%.o,$(SRC))

lib/libencoder_shared.so: $(OBJ)
	g++ -shared -fPIC obj/encoder.o -o lib/libencoder_shared.so   
lib/libdecoder_shared.so: $(OBJ)
	g++ -shared -fPIC obj/decoder.o -o lib/libdecoder_shared.so

# Ներքևի տողում կախվածությունների ցանկում գրված է "obj"
# obj֊ն կառուցելու համար rule չունենք
# Եթե make clean անենք, ու անմիջապես հետո կանչենք make obj/main.o կտեսնենք խնդիր
# Այսինքն պետք է լիներ նաև հետևյալ մասը
# obj:
# 	mkdir -p obj

obj/%.o: obj
	$(eval TEMP = $(patsubst obj/%.o,%,$@))
	g++ -c src/$(TEMP).cpp -o obj/$(TEMP).o
    
create_directories:
	mkdir -p lib bin obj
	
# Քանի որ 23 տողում օգտագործում ես "-lencoder_shared",
# Պետք ա կախվածությունների ցանկում ավելացնես նաև գրադարանի so֊ն
# Ծրագիրը ճիշտ ա կոառուցվում all֊ի մեջ գրած կախվածությունների շնորհիվ, բայց
# դա ծրագրի ճիշտ կառուցվածք չի
bin/encoder_shared: obj/main.o 
	export LD_LIBRARY_PATH=$(LD_LIBRARY_PATH):pwd
	g++ $^ -L./lib -Wl,-rpath=./lib -lencoder_shared -o $@
	./bin/encoder_shared
	
# Քանի որ 30 տողում օգտագործում ես "-lencoder_shared",
# Պետք ա կախվածությունների ցանկում ավելացնես նաև գրադարանի so֊ն
bin/decoder_shared: obj/second_main.o
	g++ $^ -L./lib -Wl,-rpath=./lib -ldecoder_shared -o $@
	./bin/decoder_shared
clean:
	$(CLEAN)
