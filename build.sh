#!/bin/bash

set -e

if ! command -v virtualenv &> /dev/null
then
    echo "virtualenv could not be found"
    pip install pipx;
else
  venv_path=$(which virtualenv);
  echo "using venv located at $venv_path"
fi

venv="venv"
echo "making virtualenv: $venv"

echo "linking res library"
ln -sf ../../../res .

virtualenv $venv

$venv/bin/pip install --upgrade pip pytest
$venv/bin/pip install pip-tools
$venv/bin/pip install -r src/requirements.txt

echo "running pytest"
PYTHONPATH=${pwd}/res:$PYTHONPATH $venv/bin/pytest

path=`pwd`

echo "useful aliases"
echo "alias pr_py=\"PYTHONPATH=$path/res:$PYTHONPATH $path/$venv/bin/python\""
echo "alias pr_pytest=\"PYTHONPATH=$path/res:$PYTHONPATH $path/$venv/bin/pytest\""

echo "then run"
echo "opt_py -m optimus_printer.main -d"
