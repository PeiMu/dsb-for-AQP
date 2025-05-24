import os
import subprocess
import shutil
import sys

scale = 10
if len(sys.argv) > 1:
    scale = sys.argv[1]

bin_dir = os.getcwd()
bin_path = os.path.join(bin_dir, 'dsdgen')

file_dir = bin_dir + "/out_" + str(scale)  # directory of database files

if os.path.exists(file_dir):
    shutil.rmtree(file_dir)

if not os.path.exists(file_dir):
    os.makedirs(file_dir)

# WARNING: This code hasn't been valiated. Somewhat the dir parameter is not
# taken into account by the code. The output db files are generated in file_dir
cmd = [bin_path, '-scale', str(scale), '-terminate', 'N', '-force', 'Y', '-dir', file_dir]
print(cmd)
subprocess.call(cmd, cwd=bin_dir)
