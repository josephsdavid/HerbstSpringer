mutable struct Jumplist
    items::Vector{String}
    current_index::Int64
    size::Int64
    Jumplist() = new([current_win()], 1, 32)
    Jumplist(items, current_index) = new(items, current_index, 32)
    Jumplist(items, current_index, size) = new(items, current_index, size)
end


function traverse!(j::Jumplist, forward::Bool)
    if forward
        j.current_index = min(j.current_index + 1, length(j.items))
    else
        j.current_index = max(j.current_index - 1, 1)
    end
    return j
end

go_next!(j::Jumplist) = traverse!(j, true)
go_prev!(j::Jumplist) = traverse!(j, false)


(j::Jumplist)() = @inbounds j.items[j.current_index]
push!(j::Jumplist, items...) = push!(j.items, items...)

for f in (:first, :last)
    @eval begin
        $(f)(j::Jumplist) = $(f)(j.items)
    end
end

function update!(j::Jumplist)
    winid = current_win()
    isempty(winid) && return j
    if length(j.items) >= j.size
        popfirst!(j.items)
    end
    push!(j, winid)
    traverse!(j, true)
    j.items = reverse(unique(reverse(j.items)))
    j.current_index = findfirst((x) -> x == winid, j.items)
    return j
end


jumpto(winid) = hc(`jumpto`, winid)
function jumpto(j::Jumplist)
    (; items, current_index, size) = j
    run(jumpto(j()))
    j.items = items
    j.current_index = current_index
    j.size = size
    return j
end
