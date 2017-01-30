#!/bin/bash
NODE_ENV=development watchify -v --extension=".coffee" src/main.coffee -o build/main.js
