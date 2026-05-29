# 🚀 Guia Rápido - POB_AP6

## Estrutura Criada em 3 Componentes

### 1️⃣ **Controllers** (Controladores)
📄 `AppServlet.java` - Processa requisições HTTP e roteia para views

```
GET /especies → especies.jsp
GET /cuidados → cuidados.jsp
GET /wiki → wiki.jsp
GET /mapa → mapa.jsp
```

### 2️⃣ **Models** (Modelos de Dados)
📄 `Ave.java` - Classe que representa uma ave
📄 `AveDAO.java` - Operações CRUD no banco de dados

```java
// Exemplos de uso:
List<Ave> todas = aveDAO.buscarTodas();
Ave ave = aveDAO.buscarPorId(1);
aveDAO.inserir(novaAve);
```

### 3️⃣ **Views** (Apresentação - JSP)
📄 `index.jsp` - Template exemplo

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
```

---

## 📂 Para Estruturar Corretamente

### Windows (CMD/PowerShell)
```bash
cd C:\Users\phili\Documents\poa\POB_AP6
init_structure.bat
```

### Linux/Mac
```bash
cd ~/Documents/poa/POB_AP6
bash setup.sh
```

Ou **manualmente** criar essas pastas:
```
src/controllers/
src/models/dao/
src/utils/
src/config/
views/pages/
views/layouts/
views/components/
resources/styles/
resources/scripts/
WebContent/WEB-INF/
```

---

## 🔑 Arquivos Chave

| Arquivo | Localização | Função |
|---------|------------|--------|
| AppServlet.java | src/controllers/ | Roteia requisições |
| Ave.java | src/models/ | Define estrutura de Ave |
| AveDAO.java | src/models/dao/ | Acessa banco de dados |
| ConnectionDB.java | src/utils/ | Gerencia conexão BD |
| web.xml | WebContent/WEB-INF/ | Configuração da app |

---

## ⚡ Próximas Ações

1. **Criar pastas** (se ainda não feitas)
2. **Mover arquivos Java** para as pastas corretas:
   - AppServlet.java → src/controllers/
   - Ave.java → src/models/
   - AveDAO.java → src/models/dao/
   - ConnectionDB.java → src/utils/

3. **Converter HTML para JSP** (adicionar `<%@ page %>`)
4. **Organizar recursos**:
   - CSS → resources/styles/
   - JS → resources/scripts/

5. **Configurar BD** (MySQL)
6. **Compilar e Deploy**

---

## 📌 Padrões Implementados

✅ **Front Controller** - AppServlet centraliza requisições
✅ **DAO** - AveDAO encapsula acesso ao BD
✅ **Singleton** - ConnectionDB garante instância única

---

## 🎯 Estrutura Django vs POB_AP6

```
Django                  →    POB_AP6 Java
─────────────────────────────────────────
urls.py                 →    web.xml + AppServlet
views.py                →    AppServlet.java
models.py               →    Ave.java
                        →    AveDAO.java (DAO pattern)
templates/              →    views/pages/ (JSP)
static/                 →    resources/
settings.py             →    ConnectionDB.java
```

---

**📖 Documentação completa**: Ver `ESTRUTURA_INICIAL.md`
