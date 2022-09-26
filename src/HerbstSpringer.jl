module HerbstSpringer

using Comonicon
import Base
import Base:+, push!, first, last

export current_win, Jumplist, jumpto, traverse, hc, update


_joinexp(x) = `$(x)`
_joinexp(x, y) = `$(x) $(y)`
_joinexp(args...) = foldl(_joinexp, args)
hc(args...) = _joinexp(`herbstclient`, args...)

function get_stdout(c::Cmd)
    out = Pipe()
    run(pipeline(ignorestatus(c); stdout = out))
    close(out.in)
    return replace(String(readchomp(out)))
end

current_win() = get_stdout(hc(`attr clients.focus.winid`))

struct Jumplist
    items::Vector{String}
    current_index::Int64
    Jumplist() = new([current_win()], 1)
    Jumplist(items, current_index) = new(items, current_index)
end

function traverse(j::Jumplist, forward::Bool)
    (j.current_index > 0 && j.current_index < length(j.items)) || return j
    current_index = j.current_index + (forward ? 1 : -1)
    return Jumplist(j.items, current_index)
end

go_forward(j::Jumplist) = traverse(j, true)
go_backward(j::Jumplist) = traverse(j, false)


(j::Jumplist)() = @inbounds j.items[j.current_index]
push!(j::Jumplist, items...) = push!(j.items, items...)
+(j::Jumplist, a::Int64) = Jumplist(j.items, j.current_index + a)

for f in (:first, :last)
    @eval begin
        $(f)(j::Jumplist) = $(f)(j.items)
    end
end

function update(j::Jumplist)
    winid = current_win()
    (; items, current_index) = j
    if winid != last(j)
        push!(items, winid)
        current_index += 1
    end
    return Jumplist(items, current_index)
end

jumpto(winid) = hc(`jumpto`, winid)

jumpto(j::Jumplist) = jumpto(j())

function listener()
    process = hc(`--idle`)
end



end # module herbstluftwm_jumplist
