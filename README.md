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
sudo npm install -g browserify watchify npm-check-updates
```

- install rest of the dependencies (specified in package.json) locally (creates node_modules
  directory)
```bash
npm install
```
