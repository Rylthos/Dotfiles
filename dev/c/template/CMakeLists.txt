CMAKE_MINIMUM_REQUIRED(VERSION 3.20)

project({#PROJECT_NAME})

set (CMAKE_EXPORT_COMPILE_COMMANDS ON)

file (GLOB_RECURSE project_files CONFIGURE_DEPENDS "src/*.c")
add_executable(${PROJECT_NAME} ${project_files})
