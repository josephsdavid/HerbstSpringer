using PackageCompiler

PackageCompiler.create_app("..", "application"; force = true,
    executables = [
        "springer next" => "next",
        "springer prev" => "prev",
        "springer watch" => "watch",
    ]
)
