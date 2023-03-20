# super-simple venv management
# If a venv exists, activate it.
# If no venv exists, create one then activate it.
# If we're already in an active venv, deactivate it.
function venv(){
    if [[ "$VIRTUAL_ENV" != "" ]]; then
        deactivate
    else
        if ! [[ -f './venv/bin/activate' ]]; then
            python3 -m venv ./venv
        fi
        source ./venv/bin/activate
    fi
}
