#!/bin/bash

# Verificar se o usuário é root
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root ou usando o comando 'sudo'."
   exit 1
fi

while true; do
    echo "Selecione uma opção:"
    echo "1. Instalar"
#    echo "3. Remover"
    echo "2. Sair"

    read -p "Opção: " option

    case $option in
        1)
            while true; do
                echo "Instalar:"
                echo "  1. OpenSSH"
                echo "  2. Supervisor"
                echo "  3. xserver-xorg"
                echo "  4. xinit"
                echo "  5. x11vnc"
                echo "  6. DBeaver"
                echo "  7. PostgreSQL"
                echo "  8. PGAdmin4"
                echo "  9. VNC-Viewer"
                echo "  10. Google Chrome"
                echo "  00. Voltar"

                read -p "Opção: " installOption

                case $installOption in
                    1)
                        echo "Instalando OpenSSH..."
                        ./01_Openssh.sh
                        ;;
                    2)
                        echo "Instalando Supervisor..."
                        ./02_Supervisor.sh
                        ;;
                    3)
                        echo "Instalando xserver-xorg..."
                        ./03_xserver-xorg.sh
                        ;;
                    4)
                        echo "Instalando xinit..."
                        ./04_xinit.sh
                        ;;
                    5)
                        echo "Instalando x11vnc..."
                        ./05_x11vnc.sh
                        ;;
                    6)
                        echo "Instalando DBeaver..."
                        ./06_DBeaver.sh
                        ;;
                    7)
                        echo "Instalando PostgreSQL..."
                        ./07_PostgreSQL.sh
                        ;;
                    8)
                        echo "Instalando PGAdmin4..."
                        ./08_PGAdmin4.sh
                        ;;
                    9)
                        echo "Instalando VNC-Viewer..."
                        ./install_vncviewer.sh
                        ;;
                    10)
                        echo "Instalando Google Chrome..."
                        ./install_googlechrome.sh
                        ;;
                    00)
                        break
                        ;;
                    *)
                        echo "Opção inválida."
                        ;;
                esac
            done
            ;;
        3)
            while true; do
                echo "Remover:"
                echo "  01. OpenSSH"
                echo "  02. Supervisor"
                echo "  03. xserver-xorg"
                echo "  04. xinit"
                echo "  05. x11vnc"
                echo "  00. Voltar"

                read -p "Opção: " removeOption

                case $removeOption in
                    01)
                        echo "Removendo OpenSSH..."
                        ./remove_openssh.sh
                        ;;
                    02)
                        echo "Removendo Supervisor..."
                        ./remove_supervisor.sh
                        ;;
                    03)
                        echo "Removendo xserver-xorg..."
                        ./remove_xserver-xorg.sh
                        ;;
                    04)
                        echo "Removendo xinit..."
                        ./remove_xinit.sh
                        ;;
                    05)
                        echo "Removendo x11vnc..."
                        ./remove_x11vnc.sh
                        ;;
                    00)
                        break
                        ;;
                    *)
                        echo "Opção inválida."
                        ;;
                esac
            done
            ;;
        2)
            echo "Saindo..."
            break
            ;;
        *)
            echo "Opção inválida."
            ;;
    esac
done
