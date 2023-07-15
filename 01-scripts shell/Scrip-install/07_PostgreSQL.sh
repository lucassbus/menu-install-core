#!/bin/bash

# Verificar se o usuario e root
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root ou usando o comando 'sudo'."
   exit 1
fi

while true; do
    echo "Selecione uma opcao:"
    echo "1. Instalar PostgreSQL"
    echo "2. Desinstalar PostgreSQL"
    echo "3. Criar banco de dados"
    echo "4. Criar usuario"
    echo "5. Liberar portas do Firewall"
	echo "6. Habilitar Acesso Remoto"
    echo "7. Voltar"

    read -p "Opcao: " option

    case $option in
        1)
            # Instalar o PostgreSQL
            echo "Instalando o PostgreSQL..."
            echo "deb http://apt.postgresql.org/pub/repos/apt \$(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
            wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
            apt-get update
            apt-get -y install postgresql

            # Definir a senha para o usuario postgres
            echo "Definindo senha para o usuario postgres..."
            echo "postgres:V1sul4166" | chpasswd

            # Configurar o diretorio de dados para /vol-postgresql
            echo "Configurando o diretorio de dados para /vol-postgresql..."
            sed -i "s|#data_directory = '/var/lib/postgresql/12/main'|data_directory = '/vol-postgresql'|g" /etc/postgresql/12/main/postgresql.conf

            # Criar o diretorio /vol-postgresql
            echo "Criando o diretorio /vol-postgresql..."
            mkdir /vol-postgresql
            chown postgres:postgres /vol-postgresql
            chmod 700 /vol-postgresql

            # Mover os dados existentes para /vol-postgresql
            echo "Movendo os dados existentes para /vol-postgresql..."
            systemctl stop postgresql
            rsync -av /var/lib/postgresql/ /vol-postgresql/
            mv /var/lib/postgresql /var/lib/postgresql.old
            ln -s /vol-postgresql /var/lib/postgresql
            chown -R postgres:postgres /vol-postgresql

            # Iniciar o servico do PostgreSQL
            echo "Iniciando o servico do PostgreSQL..."
            systemctl start postgresql

            # Habilitar o servico do PostgreSQL para iniciar na inicializacao do sistema
            echo "Habilitando o servico do PostgreSQL na inicializacao do sistema..."
            systemctl enable postgresql

            # Verificar a versao do PostgreSQL instalada
            echo "Versao do PostgreSQL:"
            psql --version

            # Exibir status do servico do PostgreSQL
            echo "Status do servico do PostgreSQL:"
            systemctl status postgresql

            echo "A instalacao do PostgreSQL foi concluida."
            ;;
        2)
            # Desinstalar o PostgreSQL
            echo "Desinstalando o PostgreSQL..."
            systemctl stop postgresql
            apt-get -y purge postgresql*
            apt-get -y autoremove
            rm -rf /etc/postgresql
            rm -rf /vol-postgresql

            echo "A remocao do PostgreSQL foi concluida."
            ;;
        3)
            # Verificar se o banco de dados ja existe
            if sudo -u postgres psql -lqt | cut -d \| -f 1 | grep -qw restaurante; then
                echo "O banco de dados 'restaurante' ja existe."
            else
                # Criar banco de dados no PostgreSQL
                echo "Criando o banco de dados no PostgreSQL..."
                sudo -u postgres createdb restaurante

                echo "O banco de dados foi criado."
            fi
            ;;
        4)
            # Verificar se o usuario ja existe
            if sudo -u postgres psql -c "SELECT * FROM pg_user WHERE usename = 'vmix';" | grep -q "1 row"; then
                echo "O usuario 'vmix' ja existe."
            else
                # Criar usuario no PostgreSQL
                read -s -p "Digite a senha para o usuario vmix: " user_password
                echo
                echo "Criando o usuario no PostgreSQL..."
                sudo -u postgres psql -c "CREATE USER vmix WITH PASSWORD '${user_password}' SUPERUSER CREATEDB CREATEROLE;"

                echo "O usuario foi criado."
            fi
            ;;
        5)
            # Liberar as portas do firewall para o PostgreSQL
            echo "Liberando as portas do firewall para o PostgreSQL..."
            ufw allow 5432

            echo "As portas do firewall foram liberadas para o PostgreSQL."
            ;;
        6)
            # Habilitar o acesso remoto no PostgreSQL
            echo "Habilitando o acesso remoto no PostgreSQL..."
            sed -i "s|#listen_addresses = 'localhost'|listen_addresses = '*'|g" /etc/postgresql/12/main/postgresql.conf
            echo "host    all    all    0.0.0.0/0    md5" >> /etc/postgresql/12/main/pg_hba.conf

            # Reiniciar o servico do PostgreSQL
            systemctl restart postgresql

            echo "O acesso remoto foi habilitado no PostgreSQL."
            ;;
        7)
            echo "Voltando ao menu principal..."
            break
            ;;
        *)
            echo "Opcao invalida."
            ;;
    esac
done
