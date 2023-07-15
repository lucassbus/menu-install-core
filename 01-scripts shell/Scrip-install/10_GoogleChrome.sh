#!/bin/bash

# Verificar se o usuário é root
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root ou usando o comando 'sudo'."
   exit 1
fi

while true; do
    echo "Selecione uma opção:"
    echo "1. Instalar Google Chrome"
    echo "2. Remover Google Chrome"
    echo "3. Voltar"

    read -p "Opção: " option

    case $option in
        1)
            # Baixar o pacote do Google Chrome
            echo "Baixando o pacote do Google Chrome..."
            wget -O google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

            # Instalar o Google Chrome
            echo "Instalando o Google Chrome..."
            dpkg -i google-chrome.deb
            apt-get install -f -y

            # Remover o arquivo baixado
            echo "Removendo o arquivo baixado..."
            rm google-chrome.deb

            echo "A instalação do Google Chrome foi concluída."
            ;;
        2)
            # Remover o Google Chrome
            echo "Removendo o Google Chrome..."
            apt-get purge -y google-chrome-stable

            echo "A remoção do Google Chrome foi concluída."
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

