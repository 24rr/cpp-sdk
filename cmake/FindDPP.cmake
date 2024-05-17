if(WIN32 AND NOT EXISTS "${CMAKE_SOURCE_DIR}/deps/dpp.lib")
execute_process(COMMAND powershell "-NoLogo" "-NoProfile" "-File" ".\\install_dpp_msvc.ps1" WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
endif()

if(APPLE)
find_path(DPP_INCLUDE_DIR NAMES dpp/dpp.h HINTS "/opt/homebrew/include")
find_library(DPP_LIBRARIES NAMES dpp "libdpp.a" HINTS "/opt/homebrew/lib")
else()
find_path(DPP_INCLUDE_DIR NAMES dpp/dpp.h HINTS "${CMAKE_SOURCE_DIR}/include")
find_library(DPP_LIBRARIES NAMES dpp "libdpp.a" HINTS "${CMAKE_SOURCE_DIR}/deps")
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(DPP DEFAULT_MSG DPP_LIBRARIES DPP_INCLUDE_DIR)