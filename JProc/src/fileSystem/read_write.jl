using HDF5

function load_data(file, group)
    fileObj = h5open(file, "r")

    data = read(fileObj, group)

    return data
end