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
        using HerbstSpringer: _joinexp
        @test _joinexp(many_args...) == `a 1 1 2 3 delight`
        @test _joinexp(one_arg...) == `p`
        @test _joinexp(two_args...) == `p q`
    end
    @testset "`hc`" begin
        @test hc(many_args...) == `herbstclient a 1 1 2 3 delight`
        @test hc(one_arg...) == `herbstclient p`
        @test hc(two_args...) == `herbstclient p q`
    end
    @testset "`get_output`" begin
        using HerbstSpringer: get_output
        hello = `echo hello`
        @test get_output(hello)[1] == "hello"
    end
    @testset "window operations" begin
        @test typeof(current_win()) == String
    end
    @testset "`Jumplist`" begin
        j = Jumplist()
        j2 = traverse(j, true)
        j3 = traverse(j, false)
        @test j() == j2() == j3() == first(j) == last(j)
        jup = update(j)
        @test jup() == j()
        push!(j2, "test")
        @test first(j2) != "test"
        @test last(j2) == "test"
        j2 += 1
        @test j2() == "test"
    end
    @testset "jumping" begin
        j = Jumplist()
        @test run(jumpto(current_win())).exitcode == 0
        @test run(jumpto(j)).exitcode == 0
    end
end


end # module
