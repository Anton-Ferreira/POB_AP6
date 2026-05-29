# 📐 Diagrama da Arquitetura MVC - POB_AP6

## 🔄 Fluxo de Requisição

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         NAVEGADOR DO USUÁRIO                            │
│                                                                           │
│    http://localhost:8080/POB_AP6/especies  (ou qualquer URL)           │
└─────────────────────┬───────────────────────────────────────────────────┘
                      │
                      │ GET /especies
                      │
                      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                         WEB SERVER (Tomcat)                              │
│                                                                           │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │         web.xml (Configuração)                                   │   │
│  │         - Mapeia "/" para AppServlet                            │   │
│  └────────────────────────────────────────────────────────────────┬┘   │
│                                                                     │    │
└─────────────────────────────────────────────────────────────────────────┘
                      │
                      │
                      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│           CONTROLLER (src/controllers/AppServlet.java)                   │
│                                                                           │
│   doGet(HttpServletRequest request, HttpServletResponse response)       │
│   {                                                                      │
│       String path = request.getRequestURI();                           │
│       String action = extractAction(path);                             │
│                                                                          │
│       switch(action) {                                                  │
│           case "especies":                                              │
│               forwardToView(request, response, "especies.jsp");        │
│           case "cuidados":                                              │
│               forwardToView(request, response, "cuidados.jsp");        │
│           ...                                                            │
│       }                                                                  │
│   }                                                                      │
└──────────────────────────────────────────────────────────────────────┬──┘
                                                                        │
                                                                        │
                                                   ┌────────────────────┘
                                                   │
                                                   ▼
                                    ┌──────────────────────────┐
                                    │  Precisa de dados?       │
                                    │  Sim: Chamar MODEL       │
                                    │  Não: Ir direto à VIEW   │
                                    └──────────────────────────┘
                                                   │
                        ┌──────────────────────────┼──────────────────────────┐
                        │ SIM                      │ NÃO                      │
                        │                          │                          │
                        ▼                          ▼                          ▼
        ┌─────────────────────────┐    ┌─────────────────────────┐
        │ MODEL (src/models/)     │    │ VIEW (views/pages/)     │
        │                         │    │                         │
        │ ┌───────────────────┐   │    │ ┌───────────────────┐   │
        │ │ Ave.java          │   │    │ │ especies.jsp      │   │
        │ │ - id              │   │    │ │ cuidados.jsp      │   │
        │ │ - nomeComum       │   │    │ │ wiki.jsp          │   │
        │ │ - domesticavel    │   │    │ │ index.jsp         │   │
        │ │ - ...             │   │    │ │ ...               │   │
        │ └───────────────────┘   │    │ └───────────────────┘   │
        │                         │    │                         │
        │ ┌───────────────────┐   │    │ Request.setAttribute()  │
        │ │ AveDAO.java       │   │    │ renderiza dados        │
        │ │ (DAO Pattern)     │   │    │                         │
        │ │                   │   │    │ <%= objeto.atributo %>  │
        │ │ buscarTodas()     │   │    │                         │
        │ │ buscarPorId()     │   │    │                         │
        │ │ inserir()         │   │    │                         │
        │ │ atualizar()       │   │    │                         │
        │ │ deletar()         │   │    │                         │
        │ └────────┬──────────┘   │    │                         │
        │          │              │    │                         │
        │          │ executa      │    │                         │
        │          │ queries      │    │                         │
        │          │              │    │                         │
        │          ▼              │    │                         │
        │ ┌───────────────────┐   │    │                         │
        │ │ ConnectionDB.java │   │    │                         │
        │ │ (Singleton)       │   │    │                         │
        │ │                   │   │    │                         │
        │ │ getConnection()   │   │    │                         │
        │ └────────┬──────────┘   │    │                         │
        │          │              │    │                         │
        │          │              │    │                         │
        │          ▼              │    │                         │
        │ ┌───────────────────┐   │    │                         │
        │ │    MySQL BD       │   │    │                         │
        │ │   pob_ap6         │   │    │                         │
        │ │                   │   │    │                         │
        │ │  TABLE: aves      │   │    │                         │
        │ │  ├─ id            │   │    │                         │
        │ │  ├─ nome_comum    │   │    │                         │
        │ │  ├─ domesticavel  │   │    │                         │
        │ │  └─ ...           │   │    │                         │
        │ └───────────────────┘   │    │                         │
        │                         │    │                         │
        └─────────────┬───────────┘    │                         │
                      │                 │                         │
                      │ retorna dados   │                         │
                      │ (Lista de Ave)  │                         │
                      │                 │                         │
                      └────────┬────────┘                         │
                               │                                  │
                               └──────────────┬───────────────────┘
                                              │
                                              │ request.setAttribute("aves", lista)
                                              │
                                              ▼
                        ┌──────────────────────────────────┐
                        │  JSP renderiza HTML com dados    │
                        │                                  │
                        │  <% for(Ave a : aves) { %>       │
                        │      <%= a.getNomeComum() %>    │
                        │  <% } %>                         │
                        └──────────────┬───────────────────┘
                                       │
                                       │
                                       ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                    RESPONSE (HTML renderizado)                           │
│                                                                           │
│    <!DOCTYPE html>                                                      │
│    <html>                                                               │
│      <body>                                                             │
│        <h1>Espécies de Aves</h1>                                       │
│        <ul>                                                             │
│          <li>Calopsita</li>                                            │
│          <li>Periquito</li>                                            │
│          <li>Canário</li>                                              │
│        </ul>                                                            │
│      </body>                                                            │
│    </html>                                                              │
└─────────────────────────────────────────────────────────────────────────┘
                                       │
                                       │
                                       ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                      NAVEGADOR DO USUÁRIO                               │
│                                                                           │
│              ┌─────────────────────────────────────┐                   │
│              │ Espécies de Aves                    │                   │
│              │ • Calopsita                         │                   │
│              │ • Periquito                         │                   │
│              │ • Canário                           │                   │
│              └─────────────────────────────────────┘                   │
│                                                                           │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 🎨 Estrutura de Pastas

```
POB_AP6/
│
├── src/                                  ← Código-fonte Java
│   │
│   ├── controllers/
│   │   └── AppServlet.java              ← ✅ CRIADO
│   │       (Front Controller)
│   │
│   ├── models/                          ← ✅ CRIADO (Ave.java)
│   │   ├── Ave.java                     ← ✅ CRIADO
│   │   │   (Classe modelo)
│   │   │
│   │   └── dao/
│   │       └── AveDAO.java              ← ✅ CRIADO
│   │           (Data Access Object)
│   │
│   ├── utils/
│   │   └── ConnectionDB.java            ← ✅ CRIADO
│   │       (Gerenciador de conexão)
│   │
│   └── config/
│       └── AppConfig.java               ← (a criar)
│
├── views/                               ← Templates JSP
│   │
│   ├── pages/                           ← Páginas principais
│   │   ├── index.jsp                    ← ✅ EXEMPLO CRIADO
│   │   ├── especies.jsp                 ← (a converter)
│   │   ├── cuidados.jsp                 ← (a converter)
│   │   ├── wiki.jsp                     ← (a converter)
│   │   ├── mapa.jsp                     ← (a converter)
│   │   └── ...
│   │
│   ├── layouts/                         ← Templates reutilizáveis
│   │   ├── header.jsp                   ← (a criar)
│   │   ├── footer.jsp                   ← (a criar)
│   │   └── base.jsp                     ← (a criar)
│   │
│   └── components/                      ← Componentes reutilizáveis
│       └── navbar.jsp                   ← (a criar)
│
├── resources/                           ← Recursos estáticos
│   ├── styles/                          ← CSS
│   ├── scripts/                         ← JavaScript
│   └── images/                          ← Imagens
│
├── WebContent/
│   └── WEB-INF/
│       └── web.xml                      ← ✅ CRIADO
│           (Configuração da app)
│
├── pages/                               ← (ORIGINAL - descontinuado)
│   ├── styles/
│   └── scripts/
│
└── DOCUMENTAÇÃO
    ├── ESTRUTURA_INICIAL.md             ← ✅ CRIADO (Completo)
    ├── QUICK_START.md                   ← ✅ CRIADO
    ├── CHECKLIST.md                     ← ✅ CRIADO
    ├── RESUMO_CRIACAO.md                ← ✅ CRIADO
    ├── PROJECT_STRUCTURE.md             ← ✅ CRIADO
    ├── setup.sh                         ← ✅ CRIADO
    ├── init_structure.bat               ← ✅ CRIADO
    └── organize_project.py              ← ✅ CRIADO
```

---

## 🔀 Roteamento de URLs

```
URL Requisitada              Ação Extraída      JSP Renderizada
─────────────────────────────────────────────────────────────────
/                       →     ""             →  views/pages/index.jsp
/inicio                 →  "inicio"          →  views/pages/index.jsp
/especies               →  "especies"        →  views/pages/especies.jsp
/cuidados               →  "cuidados"        →  views/pages/cuidados.jsp
/wiki                   →  "wiki"            →  views/pages/wiki.jsp
/mapa                   →  "mapa"            →  views/pages/mapa.jsp
/legalizacao            →  "legalizacao"     →  views/pages/legalizacao.jsp
/alimentacao            →  "alimentacao"     →  views/pages/alimentacao.jsp
```

---

## 📊 Ciclo de Vida de uma Requisição

```
1. REQUISIÇÃO CHEGA
   └─ AppServlet.doGet()

2. EXTRAI AÇÃO
   └─ extractAction(uri)

3. ROTEIA PARA JSP
   ├─ Sem lógica → vai direto para JSP
   └─ Com lógica → chama Model/DAO antes

4. MODEL BUSCA DADOS (se necessário)
   ├─ AveDAO.buscarTodas()
   ├─ AveDAO.buscarPorId(id)
   └─ ConnectionDB.getConnection()

5. DADOS VÊM DO BANCO
   └─ MySQL (tabela aves)

6. CONTROLLER COLOCA DADOS NA REQUEST
   └─ request.setAttribute("aves", lista)

7. FORWARD PARA JSP
   └─ request.getRequestDispatcher().forward()

8. JSP RENDERIZA HTML COM DADOS
   ├─ <% for(Ave a : aves) %>
   └─ <%= a.getNomeComum() %>

9. RESPONSE RETORNA AO NAVEGADOR
   └─ HTML renderizado
```

---

## 🎯 Padrões de Projeto

### 1. Front Controller (AppServlet)
```
Benefício: Centraliza o controle de requisições
Uso: Todas as requisições passam por um único ponto
```

### 2. DAO (AveDAO)
```
Benefício: Encapsula lógica de banco de dados
Uso: Model nunca acessa BD diretamente
```

### 3. Singleton (ConnectionDB)
```
Benefício: Conexão única com BD
Uso: Evita múltiplas conexões desnecessárias
```

---

**Diagrama criado em 2026-05-29**
