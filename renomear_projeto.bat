@echo off
:: =============================================
:: Script para renomear pastas de projeto
:: Fica na pasta acima das pastas de projetos
:: =============================================

echo.
echo === Pastas encontradas neste diretório ===
dir /ad /b
echo.

:: Pede o nome da pasta atual
set /p OLDNAME=Digite o nome da pasta que deseja renomear: 

:: Verifica se existe
if not exist "%OLDNAME%" (
    echo ERRO: Pasta "%OLDNAME%" nao encontrada.
    pause
    exit /b
)

:: Pede o novo nome
set /p NEWNAME=Digite o novo nome da pasta: 

:: Renomeia localmente
ren "%OLDNAME%" "%NEWNAME%"
echo Pasta renomeada para "%NEWNAME%".

:: Agora tenta renomear o repositório remoto (se .git existir)
IF EXIST "%NEWNAME%\.git" (
    cd "%NEWNAME%"
    echo Atualizando URL remota do Git...
    git remote set-url origin https://github.com/Zocarat/%NEWNAME%.git
    cd ..
)

echo Operacao finalizada.
pause
