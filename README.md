A "husk" project I'm making as a placeholder for other projects for my own personal use. This uses the Make build system, Emscripten toolchain for web assembly compiliation, the C programming language, and Raylib for graphics, sound, and inputs programming. This project is meant to be a "Starter" for anything I would like to make using Raylib, as it's meant to simplify distributing to both desktop Linux and Web compilation. It's also my first real study and practice with the Make build system. 

Raylib is written by Ramon Santamaria, and is distributed as is. It is not included with this github repository.

this husk on it's own isn't everything you need. To build this project, you need the following:

- The Emscripten and/or GCC toolchain
- A copy of raylib for your desired build targets
    - Place the three raylib headers in the include/ directory
    - For each platform you wish to compile for, place the static Raylib library compiled for that platform (usually libraylib.a) in build/target/lib, where target is the platform you're targeting
- Make


