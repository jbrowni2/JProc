#=
    Applying a Brick wall filter to the cds given by a standing wavelet Transform.
=#
using Statistics


@inline function cut_wave!(threshold, cds, len)
    median_values = mapslices(median, cds, dims=1)
    absol = abs.(cds .- median_values)
    threshold = 1.2*(mapslices(median, absol, dims=1)/0.675 * sqrt(2*log(length(cds[:,1]))))


    for i in 2:length(cds[1,:])
        cds[abs.(cds[:,i]) .< threshold[i], i] .= 0.0
    end


end