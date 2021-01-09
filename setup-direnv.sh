#!/usr/bin/env bash

if ! python3 -c "print('hello world')"; then
  echo "can't use python3"
  exit 1
fi

if ! pip3 --version; then
  echo "can't use pip3"
  exit 1
fi

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
  if pip3 install --user direnv ; then
    s "direnv installed"
  else
    f "direnv installation failed"
    exit 1
  fi

}

if [ -f ".envrc" ]; then
  if ! grep "source .virtualenvs" .envrc &>/dev/null ; then
    echo "source .virtualenvs/$(basename $(git rev-parse --show-toplevel))/bin/activate" >> .envrc
    s "Remember to run 'direnv allow'"
  fi
else
  echo "source .virtualenvs/$(basename $(git rev-parse --show-toplevel))/bin/activate" > .envrc
  s "Remember to run 'direnv allow'"
fi
