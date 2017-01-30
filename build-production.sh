#!/bin/bash
NODE_ENV=production browserify -v --extension=".coffee" src/main.coffee -o build/main.js
# sass --update assets/css:assets/css
