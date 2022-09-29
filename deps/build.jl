using PackageCompiler

PackageCompiler.create_app(
    "..",
    "application";
    force = true,
    executables = ["springer" => "springer"],
    incremental = true,
    precompile_execution_file = "precompile.jl",
)
