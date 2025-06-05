SETUP_EXECUTABLE(must_bare_metal)

set(LINKER_SCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/linker.ld)

target_link_options(must_bare_metal PRIVATE -T ${LINKER_SCRIPT})
set_target_properties(must_bare_metal
    PROPERTIES LINK_DEPENDS ${LINKER_SCRIPT})
