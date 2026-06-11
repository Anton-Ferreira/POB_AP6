<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String navSite = (String) request.getAttribute("navSite");
  if (navSite == null) {
    navSite = "";
  }
%>
<div class="menu">
  <a
    href="${pageContext.request.contextPath}/"
    class="<%= "inicio".equals(navSite) ? "active" : "" %>"
    >Início</a
  >
  <a
    href="${pageContext.request.contextPath}/#quiz"
    class="<%= "quiz".equals(navSite) ? "active" : "" %>"
    >Quiz</a
  >
  <a
    href="${pageContext.request.contextPath}/wiki"
    class="<%= "wiki".equals(navSite) ? "active" : "" %>"
    >Wiki</a
  >
  <a
    href="${pageContext.request.contextPath}/mapa"
    class="<%= "mapa".equals(navSite) ? "active" : "" %>"
    >Mapa</a
  >
</div>
