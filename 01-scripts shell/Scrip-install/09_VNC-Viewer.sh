#!/bin/bash

# Verificar se o usuário é root
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root ou usando o comando 'sudo'."
   exit 1
fi

while true; do
    echo "Selecione uma opção:"
    echo "1. Instalar VNC Viewer"
    echo "2. Remover VNC Viewer"
    echo "3. Voltar"

    read -p "Opção: " option

    case $option in
        1)
            # Baixar o arquivo do VNC Viewer
            echo "Baixando o pacote VNC Viewer..."
            wget -O vnc-viewer.deb https://downloads.realvnc.com/download/file/viewer.files/VNC-Viewer-7.5.1-Linux-x64.deb

            # Instalar o VNC Viewer
            echo "Instalando o VNC Viewer..."
            dpkg -i vnc-viewer.deb
            apt-get install -f -y

            # Remover o arquivo baixado
            echo "Removendo o arquivo baixado..."
            rm vnc-viewer.deb

            echo "A instalação do VNC Viewer foi concluída."
            ;;
        2)
            # Remover o VNC Viewer
            echo "Removendo o VNC Viewer..."
            apt-get purge -y realvnc-vnc-viewer

            echo "A remoção do VNC Viewer foi concluída."
            ;;
        3)
            echo "Voltando ao menu principal..."
            break
            ;;
        *)
            echo "Opção inválida."
            ;;
    esac
done

