#   ==========================
#  ||    MAKEFILE OBJECT     ||
#   ==========================
#
#  Compiles objects

include .functions.mk

# $(info TARGET----------->$(TARGET))
TARGET_SOURCE := $(call get_source_from_object,$(TARGET))
# $(info ==================================)
# $(info TARGET_SOURCE---->$(TARGET_SOURCE))
FULL_RULE := $(call get_object_rule_from_source,$(TARGET_SOURCE))
# $(info ==================================)
# $(info $(FULL_RULE))
PREREQUISITES := $(call get_prerequisites_from_rule,$(FULL_RULE))
# $(info ==================================)
# $(info $(PREREQUISITES))
COMPILER := $(call get_compiler,$(TARGET_SOURCE))
# $(info ==================================)
# $(info COMPILER-------->$(COMPILER))
# $(info #)

COMPILATION_FLAGS := $(if $(call is_cpp_file, $(TARGET_SOURCE)),$(CXXFLAGS),$(CFLAGS))

$(TARGET): $(PREREQUISITES)
	@echo -e '------------------------------------------------------'
	@echo -e '\t\tUpdating:\n\t$@ ...'
	@set -e; rm -f $(TARGET); $(COMPILER) $(COMPILATION_FLAGS) -c $(TARGET_SOURCE) -o $@;

#   ===================================
#  ||      MAKEFILE OBJECT >END<      ||
#   ===================================
