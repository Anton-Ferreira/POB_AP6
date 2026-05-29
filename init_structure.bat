@echo off
REM Script para criar estrutura inicial do projeto POB_AP6

cd /d "C:\Users\phili\Documents\poa\POB_AP6"

REM Criar diretórios
mkdir src\controllers 2>nul
mkdir src\models\dao 2>nul
mkdir src\utils 2>nul
mkdir src\config 2>nul
mkdir resources\styles 2>nul
mkdir resources\scripts 2>nul
mkdir resources\images 2>nul
mkdir views\pages 2>nul
mkdir views\layouts 2>nul
mkdir views\components 2>nul
mkdir WebContent\WEB-INF 2>nul

echo.
echo ===== Estrutura do Projeto Criada com Sucesso =====
echo.
echo Diretórios criados:
dir /s /b /ad | find /v "^."

echo.
echo Próximos passos:
echo 1. Converter arquivos HTML para JSP na pasta views/pages
echo 2. Mover estilos e scripts para resources/
echo 3. Implementar classes Java nos arquivos src/

pause
