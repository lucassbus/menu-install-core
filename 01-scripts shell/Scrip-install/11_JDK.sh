#!/bin/bash

# Verificar se o usu�rio � root
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root ou usando o comando 'sudo'."
   exit 1
fi

# Criar o diret�rio de instala��o
install_dir="/visualkitchen/ambiente"
mkdir -p $install_dir
cd $install_dir

# Baixar o JDK 8
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/8u301-b09/d3c52aa6bfa54d3ca74e617f18309292/jdk-8u301-linux-x64.tar.gz"

# Extrair o arquivo
tar -xf jdk-8u301-linux-x64.tar.gz

# Definir as vari�veis de ambiente
echo "export JAVA8_HOME=$install_dir/jdk1.8.0_301" >> ~/.bashrc
echo "export PATH=\$JAVA8_HOME/bin:\$PATH" >> ~/.bashrc

# Carregar as vari�veis de ambiente
source ~/.bashrc

# Verificar a vers�o do JDK instalada
java -version

echo "A instala��o do JDK 8 foi conclu�da."
