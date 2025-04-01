:: Oculta os comandos na tela
@echo off

:: =========================================================================================
:: Verificacao do repositório GIT

echo === Verificando se o repositório do GIT já foi iniciado ===

IF EXIST ".git" (
    echo GIT JA FOI INICIADO NESTA PASTA.
) ELSE (
    echo INICIALIZANDO REPOSITÓRIO GIT...
    git init
    git branch -M main
)

:: =========================================================================================
:: Adicionando arquivos e commit

echo === Adicionando arquivos no GIT .... ===
git add .
git commit -m "Atualizacao"

:: =========================================================================================
:: Conectar ao repositório remoto e enviar

echo === Enviando para o repositório remoto no GitHub... ===

REM Adiciona origin (ignora erro se já existir)
git remote add origin https://github.com/Zocarat/esp8266_wifi_relay.git 2>nul

REM Faz pull antes do push, caso o repositório remoto tenha conteúdo
git pull origin main --allow-unrelated-histories --no-edit


REM Envia os arquivos
git push -u origin main

echo === Processo concluído. Pressione qualquer tecla para sair... ===
pause >nul
