<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Ave" %>
<%
  String navWiki = (String) request.getAttribute("navWiki");
  if (navWiki == null) {
    navWiki = "";
  }

  String categoriaAtiva = (String) request.getAttribute("categoriaFiltro");
  if (categoriaAtiva == null) {
    Ave aveNav = (Ave) request.getAttribute("ave");
    if (aveNav != null) {
      categoriaAtiva = aveNav.isPequena() ? "pequenas" : "medias";
    } else {
      categoriaAtiva = "";
    }
  }
%>
<h3>Navegação</h3>
<ul>
  <li>
    <a
      href="${pageContext.request.contextPath}/wiki"
      class="<%= "wiki".equals(navWiki) ? "active" : "" %>"
      >Página Principal</a
    >
  </li>
  <li>
    <a
      href="${pageContext.request.contextPath}/especies"
      class="<%= "especies".equals(navWiki) ? "active" : "" %>"
      >Espécies</a
    >
  </li>
  <li>
    <a
      href="${pageContext.request.contextPath}/cuidados"
      class="<%= "cuidados".equals(navWiki) ? "active" : "" %>"
      >Cuidados</a
    >
  </li>
  <li>
    <a
      href="${pageContext.request.contextPath}/alimentacao"
      class="<%= "alimentacao".equals(navWiki) ? "active" : "" %>"
      >Alimentação</a
    >
  </li>
  <li>
    <a
      href="${pageContext.request.contextPath}/legalizacao"
      class="<%= "legalizacao".equals(navWiki) ? "active" : "" %>"
      >Legalização</a
    >
  </li>
</ul>

<h3>Categorias</h3>
<ul>
  <li>
    <a
      href="${pageContext.request.contextPath}/aves-pequenas"
      class="<%= "pequenas".equals(categoriaAtiva) ? "active" : "" %>"
      >Aves Pequenas</a
    >
  </li>
  <li>
    <a
      href="${pageContext.request.contextPath}/aves-medias"
      class="<%= "medias".equals(categoriaAtiva) ? "active" : "" %>"
      >Aves Médias</a
    >
  </li>
</ul>
