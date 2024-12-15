# FindDPP.cmake

# Find DPP library
find_library(DPP_LIBRARY
    NAMES dpp libdpp
    PATHS
        "${CMAKE_SOURCE_DIR}/deps"
        "${CMAKE_SOURCE_DIR}/deps/lib"
    NO_DEFAULT_PATH
)

# Find DPP headers
find_path(DPP_INCLUDE_DIR
    NAMES "dpp/dpp.h"
    PATHS
        "${CMAKE_SOURCE_DIR}/deps"
        "${CMAKE_SOURCE_DIR}/deps/include"
    PATH_SUFFIXES
        include
        dpp
    NO_DEFAULT_PATH
)

message(STATUS "Looking for DPP in: ${CMAKE_SOURCE_DIR}/deps")
message(STATUS "DPP Library: ${DPP_LIBRARY}")
message(STATUS "DPP Include: ${DPP_INCLUDE_DIR}")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(DPP
    REQUIRED_VARS
        DPP_LIBRARY
        DPP_INCLUDE_DIR
)

if(DPP_FOUND AND NOT TARGET DPP::DPP)
    add_library(DPP::DPP UNKNOWN IMPORTED)
    set_target_properties(DPP::DPP PROPERTIES
        IMPORTED_LOCATION "${DPP_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${DPP_INCLUDE_DIR}"
    )
endif()

set(DPP_LIBRARIES ${DPP_LIBRARY})
set(DPP_INCLUDE_DIRS ${DPP_INCLUDE_DIR})

mark_as_advanced(DPP_LIBRARY DPP_INCLUDE_DIR)