import os
import platform
# import vim


# Convert a relative path to an abosolute path.
def AbsolutePath(relPath):
    return os.path.join(os.getcwd(), relPath)


# Find a directory Upwards from the current directory.
def FindDirUp(dirName, toRoot=False):
    # TODO
    return [""]


# Get the platform name.
def GetPlatformName():
    system = platform.system()
    if system == "Linux":
        return "LINUX"
    elif system == "Windows":
        return "WINDOWS"
    raise Exception("Unknown platform.")


def GetFiletype(filename):
    # TODO Nasty hack. Remove ASAP.
    extension = os.path.splitext(filename)[1][1:].strip().lower()
    if extension == 'c' or extension == 'h':
        return 'c'
    elif extension == 'cpp' or extension == 'hpp' or \
            extension == 'cc' or extension == 'hh':
        return 'cpp'


# Create filetype flags.
def FlagsForFile(filename):
    # TODO After the new YCM update (2013-10-25) `import vim` cannot be done.
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
