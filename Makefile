JULIA_FLAGS = --project=. --history-file=no --startup-file=no

compile:
	julia  -e 'using Pkg; Pkg.build()'
