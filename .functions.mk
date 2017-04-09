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

define convert_source_to_dependency
$(addprefix $(dir $1)$(DEPDIR)/,$(patsubst %.cpp,%.d,$(notdir $1)))
endef

define get_dependencies_from_sources_list
$(foreach source,$1,$(call convert_source_to_dependency,$(source)))
endef

define get_dependencies_dependency_list
$(patsubst %.d,%$(DEPSUFFIX).d,$1)
endef

define convert_source_to_object
$(addprefix $(dir $1)$(OBJDIR)/,$(patsubst %.cpp,%.o,$(notdir $1)))
endef

define get_objects_from_sources_list
$(foreach source,$1,$(call convert_source_to_object,$(source)))
endef
