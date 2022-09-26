module HerbstSpringerTests

using HerbstSpringer
using ReTest

@testset "command manipulation" begin
    # test cases
    many_args = ("a", 1, [1, 2,3], :delight )
    one_arg = (:p,)
    two_args = (:p, "q")

    # tests
    @testset "`_joinexp`" begin
        @test _joinexp(many_args...) == `a 1 1 2 3 delight`
        @test _joinexp(one_arg...) == `p`
        @test _joinexp(two_args...) == `p q`
    end
    @testset "`hc`" begin
        @test hc(many_args...) == `herbstclient a 1 1 2 3 delight`
        @test hc(one_arg...) == `herbstclient p`
        @test hc(two_args...) == `herbstclient p q`
    end
end


end # module
