@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: ===jhj====================================
:: CONFIGURAÇÕES
SET USER=Zocarat
SET COMENTAR=1
SET DESTINO_DIR=%CD%\updater_git

echo === Iniciando processo de upload Git ===
echo Diretório atual: %CD%
echo Subpasta alvo: %DESTINO_DIR%
echo.

:: =======================================
:: VERIFICAR SE A SUBPASTA updater_git EXISTE
IF NOT EXIST "%DESTINO_DIR%\" (
    echo [ERRO_01] A pasta "updater_git" nao foi encontrada dentro de %CD%
    pause
    exit /b
)

:: =======================================
:: ENTRAR NA PASTA updater_git (nível 2)
cd "%DESTINO_DIR%" || (
    echo [ERRO_02] Falha ao entrar na subpasta updater_git
    pause
    exit /b
)

:: PEGAR O NOME DA PASTA COMO NOME DO REPO
FOR %%I IN ("%CD%") DO SET "REPO=%%~nxI"
echo === Nome do repositório definido: %REPO%

:: =======================================
:: VERIFICAR SE TEM ARQUIVOS VÁLIDOS DE PROJETO
SET "CHAVEENCONTRADA=0"
SET "TIPOS=.ino .c .cpp .py .java .txt README.md"

FOR %%E IN (%TIPOS%) DO (
    IF EXIST "*%%E" (
        SET CHAVEENCONTRADA=1
    )
)

IF "!CHAVEENCONTRADA!"=="0" (
    echo [ERRO_03] A pasta "%CD%" nao contem arquivos de projeto reconhecidos (*.py, *.cpp, etc).
    pause
    exit /b
)

:: =======================================
:: INICIALIZAR GIT
IF EXIST ".git" (
    echo === Git ja foi iniciado nesta pasta.
) ELSE (
    echo === Inicializando repositório Git...
    git init || (
        echo [ERRO_04] Falha ao iniciar o Git.
        pause
        exit /b
    )
    git branch -M main
)

:: =======================================
:: ADICIONAR ARQUIVOS
echo === Adicionando arquivos ao Git...
git add . || (
    echo [ERRO_05] Falha ao adicionar arquivos.
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
    echo [ERRO_06] Falha ao realizar commit. Verifique se ha modificacoes.
    pause
    exit /b
)

:: =======================================
:: REMOTE ADD E PULL
echo === Conectando ao repositório remoto...
git remote add origin https://github.com/%USER%/%REPO%.git 2>nul

git pull origin main --allow-unrelated-histories --no-edit || (
    echo [ERRO_07] Falha ao sincronizar com o repositório remoto.
    pause
    exit /b
)

:: =======================================
:: PUSH
echo === Enviando arquivos para o GitHub...
git push -u origin main || (
    echo [ERRO_08] Falha ao enviar para o GitHub.
    pause
    exit /b
)

:: =======================================
:: FIM
echo.
echo === Processo concluido com sucesso! ===
echo === Script finalizado. Pressione qualquer tecla para sair. ===
pause >nul
