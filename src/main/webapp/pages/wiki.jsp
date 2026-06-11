<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Ave" %>
<%
  Ave especieDestaque = (Ave) request.getAttribute("especieDestaque");
  String erroWiki = (String) request.getAttribute("erroWiki");

  @SuppressWarnings("unchecked")
  List<Ave> especiesPopulares = (List<Ave>) request.getAttribute("especiesPopulares");
%>
<!doctype html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Wiki das Aves</title>

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />

    <link
      href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;700&family=Poppins:wght@300;400;500;600&display=swap"
      rel="stylesheet"
    />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/styles/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/styles/wiki.css" />
  </head>

  <body>
    <header>
      <nav>
        <div class="logo">Aves Legalizadas</div>

        <%@ include file="includes/nav-site.jsp" %>
      </nav>
    </header>

    <main class="wiki-layout">
      <aside class="sidebar">
        <%@ include file="includes/pesquisa-especie.jsp" %>

        <%@ include file="includes/nav-wiki.jsp" %>
      </aside>

      <section class="wiki-content">
        <div class="welcome-box">
          <h1>Bem-vindo à Wiki das Aves</h1>
          <p>
            Uma enciclopédia dedicada à posse responsável, legalização e
            cuidados com aves domésticas.
          </p>
        </div>

        <%
          if (erroWiki != null && !erroWiki.isBlank()) {
        %>
        <p class="wiki-error"><%= erroWiki %></p>
        <%
          }
        %>

        <div class="content-grid">
          <article class="featured-article">
            <h2>Espécie em Destaque</h2>
            <%
              if (especieDestaque != null) {
            %>
            <div class="article-box">
              <img
                src="<%= especieDestaque.getImagemExibicao() %>"
                alt="<%= especieDestaque.getNomePopular() %>"
              />
              <div>
                <h3><%= especieDestaque.getNomePopular() %></h3>
                <p><%= especieDestaque.getTextoOuPadrao(especieDestaque.getResumoBreve()) %></p>
                <a href="<%= request.getContextPath() + especieDestaque.getArtigoPath() %>"
                  >Ler artigo completo</a
                >
              </div>
            </div>
            <%
              } else {
            %>
            <p>Nenhuma espécie disponível para destaque no momento.</p>
            <%
              }
            %>
          </article>

          <div class="wiki-info">
            <h2>Sobre a Wiki</h2>
            <p>
              Esta plataforma reúne informações sobre espécies domésticas
              legalizadas, manejo responsável, alimentação, comportamento e
              orientações legais.
            </p>
          </div>
        </div>

        <section class="species-section">
          <h2>Espécies Populares</h2>
          <div class="species-table">
            <%
              if (especiesPopulares != null && !especiesPopulares.isEmpty()) {
                for (Ave ave : especiesPopulares) {
            %>
            <a
              href="<%= request.getContextPath() + ave.getArtigoPath() %>"
              class="species-item"
            >
              <img src="<%= ave.getImagemExibicao() %>" alt="<%= ave.getNomePopular() %>" />
              <div>
                <h3><%= ave.getNomePopular() %></h3>
                <p><%= ave.getTextoOuPadrao(ave.getResumoBreve()) %></p>
              </div>
            </a>
            <%
                }
              } else {
            %>
            <p>Nenhuma espécie popular cadastrada no momento.</p>
            <%
              }
            %>
          </div>
        </section>
      </section>
    </main>

    <footer>
      <p>© 2026 - Plataforma de Apoio à Posse Responsável de Aves</p>
    </footer>

    <script>window.APP_CONTEXT_PATH = '${pageContext.request.contextPath}';</script>
    <script src="${pageContext.request.contextPath}/pages/scripts/pesquisa.js"></script>
  </body>
</html>
