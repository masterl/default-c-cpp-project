## Default C/C++ Project
Makefiles and folder structure for C/C++ development

### Notes
- **Linux only** (for now?)
- This project expects both `src` and `tests` folder to contain a main file named `main.EXT` where *EXT* are any of the default C/C++ extensions
  - C: `.c`
  - C++: `.cc`/`.cp`/`.cxx`/`.cpp`/`.CPP`/`.c++`/`.C` (**Makefile currently only support .cpp for C++**)
  - By *"main file"* we mean the file that actually contains a `main` function

### Features:
- Automatically detects subfolders
- Compiler selection according to source extension

### Tested on:
- Manjaro

### Notes
- *Only supports .cpp extension for C++ source files!*

### TODOs
See [TODO.md](TODO.md)

#### Dependencies:

- For `autotest.sh`:
  - [entr](http://entrproject.org/)
