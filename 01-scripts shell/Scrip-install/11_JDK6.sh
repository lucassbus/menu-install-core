#!/bin/bash

# Criar diretório de instalação
mkdir -p /vmix/ambiente

# Acessar o diretório de instalação
cd /vmix/ambiente

# Baixar o OpenJDK 6
wget https://github.com/AdoptOpenJDK/openjdk6-binaries/releases/download/jdk6u41-b00/OpenJDK6U-jdk_x64_linux_6u41b00.tar.gz

# Extrair o arquivo tar.gz
tar -xzf OpenJDK6U-jdk_x64_linux_6u41b00.tar.gz

# Remover o arquivo tar.gz
rm OpenJDK6U-jdk_x64_linux_6u41b00.tar.gz

# Renomear o diretório extraído para um nome mais amigável
mv jdk6u41-b00 jdk6

# Configurar as variáveis de ambiente
echo "export JAVA_HOME=/vmix/ambiente/jdk6" >> ~/.bashrc
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc

# Carregar as variáveis de ambiente no terminal atual
source ~/.bashrc

# Verificar a instalação do JDK 6
java -version
