import os

default_flags = [
    '-I',
    '.',
    '-isystem',
    '/usr/include',
    '-isystem',
    '/usr/local/include',
    '-isystem',
    '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../include/c++/v1',
    '-isystem',
    '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include'
    ]

include_dirs = ['inc', 'include']
library_dirs = ['lib', 'ext', 'external', 'third_party']
root_dir_files = ['.git', 'src', 'inc', 'test']


def prepare_flags(flags):
    """Split a string of flags into a list."""
    return flags.split()


def prepare_includes(includes):
    """Add '-I' prefix to include flags."""
    new_includes = list()
    for i in includes:
        new_includes.extend(['-I', i])
    return new_includes


def find_root_dir():
    """Find the project root else return the current directory."""
    cwd = os.getcwd()
    pwd = None
    while cwd != pwd:
        files = [f for f in os.listdir(cwd)]
        for f in files:
            if f in root_dir_files:
                return cwd
        pwd = cwd
        cwd = os.path.dirname(cwd)
    return os.getcwd()


def find_include_dirs(path, recurse=False):
    """Find include directories for the project in 'path'."""
    includes = list()
    dirs = [d for d in os.listdir(path)
            if os.path.isdir(os.path.join(path, d))]
    for d in dirs:
        d_full = os.path.join(path, d)
        if d in include_dirs:
            includes.append(d_full)
        elif d in library_dirs and recurse:
            # recurse into library directories for includes
            ldirs = [ld for ld in os.listdir(d_full)
                     if os.path.isdir(os.path.join(d_full, ld))]
            for ld in ldirs:
                ld_full = os.path.join(d_full, ld)
                includes.extend(find_include_dirs(ld_full))
    return includes


def FlagsForFile(filename, **kwargs):
    flags = default_flags
    try:
        client_data = kwargs['client_data']
        filetype = client_data['&filetype']
        if filetype == 'c':
            flags.append('-xc')
            flags.extend(prepare_flags(client_data['g:ycm_extra_conf_c_flags']))
        elif filetype == 'cpp':
            flags.append('-xc++')
            flags.extend(prepare_flags(client_data['g:ycm_extra_conf_cpp_flags']))
        elif filetype == 'objc':
            flags.append('-ObjC')
            flags.extend(prepare_flags(client_data['g:ycm_extra_conf_objc_flags']))
    except KeyError:
        pass
    root_dir = find_root_dir()
    flags.extend(prepare_includes(find_include_dirs(root_dir, True)))
    return {'flags': flags, 'do_cache': True}


if __name__ == '__main__':
    print(find_root_dir())
    print(find_include_dirs(find_root_dir(), True))
    print(prepare_includes(find_include_dirs(find_root_dir(), True)))
