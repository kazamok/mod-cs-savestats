cmake_minimum_required(VERSION 3.16)

set(MODULE_NAME "mod-cs-savestats")

# Add the source file to the build using the available macro
AC_ADD_SCRIPT("${CMAKE_CURRENT_LIST_DIR}/mod-cs-savestats.cpp")

message(STATUS "Building module mod-cs-savestats (using legacy AC_ADD_SCRIPT method)")