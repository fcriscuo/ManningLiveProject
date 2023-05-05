# Julia live project workflow 2-1" Plotting Past Data
using DataFrames
using CSV
using Plots
using Printf
plotlyjs()
# read CSV file data.csv
csv = CSV.File("./data/data.csv")
df = DataFrame(csv)
s = size(df)
@printf "datframe size = %d rows and %d columns.\n" s[1] s[2]
describe(df)
susc = df[!,"susceptible"]
infec = df[!,"infectious"]
rem = df[!,"removed"]

#plot the data
df_mat = Matrix(df)
col_names = permutedims(names(df))
p1 =plot(df_mat, label=col_names, legend=:topright)

# explore the data
@printf "Percent infectious at day 42: %.4f \n" df[42,"infectious"]*100.0
@printf "Percent susceptible at day 66: %.4f \n" df[66,"susceptible"]*100.0
@printf "Percent removed at day 66: %.4f \n" df[66,"removed"]*100.0
