#!/bin/sh

# debian12 

# read run file
if [[ ! -f config.ini ]]; then
  echo "-- No config file ..."
  echo "-- Closing ..."
  exit
else
  echo "---- Starting module ----------"
fi

# create virtualenv
run_file=$(grep -Po '^create_venv=(\K.*)$' config.ini) 
if [[ "$run_file" == "true" ]]; then
  if [[ -d venv ]]; then
    echo "-- Venv already exists. Deleting ..."
    rm -rf venv
    echo "-- Venv was deleted"
  fi
  echo "-- Creating virtual environment"	
  # sudo apt install python3-virtualenv
  # upgrade pip
  # python3 -m pip install --user --upgrade pip
  # create virtual environment with all your libs
  python3 -m virtualenv venv --system-site-packages
  # activate venv
  source venv/bin/activate
  # install all additional requirements
  requirements=$(grep -Po '^req_file=(\K.*)$' config.ini)
  pip install -r "$requirements"
  # deactivate
  deactivate
else
  echo "-- Venv was not created"
fi

# run script using venv
activate_venv=$(grep -Po '^activate_venv=(\K.*)$' config.ini)
if [[ "$activate_venv" == "true" ]]; then
  source venv/bin/activate
  echo "-- Virtual environment is activated"
fi

# run script
file_name=$(grep -Po '^file_name=(\K.*)$' config.ini) || echo "-- No file to run"
if [[ "$file_name" == "true" ]]; then
  echo "-- Running python script"
  python3 "$file_name"
fi

# deactivate venv
if [[ "$activate_venv" == "true" ]]; then
  deactivate
  echo "-- Virtual environment diactivated"
fi

exit


