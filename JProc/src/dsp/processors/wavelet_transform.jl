#=
    This function takes in a sequence and performs a standing wavelet transform given a matrix.
    This matrix has to match the column based memory sequencing.
=#

function sub_seq_periodic(seq, level, mat, cds, i)
    m = i+2^(level+1)-length(seq)
    @inbounds arr1 = seq[i:end]
    @inbounds arr2 = seq[1:m-1]
    sub_seq = vcat(arr1, arr2)
    cds[i,:] = mat' * sub_seq
end


@inline function haar_swt!(seq::Array, level::Int, cds::Array, mat::Array, sub_seq::Array)
    for i in 1:length(seq)
            if i < length(seq) - 2^(level+1) + 1
                @views sub_seq = seq[i:i+2^(level+1)-1]
                cds[i,:] = mat' * sub_seq
            else
                sub_seq_periodic(seq, level, mat, cds, i)
            end
    end

end