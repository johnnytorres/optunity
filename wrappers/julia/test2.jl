using Base.Test

include("optunity.jl")

function testit_dict(d::Dict)
	-(d[:x]-1)^2 - (d[:y]-2)^2 - (d[:z]+3)^4
end

result = maximize(testit_dict, num_evals=10000, solver_name="grid search", x=[-5,5], y=[-5,5], z=[-5,5])

@test_approx_eq_eps result[1]["x"]  1.0 .2
@test_approx_eq_eps result[1]["y"]  2.0 .2
@test_approx_eq_eps result[1]["z"] -3.0 .2

result = maximize(testit_dict, num_evals=10000, x=[-5,5], y=[-5,5], z=[-5,5])

@test_approx_eq_eps result[1]["x"] 1.0 .2
@test_approx_eq_eps result[1]["y"] 2.0 .2
@test_approx_eq_eps result[1]["z"] -3.0 .2