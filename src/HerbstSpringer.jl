module HerbstSpringer

using Comonicon
import Base

export current_win, Jumplist, jumpto, traverse, hc


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
    Jumplist() = new(String[], 1)
    Jumplist(items, current_index) = new(items, current_index)
end

function traverse(j::Jumplist, forward::Bool)
    (j.current_index > 0 && j.current_index <= length(j.items)) || return j
    current_index = j.current_index + (forward ? 1 : -1)
    return Jumplist(j.items, current_index)
end

(j::Jumplist)() = @inbounds j.items[j.current_index]
Base.push!(j::Jumplist, items...) = push!(j.items, items...)

for f in (:first, :last)
    @eval begin
        Base.$(f)(j::Jumplist) = $(f)(j.items)
    end
end

function update!(j::Jumplist)
    winid = current_win()
    if winid != last(j)
        push!(j, winid)
    end
end




jumpto(winid) = hc(`jumpto`, winid)

function listener()
    process = hc(`--idle`)
end



end # module herbstluftwm_jumplist
