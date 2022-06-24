#!/bin/sh

Help() {
  # Display Help
  echo "Add description of the script functions here."
  echo
  echo "Syntax: scriptTemplate [-g|h|v|V]"
  echo "options:"
  echo "help     Print this Help."
  echo "new     Create new symfony project"
  echo
  exit 0
}

ConfigureProject() {
  echo "Install code quality tools..."
  cp /conf/* .
  composer require -q --dev phpro/grumphp phpstan/phpstan phpstan/phpstan-doctrine phpstan/phpstan-symfony friendsofphp/php-cs-fixer povils/phpmnd
  ./vendor/bin/grumphp git:init
}

InitProject() {
  GIT_AUTHOR_NAME=${GIT_AUTHOR_NAME:-IT-Room} EMAIL=${EMAIL:-developpement@itroom.fr} symfony new --version="${VERSION:-lts}" --webapp "$1"
}

if [ "help" = "$1" ]; then
  Help
elif [ "new" = "$1" ] && [ -n "$2" ]; then
  InitProject "$2"
  cd "$2" || exit
  ConfigureProject
  exit 0
fi

exec "$@"
