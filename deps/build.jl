using PackageCompiler

PackageCompiler.create_app(
    "..",
    "application";
    force = true,
    executables = ["springer" => "springer"],
    incremental = false,
    precompile_execution_file="precompile.jl"
)
