#!/bin/bash

# Verificar se o usuário é root
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root ou usando o comando 'sudo'."
   exit 1
fi

while true; do
    echo "Selecione uma opção:"
    echo "1. Instalar DBeaver Community"
    echo "2. Remover DBeaver Community"
    echo "3. Voltar"

    read -p "Opção: " option

    case $option in
        1)
            # Instalar o DBeaver Community
            echo "Instalando o DBeaver Community..."

            # Baixar o pacote do DBeaver Community
            wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb

            # Instalar o pacote
            dpkg -i dbeaver-ce_latest_amd64.deb

            # Instalar as dependências faltantes
            apt-get -f install -y

            echo "A instalação do DBeaver Community foi concluída."
            ;;
        2)
            # Remover o DBeaver Community
            echo "Removendo o DBeaver Community..."

            # Desinstalar o pacote
            apt-get remove dbeaver-ce -y

            echo "A remoção do DBeaver Community foi concluída."
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

