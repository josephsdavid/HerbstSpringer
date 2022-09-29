module HerbstSpringer

import Base: push!, first, last

include("backend.jl")
export hc, get_output, current_win, dialoglistener

include("Jumplist.jl")
export Jumplist, jumpto, traverse!, update!

using Crayons

const SPRINGER_VERSION = v"0.1.0"
const inchannel = open_channel()
const outchannel = open_channel()
const history = String[]

function watch()::Cint
    dialoglistener()
    return 1
end


function version()
    print(
        Crayon(foreground = :blue),
        "\tspringer",
        Crayon(foreground = :default, bold = true),
        " v$(SPRINGER_VERSION)\n",
    )
end

function usage()
    # TODO: logging or jumplist storage, so it can be used in dmenu
    # for now you can just look at herbstclient --idle
    # !isdir("~/.local/share/herbstluftwm/") && mkdir()
    version()
    println("\nUsage:\n")
    print(
        Crayon(foreground = :blue, bold = true),
        "\tspringer <command>",
        Crayon(reset = true),
    )
    print("\nRun a daemon which listens for hooks `")
    print(Crayon(foreground = :red, underline = true), "jump_prev", Crayon(reset = true))
    print("` or `")
    print(Crayon(foreground = :green), "jump_next", Crayon(reset = true))
    print("`.\n")
    print("Run `")
    print(Crayon(foreground = :blue), "herbstcleint emit_hook HOOK", Crayon(reset = true))
    print("` to traverse the jumplist.")
    print("\n\nCommands:\n")
    print(Crayon(foreground = :blue), "\n\twatch", Crayon(reset = true))
    print(" - start the springer daemon\n")
    print(Crayon(foreground = :blue), "\n\thelp, -h, --help", Crayon(reset = true))
    print(" - print this message\n")
end

Base.@ccallable function julia_main()::Cint
    try
        springer()
    catch
        Base.invokelatest(Base.display_error, Base.catch_stack())
        return 1
    end
    return 0
end


function springer()::Cint
    Crayons.FORCE_COLOR[] = true
    if length(ARGS) == 0
        print(
            Crayon(foreground = :red, negative = true),
            "ERROR: no arguments supplied!",
            Crayon(reset = true),
        )
        print("\n\n")
        usage()
        return 0
    end
    arg = first(ARGS)
    if "--help" == arg || "-h" == arg
        usage()
        return 1
    elseif "--version" == arg || "-v" == arg || "version" == arg
        version()
        return 1
    elseif arg == "watch"
        watch()
        return 1
    elseif arg == "help"
        usage()
        return 1
    else
        print(Crayon(foreground = :red, negative = true), "ERROR: unknown argument ")
        print(arg, Crayon(reset = true))
        print("\n\n")
        usage()
        return 0
    end
    return 1
end

if abspath(PROGRAM_FILE) == @__FILE__
    springer()
end

end # module herbstluftwm_jumplist
