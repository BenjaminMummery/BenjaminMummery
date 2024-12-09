# one-command venv management
# If a venv exists, activate it.
# If no venv exists, create one then activate it.
# If we're already in an active venv, deactivate it.
function venv(){
    if [[ "$VIRTUAL_ENV" != "" ]]; then
        if [[ "$1" != "" ]]; then
            echo "Deactivating current venv, version argument will be ignored."
        fi
        deactivate

    else
        # Determine python version to use
        if [[ "$1" != "" ]]; then
            pyver="$1"
        else
            pyver="3.12"
            echo "No python version specified, defaulting to $pyver."
        fi

        # if the venv doesn't already exist, create it.
        if ! [[ -f "./venv$pyver/bin/activate" ]]; then
            # construct the python evocation, and get the full python version being used
            # (example: if the pyver arg is 3.12, full_pyver will be 3.12.7 or similar
            # depending on the specific version of python 3.12 available)
            pycommand="python$pyver"
            full_pyver="${$(eval "$pycommand --version")#Python\ }"

            # create the venv
            eval "$pycommand -m venv ./venv$pyver"

            # edit the activation script so the prompt is the python version, and is
            # also a nice colour.
            sed -i -e "s/(venv$pyver)/%F{magenta}($full_pyver)%f/" venv$pyver/bin/activate
            echo "Created new venv in 'venv$pyver'."

            # activate the venv, and ensure that the latest version of pip is installed.
            source ./venv$pyver/bin/activate
            python -m pip install --upgrade pip

        # If the venv already exists, activate it.
        else
            source ./venv$pyver/bin/activate
        fi
    fi
}
