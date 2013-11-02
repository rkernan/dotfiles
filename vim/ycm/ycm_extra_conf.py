import os
import platform
import ycm_core
from clang_helpers import PrepareClangFlags


def DirectoryOfThisScript():
    return os.path.dirname(os.path.abspath(__file__))


def AbsolutePath(relative_path):
    return os.path.join(os.getcwd(), relative_path)


def PlatformName():
    system = platform.system()
    if system == "Linux":
        return "LINUX"
    elif system == "Windows":
        return 'WINDOWS'
    raise Exception('Unknown platform.')


def MakeRelativePathsInFlagsAbsolute(flags, working_directory):
    if not working_directory:
        return flags
    new_flags = []
    make_next_absolute = False
    path_flags = ['-isystem', '-I', '-iquote', '--sysroot=']
    for flag in flags:
        new_flag = flag
        if make_next_absolute:
            make_next_absolute = False
            if not flag.startswith('/'):
                new_flag = os.path.join(working_directory, flag)

        for path_flag in path_flags:
            if flag == path_flag:
                make_next_absolute = True
                break

            if flag.startswith(path_flag):
                path = flag[len(path_flag):]
                new_flag = path_flag + os.path.join(working_directory, path)
                break
        if new_flag:
            new_flags.append(new_flag)
    return new_flags


flags = [
    '-Wall',
    '-Wextra',
    '-DDEBUG',
    '-I', 'inc',
    '-I', 'include'
]

try:
    flags += ['-D%s' % PlatformName()]
except:
    pass

c_flags = [
    '-std=c11',
    '-x', 'c'
]

cpp_flags = [
    '-std=c++11',
    '-x', 'c++'
]


def GetCompleteFlags(filename):
    extension = os.path.splitext(filename)[1][1:].strip().lower()
    if extension == 'c':
        # C file
        return flags + c_flags
    elif extension == 'cpp' or extension == 'cxx' or extension == 'cc' \
            or extension == 'hpp' or extension == 'hxx' or extension == 'hh' \
            or extension == 'inl' or extension == 'h':
        # C++ file
        return flags + cpp_flags

compilation_database_folder = None
if compilation_database_folder:
    database = ycm_core.CompilationDatabase(compilation_database_folder)
else:
    database = None


def FlagsForFile(filename):
    if database:
        compilation_info = database.GetCompilationInfoForFile(filename)
        final_flags = PrepareClangFlags(
            MakeRelativePathsInFlagsAbsolute(
                compilation_info.compiler_flags_,
                compilation_info.compiler_working_dir_),
            filename)
    else:
        # relative_to = DirectoryOfThisScript()
        relative_to = os.getcwd()
        final_flags = MakeRelativePathsInFlagsAbsolute(
            GetCompleteFlags(filename), relative_to)

    return {
        'flags': final_flags,
        'do_cache': True
    }
