INCLUDE(cotire)
MACRO(COTIRE_VEYON TARGET_NAME)
get_target_property(_targetType ${TARGET_NAME} TYPE)
if(NOT VEYON_BUILD_ANDROID OR NOT _targetType STREQUAL "EXECUTABLE")
SET_PROPERTY(TARGET ${TARGET_NAME} PROPERTY CXX_STANDARD 14)
SET_PROPERTY(TARGET ${TARGET_NAME} PROPERTY CXX_STANDARD_REQUIRED ON)
SET_TARGET_PROPERTIES(${TARGET_NAME} PROPERTIES COTIRE_CXX_PREFIX_HEADER_INIT "${PROJECT_SOURCE_DIR}/core/include/Cotire.h")
cotire(${TARGET_NAME})
endif()
ENDMACRO(COTIRE_VEYON)
