using HerbstSpringer;

function pc(arg)
    push!(ARGS, arg)
    precompile(HerbstSpringer.springer, (Missing,))
    pop!(ARGS)
end

pc("help")
pc("-h")
pc("--help")
pc("-v")
pc("--version")
