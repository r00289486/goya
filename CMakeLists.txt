cmake_minimum_required(VERSION 3.9)
project(goya VERSION 0.1 LANGUAGES C CXX)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED OFF)
set(CMAKE_C_EXTENSIONS OFF)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include_directories(
  "${PROJECT_SOURCE_DIR}/src"
)

add_executable(fs_client "")
target_sources(fs_client
  PRIVATE 
    "${PROJECT_SOURCE_DIR}/src/client/fs_client.cc"
)

add_library(goya "")
target_sources(goya
  PRIVATE
    "${PROJECT_SOURCE_DIR}/src/sdk/file_client.h"
    "${PROJECT_SOURCE_DIR}/src/sdk/file_client_impl.h"
    "${PROJECT_SOURCE_DIR}/src/sdk/file_client_impl.cc"
)

target_link_libraries(fs_client goya)

