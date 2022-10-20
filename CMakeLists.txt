cmake_minimum_required(VERSION 3.0.0 FATAL_ERROR)
set(CMAKE_TOOLCHAIN_FILE "/vcpkg/scripts/buildsystems/vcpkg.cmake"
    CACHE STRING "Vcpkg toolchain file")
set(VCPKG_TARGET_TRIPLET "x64-mingw-static" CACHE STRING "" FORCE)

# [cmake]
include(cmake/utils.cmake)
# [cmake settings]
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_VERBOSE_MAKEFILE ON)

# [project settings]
project(cl-translator
    VERSION 0.0.1
    LANGUAGES CXX
    DESCRIPTION "a commandline application for translator"
    )

include_directories(${PROJECT_SOURCE_DIR})

set(CMAKE_BUILD_TYPE "Debug")

# [compiler settings]
set(CMAKE_CXX_FLAGS "-fPIC -Wno-builtin-macro-redefined")
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# [source file]
set(SRC_LIST
    src/log.cc
    )

# [dependencies]
find_package(OpenSSL REQUIRED)

# [library target]
add_library(app ${SRC_LIST})
force_refdefine_file_macro_for_sources(app)
target_link_libraries(app PRIVATE OpenSSL::SSL OpenSSL::Crypto)


# [executeable target]
add_executable(${PROJECT_NAME} src/main.cc)
target_link_libraries(${PROJECT_NAME} PRIVATE app)
force_refdefine_file_macro_for_sources(${PROJECT_NAME})

# [test targets]
add_unit_test(project app)
force_refdefine_file_macro_for_sources(test-project)

add_unit_test(sion app)
force_refdefine_file_macro_for_sources(test-sion)
