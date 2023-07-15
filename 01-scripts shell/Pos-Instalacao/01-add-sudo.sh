#!/bin/bash

# Verificar se o usuário é root
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root ou usando o comando 'sudo'."
   exit 1
fi

# Adicionar o usuário "vmix" ao grupo "sudo"
echo "Adicionando o usuário 'vmix' ao grupo 'sudo'..."
usermod -aG sudo vmix

# Adicionar a configuração para o usuário "vmix" no arquivo "sudoers"
echo "Adicionando a configuração para o usuário 'vmix' no arquivo 'sudoers'..."
echo "vmix ALL=(ALL:ALL) ALL" >> /etc/sudoers

echo "O usuário 'vmix' foi adicionado ao grupo 'sudo' e configurado no arquivo 'sudoers' com sucesso."
