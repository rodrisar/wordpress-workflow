# -*- coding: utf-8 -*-
import sys
import json
import os
from fabric.api import cd, env, run, task, require, sudo, local
from fabric.colors import green, red, white, yellow, blue
from fabric.contrib.console import confirm
from fabric.contrib.files import exists
from fabric.operations import get
from fabric import state
from fabutils import boolean

from fabutils.env import set_env_from_json_file
from fabutils.tasks import ursync_project, ulocal, urun

@task
def custom_task():
    """
    Example of custom task, can be called using `fab environment:your_env cutomfile.custom_task`.
    """
    print "Example of custom task, can be called using `fab environment:your_env cutomfile.custom_task`."

# After this line you can put all your custom tasks
