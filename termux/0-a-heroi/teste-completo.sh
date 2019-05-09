#!/bin/bash
#===============================================================================
#
#          FILE:  teste-completo.sh
#
#         USAGE:  TEST_PRIVATEKEY=http://url.com/privkey ./teste-completo.sh
#                 TEST_PRIVATEKEY=http://url.com/privkey TEST_NAME="Meu Nome" TEST_EMAIL="meuemail@example.org" ./teste-completo.sh
#
#   DESCRIPTION:  Script de testes, para uso interno, do artigo 
#                 "Do zero ao seu perfil profissional no GitHub usando apenas
#                 Smartphone Android e internet móvel" iniciado em 2019-05-07
#                 na comunidade de Facebook "Ligação Africa Brasil (Programação
#                 e informática)"
#
#       OPTIONS:  ---
#  REQUIREMENTS:  Android 5.0+
#                 Termux (https://termux.com/)
#                 curl (pkg install curl)
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Emerson Rocha, rocha@ieee.org
#       COMPANY:  EticaAI
#       LICENSE:  Public Domain
#       VERSION:  1.0
#       CREATED:  2019-05-09 00:36 BRT
#      REVISION:  ---
#===============================================================================

### Geracao do par de chave de eticaaibot (feita num Linux Ubuntu)
## ssh-keygen -t rsa -b 4096 -C "etica.of.a.ai@gmail.com"
# Destino, private key /alligo/code/eticaai/eticaai-shell-scripts/temp/id_rsa-eticaaibot
# Sem senha
# Destino, public key /alligo/code/eticaai/eticaai-shell-scripts/temp/id_rsa-eticaaibot.pub

### TESTE DE PRIVATEKEYS PREVIAMENTE EXISTENTES, inicio
## Por seguranca, ./teste-completo.sh tentara abortar se ja existem chaves
## neste sistema
SSL_LOCAL_FOLDER="$HOME/.ssh"
if [ -d "$SSL_LOCAL_FOLDER" ]; then
    echo 'ABORTADO! Diretorio $SSL_LOCAL_FOLDER já existe.'
    echo '  teste-completo.sh por seguranca so deveria rodar em intalacoes novas'
    exit 1
fi

TEST_PRIVATEKEY_LOCALFILE="$HOME/.ssh/id_rsa"
if [[ -f "$TEST_PRIVATEKEY_LOCALFILE" ]]; then
    echo "TEST_PRIVATEKEY_LOCALFILE: ja existe! abortando ($TEST_PRIVATEKEY_LOCALFILE)"
    exit 1
else
    echo "TEST_PRIVATEKEY_LOCALFILE: ainda nao existe ($TEST_PRIVATEKEY_LOCALFILE)"
fi
### TESTE DE PRIVATEKEYS PREVIAMENTE EXISTENTES, fim

### TESTE SE VARIAVEIS DE AMBIENTE FORAM DEFINIDAS, inicio
if [[ -z "${TEST_PRIVATEKEY}" ]]; then
  echo 'TEST_PRIVATEKEY indefinida. ./teste-completo.sh neste momento somente aceita URL já criada previamente'
  exit 1
else
  echo "TEST_PRIVATEKEY: ${TEST_PRIVATEKEY}"

  # TODO: checar se URL remota de chave privada parece realmente ser uma chave privada

  #if curl --output /dev/null --silent --head --fail "${TEST_PRIVATEKEY}"
  #then
  #    echo "TEST_PRIVATEKEY definida e parece ser valida"
  #else
  #    echo "TEST_PRIVATEKEY definida, mas parece nao ser URL valida, abortando"
  #    echo 1
  #fi
fi

if [[ -z "${TEST_NAME}" ]]; then
  TEST_NAME="EticaAI Bot"
  echo "TEST_NAME indefinido, usando padrao ${TEST_NAME}"
  #exit 1
else
  echo "TEST_NAME: ${TEST_NAME}"
fi
if [[ -z "${TEST_EMAIL}" ]]; then
  TEST_EMAIL="etica.of.a.ai@gmail.com"
  echo "TEST_NAME indefinido, usando padrao ${TEST_EMAIL}"
  #exit 1
else
  echo "TEST_NAME: ${TEST_EMAIL}"
fi
### TESTE SE VARIAVEIS DE AMBIENTE FORAM DEFINIDAS, fim

echo "Criando diretorio "
mkdir $SSL_LOCAL_FOLDER
curl http://example.com --output $TEST_PRIVATEKEY_LOCALFILE