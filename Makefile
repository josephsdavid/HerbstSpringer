JULIA_FLAGS = --project=. --history-file=no --startup-file=no
INSTALL_PATH = ~/bin
RELEASE_PATH = release/


compile:
	julia $(JULIA_FLAGS) -e 'using Pkg; Pkg.build(; verbose=true)'
install: deps/application/
	cp -r $? $(INSTALL_PATH)/springer_bin
	cp deps/run.sh $(INSTALL_PATH)/springer
	chmod +x $(INSTALL_PATH)/springer
release: deps/application
	mkdir -p $(RELEASE_PATH)
	cp -r $? $(RELEASE_PATH)/springer_bin
	cp deps/run.sh $(RELEASE_PATH)/springer
	chmod +x $(RELEASE_PATH)/springer
	tar -cvf springer.tar /path/to/my/directory


