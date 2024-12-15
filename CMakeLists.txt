cmake_minimum_required(VERSION 3.15)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

project(
  topgg
  VERSION 1.0.0
  LANGUAGES CXX
  HOMEPAGE_URL "https://docs.top.gg/docs"
  DESCRIPTION "The official C++ wrapper for the Top.gg API."
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

find_package(DPP REQUIRED)
include(FetchContent)
FetchContent_Declare(json
  URL https://github.com/nlohmann/json/releases/download/v3.11.3/json.tar.xz
)
FetchContent_MakeAvailable(json)

set(TOPGG_SOURCES
  src/client.cpp
  src/webhook.cpp
  src/models.cpp
  src/result.cpp
)

add_library(topgg STATIC ${TOPGG_SOURCES})

target_compile_definitions(topgg PUBLIC TOPGG_STATIC_DEFINE)
target_include_directories(topgg PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include>
)

target_link_libraries(topgg PUBLIC DPP::DPP nlohmann_json::nlohmann_json)

enable_testing()
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/refs/tags/v1.15.2.zip
)
FetchContent_MakeAvailable(googletest)

add_executable(topgg_tests
  tests/client_test.cpp
  tests/webhook_test.cpp
  tests/models_test.cpp
)

target_link_libraries(topgg_tests PRIVATE
  topgg
  GTest::gtest_main
  GTest::gmock
)

target_include_directories(topgg_tests PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}/include
)

add_test(NAME topgg_tests COMMAND topgg_tests)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)