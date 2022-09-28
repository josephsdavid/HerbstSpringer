####
#### command manipulation
####

_joinexp(x) = `$(x)`
_joinexp(x, y) = `$(x) $(y)`
_joinexp(args...) = foldl(_joinexp, args)


function get_output(c::Cmd)
    out = Pipe()
    err = Pipe()

    run(pipeline(ignorestatus(c); stdout=out, stderr=err))
    close(out.in)
    close(err.in)

    return map((out, err)) do output
        return String(fetch(@async readchomp((output))))
    end

end

####
#### herbstclient stuff
####
hc(args...) = _joinexp(`herbstclient`, args...)
current_win() = get_output(hc(`attr clients.focus.winid`))[1]
idlehook() = get_output(hc(`-c 1 --wait`))[1]

####
#### the big event listener
####

open_channel(bufsize=32) = Channel(bufsize)


function dialoglistener(;inchannel = open_channel(), outchannel = open_channel())
    cprint("Starting herbstluftwm daemon\n\n", :green)
    @async while inchannel.state == :open
        put!(inchannel, idlehook())
    end

    j = Jumplist()
    just_jumped = false

    cprint("Ready!\n\n", :green)
    while inchannel.state == :open
        hook = take!(inchannel)
        @show hook
        try
            if occursin("focus_changed", hook)
                if !just_jumped
                    update!(j)
                    put!(outchannel, j())
                else
                    just_jumped = false
                end
            elseif occursin("jump_prev", hook)
                go_prev!(j)
                jumpto(j)
                just_jumped = true
            elseif occursin("jump_next", hook)
                go_next!(j)
                jumpto(j)
                just_jumped = true
            end
        catch
            continue
        end
    end

    return inchannel
end
