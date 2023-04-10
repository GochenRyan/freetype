target("libFreeType")
    add_includedirs(
        "./include/"
    )

    on_build("windows", function(target)
        if (is_mode("debug"))
        then
            os.run("cmake -B build -D CMAKE_BUILD_TYPE=Debug CMAKE_CXX_FLAGS=\"/MT\"")
            os.run("cmake --build build")
        else
            os.run("cmake -B build -D CMAKE_BUILD_TYPE=Release CMAKE_CXX_FLAGS=\"/MT\"")
            os.run("cmake --build build")
        end
    end)

    after_build("windows", function(target)
        os.cp("build/Debug/*.lib", "$(projectdir)/lib/")
    end)

    on_clean("windows", function(target)
        if os.exists("$(buildir)") then
            os.rm("$(buildir)/")
        end
    end)