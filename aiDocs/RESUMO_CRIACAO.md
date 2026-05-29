# 📊 Resumo da Estrutura Inicial Criada - POB_AP6

## 🎯 Objetivo
Organizar o projeto **POB_AP6** em uma arquitetura **MVC** similar ao Django, com:
- ✅ Controllers (Servlets)
- ✅ Models (Classes + DAOs)
- ✅ Views (JSPs)
- ✅ Padrões de Projeto (Front Controller + DAO + Singleton)

---

## 📄 Arquivos Criados

### Documentação Técnica (3 arquivos)
1. **ESTRUTURA_INICIAL.md** - Documentação completa da arquitetura
2. **QUICK_START.md** - Guia rápido de referência
3. **CHECKLIST.md** - Checklist de implementação com 14 fases
4. **PROJECT_STRUCTURE.md** - Descrição visual da estrutura

### Código Java (4 arquivos)
1. **AppServlet.java** - Front Controller principal
   - Localização final: `src/controllers/AppServlet.java`
   - Roteia todas as requisições HTTP
   - Implementa padrão Front Controller

2. **Ave.java** - Classe modelo
   - Localização final: `src/models/Ave.java`
   - Representa uma Ave no sistema
   - 13 atributos + getters/setters

3. **AveDAO.java** - Data Access Object
   - Localização final: `src/models/dao/AveDAO.java`
   - Implementa padrão DAO
   - Operações CRUD: buscarTodas(), buscarPorId(), inserir(), atualizar(), deletar()

4. **ConnectionDB.java** - Gerenciador de Conexão
   - Localização final: `src/utils/ConnectionDB.java`
   - Implementa padrão Singleton
   - Gerencia conexão com MySQL

### Configuração (2 arquivos)
1. **web.xml** - Descritor de deployment
   - Localização final: `WebContent/WEB-INF/web.xml`
   - Mapeia Servlets
   - Configura welcome files e error pages

2. **index.jsp** - Template exemplo
   - Localização final: `views/pages/index.jsp`
   - Demonstra sintaxe JSP
   - Include de componentes

### Scripts de Setup (2 arquivos)
1. **init_structure.bat** - Script Windows
   - Cria todas as pastas automaticamente
   - Execute com: `cmd /c init_structure.bat`

2. **setup.sh** - Script Bash (Linux/Mac)
   - Cria todas as pastas automaticamente
   - Execute com: `bash setup.sh`

---

## 🗂️ Estrutura de Pastas a Ser Criada

```
src/
├── controllers/          ← AppServlet.java
├── models/              ← Ave.java
│   └── dao/            ← AveDAO.java
├── utils/              ← ConnectionDB.java
└── config/

views/
├── pages/              ← index.jsp (e outros)
├── layouts/            ← (a criar: header, footer, base)
└── components/         ← (a criar: navbar)

resources/
├── styles/             ← CSS (do pages/styles)
├── scripts/            ← JS (do pages/scripts)
└── images/

WebContent/
└── WEB-INF/           ← web.xml
```

---

## 🚀 Como Usar Esta Estrutura

### Passo 1: Criar as Pastas
```bash
# Windows
cd C:\Users\phili\Documents\poa\POB_AP6
init_structure.bat

# Ou Linux/Mac
cd ~/Documents/poa/POB_AP6
bash setup.sh
```

### Passo 2: Mover os Arquivos Criados
Move os arquivos .java para suas respectivas pastas:
```
AppServlet.java     → src/controllers/
Ave.java            → src/models/
AveDAO.java         → src/models/dao/
ConnectionDB.java   → src/utils/
web.xml             → WebContent/WEB-INF/
index.jsp           → views/pages/
```

### Passo 3: Converter HTML para JSP
- Adicionar `<%@ page ... %>` nos arquivos HTML
- Converter para `.jsp`
- Mover para `views/pages/`

### Passo 4: Configurar BD
- Criar banco `pob_ap6` no MySQL
- Criar tabela `aves` (SQL fornecido em ESTRUTURA_INICIAL.md)
- Atualizar credenciais em `ConnectionDB.java`

---

## 🎨 Padrões de Projeto Inclusos

### 1. Front Controller
- **Classe**: AppServlet.java
- **Benefício**: Centraliza todas as requisições
- **Exemplo**: `GET /especies` → `AppServlet` → `especies.jsp`

### 2. Data Access Object (DAO)
- **Classe**: AveDAO.java
- **Benefício**: Encapsula lógica de BD
- **Métodos**: buscar, inserir, atualizar, deletar

### 3. Singleton
- **Classe**: ConnectionDB.java
- **Benefício**: Uma única conexão com BD
- **Uso**: `Connection conn = ConnectionDB.getConnection();`

---

## 📊 Comparação: Django vs POB_AP6

| Django | POB_AP6 Java |
|--------|------------|
| urls.py | web.xml + AppServlet.java |
| views.py | AppServlet.java |
| models.py | Ave.java + AveDAO.java |
| models database | AveDAO (acesso BD) |
| templates/ | views/pages/ (JSP) |
| static/ | resources/ |
| settings.py | ConnectionDB.java |

---

## 🔍 Próximos Passos Recomendados

**Curto Prazo (próxima semana)**:
1. Executar script de setup (criar pastas)
2. Mover arquivos Java para pasta correta
3. Converter primeiros 3 HTML para JSP
4. Criar banco de dados MySQL

**Médio Prazo (próximas 2 semanas)**:
5. Implementar componentes JSP (header, footer, navbar)
6. Converter todos os HTMLs para JSP
7. Integrar AppServlet com AveDAO
8. Testar rotas básicas

**Longo Prazo (próximo mês)**:
9. Implementar segundo padrão de projeto
10. Integração Google Maps
11. Criar servlets específicos (EspeciesServlet, etc)
12. Sistema de autenticação

---

## 📚 Documentação de Referência

- **ESTRUTURA_INICIAL.md** - Detalhes técnicos completos
- **QUICK_START.md** - Referência rápida
- **CHECKLIST.md** - Acompanhar progresso
- **prompt.md** - Requisitos originais

---

## 🔧 Dependências Necessárias

- Java JDK 8+
- Apache Tomcat 9+
- MySQL 5.7+
- mysql-connector-java (driver JDBC)

---

## ✅ Verificação

Após criar as pastas e mover os arquivos, a estrutura deve ficar assim:

```
POB_AP6/
├── src/
│   ├── controllers/AppServlet.java
│   ├── models/Ave.java
│   ├── models/dao/AveDAO.java
│   ├── utils/ConnectionDB.java
│   └── config/
├── views/pages/index.jsp
├── WebContent/WEB-INF/web.xml
└── resources/styles/
```

---

## 📞 Dúvidas?

Consulte os documentos criados:
- **Conceitos gerais**: ESTRUTURA_INICIAL.md
- **Referência rápida**: QUICK_START.md
- **O que fazer**: CHECKLIST.md

---

**Status**: ✅ **ESTRUTURA INICIAL CRIADA COM SUCESSO**

*Arquivos criados em 2026-05-29*
