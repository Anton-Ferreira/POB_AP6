<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Ave" %>
<%
  Ave ave = (Ave) request.getAttribute("ave");
%>
<!doctype html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title><%= ave != null ? ave.getNomePopular() + " - Wiki das Aves" : "Espécie - Wiki das Aves" %></title>

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;700&family=Poppins:wght@300;400;500;600&display=swap"
      rel="stylesheet"
    />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/styles/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/styles/wiki.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/styles/calopsita.css" />
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

      <% if (ave != null) { %>
      <div class="page-layout">
        <section class="article-content">
          <h1><%= ave.getNomePopular() %></h1>

          <p class="intro"><%= ave.getTextoOuPadrao(ave.getResumoBreve()) %></p>

          <section class="content-section">
            <h2>Características físicas</h2>
            <p><%= ave.getTextoOuPadrao(ave.getCaracteristicasFisicas()) %></p>
          </section>

          <section class="content-section">
            <h2>Legalização</h2>
            <p><%= ave.getTextoOuPadrao(ave.getLegislacaoInfo()) %></p>
          </section>

          <section class="content-section">
            <h2>Curiosidades</h2>
            <p><%= ave.getTextoOuPadrao(ave.getCuriosidades()) %></p>
          </section>

          <section class="content-section">
            <h2>Comportamento</h2>
            <p><%= ave.getTextoOuPadrao(ave.getComportamentoTemperamento()) %></p>
          </section>

          <section class="content-section">
            <h2>Alimentação</h2>
            <p><%= ave.getTextoOuPadrao(ave.getGuiaAlimentacao()) %></p>
          </section>

          <section class="content-section">
            <h2>Alimentos proibidos</h2>
            <p><%= ave.getTextoOuPadrao(ave.getAlimentosProibidos()) %></p>
          </section>

          <section class="content-section">
            <h2>Requisitos para gaiola</h2>
            <p><%= ave.getTextoOuPadrao(ave.getRequisitosGaiola()) %></p>
          </section>

          <section class="content-section">
            <h2>Sinais de alerta</h2>
            <p><%= ave.getTextoOuPadrao(ave.getSinaisAlertaSaude()) %></p>
          </section>

          <section class="content-section">
            <h2>Enriquecimento ambiental</h2>
            <p><%= ave.getTextoOuPadrao(ave.getEnriquecimentoAmbiental()) %></p>
          </section>
        </section>

        <aside class="infobox">
          <h3><%= ave.getNomePopular() %></h3>

          <img src="<%= ave.getImagemExibicao() %>" alt="<%= ave.getNomePopular() %>" />

          <div class="info-item">
            <span>Nome científico</span>
            <p><%= ave.getTextoOuPadrao(ave.getNomeCientifico()) %></p>
          </div>

          <div class="info-item">
            <span>Expectativa de vida</span>
            <p><%= ave.getTextoOuPadrao(ave.getExpectativaVida()) %></p>
          </div>

          <div class="info-item">
            <span>Porte</span>
            <p><%= ave.getPorte() %></p>
          </div>

          <div class="info-item">
            <span>Nível de ruído</span>
            <p><%= ave.getNivelRuidoExibicao() %></p>
          </div>

          <div class="info-item">
            <span>Dificuldade</span>
            <p><%= ave.getDificuldadeExibicao() %></p>
          </div>

          <div class="info-item">
            <span>Ideal para</span>
            <p><%= ave.getIdealPara() %></p>
          </div>

          <div class="info-item">
            <span>Status da legalização</span>
            <p><%= ave.getStatusLegalFormatado() %></p>
          </div>
        </aside>
      </div>
      <% } %>
    </main>

    <footer>
      <p>© 2026 - Plataforma de Apoio à Posse Responsável de Aves</p>
    </footer>

    <script>window.APP_CONTEXT_PATH = '${pageContext.request.contextPath}';</script>
    <script src="${pageContext.request.contextPath}/pages/scripts/pesquisa.js"></script>
  </body>
</html>
