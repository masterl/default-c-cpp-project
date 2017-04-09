#   ==========================
#  ||    HELPER FUNCTIONS    ||
#   ==========================
#

empty =
tab = $(empty)$(shell printf '\t')$(empty)

define execute-command
$(tab)$(1)

endef
