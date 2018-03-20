.PHONY: all
all: help

.PHONY: build ## Build image
build:
	docker build . -t corpus-embedder

.PHONY: pull ## Pull image
pull:
	docker pull chck/corpus-embedder

.PHONY: run ## Run embedder
run:
	echo 'Run embedder!!'
	docker run -it --rm -v /tmp/embedder:/tmp/embedder corpus-embedder bash
	#$(eval CNAME := $(shell docker run -d corpus-embedder))
	#echo $(CNAME)
  #$(eval x := $(shell docker cp $(CNAME):/tmp/jawiki_neologd.bin .))
  #$(eval x := $(shell docker cp $(CNAME):/tmp/jawiki_neologd.bin .))
  #$(eval x := $(shell docker stop $(CNAME)))
  #$(eval x := $(shell docker rm $(CNAME)))

.PHONY: help ## View help
help:
	@grep -E '^.PHONY: [a-zA-Z_-]+.*?## .*$$' $(MAKEFILE_LIST) | sed 's/^.PHONY: //g' | awk 'BEGIN {FS = "## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
