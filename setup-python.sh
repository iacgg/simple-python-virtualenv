#!/usr/bin/env bash

e() {
  echo -e "\e[39m  $1"
}

s() {
  echo -e "\e[92m  $1"
}

f() {
  echo -e "\e[91m  $1"
}

line() {
  echo -e "\e[39m================================"
}

pythonbootstrap() {
  e "Updating pip and install virtualenv"

  line
  if pip3 install --user --upgrade pip ; then
    s "pip updated"
  else
    f "pip update failed"
    exit 1
  fi
  line
  if pip3 install --user virtualenv ; then
    s "virteualenv installed"
  else
    f "virtualenv installation failed"
    exit 1
  fi

}

pythonvirtualenv() {
  line
  ENV_NAME="$1"
  mkdir -p ".virtualenvs"
  virtualenv -p python3 -q ".virtualenvs/$1"

  source ".virtualenvs/$1/bin/activate"
  pip3 -q install -r ./requirements.txt
  deactivate
}

pythonbootstrap

if [ -f "requirements.txt" ]; then
  pythonvirtualenv "$(basename $(git rev-parse --show-toplevel))"
fi
