#   ==========================
#  ||    MAKEFILE OBJECTS    ||
#   ==========================
#
#  Calls compilation for each object

allobjs: $(ALLOBJS)
	@echo -e '------------------------------------------------------'
	@echo -e '\tObjects updated!\n'

$(ALLOBJS): FORCE
	@set -e; $(MAKE) --no-print-directory -f makeobj.mk TARGET=$@


FORCE:

#   ====================================
#  ||      MAKEFILE OBJETOS >END<      ||
#   ====================================
