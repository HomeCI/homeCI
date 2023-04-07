# homeCI
Proyecto general de HomeCI

# Instalación

### Setup

[install.sh](install/install.sh)

### Instalar los componentes

```bash
curl -o install_components.sh https://raw.githubusercontent.com/HomeCI/homeCI/main/install/install_components.sh
chmod +x install_components.sh
./install_components.sh
```

```bash
hci list
```

```
REPOSITORIOS
-------------
En /home/alpeza/HomeCI/repo:

En /home/alpeza/HomeCI/core:
- core_authentik
- core_jenkins
- core_npm
- core_portainer
```

Levantamos 

```
hci start core_npm
````

Levantamos el resto

```bash
hci start core_jenkins
hci start core_authentik
hci start core_portainer
...
```