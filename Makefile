all: clean create_directories obj_files  encoder.so_decoder.so_files linking

create_directories:
	@echo "|-------------------------|"
	@echo "|Creating directories...  |"
	@echo "|-------------------------|"
	@mkdir -p lib bin obj

obj_files:
	@echo "|-------------------------|"
	@echo "|Creating encoder.o...    |"
	@echo "|-------------------------|"
	@g++ -c src/main.cpp -o obj/main.o
	@echo "|-------------------------|"
	@echo "|Creating main.o...       |"
	@echo "|-------------------------|"
	@g++ -c encoder/encoder.cpp -o obj/encoder.o
	@echo "|-------------------------|"
	@echo "|Creating decoder.o...    |"
	@echo "|-------------------------|"
	@g++ -c src/second_main.cpp -o obj/second_main.o
	@echo "|-------------------------|"
	@echo "|Creating second_main.o...|"
	@echo "|-------------------------|"
	@g++ -c decoder/decoder.cpp -o obj/decoder.o
	
encoder.so_decoder.so_files:
	@g++ -shared -fPIC obj/encoder.o -o lib/libencoder_shared.so	
	@g++ -shared -fPIC obj/decoder.o -o lib/libdecoder_shared.so

linking:
	@echo "|-------------------------|"
	@echo "|Path importing...        |"
	@echo "|-------------------------|"
	@export LD_LIBRARY_PATH=$(LD_LIBRARY_PATH):`pwd`
	@echo "|-------------------------|"
	@echo "|Shared libraryes exist   |"
	@echo "|-------------------------|"
	@g++ obj/main.o -L./lib -Wl,-rpath=./lib -lencoder_shared -o bin/encoder_shared
	@g++ obj/second_main.o -L./lib -Wl,-rpath=./lib -ldecoder_shared -o bin/decoder_shared

#	@g++ src/main.cpp -L lib lib/libencoder_shared.so -o bin/kes
	@echo "|-------------------------|"
	@echo "|Text for encoder...      |"
	@echo "|-------------------------|"
	@./bin/encoder_shared
	@echo "|-------------------------|"
	@echo "|Text for decoder...      |"
	@echo "|-------------------------|"
	@./bin/decoder_shared
	
clean:
	@echo "|-------------------------|"
	@echo "|Cleaning directories...  |"
	@echo "|-------------------------|"
	@rm -rf lib bin obj
