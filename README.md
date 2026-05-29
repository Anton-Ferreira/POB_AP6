# 📑 Índice de Documentação - POB_AP6

## 📌 Leia Primeiro

1. **[RESUMO_CRIACAO.md](RESUMO_CRIACAO.md)** ⭐
   - Visão geral do que foi criado
   - Lista de todos os arquivos
   - Status do projeto

2. **[QUICK_START.md](QUICK_START.md)** ⚡
   - Guia rápido de referência
   - Próximos passos imediatos
   - Estrutura simplificada

---

## 📚 Documentação Técnica Completa

### Arquitetura e Estrutura
- **[ESTRUTURA_INICIAL.md](ESTRUTURA_INICIAL.md)** - Documentação técnica completa
  - Organização MVC detalhada
  - Explicação de cada componente
  - Como configurar e usar
  - Convenções adotadas

- **[ARQUITETURA_DIAGRAMA.md](ARQUITETURA_DIAGRAMA.md)** - Diagramas visuais
  - Fluxo de requisição HTTP
  - Estrutura de pastas
  - Roteamento de URLs
  - Padrões de projeto

- **[PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)** - Visualização de estrutura
  - Árvore de diretórios
  - Descrição de padrões

### Implementação
- **[CHECKLIST.md](CHECKLIST.md)** - Checklist de 14 fases
  - Próximos passos em ordem
  - 4 fases já marcadas como concluídas
  - Acompanhe o progresso do projeto

---

## 💻 Código-Fonte Criado

### Java (4 arquivos)
| Arquivo | Tipo | Localização Final | Função |
|---------|------|------------------|--------|
| `AppServlet.java` | Controller | `src/controllers/` | Front Controller |
| `Ave.java` | Model | `src/models/` | Classe modelo |
| `AveDAO.java` | DAO | `src/models/dao/` | Acesso BD |
| `ConnectionDB.java` | Utility | `src/utils/` | Gerenciador conexão |

### Configuração (2 arquivos)
| Arquivo | Tipo | Localização Final | Função |
|---------|------|------------------|--------|
| `web.xml` | Config | `WebContent/WEB-INF/` | Deployment descriptor |
| `index.jsp` | View | `views/pages/` | Template exemplo |

### Utilitários de Automação (3 arquivos)
| Arquivo | Tipo | Função |
|---------|------|--------|
| `init_structure.bat` | Script Windows | Cria pastas automaticamente |
| `setup.sh` | Script Bash | Cria pastas (Linux/Mac) |
| `organize_project.py` | Script Python | Move arquivos para pastas certas |

---

## 🚀 Como Começar

### 1️⃣ Criar Estrutura de Pastas
```bash
# Windows
cmd /c init_structure.bat

# Linux/Mac
bash setup.sh

# Ou com Python (multiplataforma)
python3 organize_project.py
```

### 2️⃣ Mover Arquivos Java
Mova para as pastas respectivas:
- `AppServlet.java` → `src/controllers/`
- `Ave.java` → `src/models/`
- `AveDAO.java` → `src/models/dao/`
- `ConnectionDB.java` → `src/utils/`
- `web.xml` → `WebContent/WEB-INF/`
- `index.jsp` → `views/pages/`

### 3️⃣ Configurar Banco de Dados
- Criar banco: `pob_ap6`
- Criar tabela: `aves` (SQL em ESTRUTURA_INICIAL.md)
- Atualizar credenciais em `ConnectionDB.java`

### 4️⃣ Converter HTML → JSP
- Adicionar `<%@ page ... %>` directives
- Converter para `.jsp`
- Mover para `views/pages/`

### 5️⃣ Deploy
- Compilar com javac
- Criar WAR
- Deploy em Tomcat

---

## 📊 Status do Projeto

```
✅ Fase 1: Estrutura Inicial (CONCLUÍDA)
   ├─ [x] Definir arquitetura MVC
   ├─ [x] Criar Front Controller
   ├─ [x] Criar classe modelo
   ├─ [x] Criar DAO
   ├─ [x] Criar utilitários
   ├─ [x] Criar template exemplo
   ├─ [x] Criar web.xml
   └─ [x] Documentar estrutura

⏳ Fase 2-14: PENDENTES
   └─ Veja CHECKLIST.md para detalhes
```

---

## 🎯 Arquivo de Cada Arquivo Criado

```
RESUMO_CRIACAO.md              ← Comece aqui!
│
├─ QUICK_START.md              ← Referência rápida
│
├─ ESTRUTURA_INICIAL.md        ← Documentação técnica completa
│
├─ ARQUITETURA_DIAGRAMA.md     ← Diagramas visuais
│
├─ PROJECT_STRUCTURE.md        ← Visualização da estrutura
│
├─ CHECKLIST.md                ← Acompanhe o progresso
│
├─ Código Java:
│  ├─ AppServlet.java          ← Front Controller
│  ├─ Ave.java                 ← Modelo
│  ├─ AveDAO.java              ← DAO (Padrão de Projeto)
│  └─ ConnectionDB.java        ← Utilitário (Padrão Singleton)
│
├─ Configuração:
│  ├─ web.xml                  ← Deployment descriptor
│  └─ index.jsp                ← Template exemplo
│
└─ Scripts de Automação:
   ├─ init_structure.bat       ← Windows
   ├─ setup.sh                 ← Linux/Mac
   └─ organize_project.py      ← Python (multiplataforma)
```

---

## 🔍 Navegação Rápida

### Preciso entender...
- **...a arquitetura geral?** → `ESTRUTURA_INICIAL.md`
- **...como as requisições funcionam?** → `ARQUITETURA_DIAGRAMA.md`
- **...o que fazer agora?** → `QUICK_START.md`
- **...onde colocar cada arquivo?** → `RESUMO_CRIACAO.md`
- **...qual é o próximo passo?** → `CHECKLIST.md`

### Preciso fazer...
- **...criar as pastas** → Execute `init_structure.bat` ou `setup.sh`
- **...mover os arquivos** → Use `organize_project.py`
- **...converter HTML em JSP** → Ver seção em `ESTRUTURA_INICIAL.md`
- **...configurar o BD** → Ver seção em `ESTRUTURA_INICIAL.md`
- **...adicionar segundo padrão** → Ver Fase 9 em `CHECKLIST.md`

---

## 📝 Padrões de Projeto Usados

1. ✅ **Front Controller** (AppServlet.java)
2. ✅ **Data Access Object** (AveDAO.java)
3. ✅ **Singleton** (ConnectionDB.java)
4. ⏳ (Segundo padrão a definir - Fase 9)

---

## 🔗 Comparação: Django vs POB_AP6

| Aspecto | Django | POB_AP6 Java |
|---------|--------|------------|
| Roteamento | urls.py | web.xml + AppServlet |
| Controlador | views.py | AppServlet.java |
| Modelo | models.py | Ave.java |
| Acesso BD | ORM | AveDAO.java |
| Templates | templates/ | views/pages/ (JSP) |
| Estáticos | static/ | resources/ |

---

## 🎓 Próximas Lições

Depois de concluir a Fase 1, estude:
1. **Servlets e JSP** - Como funcionam juntos
2. **JDBC** - Conexão com BD
3. **Padrões de Projeto** - Outros padrões além dos 3 já usados
4. **Segurança** - SQL Injection, XSS, etc
5. **Testes** - JUnit para testes unitários

---

## 💡 Dicas Úteis

1. **Sempre use `${pageContext.request.contextPath}`** em links JSP
2. **Sempre use `PreparedStatement`** para queries (evita SQL Injection)
3. **Implemente validação** em Controller antes de chamar Model
4. **Use try-catch** para exceções SQL

---

## ❓ FAQ

**P: Por que separar em src/ e views/?**
R: Seguindo padrão Django - code source separado de templates

**P: Por que usar DAO?**
R: Encapsula lógica de BD, facilita manutenção e testes

**P: Por que Singleton em ConnectionDB?**
R: Garante uma única conexão, economiza recursos

**P: Preciso de framework?**
R: Não necessariamente. Este projeto usa Servlets puro, que já é suficiente.

---

## 📞 Suporte

Consulte a documentação correspondente:
- **Dúvidas técnicas** → `ESTRUTURA_INICIAL.md`
- **Visão geral** → `RESUMO_CRIACAO.md`
- **Diagramas** → `ARQUITETURA_DIAGRAMA.md`
- **O que fazer** → `CHECKLIST.md`

---

## 📅 Status Atual

**Data de Criação**: 2026-05-29
**Fase Atual**: Fase 1 (Estrutura Inicial) - CONCLUÍDA ✅
**Próxima Fase**: Fase 2 (Organização de Pastas)

---

**🎉 Estrutura inicial criada com sucesso!**

Comece lendo: **RESUMO_CRIACAO.md** → **QUICK_START.md** → **CHECKLIST.md**
