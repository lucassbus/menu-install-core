#!/bin/bash

while true; do
    echo "Selecione uma opção:"
    echo "1. Instalar x11vnc"
    echo "2. Remover x11vnc"
    echo "3. Voltar"

    read -p "Opção: " option

    case $option in
        1)
            # Verificar se o x11vnc já está instalado
            if [ -x "$(command -v x11vnc)" ]; then
                echo "O x11vnc já está instalado."
            else
                # Instalar o x11vnc
                sudo apt install x11vnc -y

                # Criar arquivo de serviço do x11vnc
                sudo tee /lib/systemd/system/x11vnc.service > /dev/null <<EOT
[Unit]
Description=x11vnc service
After=display-manager.service network.target syslog.target

[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -display :0 -auth guess -rfbauth /root/.vnc/passwd -noxrecord -xkb -repeat -shared -bg
ExecStop=/usr/bin/killall x11vnc
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOT

                # Recarregar configuração do systemd
                sudo systemctl daemon-reload

                # Habilitar e iniciar o serviço do x11vnc
                sudo systemctl enable x11vnc.service
                sudo systemctl start x11vnc.service

                # Definir a senha do VNC
                echo "4913" | sudo x11vnc -storepasswd /root/.vnc/passwd

                # Abrir porta 5900 no firewall
                sudo ufw allow 5900/tcp

                # Recarregar configuração do firewall
                sudo ufw reload

                echo "A instalação do x11vnc com senha foi concluída."
            fi
            ;;
        2)
            # Verificar se o x11vnc está instalado
            if [ ! -x "$(command -v x11vnc)" ]; then
                echo "O x11vnc não está instalado."
            else
                # Remover o x11vnc
                sudo systemctl stop x11vnc.service
                sudo systemctl disable x11vnc.service
                sudo apt remove x11vnc -y
                sudo rm /lib/systemd/system/x11vnc.service

                # Recarregar configuração do systemd
                sudo systemctl daemon-reload

                # Recarregar configuração do firewall
                sudo ufw reload

                echo "A remoção do x11vnc foi concluída."
            fi
            ;;
        3)
            echo "Voltando ao menu anterior..."
            break
            ;;
        *)
            echo "Opção inválida."
            ;;
    esac
done
