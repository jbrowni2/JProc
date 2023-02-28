#=
    This processor grabs the haar matrix of a desired level.
    Apply this matrix to the wavelet_denoise processor.
=#

function haar_mat(level::Int)
    s = sqrt(2)/2
    mat = Array([1.0 1.0; 1.0 -1.0])*s
    for n in 1:level
        A = kron(mat, [1.0;1.0])
        B = kron(Matrix(1.0I, 2^n, 2^n), [1.0; -1.0])
        mat = hcat(A,B)*s
    end

    return mat
end