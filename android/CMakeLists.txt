cmake_minimum_required(VERSION 3.4.1)

add_definitions(-DHAVE_CONFIG_H)

add_library(zinnia_flutter
    SHARED
    ../ios/Classes/zinnia/character.cpp
    ../ios/Classes/zinnia/feature.cpp
    ../ios/Classes/zinnia/libzinnia.cpp
    ../ios/Classes/zinnia/param.cpp
    ../ios/Classes/zinnia/recognizer.cpp
    ../ios/Classes/zinnia/sexp.cpp
    ../ios/Classes/zinnia/svm.cpp
    ../ios/Classes/zinnia/trainer.cpp
)