pc(arg) = @show run(
    `julia --project=. --startup-file=no --trace-compile=$(arg)_precompile.jl src/HerbstSpringer.jl $(arg)`,
)
const args = [:version, "--version", "-v", "--help", :help, "-h", :watch]

for arg in args
    @show arg
    pc(arg)
end
