def PrepareFlags(flags):
    return flags.split()


def FlagsForFile(filename, **kwargs):
    client_data = kwargs['client_data']
    filetype = client_data['&filetype']

    if filetype == 'c':
        flags = PrepareFlags(client_data['g:ycm_extra_conf_c_flags'])
    elif filetype == 'cpp':
        flags = PrepareFlags(client_data['g:ycm_extra_conf_cpp_flags'])

    return {'flags': flags, 'do_cache': True}
