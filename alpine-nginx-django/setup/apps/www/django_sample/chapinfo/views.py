import os
import subprocess
from django.shortcuts import get_object_or_404, render

container_name = os.environ['CONTAINER_NAME'] + " Container"

LS_CMD = """cd $APPS_DIR; ls -l | sed -r 's/^.*(etc|var|chaperone.d|startup.d|var|www|build.sh)$/<span class="ls-high">\\0<\/span>/'"""

def generic(request, pagename):
    context = {
        'container': container_name,
        'env': os.environ,
        'development_mode': os.environ['APPS_DIR'] != '/apps',
    }
    if pagename == "process_list.html":
        context['procoutput'] = subprocess.check_output("ps", shell=True)
    elif pagename == "index.html":
        context['ls_output'] = subprocess.check_output(LS_CMD, shell=True)
    elif pagename == "sample.html":
        context['ls_output'] = subprocess.check_output("cd $APPS_DIR/www; ls -l", shell=True)

    return render(request, 'chapinfo/' + pagename, context)
