
:: A linha abaixo oculta os comandos na tela, pra deixar a execução mais limpa.
@echo off            



:: =========================================================================================

:: A FUNCAO ABAIXO FAZ A VERIFICAÇÃO PRA SABER SE O GIT JÁ FOI INICIADO


echo === Verificando se o repositório do GIT já foi iniciado ===

IF EXIST ".git" (
    echo GIT JA FOI INICIADO NESTA PASTA.
)  ELSE (
    echo INICIALIZANDO RESPOSITÓRIO GIT...
    git init

    :: O CODIGO ABAIXO É PRA GARANTIR QUE O NOME SEMPRE SERA MAIN
    git branch -M main
)


:: ========================================================================================

:: FUNCA ABAIXO É RESPONSAVEL POR REALIZAR O GIT


echo === Adicionando arquivos no GIT .... ===

:: git.add  >>> adiciona todos os arquivos modificados
git add .

:: git commit -m "..."    >>>> Salva as mudanças com uma mensagem
git commit -m " Atualização automática "


:: ========================================================================================

:: ESTA FUNCAO É RESPONSAVEL POR CONECTAR O GIT E REALIZAR O UPLOAD

echo === Enviando para o repositório remoto no GitHub... ===

REM Define a URL do repositório remoto
git remote add origin https://github.com/Zocarat/esp8266_wifi_relay.git

REM Faz push pro ramo principal (main)
git push -u origin main




:: OBS >>>>> O 2>nul evita erro se o remote origin já existir (ignora o aviso)



echo === Processo concluído. Pressione qualquer tecla para sair... ===
pause >nul












