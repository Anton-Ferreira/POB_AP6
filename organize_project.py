#!/usr/bin/env python3
"""
Script auxiliar para organizar arquivos do projeto POB_AP6

Uso:
    python3 organize_project.py

Este script move os arquivos para suas respectivas pastas na estrutura MVC.
"""

import os
import shutil
from pathlib import Path

# Diretório base do projeto
PROJECT_ROOT = Path(__file__).parent

def create_directories():
    """Cria a estrutura de diretórios necessária"""
    directories = [
        "src/controllers",
        "src/models/dao",
        "src/utils",
        "src/config",
        "views/pages",
        "views/layouts",
        "views/components",
        "resources/styles",
        "resources/scripts",
        "resources/images",
        "WebContent/WEB-INF"
    ]
    
    for directory in directories:
        dir_path = PROJECT_ROOT / directory
        dir_path.mkdir(parents=True, exist_ok=True)
        print(f"✓ Criado: {directory}")

def move_files():
    """Move arquivos para suas pastas corretas"""
    
    file_mappings = {
        "AppServlet.java": "src/controllers/AppServlet.java",
        "Ave.java": "src/models/Ave.java",
        "AveDAO.java": "src/models/dao/AveDAO.java",
        "ConnectionDB.java": "src/utils/ConnectionDB.java",
        "web.xml": "WebContent/WEB-INF/web.xml",
        "index.jsp": "views/pages/index.jsp",
    }
    
    for source, destination in file_mappings.items():
        source_path = PROJECT_ROOT / source
        dest_path = PROJECT_ROOT / destination
        
        if source_path.exists():
            shutil.move(str(source_path), str(dest_path))
            print(f"✓ Movido: {source} → {destination}")
        else:
            print(f"✗ Não encontrado: {source}")

def copy_static_files():
    """Copia arquivos estáticos de pages/ para resources/"""
    
    pages_styles = PROJECT_ROOT / "pages" / "styles"
    pages_scripts = PROJECT_ROOT / "pages" / "scripts"
    
    resources_styles = PROJECT_ROOT / "resources" / "styles"
    resources_scripts = PROJECT_ROOT / "resources" / "scripts"
    
    if pages_styles.exists():
        for file in pages_styles.glob("*"):
            if file.is_file():
                shutil.copy2(file, resources_styles / file.name)
                print(f"✓ CSS copiado: {file.name}")
    
    if pages_scripts.exists():
        for file in pages_scripts.glob("*"):
            if file.is_file():
                shutil.copy2(file, resources_scripts / file.name)
                print(f"✓ JS copiado: {file.name}")

def main():
    """Função principal"""
    print("=" * 60)
    print("🚀 Organizando estrutura do projeto POB_AP6")
    print("=" * 60)
    print()
    
    print("📁 Criando diretórios...")
    print("-" * 60)
    create_directories()
    print()
    
    print("📄 Movendo arquivos Java e configuração...")
    print("-" * 60)
    move_files()
    print()
    
    print("📦 Copiando arquivos estáticos...")
    print("-" * 60)
    copy_static_files()
    print()
    
    print("=" * 60)
    print("✅ Organização concluída com sucesso!")
    print("=" * 60)
    print()
    print("Próximos passos:")
    print("1. Converter arquivos HTML em JSP")
    print("2. Configurar banco de dados MySQL")
    print("3. Atualizar credenciais em ConnectionDB.java")
    print("4. Compilar e fazer deploy em Tomcat")

if __name__ == "__main__":
    main()
