module HerbstSpringer

import Base: push!, first, last

include("backend.jl")
export hc, get_output, current_win, dialoglistener

include("Jumplist.jl")
export Jumplist, jumpto, traverse!, update!


const SPRINGER_VERSION = v"0.1.0"
const inchannel = open_channel()
const outchannel = open_channel()
const history = String[]

function watch()::Cint
    dialoglistener()
    return 1
end


function cprint(message, color)
    return printstyled(message; color)
end

function version()
    cprint("\tspringer", :blue)
    cprint(" v$(SPRINGER_VERSION)\n", :normal)
end

function usage()
    version()
    println("\nUsage:\n")
    cprint("\tspringer <command>", :blue)
    cprint("\nRun a daemon which listens for hooks `", :normal)
    cprint("jump_prev", :red)
    cprint("` or `", :normal)
    cprint("jump_next", :green)
    cprint("`.\n", :normal)
    cprint("Run `", :normal)
    cprint("herbstcleint emit_hook HOOK", :blue)
    cprint("` to traverse the jumplist.", :normal)
    cprint("\n\nCommands:\n", :normal)
    cprint("\n\twatch", :blue)
    cprint(" - start the springer daemon\n", :normal)
    cprint("\n\thelp, -h, --help", :blue)
    cprint(" - print this message\n", :normal)
end


function springer()::Cint
    if length(ARGS) == 0
        printstyled("ERROR: no arguments supplied!\n\n"; color = :red)
        usage()
        return 0
    end
    if length(ARGS) > 1
        printstyled("ERROR: too many arguments supplied!\n\n"; color = :red)
        usage()
        return 0
    end
    arg = only(ARGS)
    if "--help" == arg || "-h" == arg
        usage()
        return 1
    elseif "--version" == arg || "-v" == arg
        version()
        return 1
    elseif arg == "watch"
        watch()
        return 1
    elseif arg == "help"
        usage()
        return 1
    else
        cprint("ERROR: unknown argument ", :red)
        cprint(arg, :normal)
        print("\n\n")
        usage()
        return 0
    end
    return 1
end

end # module herbstluftwm_jumplist
