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
  python3
  python3-pip
  python3-venv
  php
  virtualbox
  virtualbox-dkms
  libelf-dev
)

# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

## Instalando pacotes Flatpak ##
flatpak install flathub com.obsproject.Studio -y

## Instalando pacotes Snap ##
sudo snap install spotify

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #