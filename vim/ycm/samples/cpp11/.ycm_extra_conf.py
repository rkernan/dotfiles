def FlagsForFile(filename, **kwargs):
    flags = [
        "-std=c++11",
        "xc++",
        "-Wall",
        "-Wextra",
        "-Werror"
        "-pedantic",
        "-I",
        ".",
        "-isystem",
        "/usr/include",
        "-isystem",
        "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include",
        "-isystem",
        "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/5.1/include",
        "-isystem",
        "/usr/local/include",
        "-isystem",
        "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/c++/v1",
    ]

    return { "flags": flags, "do_cache": True }
