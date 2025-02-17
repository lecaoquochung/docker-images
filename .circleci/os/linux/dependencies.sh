echo $SHELL
cat /etc/os-release
pwd;ls;whoami;date;

# NPM latest version
sudo npm install -g npm@latest

# Chrome version
google-chrome --version
sudo apt-get upgrade google-chrome-stable -y
google-chrome --version

# yarn latest version
# https://github.com/lecaoquochung/docker-images/issues/48
# Check if corepack is available
# if ! command -v corepack &> /dev/null; then # Check if corepack is not available -> Make sure this works on CircleCI
#   echo "Installing corepack..."
#   sudo npm install -g corepack
# else
#   echo "Corepack is already installed"
# fi
sudo npm install -g corepack
corepack enable

# Install Yarn dependencies
echo "Installing Yarn dependencies..."
yarn install
yarn --version

# Install global Yarn packages
echo "Installing global Yarn packages..."
yarn global add junit-report-merger
yarn global bin

export PATH="$PATH:/home/qa/.yarn/bin"

# Install web driver
echo "Installing Playwright..."
npx playwright install

# Verify environment variable
echo $PUPPETEER_EXECUTABLE_PATH
