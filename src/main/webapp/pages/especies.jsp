<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Ave" %>
<%
  String categoriaFiltro = (String) request.getAttribute("categoriaFiltro");
  boolean mostrarPequenas = categoriaFiltro == null || "pequenas".equals(categoriaFiltro);
  boolean mostrarMedias = categoriaFiltro == null || "medias".equals(categoriaFiltro);

  String tituloPagina = "Espécies";
  String descricaoPagina =
      "Conheça as principais aves domésticas legalizadas no Brasil. Cada espécie possui características únicas de comportamento, cuidado e manejo — encontre a companheira ideal para o seu perfil de tutor.";

  if ("pequenas".equals(categoriaFiltro)) {
    tituloPagina = "Aves Pequenas";
    descricaoPagina =
        "Aves de porte reduzido, com até 25 cm de tamanho médio — como periquitos, canários e agapornis. Ideais para espaços menores e tutores que buscam companheiros mais discretos.";
  } else if ("medias".equals(categoriaFiltro)) {
    tituloPagina = "Aves Médias";
    descricaoPagina =
        "Aves acima de 25 cm de tamanho médio — como calopsitas, ringnecks e papagaios médios. Exigem mais espaço e interação, mas oferecem personalidade marcante.";
  }
%>
<!doctype html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title><%= tituloPagina %> - Wiki das Aves</title>

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;700&family=Poppins:wght@300;400;500;600&display=swap"
      rel="stylesheet"
    />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/styles/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/styles/wiki.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/styles/calopsita.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/styles/especies.css" />
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

      <div class="page-layout care-layout">
        <section class="article-content full-width">
          <div class="species-list-header">
            <h1><%= tituloPagina %></h1>
            <p><%= descricaoPagina %></p>
          </div>

          <%
            String erroEspecies = (String) request.getAttribute("erroEspecies");
            if (erroEspecies != null && !erroEspecies.isBlank()) {
          %>
          <p class="species-error"><%= erroEspecies %></p>
          <%
            }

            @SuppressWarnings("unchecked")
            List<Ave> avesPequenas = (List<Ave>) request.getAttribute("avesPequenas");
            @SuppressWarnings("unchecked")
            List<Ave> avesMedias = (List<Ave>) request.getAttribute("avesMedias");
          %>

          <% if (mostrarPequenas) { %>
          <h2 class="divider-title">Aves Pequenas</h2>

          <div class="species-grid">
            <%
              if (avesPequenas != null && !avesPequenas.isEmpty()) {
                for (Ave ave : avesPequenas) {
            %>
            <div class="species-card">
              <img src="<%= ave.getImagemExibicao() %>" alt="<%= ave.getNomePopular() %>" />
              <div class="species-card-body">
                <h3><%= ave.getNomePopular() %></h3>
                <span class="sci-name"><%= ave.getNomeCientifico() %></span>
                <p><%= ave.getResumoBreve() %></p>
                <div class="species-tags">
                  <span class="tag"><%= ave.getDificuldadeFormatada() %></span>
                  <span class="tag"><%= ave.getNivelRuidoFormatado() %></span>
                </div>
                <a
                  href="<%= request.getContextPath() + ave.getArtigoPath() %>"
                  class="species-card-link"
                  >Ver artigo</a
                >
              </div>
            </div>
            <%
                }
              } else {
            %>
            <p>Nenhuma ave pequena cadastrada no momento.</p>
            <%
              }
            %>
          </div>
          <% } %>

          <% if (mostrarMedias) { %>
          <h2 class="divider-title">Aves Médias</h2>

          <div class="species-grid">
            <%
              if (avesMedias != null && !avesMedias.isEmpty()) {
                for (Ave ave : avesMedias) {
            %>
            <div class="species-card">
              <img src="<%= ave.getImagemExibicao() %>" alt="<%= ave.getNomePopular() %>" />
              <div class="species-card-body">
                <h3><%= ave.getNomePopular() %></h3>
                <span class="sci-name"><%= ave.getNomeCientifico() %></span>
                <p><%= ave.getResumoBreve() %></p>
                <div class="species-tags">
                  <span class="tag"><%= ave.getDificuldadeFormatada() %></span>
                  <span class="tag"><%= ave.getNivelRuidoFormatado() %></span>
                </div>
                <a
                  href="<%= request.getContextPath() + ave.getArtigoPath() %>"
                  class="species-card-link"
                  >Ver artigo</a
                >
              </div>
            </div>
            <%
                }
              } else {
            %>
            <p>Nenhuma ave média cadastrada no momento.</p>
            <%
              }
            %>
          </div>
          <% } %>
        </section>
      </div>
    </main>

    <footer>
      <p>© 2026 - Plataforma de Apoio à Posse Responsável de Aves</p>
    </footer>

    <script>window.APP_CONTEXT_PATH = '${pageContext.request.contextPath}';</script>
    <script src="${pageContext.request.contextPath}/pages/scripts/pesquisa.js"></script>
  </body>
</html>
