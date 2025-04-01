@echo off

:: ================================================
:: CONFIGURACAO
SET USER=Zocarat
SET COMENTAR=1

:: ================================================
:: PEGAR O NOME DA PASTA
FOR %%I IN ("%CD%") DO SET "REPO=%%~nxI"

:: ================================================
:: INICIALIZAR GIT SE NECESSARIO
echo === Verificando se o repositorio do GIT ja foi iniciado ===

IF EXIST ".git" (
    echo GIT ja foi iniciado nesta pasta.
) ELSE (
    echo Inicializando repositorio GIT...
    git init
    git branch -M main
)

:: ================================================
:: ADICIONAR E COMMITAR
echo === Adicionando arquivos no GIT ===
git add .

IF "%COMENTAR%"=="1" (
    set /p MSG=Digite uma mensagem de commit: 
) ELSE (
    set MSG=Atualizacao automatica
)

git commit -m "%MSG%"

:: ================================================
:: CONECTAR E ENVIAR PRO GITHUB
echo === Enviando para o GitHub ===

git remote add origin https://github.com/%USER%/%REPO%.git 2>nul
git pull origin main --allow-unrelated-histories --no-edit
git push -u origin main

echo === Processo concluido. Pressione qualquer tecla para sair ===
pause >nul
