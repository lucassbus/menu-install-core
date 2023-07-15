#!/bin/bash

# Verificar se o usuario e root
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root ou usando o comando 'sudo'."
   exit 1
fi

instalar_supervisor() {
    echo "Instalando o Supervisor..."
    apt-get update
    apt-get install supervisor -y

    echo "Liberando a porta 9001 no firewall..."
    ufw allow 9001

    echo "Criando o arquivo de configuracao /etc/supervisor/supervisord.conf..."
    echo "[inet_http_server]" >> /etc/supervisor/supervisord.conf
    echo "port=*:9001" >> /etc/supervisor/supervisord.conf
    echo "username=admin" >> /etc/supervisor/supervisord.conf
    echo "password=admin" >> /etc/supervisor/supervisord.conf

    echo "Reiniciando o servico do Supervisor..."
    systemctl restart supervisor

    echo "A instalacao do Supervisor foi concluida com sucesso."
}

remover_supervisor() {
    echo "Removendo o Supervisor..."
    apt-get remove supervisor -y

    echo "Removendo a regra de firewall para a porta 9001..."
    ufw delete allow 9001

    echo "A remocao do Supervisor foi concluida com sucesso."
}

while true; do
    echo "Selecione uma opcao:"
    echo "1. Instalar Supervisor"
    echo "2. Remover Supervisor"
    echo "3. Voltar"

    read -p "Opcao: " opcao

    case $opcao in
        1)
            instalar_supervisor
            ;;
        2)
            remover_supervisor
            ;;
        3)
            echo "Voltando ao menu principal..."
            break
            ;;
        *)
            echo "Opcao invalida."
            ;;
    esac
done
