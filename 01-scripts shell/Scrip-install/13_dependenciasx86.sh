#!/bin/bash

while true; do
    echo "Selecione uma opcao:"
    echo "1. Instalar lightdm"
    echo "2. Remover lightdm"
    echo "3. Voltar"

    read -p "Opcao: " option

    case $option in
        1)
            # Verificar se o lightdm já está instalado
            if [ -x "$(command -v lightdm)" ]; then
                echo "O lightdm já está instalado."
            else
                # Instalar o pacote lightdm
                apt install lightdm -y

                echo "A instalacao do lightdm foi concluida com sucesso."
            fi
            ;;
        2)
            # Verificar se o lightdm está instalado
            if [ ! -x "$(command -v lightdm)" ]; then
                echo "O lightdm não está instalado."
            else
                # Remover o pacote lightdm
                apt remove lightdm -y

                echo "A remocao do lightdm foi concluida."
            fi
            ;;
        3)
            echo "Voltando ao menu anterior..."
            bash 00-menu-install-core.sh
            break
            ;;
        *)
            echo "Opcao invalida."
            ;;
    esac
done
