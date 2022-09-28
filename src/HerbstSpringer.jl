module HerbstSpringer

import Base
import Base: push!, first, last

include("backend.jl")
export hc, get_output, current_win, dialoglistener

include("Jumplist.jl")
export Jumplist, jumpto, traverse!, update!

const inchannel = open_channel()
const outchannel = open_channel()
const history = String[]

function next()::Cint
    get_output(hc(`emit_hook jump_next`))[1]
    return 1
end

function prev()::Cint
    get_output(hc(`emit_hook jump_prev`))[1]
    return 1
end

function watch()::Cint
    dialoglistener(;inchannel, outchannel)
    return 1
end



end # module herbstluftwm_jumplist
