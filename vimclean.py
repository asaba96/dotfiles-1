#!/usr/bin/env python3

import os
import re
import sys
import enum

swp_filename_regexes = (
    '\..*[._]*\.s[a-v][a-z]',
    '\..*[._]*\.sw[a-p]',
    '\..*[._]s[a-v][a-z]',
    '\..*[._]sw[a-p]'
)

swp_filename_patterns = tuple(
    re.compile(regex) for regex in swp_filename_regexes
)


class FileState(enum.Enum):
    UNMODIFIED = enum.auto()
    MODIFIED = enum.auto()
    TOO_SMALL = enum.auto()
    UNKNOWN = enum.auto()


def is_swp_filename(filename):
    if not filename:
        return False

    if filename[0] != '.':
        return False

    for ptn in swp_filename_patterns:
        if re.match(ptn, filename):
            return True

    return False


def get_file_state(path):
    '''
    Returns the state of the swapfile at `path`
    '''
    with open(path, 'rb') as f:
        f.seek(1007)
        b = f.read(1)

        if b == b'\x55':
            return FileState.MODIFIED
        elif b == b'\x00':
            return FileState.UNMODIFIED
        elif not b:
            return FileState.TOO_SMALL
        else:
            print('Unexpected modified byte value in swpfile ({}): \'\\x{}\''.format(
                path,
                b.encode('hex')))
            return FileState.UNKNOWN


def is_safe_to_remove(file_state):
    return file_state == FileState.UNMODIFIED


if __name__ == '__main__':
    if len(sys.argv) > 1:
        dirname = sys.argv[1]
    else:
        dirname = '.'

    files_to_remove = []

    for dirpath, dirnames, filenames in os.walk(dirname):
        for filename in filenames:
            if is_swp_filename(filename):
                files_to_remove.append(os.path.join(dirpath, filename))

    file_states = {file_state: [] for file_state in FileState}
    for path in files_to_remove:
        file_states[get_file_state(path)].append(path)

    for file_state in FileState:
        if file_states[file_state]:
            print('{} files:'.format(file_state.name.title()))
            for filename in file_states[file_state]:
                print(filename)
            print()

    if file_states[FileState.UNMODIFIED]:
        if input('Remove unmodified swapfiles (y/N)? ').lower() == 'y':
            for filename in file_states[FileState.UNMODIFIED]:
                os.remove(filename)
