precompile(Tuple{typeof(HerbstSpringer.include),String})
precompile(Tuple{typeof(Base.sprint),Function,Symbol})
precompile(Tuple{typeof(Base.show_unquoted),Base.GenericIOBuffer{Array{UInt8,1}},Symbol})
precompile(Tuple{typeof(HerbstSpringer.open_channel)})
precompile(Tuple{typeof(Base.expand_ccallable),Nothing,Expr})
precompile(Tuple{typeof(Base.getindex),Array{Any,1},Base.UnitRange{Int64}})
precompile(
    Tuple{Type{Base.Generator{I,F} where {F} where I},Base.var"#374#375",Array{Any,1}},
)
precompile(
    Tuple{
        typeof(Base.collect_similar),
        Array{Any,1},
        Base.Generator{Array{Any,1},Base.var"#374#375"},
    },
)
precompile(Tuple{Type{Base.Generator{I,F} where {F} where I},typeof(Base.esc),Array{Any,1}})
precompile(
    Tuple{
        typeof(Base.collect_similar),
        Array{Any,1},
        Base.Generator{Array{Any,1},typeof(Base.esc)},
    },
)
precompile(Tuple{typeof(Base._ccallable),Type,Type})
precompile(
    Tuple{Type{NamedTuple{(:foreground, :negative),T} where T<:Tuple},Tuple{Symbol,Bool}},
)
precompile(
    Tuple{
        typeof(Base.haskey),
        NamedTuple{(:foreground, :negative),Tuple{Symbol,Bool}},
        Symbol,
    },
)
precompile(Tuple{Type{Crayons.ANSIStyle},Bool})
precompile(Tuple{Type{NamedTuple{(:reset,),T} where T<:Tuple},Tuple{Bool}})
precompile(
    Tuple{Core.var"#Type##kw",NamedTuple{(:reset,),Tuple{Bool}},Type{Crayons.Crayon}},
)
precompile(Tuple{Type{NamedTuple{(:foreground,),T} where T<:Tuple},Tuple{Symbol}})
precompile(Tuple{typeof(Base.haskey),NamedTuple{(:foreground,),Tuple{Symbol}},Symbol})
precompile(
    Tuple{Type{NamedTuple{(:foreground, :bold),T} where T<:Tuple},Tuple{Symbol,Bool}},
)
precompile(
    Tuple{typeof(Base.haskey),NamedTuple{(:foreground, :bold),Tuple{Symbol,Bool}},Symbol},
)
precompile(
    Tuple{Type{NamedTuple{(:foreground, :underline),T} where T<:Tuple},Tuple{Symbol,Bool}},
)
precompile(
    Tuple{
        typeof(Base.haskey),
        NamedTuple{(:foreground, :underline),Tuple{Symbol,Bool}},
        Symbol,
    },
)
precompile(Tuple{typeof(Base.:(!=)),UInt32,UInt8})
precompile(Tuple{Type{Base.BottomRF{typeof(HerbstSpringer._joinexp)}},Function})
precompile(Tuple{typeof(HerbstSpringer.springer)})
precompile(Tuple{typeof(Base.setup_stdio),Base.Pipe,Bool})
precompile(Tuple{typeof(Base.indexed_iterate),Tuple{Base.PipeEndpoint,Bool},Int64})
precompile(Tuple{typeof(Base.indexed_iterate),Tuple{Base.PipeEndpoint,Bool},Int64,Int64})
precompile(
    Tuple{
        typeof(Base.setindex!),
        Array{Union{Base.Libc.RawFD,IO},1},
        Base.PipeEndpoint,
        Int64,
    },
)
precompile(Tuple{typeof(Base.rawhandle),Base.PipeEndpoint})
precompile(Tuple{HerbstSpringer.var"#6#7"{Base.Channel{Any}}})
precompile(Tuple{HerbstSpringer.var"#2#4"{Base.Pipe}})
precompile(Tuple{Type{String},Base.SubString{String}})
