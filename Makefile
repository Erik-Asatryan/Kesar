all: clean create_directories lib/libencoder_shared.so lib/libdecoder_shared.so bin/encoder_shared bin/decoder_shared

CLEAN = rm -rf lib bin obj
LIB := src/
SRC := $(wildcard $(LIB)*.cpp)
OBJ := $(patsubst src/%.cpp,obj/%.o,$(SRC))

lib/libencoder_shared.so: $(OBJ)
	g++ -shared -fPIC obj/encoder.o -o lib/libencoder_shared.so   
lib/libdecoder_shared.so: $(OBJ)
	g++ -shared -fPIC obj/decoder.o -o lib/libdecoder_shared.so

obj/%.o: obj
	$(eval TEMP = $(patsubst obj/%.o,%,$@))
	g++ -c src/$(TEMP).cpp -o obj/$(TEMP).o
    
create_directories:
	mkdir -p lib bin obj
bin/encoder_shared: obj/main.o
	export LD_LIBRARY_PATH=$(LD_LIBRARY_PATH):pwd
	g++ $^ -L./lib -Wl,-rpath=./lib -lencoder_shared -o $@
	./bin/encoder_shared
bin/decoder_shared: obj/second_main.o
	g++ $^ -L./lib -Wl,-rpath=./lib -ldecoder_shared -o $@
	./bin/decoder_shared
clean:
	$(CLEAN)
