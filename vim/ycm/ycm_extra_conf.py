import os
import platform
# FIXME Can't import vim since commit on 2013-10-24 (change to client-server).
# import vim


# Convert a relative path to an abosolute path.
def AbsolutePath(relPath):
    return os.path.join(os.getcwd(), relPath)


# Get the platform name.
def GetPlatformName():
    system = platform.system()
    if system == "Linux":
        return "LINUX"
    elif system == "Windows":
        return "WINDOWS"
    raise Exception("Unknown platform.")


# FIXME
def GetFiletype(filename):
    extension = os.path.splitext(filename)[1][1:].strip().lower()
    if extension == 'c' or extension == 'h':
        return 'c'
    elif extension == 'cpp' or extension == 'cxx' or extension == 'cc'        \
            or extension == 'hpp' or extension == 'hxx' or extension == 'hh'  \
            or extension == 'inl':
        return 'cpp'


# Create filetype flags.
def FlagsForFile(filename):
    # FIXME
    # filetype = vim.eval('&filetype')
    filetype = GetFiletype(filename)
    if filetype == "c":
        flags = [
            "-std=c11",
            "-x", "c"
            "-Wall",
            "-Wextra",
            "-I", AbsolutePath("inc"),
            "-I", AbsolutePath("include"),
            "-DDEBUG",
            ]
        try:
            flags += ["-D%s" % GetPlatformName()]
        except:
            pass
    elif filetype == "cpp":
        flags = [
            "-std=c++11",
            "-x", "c++",
            "-Wall",
            "-Wextra",
            "-I", AbsolutePath("inc"),
            "-I", AbsolutePath("include"),
            "-DDEBUG",
            ]
        try:
            flags += ["-D%s" % GetPlatformName()]
        except:
            pass
    return {"flags": flags, "do_cache": True}
