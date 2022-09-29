using HerbstSpringer
using Crayons
for f in readdir("statements")
    include(joinpath("statements", f))
end
