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
cloneCore(){
    FORCE_CLONE=0 #Si vale 1 elimina los repositorios descargados
    # Descargar el archivo corerepos.txt en la carpeta /tmp
    curl -o /tmp/corerepos.txt https://raw.githubusercontent.com/HomeCI/homeCI/main/install/corerepos.txt
    # Cambiar al directorio $CORE_PATH
    cd "$CORE_PATH"
    # Leer el archivo corerepos.txt y clonar los repositorios con git clone
    while read -r repo; do
    # Extraer el nombre de la carpeta del repositorio de la URL
    repo_name=$(basename "$repo" ".git")
    # Comprobar si el repositorio ya existe
    if [ -d "$repo_name" ]; then
        # Si la variable $FORCE_CLONE es 1, eliminar y clonar de nuevo
        if [ "$FORCE_CLONE" -eq 1 ]; then
        rm -rf "$repo_name"
        git clone -q "$repo"
        else
        echo "El repositorio $repo_name ya existe en $CORE_PATH"
        fi
    else
        git clone -q "$repo"
    fi
    done < /tmp/corerepos.txt
}
cloneCore