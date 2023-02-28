include("../fileSystem/read_write.jl")
include("../dsp/processors/__init__.jl")
using Plots
using LinearAlgebra
using Statistics

@inline function denoiseWave!(denoiseWave, wave, level, i)
    mat = haar_mat(level)
    cds = zeros((length(wave[:,i]), 2^(level+1)))
    sub_seq = Array{Float64}(undef, 2^(level+1))


    haar_swt!(wave[:,i], level, cds, mat, sub_seq)

    threshold = zeros(2^(level+1))
    cut_wave!(threshold, cds, length(cds[:,1]))

    haar_iswt!(denoiseWave, cds, mat, i)

end

@inline function applyDenoise(wave, level)
    denoiseWave = zeros((length(wave[:,1]), length(wave[1,:])))
    for i in 1:length(wave[1,:])
        denoiseWave!(denoiseWave, wave, level, i)

    end

    return denoiseWave
end


data = load_data("/home/jlb1694/data/raw/Run11444.lh5", "Det1724/waveform/values")
wave = convert(Array{Float64}, data[:,1:10000])


level = 6
@time denoiseWave = applyDenoise(wave, level)
#denoiseWave!(denoiseWave, wave, level)


plot(wave[:,8])
plot!(denoiseWave[:,8])
gui()