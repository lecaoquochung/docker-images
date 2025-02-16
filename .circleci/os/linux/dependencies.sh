echo $SHELL
cat /etc/os-release
pwd;ls;whoami;date;

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

# Upgrade Yarn and install dependencies
echo "Upgrading Yarn and installing dependencies..."
yarn upgrade 
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
