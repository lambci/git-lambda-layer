import os
import sys
import subprocess
from git import Repo

repo_url = 'https://github.com/mhart/aws4'
repo_name = 'aws4'
os.chdir('/tmp')
sys.path.insert(0, '')
print(subprocess.run(["rm", "-rf", repo_name], capture_output=True))
if not os.path.exists(repo_name):
    repo = Repo.clone_from(repo_url, repo_name)
print(os.listdir(repo_name))
print(subprocess.run(["ssh", "-V"], capture_output=True))
