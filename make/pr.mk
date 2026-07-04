PR_TYPE := $(word 2,$(MAKECMDGOALS))
PR_ARG := $(word 3,$(MAKECMDGOALS))
PR_TYPES := feature bug task release

ifeq ($(firstword $(MAKECMDGOALS)),pr)
ifneq ($(words $(MAKECMDGOALS)),1)
$(foreach arg,$(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS)),$(eval $(arg):;@:))
endif
endif

.PHONY: pr
pr:
	@if [ -z "$(PR_TYPE)" ] || [ -z "$(PR_ARG)" ]; then \
		echo "Usage: make pr <feature|bug|task> <issue-number>"; \
		echo "   or: make pr release <version>"; \
		exit 1; \
	fi
	@if ! printf '%s\n' $(PR_TYPES) | grep -Fxq "$(PR_TYPE)"; then \
		echo "Unsupported PR type: $(PR_TYPE)"; \
		echo "Supported types: $(PR_TYPES)"; \
		exit 1; \
	fi
	@./scripts/pr/create.sh "$(PR_TYPE)" "$(PR_ARG)"