#!/bin/bash

while true; do
    echo "Selecione uma op��o:"
    echo "1. Instalar x11vnc"
    echo "2. Remover x11vnc"
    echo "3. Voltar"

    read -p "Op��o: " option

    case $option in
        1)
            # Verificar se o x11vnc j� est� instalado
            if [ -x "$(command -v x11vnc)" ]; then
                echo "O x11vnc j� est� instalado."
            else
                # Instalar o x11vnc
                sudo apt install x11vnc -y

                # Criar arquivo de servi�o do x11vnc
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

                # Recarregar configura��o do systemd
                sudo systemctl daemon-reload

                # Habilitar e iniciar o servi�o do x11vnc
                sudo systemctl enable x11vnc.service
                sudo systemctl start x11vnc.service

                # Definir a senha do VNC
                echo "4913" | sudo x11vnc -storepasswd /root/.vnc/passwd

                # Abrir porta 5900 no firewall
                sudo ufw allow 5900/tcp

                # Recarregar configura��o do firewall
                sudo ufw reload

                echo "A instala��o do x11vnc com senha foi conclu�da."
            fi
            ;;
        2)
            # Verificar se o x11vnc est� instalado
            if [ ! -x "$(command -v x11vnc)" ]; then
                echo "O x11vnc n�o est� instalado."
            else
                # Remover o x11vnc
                sudo systemctl stop x11vnc.service
                sudo systemctl disable x11vnc.service
                sudo apt remove x11vnc -y
                sudo rm /lib/systemd/system/x11vnc.service

                # Recarregar configura��o do systemd
                sudo systemctl daemon-reload

                # Recarregar configura��o do firewall
                sudo ufw reload

                echo "A remo��o do x11vnc foi conclu�da."
            fi
            ;;
        3)
            echo "Voltando ao menu anterior..."
            break
            ;;
        *)
            echo "Op��o inv�lida."
            ;;
    esac
done
