# Install Create React app
# Create a new React app with:
# react router
# redux
# axios
# styled components
# normalize
# redux form
# esdoc
# eslint
#
#!/bin/bash

NPM_PACKAGES="axios prop-types react-router-dom styled-components normalize.css redux-form"
REDUX_PACKAGES="redux react-redux redux-thunk"
DEV_PACKAGES="esdoc eslint eslint-config-airbnb eslint-plugin-import eslint-plugin-jsx-a11y@5 eslint-plugin-react"
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

elif [ "$1" == "go" ]
then
  read -p "What would you like the app name to be? " appname
  create-react-app $appname
  cd ./$appname

  echo "Removing default fies to be replaced"
  cd ./src
  rm App.js App.css index.js index.css logo.svg
  cd ..

  mv ./src ./temp

  echo "Installing Hamish npm packages: $NPM_PACKAGES $REDUX_PACKAGES"
  npm install --save $NPM_PACKAGES $REDUX_PACKAGES

  echo "Installing Hamish dev packages: $DEV_PACKAGES"
  npm install --save-dev $DEV_PACKAGES

  echo "Pulling ./src folder"
  svn export $GITHUB_FOLDER_URL/src
  cp ./temp/App.test.js ./src/App.test.js
  cp ./temp/registerServiceWorker.js ./src/registerServiceWorker.js
  rm -rf ./temp

  echo "Pulling config files"
  curl https://raw.githubusercontent.com/searleb/hamish/master/config/.esdoc.json -o .esdoc.json
  curl https://raw.githubusercontent.com/searleb/hamish/master/config/.env -o .env
  curl https://raw.githubusercontent.com/searleb/hamish/master/config/.eslintrc -o .eslintrc

  npm run start

elif [ "$1" == "help" ]
then
  echo "./hami.sh install    Installs create-react-app"
  echo "./hami.sh go    Creates react app and adds redux, routing, axios and config"

else
  echo "I'm Hamish!"
fi
