#!/bin/bash

# Verificar se o usu�rio � root
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root ou usando o comando 'sudo'."
   exit 1
fi

while true; do
    echo "Selecione uma op��o:"
    echo "1. Instalar DBeaver Community"
    echo "2. Remover DBeaver Community"
    echo "3. Voltar"

    read -p "Op��o: " option

    case $option in
        1)
            # Instalar o DBeaver Community
            echo "Instalando o DBeaver Community..."

            # Baixar o pacote do DBeaver Community
            wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb

            # Instalar o pacote
            dpkg -i dbeaver-ce_latest_amd64.deb

            # Instalar as depend�ncias faltantes
            apt-get -f install -y

            echo "A instala��o do DBeaver Community foi conclu�da."
            ;;
        2)
            # Remover o DBeaver Community
            echo "Removendo o DBeaver Community..."

            # Desinstalar o pacote
            apt-get remove dbeaver-ce -y

            echo "A remo��o do DBeaver Community foi conclu�da."
            ;;
        3)
            echo "Voltando ao menu principal..."
            break
            ;;
        *)
            echo "Op��o inv�lida."
            ;;
    esac
done

