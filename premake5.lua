local PUBLIC_HDRS = {
    "zconf.h",
    "zlib.h",
}

do -- Copy public include headers
    if not os.isdir("include/zlib") then
        os.mkdir("include/zlib")
    end
    
    for _, name in next, PUBLIC_HDRS do
        os.copyfile(name, "include/zlib/" .. name)
    end
end

project "zlib"
    kind "StaticLib"
    language "C"

    defines {
        "HAVE_SYS_TYPES_H",
        "HAVE_STDINT_H",
        "HAVE_STDDEF_H",
        "HAVE_FSEEKO",
    }

    files(PUBLIC_HDRS)

    files {
        "crc32.h",
        "deflate.h",
        "gzguts.h",
        "inffast.h",
        "inffixed.h",
        "inflate.h",
        "inftrees.h",
        "trees.h",
        "zutil.h",

        "adler32.c",
        "compress.c",
        "crc32.c",
        "deflate.c",
        "gzclose.c",
        "gzlib.c",
        "gzread.c",
        "gzwrite.c",
        "inflate.c",
        "infback.c",
        "inftrees.c",
        "inffast.c",
        "trees.c",
        "uncompr.c",
        "zutil.c",
    }
    
    filter "toolset:msc"
        defines {
            "_CRT_SECURE_NO_DEPRECATE",
            "_CRT_NONSTDC_NO_DEPRECATE",
        }

    filter "system:linux"
        defines "Z_HAVE_UNISTD_H"

    filter "architecture:x64"
        defines "_LARGEFILE64_SOURCE=1"

	filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "on"
