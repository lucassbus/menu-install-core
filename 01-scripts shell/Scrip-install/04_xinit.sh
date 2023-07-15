#!/bin/bash

while true; do
    echo "Selecione uma opcao:"
    echo "1. Instalar xinit"
    echo "2. Remover xinit"
    echo "3. Voltar"

    read -p "Opcao: " option

    case $option in
        1)
            # Verificar se o xinit ja esta instalado
            if [ -x "$(command -v xinit)" ]; then
                echo "O xinit ja esta instalado."
            else
                # Instalar o pacote xinit
                apt install xinit -y

                echo "A instalacao do xinit foi concluida com sucesso."
            fi
            ;;
        2)
            # Verificar se o xinit esta instalado
            if [ ! -x "$(command -v xinit)" ]; then
                echo "O xinit nao esta instalado."
            else
                # Remover o pacote xinit
                apt remove xinit -y

                echo "A remocao do xinit foi concluida."
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
