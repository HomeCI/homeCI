export HOME_CI_PATH=$HOME/HomeCI
export CORE_PATH=$HOME_CI_PATH/core
export REPO_PATH=$HOME_CI_PATH/repo
export CLI_PATH=$HOME_CI_PATH/cli

# Instalación del CLI
cliInstall(){
    curl https://raw.githubusercontent.com/HomeCI/hci/main/install.sh -o /tmp/installcli.sh
    chmod +x /tmp/installcli.sh
    /tmp/installcli.sh
    source ~/.bashrc
}
cliInstall

# Core 