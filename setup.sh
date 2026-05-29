#!/bin/bash
# Script para criar a estrutura inicial do projeto POB_AP6
# Execute este script na raiz do projeto

cd "$(dirname "$0")"

echo "Criando estrutura do projeto POB_AP6..."
echo ""

# Criar diretórios da aplicação
mkdir -p src/controllers
mkdir -p src/models/dao
mkdir -p src/utils
mkdir -p src/config

# Criar diretórios de views (JSP)
mkdir -p views/pages
mkdir -p views/layouts
mkdir -p views/components

# Criar diretórios de recursos estáticos
mkdir -p resources/styles
mkdir -p resources/scripts
mkdir -p resources/images

# Criar diretório do deploy
mkdir -p WebContent/WEB-INF

echo "✓ Diretórios criados com sucesso!"
echo ""
echo "Estrutura criada:"
tree -L 3 2>/dev/null || find . -type d | sort | sed 's|^\./||' | awk '
  BEGIN { FS="/" }
  {
    depth = NF - 1
    if (depth == 0) next
    printf "%s", ""
    for (i = 1; i < depth; i++) printf "  "
    printf "├── %s\n", $NF
  }
'

echo ""
echo "Próximos passos:"
echo "1. Converter arquivos HTML em JSP e mover para views/pages/"
echo "2. Mover estilos CSS para resources/styles/"
echo "3. Mover scripts JS para resources/scripts/"
echo "4. Criar classes Java em src/"
echo "5. Configurar web.xml em WebContent/WEB-INF/"
