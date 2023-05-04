# Plotting exercise
# add packages for fisrt invocation, then comment out
#import Pkg; Pkg.add("Plots"); Pkg.add("PlotlyJS")
using Plots
using PlotlysJS
plotlyjs()
# line plot
x_val = range(-10,10)
y = [3*x+50 for x in x_val]
p1 =Plots.plot(x_val,y,title="Basic Line Plots",label="affine",  xlabel = "x values", ylabel= "y values")
y2 = [x^2 for x in x_val]
plot!(p1,x_val,y2, label="square", lw = 3)

#scatter plot
y = [-2*x^3 for x in x_val]
p2 = Plots.plot(title ="Scatter Plot",xlabel ="x values", ylabel= "y values")
scatter!(x_val,y, label = "Cubic")
display(p2)

#Histogram
p3 = Plots.plot(title ="Histogram",xlabel ="x values", ylabel= "count")
histogram!(randn(1000), label = "Normal DIstribution")

#Bar plot
categories = ["a","b","c","d","e","f","g"]
count = [3,5,-4,2,5,-2,-3]
p4 = Plots.plot(label="Value")
bar!(categories,count,orientation=:horizontal)
xlabel!("x values")
ylabel!("count")
title!("Bar Plot")
display(p4)

#display all plots
Plots.plot(p1,p2,p3,p4, legend=false)