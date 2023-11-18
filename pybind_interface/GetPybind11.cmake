include(FetchContent)

set(MIN_PYBIND_VERSION "2.10.1")
FetchContent_Declare(
  pybind11
  GIT_REPOSITORY https://github.com/pybind/pybind11
  GIT_TAG "v${MIN_PYBIND_VERSION}"
)
FetchContent_GetProperties(pybind11)
find_package(pybind11 "${MIN_PYBIND_VERSION}" CONFIG)
if((NOT pybind11_FOUND) AND (NOT pybind11_POPULATED)) # check first on system path, then attempt git fetch
  FetchContent_Populate(pybind11)
  add_subdirectory(${pybind11_SOURCE_DIR} ${pybind11_BINARY_DIR})
endif()

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
