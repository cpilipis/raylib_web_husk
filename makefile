# The goal of this makefile is to function for both native web assembly builds and native Linux builds
# perhaps it can be expanded later on with win32 or mac support
# Web is intended as the first class citizen, so the default build target will be index.html
# however, there will be an alternate target for Linux native and switching to this target will require different resources.

# Write the working directories to objects and libraries to a variable
dir_obj = ./build/emscripten/obj
dir_lib = ./build/emscripten/lib
dir_bin = ./build/emscripten/bin

# A variable of all the desired object files
# To add a new object file to the build, just add it to this list in this format, 
# then add it's rule below near the bottom of the file, 
# and be sure to amend the requirements of other files that may now require this new object/source file.
files_obj = $(dir_obj)/main.o


# variables for the cc and flags
# flags change depending on whether we're compiling for native or the web browser
# more specifically, EMCC demands a LOT of flags. GCC, not so much.
cc = emcc
# emcc doesn't require any extra flags than the shared ones for individual object files.
cc_flags = 
# the final flags are only required for the final target, and not for individual object files.
cc_flags_final = -o $(dir_bin)/index.html -L$(dir_lib)/lib/ -s USE_GLFW=3 -s ASYNCIFY -DPLATFORM_WEB

# some "shared" variables, meaning they're supposed to stay the same regardless of compiler/target file in general, 
# but I might change them for entirely unrelated purposes.

flags_shared = -Wall -I./include/
flags_shared_final = $(dir_lib)/libraylib.a

# An implicit compile rule for object file targets.
# Make already has a very basic implicit rule for compiling object files from their source, but I considered
# it inadequate for my needs. I wish to separate my source and object files into different directories,
# and I needed to include the include folder that has the headers I need for raylib.

$(dir_obj)/%.o : ./src/%.c 
	$(cc) $(flags_shared) $(cc_flags) -c $^ -o $@

# This is the default target of the file, the final goal. It compiles a binary for web assembly.
# Index.html is where my (prototype) build of the game lives.
# If I compile this, I need to host a web server running this page and I can connect to it to play the game.
$(dir_bin)/index.html: $(files_obj)
	$(cc) $(flags_shared) $(flags_shared_final) $(cc_flags) $(cc_flags_final) $(files_obj)

# object file definitions and rerequisites. Ideally, most if not all of these should just use the implicit rule.
$(dir_obj)/main.o: src/main.c
#You can see that main.o doesn't have any instructions for fulfilling the target. That's because it uses the implicit rule.

clean: 
	rm $(dir_obj)/*.o $(dir_bin)/* 
#todo: make the cleanup clean up ALL POSSIBLE obj and bin directories.

setup:
	mkdir build
	mkdir build/emscripten
	mkdir build/emscripten/obj
	mkdir build/emscripten/lib
	mkdir build/emscripten/bin
	mkdir build/linuxamd64/
	mkdir build/linuxamd64/obj
	mkdir build/linuxamd64/lib
	mkdir build/linuxamd64/bin

