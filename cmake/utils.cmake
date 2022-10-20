function(force_refdefine_file_macro_for_sources targetname)
    get_target_property(source_files "${targetname}" SOURCES)
    foreach(sourcefile ${source_files})
        # Get source file's current list of compile definitions.
        get_property(defs SOURCE "${sourcefile}"
            PROPERTY COMPILE_DEFINITIONS)
        # Get the relative path of the source file in project directory
        get_filename_component(filepath "${sourcefile}" ABSOLUTE)
        string(REPLACE ${PROJECT_SOURCE_DIR}/ "" relpath ${filepath})
        list(APPEND defs "__FILE__=\"${relpath}\"")
        # Set the updated compile definitions on the source file
        set_property(
            SOURCE "${sourcefile}"
            PROPERTY COMPILE_DEFINITIONS ${defs}
            )
    endforeach()
endfunction()

function(add_unit_test test_name test_libraries)
  string(APPEND file_name ${test_name} ".cc")
  string(JOIN "/" file_path "tests" ${file_name})
  string(APPEND target_name "test-" ${test_name})
  add_executable(${target_name} ${file_path})
  target_link_libraries(${target_name} ${test_libraries})
  add_test(NAME ${target_name} COMMAND $<TARGET_FILE:${target_name}>)
endfunction()
