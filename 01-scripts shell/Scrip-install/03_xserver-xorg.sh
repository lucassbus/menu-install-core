#!/bin/bash

while true; do
    echo "Selecione uma opcao:"
    echo "1. Instalar xserver-xorg"
    echo "2. Remover xserver-xorg"
    echo "3. Voltar"

    read -p "Opcao: " option

    case $option in
        1)
            # Verificar se o xserver-xorg já está instalado
            if [ -x "$(command -v Xorg)" ]; then
                echo "O xserver-xorg ja esta instalado."
            else
                # Instalar o servidor X11
                echo "Instalando xserver-xorg..."
                apt install xserver-xorg -y

                echo "A instalacao do xserver-xorg foi concluida com sucesso."
            fi
            ;;
        2)
            # Verificar se o xserver-xorg está instalado
            if [ ! -x "$(command -v Xorg)" ]; then
                echo "O xserver-xorg nao esta instalado."
            else
                # Remover o xserver-xorg
                echo "Removendo xserver-xorg..."
                apt remove xserver-xorg -y

                echo "A remocao do xserver-xorg foi concluida."
            fi
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
