cmake_minimum_required(VERSION 3.22)
project(simplePlayground C)

set(CMAKE_C_STANDARD 99)

add_executable(simplePlayground main.c List_Operation.c List_Operation.h Input.c Input.h)
