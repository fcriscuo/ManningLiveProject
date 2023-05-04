# Plotting exercise
# add packages for fisrt invocation, then comment out
#import Pkg; Pkg.add("Plots"); Pkg.add("PlotlyJS")
using Plots
using PlotlysJS
plotlyjs()

x_val = range(-10,10)
y = [3*x+50 for x in x_val]
plot!(x_val,y,title="Basic Line Plots", xlabel = "x values", ylabel= "y values")
