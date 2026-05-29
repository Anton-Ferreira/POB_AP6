# Estrutura Inicial do Projeto POB_AP6

## 📋 Visão Geral

Este documento descreve a estrutura MVC inicial criada para o projeto **POB_AP6** (Plataforma de Orientação sobre Aves), organizada de forma similar ao framework Django.

---

## 🏗️ Estrutura de Pastas

```
POB_AP6/
│
├── src/                          # Código-fonte Java
│   ├── controllers/              # Servlets (Controllers)
│   │   └── AppServlet.java      # Front Controller principal
│   │
│   ├── models/                   # Modelos de dados e DAOs
│   │   ├── Ave.java             # Classe modelo/Entity
│   │   └── dao/
│   │       └── AveDAO.java      # Data Access Object para Ave
│   │
│   ├── utils/                    # Classes utilitárias
│   │   └── ConnectionDB.java    # Gerenciador de conexões BD
│   │
│   └── config/                   # Configurações
│       └── AppConfig.java        # (Arquivo para criar)
│
├── views/                        # Templates JSP (Apresentação)
│   ├── pages/                    # Páginas principais (JSP)
│   │   ├── index.jsp             # Home
│   │   ├── especies.jsp          # Catálogo de espécies
│   │   ├── cuidados.jsp          # Guia de cuidados
│   │   ├── wiki.jsp              # Mini wiki
│   │   ├── mapa.jsp              # Mapa interativo
│   │   ├── legalizacao.jsp       # Informações legais
│   │   ├── alimentacao.jsp       # Guia de alimentação
│   │   └── calopisita.jsp        # (Já existe)
│   │
│   ├── layouts/                  # Layouts reutilizáveis
│   │   ├── header.jsp            # Cabeçalho (em criação)
│   │   ├── footer.jsp            # Rodapé (em criação)
│   │   └── base.jsp              # Template base (em criação)
│   │
│   └── components/               # Componentes reutilizáveis
│       └── navbar.jsp            # Barra de navegação
│
├── resources/                    # Recursos estáticos
│   ├── styles/                   # Arquivos CSS
│   ├── scripts/                  # Arquivos JavaScript
│   └── images/                   # Imagens
│
├── WebContent/WEB-INF/           # Diretório Web
│   └── web.xml                   # Descritor de deployment
│
├── pages/                        # (ORIGINAL - descontinuado)
│
├── PROJECT_STRUCTURE.md          # Este arquivo
├── setup.sh                      # Script bash para criar estrutura
├── init_structure.bat            # Script batch para criar estrutura
└── prompt.md                     # Prompt do usuário

```

---

## 📁 Arquivos Criados

### Controladores
- **AppServlet.java** - Front Controller que roteia todas as requisições

### Modelos
- **Ave.java** - Classe que representa uma ave
- **AveDAO.java** - Data Access Object para operações CRUD

### Utilitários
- **ConnectionDB.java** - Gerencia conexões com o banco de dados (Padrão Singleton)

### Configuração
- **web.xml** - Arquivo de configuração da aplicação Java Web

### Templates JSP
- **index.jsp** - Template de exemplo convertido para JSP

---

## 🎯 Padrões de Projeto Implementados

### 1. **Front Controller** (AppServlet.java)
- Centraliza o roteamento de todas as requisições HTTP
- Similar ao URLRouter do Django
- Encaminha cada requisição para a view apropriada

### 2. **Data Access Object (DAO)** (AveDAO.java)
- Encapsula toda a lógica de acesso ao banco de dados
- Fornece métodos CRUD (Create, Read, Update, Delete)
- Separa a lógica de persistência da lógica de negócio

### 3. **Singleton** (ConnectionDB.java)
- Garante uma única instância de conexão com o BD
- Gerencia o ciclo de vida da conexão

---

## 🚀 Próximos Passos

### 1. **Estruturação de Diretórios** (IMEDIATO)
```bash
# No Linux/Mac
bash setup.sh

# No Windows
init_structure.bat
```

### 2. **Converter HTML para JSP**
- [ ] Adicionar `<%@ page %>` directives
- [ ] Converter links estáticos para uso de `${pageContext.request.contextPath}`
- [ ] Incluir headers e footers com `<%@ include file="" %>`
- [ ] Mover para `views/pages/`

Exemplo:
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
```

### 3. **Organizar Recursos Estáticos**
- [ ] Mover CSS de `pages/styles` para `resources/styles`
- [ ] Mover JS de `pages/scripts` para `resources/scripts`
- [ ] Atualizar referências nos JSPs

### 4. **Configurar Banco de Dados**
- [ ] Criar banco de dados `pob_ap6`
- [ ] Criar tabela `aves` com campos correspondentes à classe Ave
- [ ] Atualizar credenciais em `ConnectionDB.java`

Script SQL exemplo:
```sql
CREATE TABLE aves (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_comum VARCHAR(100) NOT NULL,
    nome_cientifico VARCHAR(150),
    descricao TEXT,
    habitat VARCHAR(200),
    alimentacao TEXT,
    expectativa_vida VARCHAR(50),
    tamanho VARCHAR(50),
    temperamento VARCHAR(100),
    domesticavel BOOLEAN DEFAULT FALSE,
    informacoes_legais TEXT,
    cuidados_especiais TEXT,
    imagem_url VARCHAR(300),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 5. **Criar Componentes JSP**
- [ ] `views/layouts/header.jsp` - Cabeçalho comum
- [ ] `views/layouts/footer.jsp` - Rodapé comum
- [ ] `views/components/navbar.jsp` - Barra de navegação
- [ ] `views/layouts/base.jsp` - Template base

### 6. **Implementar Busca e Filtros**
- [ ] Criar servlets específicos para ações (Ex: `EspeciesServlet`)
- [ ] Implementar filtros no AveDAO
- [ ] Criar JSPs com lógica de apresentação

### 7. **Integração com Google Maps API**
- [ ] Adicionar SDK do Google Maps nos JSPs
- [ ] Criar servlet para buscar locais (petshops, veterinários)
- [ ] Implementar JavaScript para renderizar mapa

### 8. **Implementar Segundo Padrão de Projeto**
- Sugestões: **Strategy**, **Observer**, **Factory**, **Builder**

---

## 🔧 Configuração do Projeto

### Dependências Necessárias

Para compilar e rodar o projeto, você precisará:

1. **Java JDK 8+**
2. **Apache Tomcat 9+** (ou outro servidor web)
3. **MySQL 5.7+** (para o banco de dados)
4. **Driver JDBC MySQL** (`mysql-connector-java`)

### Adicionar Dependências (Maven)

Se usando Maven, adicione ao `pom.xml`:

```xml
<!-- MySQL JDBC Driver -->
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.33</version>
</dependency>

<!-- Servlet API -->
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>javax.servlet-api</artifactId>
    <version>4.0.1</version>
    <scope>provided</scope>
</dependency>
```

---

## 💾 Arquitetura MVC Explicada

```
REQUEST (HTTP)
    ↓
AppServlet (Controller)
    ↓
AveDAO (Model) ↔ Database
    ↓
JSP Templates (View)
    ↓
RESPONSE (HTML)
```

1. **Request chega em AppServlet** - Front Controller processa a URL
2. **Controller encaminha para Model** - Busca dados via DAO
3. **Model retorna dados** - DAO executa queries no BD
4. **View renderiza** - JSP exibe os dados em HTML
5. **Response é enviado** - HTML retorna ao navegador

---

## 📝 Convenções Adotadas

- **Pacotes Java**: `controllers`, `models`, `models.dao`, `utils`, `config`
- **Servlets**: Terminam com `Servlet` (Ex: `AppServlet`)
- **DAOs**: Terminam com `DAO` (Ex: `AveDAO`)
- **JSPs**: Extensão `.jsp`, localizados em `views/pages/`
- **URLs**: Mapeadas sem extensão (Ex: `/especies` → `especies.jsp`)

---

## ⚠️ Notas Importantes

1. **Credenciais BD**: Atualize `ConnectionDB.java` com suas credenciais
2. **Contexto da App**: Use `${pageContext.request.contextPath}` em todos os links
3. **Segurança**: Sempre use `PreparedStatement` para queries (evita SQL Injection)
4. **Validação**: Implemente validação nos Controllers antes de chamar DAOs

---

## 📞 Suporte

Para dúvidas sobre a estrutura, consulte este documento ou a documentação oficial de:
- [Servlet API](https://tomcat.apache.org/)
- [JSP Tutorial](https://www.oracle.com/java/technologies/jsp.html)
- [Design Patterns Java](https://refactoring.guru/design-patterns/java)

---

**Última atualização**: 2026-05-29
