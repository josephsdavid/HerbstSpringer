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

function create_future!(c::Channel, f, args...; kwds...)
end

function dialoglistener()
    channel = open_channel()

    @async while channel.state == :open
        put!(channel, idlehook())
    end

    j = Jumplist()

    @async while channel.state == :open
        hook = take!(channel)
        if occursin("focus_changed", hook)
            j = update(j)
        elseif occursin("jump_prev", hook)
            j = go_backward(j)
            @show j
            run(jumpto(j))
        elseif occursin("jump_next", hook)
            j = go_forward(j)
            @show j
            run(jumpto(j))

        end
    end

    return channel
end
