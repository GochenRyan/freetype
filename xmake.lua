target("libFreeType")
    add_includedirs(
        "$(projectdir)/Vendor/freetype/include/"
    )

    on_build("windows", function(target)
        os.cd("$(projectdir)/Vendor/freetype")
        if (is_mode("debug"))
        then
            os.run("cmake -B build -D FT_DISABLE_ZLIB=TRUE \
                                   -D FT_DISABLE_BZIP2=TRUE \
                                   -D FT_DISABLE_PNG=TRUE \
                                   -D FT_DISABLE_HARFBUZZ=TRUE \
                                   -D FT_DISABLE_BROTLI=TRUE \
                                   -D CMAKE_BUILD_TYPE=Debug CMAKE_CXX_FLAGS=\"/MT\"")
            os.run("cmake --build build")
        else
            os.run("cmake -B build -D FT_DISABLE_ZLIB=TRUE \
                                   -D FT_DISABLE_BZIP2=TRUE \
                                   -D FT_DISABLE_PNG=TRUE \
                                   -D FT_DISABLE_HARFBUZZ=TRUE \
                                   -D FT_DISABLE_BROTLI=TRUE \
                                   -D CMAKE_BUILD_TYPE=Release CMAKE_CXX_FLAGS=\"/MT\"")
            os.run("cmake --build build")
        end
        os.cd("$(projectdir)")
    end)

    after_build("windows", function(target)
        os.cp("$(projectdir)/Vendor/freetype/build/Debug/*.lib", "$(projectdir)/lib/")
        os.trymv("$(projectdir)/lib/freetyped.lib", "$(projectdir)/lib/libFreeType.lib")
        os.trymv("$(projectdir)/lib/freetype.lib", "$(projectdir)/lib/libFreeType.lib")

        os.cp("$(projectdir)/Vendor/freetype/build/Debug/*.pdb", "$(projectdir)/lib/")
        os.trymv("$(projectdir)/lib/freetyped.pdb", "$(projectdir)/lib/libFreeType.pdb")
        os.trymv("$(projectdir)/lib/freetype.pdb", "$(projectdir)/lib/libFreeType.pdb")
    end)

    on_clean("windows", function(target)
        if os.exists("$(buildir)") then
            os.rm("$(buildir)/")
        end
    end)
    