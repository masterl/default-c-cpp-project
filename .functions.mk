#   ==========================================
#  ||    HELPER FUNCTIONS AND DEFINITIONS    ||
#   ==========================================
#

DEPDIR := deps
DEPSUFFIX := _dep
OBJDIR := objs

empty =
tab = $(empty)$(shell printf '\t')$(empty)

define execute-command
$(tab)$(1)

endef

define get_directory_tree
$(shell find $1 -type d)
endef

define get_directories_trees_list
$(foreach dir,$1,$(call get_directory_tree,$(dir)))
endef

define remove_deps_and_objs_folders
$(filter-out %/deps %/objs,$1)
endef

define get_processed_directories_trees_list
$(call remove_deps_and_objs_folders,$(call get_directories_trees_list,$1))
endef

define get_dependencies_directories
$(addsuffix /$(DEPDIR),$1)
endef

define get_objects_directories
$(addsuffix /$(OBJDIR),$1)
endef
