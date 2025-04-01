@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
cls

:: =======================================
:: MENU INICIAL
echo.
echo === GIT UPLOADER ===
echo Escolha o modo de commit:
echo [1] Commit automático (usa o nome da pasta)
echo [2] Commit com mensagem personalizada
echo [3] Cancelar
echo.
set /p OPCAO=Digite a opcao desejada [1-3]: 

IF "%OPCAO%"=="1" (
    SET COMENTAR=0
) ELSE IF "%OPCAO%"=="2" (
    SET COMENTAR=1
) ELSE (
    echo Operacao cancelada pelo usuario.
    pause
    exit /b
)

:: =======================================
:: CONFIGURAÇÕES
SET USER=Zocarat

:: =======================================
:: PEGAR O NOME DA PASTA COMO NOME DO REPOSITÓRIO
FOR %%I IN ("%CD%") DO SET "REPO=%%~nxI"
echo === Nome do repositório definido: %REPO%

:: =======================================
:: PROTEGER git_upload.bat via .gitignore
IF NOT EXIST ".gitignore" (
    echo Criando .gitignore...
    echo git_upload.bat> .gitignore
) ELSE (
    FINDSTR /I /C:"git_upload.bat" .gitignore >nul || (
        ======================================= echo Adicionando protecao ao .gitignore...
        echo git_upload.bat>> .gitignore
    )
)

:: =======================================
:: MOSTRAR STATUS DO GIT
echo.
echo ========================================== Verificando arquivos a serem comitados... ===
git status
echo.
pause

:: =======================================
:: INICIALIZAR GIT
IF EXIST ".git" (
    echo === Git ja foi iniciado nesta pasta.
) ELSE (
    echo === Inicializando repositório Git...
    git init || (
        echo [ERRO_01] Falha ao iniciar o Git.
        pause
        exit /b
    )
    git branch -M main
)

:: =======================================
:: ADICIONAR ARQUIVOS
echo === Adicionando arquivos ao Git...
git add . || (
    echo [ERRO_02] Falha ao adicionar arquivos.
    pause
    exit /b
)

:: =======================================
:: DEFINIR MENSAGEM DE COMMIT
IF "%COMENTAR%"=="1" (
    set /p MSG=Digite a mensagem de commit: 
) ELSE (
    set MSG=%REPO%
)
echo Mensagem de commit: "%MSG%"

:: =======================================
:: COMMIT
git commit -m "%MSG%" || (
    echo [ERRO_03] Falha ao realizar commit. Verifique se ha modificacoes.
    pause
    exit /b
)

:: =======================================
:: REMOTE ADD E PUSH INICIAL
echo === Conectando ao repositório remoto...

git remote add origin https://github.com/%USER%/%REPO%.git 2>nul

echo === Enviando arquivos para o GitHub...
git push -u origin main || (
    echo [ERRO_04] Falha ao enviar para o GitHub.
    pause
    exit /b
)

:: =======================================
:: PUSH
echo === Enviando arquivos para o GitHub...
git push -u origin main || (
    echo [ERRO_05] Falha ao enviar para o GitHub.
    pause
    exit /b
)

:: =======================================
:: FIM
echo.
echo === Processo concluido com sucesso! ===
echo === Script finalizado. Pressione qualquer tecla para sair. ===
pause >nul
