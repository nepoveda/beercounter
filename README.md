## Prerequisities

- install git and curl
```bash
apt install git curl
```

- clone the repo
```bash
git clone git@github.com:nepoveda/beercounter.git
```

- enter the directory
```bash
cd beercounter
```

- install node.js with npm package manager
```bash
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
sudo apt-get install -y nodejs
```

- install global packages
```bash
sudo npm install -g coffee-script browserify watchify npm-check-updates
```

- install rest of the dependencies (specified in package.json) locally (creates node_modules
  directory)
```bash
npm install
```

## Scripts (defined in package.json)

- build app for production
```bash
npm run build
```

- watch for changes in code and build app continuously for development
```bash
npm run watch
```

- start backend API (listens on localhost:3000)
```bash
npm run backend
```

- update dependencies (may brake the app)
```bash
npm run update
```

## Resources
- react.js (frontend framework) - https://facebook.github.io/react/docs/hello-world.html
- express.js (backend framework) - http://expressjs.com/
- jQuery AJAX (frontend-backend communication) - http://api.jquery.com/category/ajax/
- twitter bootstrap (styling framework) - http://getbootstrap.com/components/
- react-bootstrap (react-bootstrap integration) - https://react-bootstrap.github.io/components.html
