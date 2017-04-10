#   ===========================
#  ||    MAKEFILE OBJECTS     ||
#   ===========================
#
#  Compiles objects

include .functions.mk

TARGET_SOURCE := $(call get_source_from_object,$(TARGET))
FULL_RULE := $(call get_object_rule_from_source,$(TARGET_SOURCE))
PREREQUISITES := $(call get_prerequisites_from_rule,$(FULL_RULE))

$(TARGET): $(PREREQUISITES)
	@echo -e '------------------------------------------------------'
	@echo -e '\t\tUpdating:\n\t$@ ...'
	@set -e; rm -f $(TARGET); $(CC) $(ALLCOMPFLAGS) -c $(TARGET_SOURCE) -o $@;

#   ====================================
#  ||      MAKEFILE OBJECTS >END<      ||
#   ====================================
