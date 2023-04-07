#!/bin/bash

# Verificar que se ejecute con permisos de superusuario
if [ "$(id -u)" != "0" ]; then
    echo "Este script debe ejecutarse con permisos de superusuario. Por favor, ejecútelo como root o con el comando sudo."
    exit 1
fi

# Función para imprimir el progreso de la instalación
print_progress() {
    echo -ne "\rProgreso: $1% completado"
}

# Contadores de instalaciones
installed=0
already_installed=0

# Comprobar si el servidor ssh está instalado
if [ $(dpkg-query -W -f='${Status}' openssh-server 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
    # Instalar el servidor ssh
    sudo apt-get update
    sudo apt-get install -y openssh-server
    sudo apt install -y net-tools
    # Reiniciar el servicio de SSH para aplicar la configuración
    sudo service ssh restart
    print_progress 33
    installed=$((installed+1))
else
    already_installed=$((already_installed+1))
fi

# Comprobar si Docker CE está instalado
if ! command -v docker &> /dev/null; then
    # Instalar Docker CE
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    # Añadir el usuario actual al grupo "docker" para ejecutar Docker sin sudo
    sudo usermod -aG docker $USER
    sudo systemctl status docker
    print_progress 66
    installed=$((installed+1))
else
    already_installed=$((already_installed+1))
fi

# Comprobar si Python está instalado
if ! command -v python3 &> /dev/null; then
    # Instalar Python
    sudo apt-get update
    sudo apt-get install -y python3 python3-pip
    print_progress 75
    installed=$((installed+1))
else
    already_installed=$((already_installed+1))
fi


if ! command -v git &> /dev/null; then
    # Instalar Git
    sudo apt-get update
    sudo apt-get install -y git
    print_progress 85
    installed=$((installed+1))
else
    already_installed=$((already_installed+1))    
fi

# Comprobar si jq está instalado
if ! command -v jq &> /dev/null; then
    # Instalar jq
    sudo apt-get update
    sudo apt-get install -y jq
    print_progress 90
    installed=$((installed+1))
else
    already_installed=$((already_installed+1))    
fi

if ! command -v node &> /dev/null; then
    # Instalar Node.js y npm
    sudo apt-get update
    sudo apt-get install -y nodejs npm
    print_progress 100
    installed=$((installed+1))
else
    already_installed=$((already_installed+1))
fi

# Imprimir resumen de las instalaciones
echo "Resumen de las instalaciones:"
echo "Paquetes instalados: $installed"
echo "Paquetes ya instalados: $already_installed"
echo "Reinicie la máquina una vez realizada la instalación"