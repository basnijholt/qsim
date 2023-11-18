# Execute python command to get pybind11 includes
execute_process(
    COMMAND python3 -m pybind11 --includes
    OUTPUT_VARIABLE PYBIND11_INCLUDES
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

# Split the output into a list
string(REPLACE " " ";" PYBIND11_INCLUDE_LIST ${PYBIND11_INCLUDES})

# Remove the -I prefix from each path
list(TRANSFORM PYBIND11_INCLUDE_LIST REPLACE "^-I" "")

# Include the directories
foreach(INCLUDE_DIR ${PYBIND11_INCLUDE_LIST})
    include_directories(${INCLUDE_DIR})
endforeach()
