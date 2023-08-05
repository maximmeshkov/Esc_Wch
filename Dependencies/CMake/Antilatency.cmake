set(ANTILATENCY_CMAKE_DIR ${CMAKE_CURRENT_LIST_DIR})
list(APPEND CMAKE_MODULE_PATH "${ANTILATENCY_CMAKE_DIR}")


set(PROJECT_BINARY_DEPENDENCIES_DIR "${CMAKE_CURRENT_LIST_DIR}/../../BinaryDependencies")

function(project_getBinaryDependencySubdir resultVariableName)
    if(MSVC)
        set(CMAKE_SYSTEM_PROCESSOR ${MSVC_CXX_ARCHITECTURE_ID})
    endif()

    if("${CMAKE_SYSTEM_NAME}" STREQUAL "Windows" )
        if((${CMAKE_SYSTEM_PROCESSOR} STREQUAL "AMD64") OR (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "x64") OR (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "X64"))
            set(${resultVariableName} "WindowsDesktop/x64" PARENT_SCOPE)
        elseif(${CMAKE_SYSTEM_PROCESSOR} STREQUAL "X86" OR ${CMAKE_SYSTEM_PROCESSOR} STREQUAL "x86")
            set(${resultVariableName} "WindowsDesktop/x86" PARENT_SCOPE)
        else()
            message(FATAL_ERROR "Unknown processor architecture ${CMAKE_SYSTEM_PROCESSOR} for Windows target")
        endif()
    else()
        message(FATAL_ERROR "Unknown target system ${CMAKE_SYSTEM_NAME}")
    endif()
endfunction(project_getBinaryDependencySubdir)




function(filesystem_getSubdirectories dir resultVarName)
  FILE(GLOB children RELATIVE ${dir} ${dir}/*)
  SET(dirlist "")
  FOREACH(child ${children})
    IF(IS_DIRECTORY ${dir}/${child})
      LIST(APPEND dirlist ${child})
    ENDIF()
  ENDFOREACH()
  SET(${resultVarName} ${dirlist} PARENT_SCOPE)
endfunction(filesystem_getSubdirectories)



function(project_getBinaryDependenciesDirectories resultPathsListName)
    project_getBinaryDependencySubdir("subdir")
    filesystem_getSubdirectories(${PROJECT_BINARY_DEPENDENCIES_DIR} binaryDepsNames)
    foreach(depName ${binaryDepsNames})
        set(depFullDir "${PROJECT_BINARY_DEPENDENCIES_DIR}/${depName}/${subdir}")
        if(IS_DIRECTORY ${depFullDir})
            list(APPEND result "${depFullDir}")
            #message("GOOD binary dependency: ${depFullDir}")
        else()
            message("BAD binary dependency: ${depFullDir}")
        endif()
    endforeach()
    set(${resultPathsListName} ${result} PARENT_SCOPE)
endfunction(project_getBinaryDependenciesDirectories)




function(project_deployBinaryDependencies exeTargetName)
    project_getBinaryDependenciesDirectories("depsFullPaths")

    foreach(depPath ${depsFullPaths})
        file(GLOB depFiles LIST_DIRECTORIES false "${depPath}/*.*")
        list(APPEND allDepFiles ${depFiles})
    endforeach()

    add_custom_command(TARGET ${exeTargetName} POST_BUILD
        COMMAND_EXPAND_LISTS
        COMMAND ${CMAKE_COMMAND} -E copy
                ${allDepFiles}
                ${CMAKE_CURRENT_BINARY_DIR})

endfunction(project_deployBinaryDependencies)



macro(linkStaticRuntimeLibraries)
    if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        message(ERROR "Not implemented")
    elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        include(Gcc/static-libstdc++)
        include(Gcc/static-libgcc)
    elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
        message(ERROR "Not implemented")
    elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        if(CMAKE_SYSTEM_NAME MATCHES "WindowsStore")

        else()
            set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
        endif()
    else()
        message(ERROR "Unknown compiler")
    endif()

endmacro(linkStaticRuntimeLibraries)


macro(defaultProjectConfig)
    #Set default language standards
    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_C_STANDARD 11)

    #Set default runtime libraries linkage
    linkStaticRuntimeLibraries()

    if(CMAKE_SYSTEM_NAME MATCHES "WindowsStore")
        add_compile_options(/ZW /EHsc)
    endif()
endmacro(defaultProjectConfig)


defaultProjectConfig()