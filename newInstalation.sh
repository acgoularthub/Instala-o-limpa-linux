#!/usr/bin/env bash

echo "Iniciando"

## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y

PROGRAMAS_PARA_INSTALAR=(
  git
  wget
  curl
  unzip
  vim
  nano
  tree
  htop
  zsh
  flameshot
  teminator
  gnome-tweaks
  gnome-tweak-tool
  flatpak
  gnome-software-plugin-flatpak
  python3
  python3-pip
  python3-venv
  php
  virtualbox
  virtualbox-dkms
  libelf-dev
  folder-color
  gnome-sushi
  gnome-shell-extensions
  
)

# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

echo " "
echo "--------------------------------------------------------------------------------"
echo " "

# Instalando docker e kubernetes

echo " "
echo "Iniciando a instalação do Docker"
echo " "

#docker
curl -fsSL https://get.docker.com/ | sh
sudo usermod -aG docker $USER
newgrp docker # Entra no grupo docker
sudo systemctl enable docker.service

echo " "
echo "---------------------------------------------------------------------------------"
echo " "

echo " "
echo "Instalando o Kubectl"
echo " "

#kubernetes
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

echo " "
echo "---------------------------------------------------------------------------------"
echo " "

echo " "
echo "Instalando o Kind"
echo " "

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

echo " "
echo "---------------------------------------------------------------------------------"
echo " "

echo " "
echo "Instalando flatpaks"
echo " "

## Instalando pacotes Flatpak ##
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.obsproject.Studio -y
flatpak install flathub com.stremio.Stremio -y
flatpak install flathub io.github.jeffshee.Hidamari -y

echo " "
echo "---------------------------------------------------------------------------------"
echo " "

echo " "
echo "Instalando snaps"
echo " "
## Instalando pacotes Snap ##
sudo snap install spotify

echo " "
echo "Finalizando"
echo " "

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #

echo " "
echo "***--------------FIM DO SCRIPT----------------***"
echo " "