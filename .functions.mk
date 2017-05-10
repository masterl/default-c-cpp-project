#   ==========================================
#  ||    HELPER FUNCTIONS AND DEFINITIONS    ||
#   ==========================================
#

OBJDIR := objs

empty =
tab = $(empty)$(shell printf '\t')$(empty)

define execute-command
$(tab)$(1)

endef

define get_folder_source_files_list
$(shell find $1 -maxdepth 1 -type f | grep -E ".c(pp)?$$")
endef

define get_directory_tree
$(shell find $1 -type d)
endef

define get_directories_trees_list
$(foreach dir,$1,$(call get_directory_tree,$(dir)))
endef

define remove_objs_folders
$(filter-out %/objs,$1)
endef

define get_processed_directories_trees_list
$(call remove_objs_folders,$(call get_directories_trees_list,$1))
endef

define get_objects_directories
$(addsuffix /$(OBJDIR),$1)
endef

define convert_source_to_object
$(addprefix $(dir $1)$(OBJDIR)/,$(addsuffix .o,$(notdir $1)))
endef

define get_objects_from_sources_list
$(foreach source,$1,$(call convert_source_to_object,$(source)))
endef

define get_source_from_object
$(subst .o,,$(subst $(OBJDIR)/,,$1))
endef

define get_object_rule_from_source
$(patsubst \,,$(shell $(CC) -MM $(ALLCOMPFLAGS) $1))
endef

define get_prerequisites_from_rule
$(patsubst %:,,$1)
endef

define get_compiler
$(if $(patsubst %.c,,$1),$(CXX),$(CC))
endef

define get_cpp_source_count
$(shell echo $(ALLSRCFILES) | tr "[:blank:]" "\n" | grep -v "[.]c$$" | wc -l)
endef

define is_cpp_source
$(subst 0,,$(call get_cpp_source_count))
endef

define get_main_compiler
$(if $(call is_cpp_source),$(CXX),$(CC))
endef
