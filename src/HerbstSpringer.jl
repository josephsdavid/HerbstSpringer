module HerbstSpringer

import Base
import Base: push!, first, last
using Comonicon

include("backend.jl")
export hc, get_output, current_win, dialoglistener

include("Jumplist.jl")
export Jumplist, jumpto, traverse, update

end # module herbstluftwm_jumplist
