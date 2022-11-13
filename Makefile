all: clean create_directories obj/main.o obj/encoder.o obj/second_main.o obj/decoder.o lib/libencoder_shared.so  lib/libdecoder_shared.so linking_first.o linking_second.o

UNSEEN = @
P = echo
W = g++
SHARED = -L./lib -Wl,-rpath=./lib
MAKE1 = bin/encoder_shared
MAKE2 = bin/decoder_shared
CLEAN = rm -rf lib bin obj
FPIC = -shared -fPIC
-lE = -lencoder_shared -o
-lD = -ldecoder_shared -o
DESIGN := "|-------------------------|"
DESIGN1 := "|"
DESIGN2 := "|"

create_directories:
	$(UNSEEN)$P $(DESIGN)
	$(UNSEEN)$P $(DESIGN1)"Creating directories...  "$(DESIGN2)
	$(UNSEEN)$P $(DESIGN)
	@mkdir -p lib bin obj


obj/main.o: src/main.cpp
	$(UNSEEN)$P $(DESIGN)
	$(UNSEEN)$P $(DESIGN1)"Creating encoder.o...    "$(DESIGN2)
	$(UNSEEN)$P $(DESIGN)
	$(UNSEEN)$W -c $< -o $@
	$(UNSEEN)$P $(DESIGN)

obj/encoder.o: encoder/encoder.cpp
	$(UNSEEN)$P $(DESIGN1)"Creating main.o...       "$(DESIGN2)
	$(UNSEEN)$P $(DESIGN)
	$(UNSEEN)$W -c $< -o $@
	$(UNSEEN)$P $(DESIGN)
obj/second_main.o: src/second_main.cpp
	$(UNSEEN)$P $(DESIGN1)"Creating decoder.o...    "$(DESIGN2)
	$(UNSEEN)$P $(DESIGN)
	$(UNSEEN)$W -c $< -o $@
	$(UNSEEN)$P $(DESIGN)
obj/decoder.o: decoder/decoder.cpp
	$(UNSEEN)$P $(DESIGN1)"Creating second_main.o..."$(DESIGN2)
	$(UNSEEN)$P $(DESIGN)
	$(UNSEEN)$W -c $< -o $@

#obj/%.o: obj
#	$(eval TEMP = $(patsubst obj/%.o,%,$@))
#	@"echo Creating $(TEMP)..."
#	$(UNSEEN)$(W) -c $^$(TEMP).cpp -o obj/$(TEMP).o

lib/libencoder_shared.so: obj/encoder.o
	$(UNSEEN)$W $(FPIC) $< -o $@	
lib/libdecoder_shared.so: obj/decoder.o
	$(UNSEEN)$W $(FPIC) $< -o $@
linking_first.o: obj/main.o
	$(UNSEEN)$P $(DESIGN)
	$(UNSEEN)$P $(DESIGN1)"Path importing...        "$(DESIGN2)
	$(UNSEEN)$P $(DESIGN)
	$(UNSEEN)export LD_LIBRARY_PATH=$(LD_LIBRARY_PATH):`pwd`
	$(UNSEEN)$P $(DESIGN)
	$(UNSEEN)$P $(DESIGN1)"Shared libraries exist   "$(DESIGN2)
	$(UNSEEN)$P $(DESIGN)
	$(UNSEEN)$W $^ $(SHARED) $(-lE) $(MAKE)
linking_second.o: obj/second_main.o
	$(UNSEEN)$W $^ $(SHARED) $(-lD) $(MAKE2)
	$(UNSEEN)$P $(DESIGN)
	$(UNSEEN)$P $(DESIGN1)"Text for encoder...      "$(DESIGN2)
	$(UNSEEN)$P $(DESIGN)
	$(UNSEEN)./$(MAKE)
	$(UNSEEN)$P $(DESIGN)
	$(UNSEEN)$P $(DESIGN1)"Text for decoder...      "$(DESIGN2)
	$(UNSEEN)$P $(DESIGN)
	$(UNSEEN)./$(MAKE2)
clean:
	$(UNSEEN)$P $(DESIGN)
	$(UNSEEN)$P $(DESIGN1)"Cleaning directories...  "$(DESIGN2)
	$(UNSEEN)$P $(DESIGN)
	$(UNSEEN)$(CLEAN)
