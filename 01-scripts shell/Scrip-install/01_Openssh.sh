#!/bin/bash

# Verificar se o usuario e root
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root ou usando o comando 'sudo'."
   exit 1
fi

install_ssh() {
    echo "Atualizando o cache do sistema..."
    sudo apt update

    echo "Verificando o status do servico SSH..."
    sudo systemctl status ssh

    echo "Instalando o servidor e o cliente SSH..."
    sudo apt install openssh-server openssh-client -y

    echo "Habilitando o SSH..."
    sudo systemctl enable ssh --now

    echo "Configurando o firewall..."
    sudo ufw enable
    sudo ufw allow 22
    sudo ufw reload

    echo "A instalacao e configuracao do SSH foram concluidas com sucesso."
}

remove_ssh() {

    echo "Removendo o servidor e o cliente SSH..."
    sudo apt remove openssh-server openssh-client -y

    echo "Desabilitando o SSH..."
    sudo systemctl disable ssh

    echo "Configurando o firewall..."
    sudo ufw delete allow 22
    sudo ufw reload

    echo "A remocao do SSH foi concluida com sucesso."
}

while true; do
    echo "Selecione uma opcao:"
    echo "1. Instalar SSH"
    echo "2. Remover SSH"
    echo "3. Voltar"

    read -p "Opcao: " option

    case $option in
        1)
            install_ssh
            ;;
        2)
            remove_ssh
            ;;
        3)
            echo "Voltando ao menu anterior..."
            break
            ;;
        *)
            echo "Opcao invalida."
            ;;
    esac
done

