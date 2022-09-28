JULIA_FLAGS = --project=. --history-file=no --startup-file=no
INSTALL_PATH = ~/bin

compile:
	julia $(JULIA_FLAGS) -e 'using Pkg; Pkg.build(; verbose=true)'
install: deps/application/
	cp -r $? $(INSTALL_PATH)/springer_bin
	cp deps/run.sh $(INSTALL_PATH)/springer
	chmod +x $(INSTALL_PATH)/springer
