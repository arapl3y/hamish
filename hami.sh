# Install Create React app
# Create a new React app with default packages
# Adds axios config
#
#
#
#!/bin/bash

NPM_PACKAGES="axios prop-types react-router-dom styled-components esdoc normalize.css"
REDUX_PACKAGES="redux react-redux redux-thunk"
FOLDERS="api components containers helpers redux styled-components"
GITHUB_RAW_URL="https://raw.githubusercontent.com/searleb/hamish/master"
GITHUB_FOLDER_URL="https://github.com/searleb/hamish/trunk"

if [ "$1" == "install" ]
then
  echo "Installing Create React App"
  npm install -g create-react-app
  echo "Complete"

elif [ "$1" == "test" ]
then
  svn export $GITHUB_FOLDER_URL/esdoc testfolder

elif [ "$1" == "create-app" ]
then
  read -p "What would you like the app name to be? " appname
  create-react-app $appname
  cd ./$appname

  echo "Installing Hamish defaults: $NPM_PACKAGES $REDUX_PACKAGES"
  npm install --save $NPM_PACKAGES $REDUX_PACKAGES

  echo "Pulling ./src folder"
  svn export $GITHUB_FOLDER_URL/api

  echo "Pulling config files"
  cd ..
  curl https://raw.githubusercontent.com/searleb/hamish/master/esdoc/.esdoc.json -o .esdoc.json

elif [ "$1" == "help" ]
then
  echo "./hami.sh install    Installs create-react-app"
  echo "./hami.sh create-app    Creates react app with some extra default packages and optionals"

else
  echo "I'm Hamish"
fi
