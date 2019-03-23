## TODOs

- [X] Set compilation flags according to source type for each object
- [ ] Improve flags management (?)
  - [X] Select flags depending on project language
- [ ] Create tool for importing project structure
- [X] Improve `autotest.sh`
  - [X] add support for other extensions(.cc, .cp, .cxx, .cpp, .CPP, .c++, .C)
  - [X] Improve script structure
  - [X] Warn user to call it's main file as `main.EXT`
- [X] Add note on README.md to create main file named `main.cpp` (or `main.c` if it's a C project)
- [X] Improve `.gitignore` using [gitignore.io](https://www.gitignore.io/)
- [ ] Remove the need to specify a target on the makefile
  - Running `make` should by default compile the project
  - [ ] Move info message to 'help' target
