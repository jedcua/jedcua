#!/bin/bash
set -xe

if [ $TRAVIS_BRANCH == 'master' ] ; then
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa

  cd /var/www/html
  git init

  git remote add deploy "travis@jedcua.dev:/home/travis/jedcua"
  git config user.name "Travis CI"
  git config user.email "jonedwardcua@gmail.com"

  git add .
  git commit -m "Deploy"
  git push --force deploy master
else
  echo "Not deploying, since this branch isn't master."
fi