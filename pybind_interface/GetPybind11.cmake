include(FetchContent)

set(MIN_PYBIND_VERSION "2.10.1")
FetchContent_Declare(
  pybind11
  GIT_REPOSITORY https://github.com/pybind/pybind11
  GIT_TAG "v${MIN_PYBIND_VERSION}"
)
FetchContent_GetProperties(pybind11)

# Attempt to find pybind11 on the system
find_package(pybind11 "${MIN_PYBIND_VERSION}" CONFIG)

# Print the result of find_package
message(STATUS "pybind11_FOUND: ${pybind11_FOUND}")
message(STATUS "pybind11_VERSION: ${pybind11_VERSION}")
message(STATUS "pybind11_INCLUDE_DIRS: ${pybind11_INCLUDE_DIRS}")

if((NOT pybind11_FOUND) AND (NOT pybind11_POPULATED))
  # If pybind11 is not found, fetch and add it
  FetchContent_Populate(pybind11)
  add_subdirectory(${pybind11_SOURCE_DIR} ${pybind11_BINARY_DIR})
endif()

# If pybind11 was fetched, print its source and binary directories
message(STATUS "pybind11_SOURCE_DIR: ${pybind11_SOURCE_DIR}")
message(STATUS "pybind11_BINARY_DIR: ${pybind11_BINARY_DIR}")
