struct Jumplist
    items::Vector{String}
    current_index::Int64
    size::Int64
    Jumplist() = new([current_win()], 1, 32)
    Jumplist(items, current_index) = new(items, current_index, 32)
    Jumplist(items, current_index, size) = new(items, current_index, size)
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

for f in (:first, :last)
    @eval begin
        $(f)(j::Jumplist) = $(f)(j.items)
    end
end


function update(j::Jumplist)
    winid = current_win()
    isempty(winid) && return j
    (; items) = j
    if length(items) == j.size
        popfirst!(items)
    end
    if winid != last(j)
        push!(items, winid)
    end
    items = reverse(unique(reverse(items)))
    return Jumplist(items, length(items))
end


jumpto(winid) = hc(`jumpto`, winid)

jumpto(j::Jumplist) = jumpto(j())


