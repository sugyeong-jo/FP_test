```
using Pkg
import Juniper

import JuMP
using JuMP: @variable, @constraint, @objective, Model, optimizer_with_attributes, read_from_file,set_optimizer,all_variables,all_constraints,VariableRef,optimize!
using JSON
using LinearAlgebra
using Random
using Distributed
using Statistics

using MathOptInterface
const MOI = MathOptInterface
const MOIU = MOI.Utilities

# functions
const SVF = MOI.SingleVariable
const SAF = MOI.ScalarAffineFunction{Float64}
const SQF = MOI.ScalarQuadraticFunction{Float64}
const VECTOR = MOI.VectorOfVariables

################
using Ipopt
using Cbc

using Base
```
using JuMP, Cbc, Juniper, Ipopt,Random
cd("/HDD/Workspace/CLT/FP/data")
#cd("/HDD/Workspace/CLT/mps/data")
pwd()
println("============================flag! read======================================")

m = read_from_file("mzzv42z.mps")
println("==========================flag! optimizer ======================================")
nl_solver= optimizer_with_attributes(Ipopt.Optimizer, "print_level" => 0)
mip_solver = optimizer_with_attributes(Cbc.Optimizer, "logLevel" => 0 , "seconds" => 100, "feasibilityPump" => "on","maxSolutions" => 2)
optimizer = optimizer_with_attributes(Juniper.Optimizer, "nl_solver"=>nl_solver, "mip_solver"=>mip_solver,"feasibility_pump"=>true ,
    "solution_limit"=>10 ,"time_limit"=>300,
"feasibility_pump_tolerance_counter"=>100)
println("========================flag! set optimize======================================")
set_optimizer(m, optimizer)
println("========================flag! Juniper_result!======================================")
#Juniper_result!(m)
#println("==============flag! optimize!======================================")
optimize!(m)
println("=======================7=====================")
#include("/HDD/Workspace/CLT/FP/sjFP/src/fpump.jl")
#fpump(model,Juniper.JuniperProblem
