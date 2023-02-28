#=
    This very basic function applies the inverse standing wavelet Transform
=#



@inline function haar_iswt!(denoiseWave, cds, mat, i)
    denoiseWave[:,i] = cds * mat[1,:]
end