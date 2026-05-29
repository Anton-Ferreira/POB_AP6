# ✅ Checklist de Implementação - POB_AP6

## 📋 Fase 1: Estrutura Inicial (**CONCLUÍDA**)

- [x] Definir arquitetura MVC
- [x] Criar Front Controller (AppServlet.java)
- [x] Criar classe modelo (Ave.java)
- [x] Criar DAO (AveDAO.java)
- [x] Criar utilitários (ConnectionDB.java)
- [x] Criar template exemplo (index.jsp)
- [x] Criar web.xml
- [x] Documentar estrutura

---

## 📁 Fase 2: Organização de Pastas

- [ ] Criar pasta `src/controllers/`
- [ ] Criar pasta `src/models/`
- [ ] Criar pasta `src/models/dao/`
- [ ] Criar pasta `src/utils/`
- [ ] Criar pasta `src/config/`
- [ ] Criar pasta `views/pages/`
- [ ] Criar pasta `views/layouts/`
- [ ] Criar pasta `views/components/`
- [ ] Criar pasta `resources/styles/`
- [ ] Criar pasta `resources/scripts/`
- [ ] Criar pasta `WebContent/WEB-INF/`

**Atalho**: Execute `init_structure.bat` (Windows) ou `setup.sh` (Linux/Mac)

---

## 🔄 Fase 3: Mover e Organizar Arquivos

### Arquivos Java
- [ ] Mover `AppServlet.java` → `src/controllers/`
- [ ] Mover `Ave.java` → `src/models/`
- [ ] Mover `AveDAO.java` → `src/models/dao/`
- [ ] Mover `ConnectionDB.java` → `src/utils/`

### Arquivos de Configuração
- [ ] Mover `web.xml` → `WebContent/WEB-INF/`

### Recursos Estáticos
- [ ] Mover conteúdo de `pages/styles` → `resources/styles/`
- [ ] Mover conteúdo de `pages/scripts` → `resources/scripts/`
- [ ] Copiar imagens para `resources/images/`

---

## 📄 Fase 4: Conversão HTML → JSP

Para cada arquivo HTML em `pages/`:

- [ ] **index.html** → `views/pages/index.jsp`
  - Adicionar: `<%@ page language="java" contentType="text/html; charset=UTF-8" %>`
  - Converter links estáticos
  - Adicionar includes de header/footer

- [ ] **especies.html** → `views/pages/especies.jsp`
  - [ ] Implementar loop JSP para listar aves
  - [ ] Integrar com AveDAO
  
- [ ] **cuidados.html** → `views/pages/cuidados.jsp`
  
- [ ] **wiki.html** → `views/pages/wiki.jsp`
  
- [ ] **mapa.html** → `views/pages/mapa.jsp`
  - [ ] Integrar Google Maps API
  
- [ ] **legalizacao.html** → `views/pages/legalizacao.jsp`
  
- [ ] **alimentacao.html** → `views/pages/alimentacao.jsp`
  
- [ ] **calopisita.html** → `views/pages/calopisita.jsp`

---

## 🎨 Fase 5: Criar Componentes JSP Reutilizáveis

- [ ] `views/layouts/header.jsp` - Cabeçalho comum
  ```jsp
  <header>
      <nav class="navbar">
          <!-- navbar content -->
      </nav>
  </header>
  ```

- [ ] `views/layouts/footer.jsp` - Rodapé comum
  ```jsp
  <footer>
      <!-- footer content -->
  </footer>
  ```

- [ ] `views/components/navbar.jsp` - Barra de navegação
  ```jsp
  <ul>
      <li><a href="${pageContext.request.contextPath}/">Home</a></li>
      <li><a href="${pageContext.request.contextPath}/especies">Espécies</a></li>
      <!-- ... -->
  </ul>
  ```

- [ ] `views/layouts/base.jsp` - Template base reutilizável
  ```jsp
  <%@ include file="/views/layouts/header.jsp" %>
  <main>
      <jsp:include page="${pageName}" />
  </main>
  <%@ include file="/views/layouts/footer.jsp" %>
  ```

---

## 💾 Fase 6: Configurar Banco de Dados

### MySQL Setup
- [ ] Criar banco de dados: `pob_ap6`
- [ ] Criar tabela `aves`:
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

- [ ] Inserir dados de aves (dados de teste/iniciais)
- [ ] Atualizar `ConnectionDB.java` com credenciais corretas

### Outras Tabelas (Futuro)
- [ ] Tabela `cuidadores` (buscadores)
- [ ] Tabela `veterinarios` (profissionais)
- [ ] Tabela `petshops` (lojas)
- [ ] Tabela `usuarios` (autenticação)

---

## 🛠️ Fase 7: Implementação de Servlets Específicos

- [ ] `EspeciesServlet.java` - Para listar/filtrar espécies
- [ ] `WikiServlet.java` - Para exibir detalhes de espécie
- [ ] `MapaServlet.java` - Para buscar locais no mapa
- [ ] `CuidadosServlet.java` - Para guias de cuidados

---

## 🗺️ Fase 8: Integração Google Maps API

- [ ] Obter API Key do Google Maps
- [ ] Criar `GoogleMapsUtils.java` para gerenciar chamadas
- [ ] Implementar busca de locais (petshops, veterinários)
- [ ] Adicionar script do Maps nos JSPs
- [ ] Criar `mapa.jsp` com mapa interativo

---

## 🎯 Fase 9: Implementar Segundo Padrão de Projeto

Escolher e implementar um dos seguintes:

- [ ] **Strategy Pattern** - Para diferentes tipos de busca/filtro
- [ ] **Factory Pattern** - Para criar diferentes tipos de entidades
- [ ] **Observer Pattern** - Para notificações de atualização
- [ ] **Decorator Pattern** - Para adicionar funcionalidades a aves

**Sugestão**: Usar **Strategy** para diferentes algoritmos de busca

---

## 🔐 Fase 10: Segurança e Validação

- [ ] Implementar validação em todas as inputs
- [ ] Usar `PreparedStatement` em todas as queries
- [ ] Adicionar proteção contra SQL Injection
- [ ] Implementar validação de formulários (frontend + backend)
- [ ] Adicionar tratamento de exceções robusto
- [ ] Implementar logging

---

## 🧪 Fase 11: Testes

- [ ] Criar testes unitários para DAOs
- [ ] Testar servlets com cliente HTTP
- [ ] Testar validações
- [ ] Testes de integração com BD
- [ ] Testar conversão HTML → JSP

---

## 📦 Fase 12: Deployment

- [ ] Configurar Tomcat
- [ ] Build do projeto
- [ ] Deploy WAR em Tomcat
- [ ] Testar em ambiente de produção
- [ ] Verificar permissões BD

---

## 📚 Fase 13: Documentação

- [ ] Documentar APIs
- [ ] Criar README.md para developers
- [ ] Documentar padrões de projeto usados
- [ ] Criar guia de contribuição

---

## 🎓 Fase 14: Funcionalidades Adicionais

- [ ] Sistema de autenticação de usuários
- [ ] Perfil de usuário
- [ ] Favoritos de aves
- [ ] Sistema de avaliação
- [ ] Blog/Artigos
- [ ] Chat com especialistas

---

## ✨ Status Geral

**Fase 1 - CONCLUÍDA**: Estrutura inicial criada ✅
**Fase 2-14 - PENDENTES**: Aguardando implementação

---

**Nota**: Este é um checklist iterativo. Algumas fases podem ser reordenadas conforme necessário.
