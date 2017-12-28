using PyCall
if VERSION >= v"0.7-"
    using DelimitedFiles
end

function loadcsv(inputcsv)
    contents = readdlm("LE1NAFEMS_MSH8_convergence.CSV", ',', Float64, '\n'; header = true)
    return contents
end

function coldata(inputcsv, theset)
    contents = loadcsv(inputcsv)
    return contents[1][:, theset]
end

inputcsv = "LE1NAFEMS_MSH8_convergence.CSV"


@pyimport matplotlib.pyplot as plt
plt.style[:use]("seaborn-whitegrid")
fig = plt.figure() 
ax = plt.axes()
x = coldata(inputcsv, 1)
y = coldata(inputcsv, 2)
ax[:loglog](x, abs.(y), color = "blue", marker = "x")
y = coldata(inputcsv, 3)
ax[:loglog](x, abs.(y), color = "red", marker = "o")
ax[:set_xlabel]("Number of elements")
ax[:set_ylabel]("Approximate error")
plt.show()