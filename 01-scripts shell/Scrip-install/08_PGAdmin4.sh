#!/bin/bash

# Verificar se o usuário é root
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root ou usando o comando 'sudo'."
   exit 1
fi

function install_pgadmin4() {
    # Atualizar o sistema
    apt update
    apt upgrade -y

    # Instalar as dependências necessárias
    apt install curl ca-certificates -y

    # Adicionar a chave GPG do repositório do pgAdmin 4
    curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | gpg --dearmor > /usr/share/keyrings/packages-pgadmin-org.gpg

    # Adicionar o repositório do pgAdmin 4 ao sources.list.d
    echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list

    # Atualizar os pacotes
    apt update

    # Instalar o pgAdmin 4 e o pgAdmin 4 Desktop
    apt install pgadmin4 pgadmin4-desktop -y

    # Configurar o pgAdmin 4 para executar no modo server
    sed -i 's/DEFAULT_SERVER = True/DEFAULT_SERVER = False/' /usr/share/pgadmin4/web/config_distro.py

    # Reiniciar o serviço do pgAdmin 4
    systemctl restart apache2

    echo "A instalação do pgAdmin 4 foi concluída."
}

function remove_pgadmin4() {
    # Remover o pgAdmin 4 e o pgAdmin 4 Desktop
    apt remove pgadmin4 pgadmin4-desktop -y

    # Remover o repositório do pgAdmin 4
    rm /etc/apt/sources.list.d/pgadmin4.list

    # Remover a chave GPG do repositório do pgAdmin 4
    rm /usr/share/keyrings/packages-pgadmin-org.gpg

    echo "A remoção do pgAdmin 4 foi concluída."
}

while true; do
    echo "Selecione uma opção:"
    echo "1. Instalar pgAdmin 4"
    echo "2. Remover pgAdmin 4"
    echo "3. Voltar"

    read -p "Opção: " option

    case $option in
        1)
            install_pgadmin4
            ;;
        2)
            remove_pgadmin4
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
