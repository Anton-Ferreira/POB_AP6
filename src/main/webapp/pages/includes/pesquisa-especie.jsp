<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form
  class="search-box"
  id="form-pesquisa-especie"
  action="${pageContext.request.contextPath}/pesquisar"
  method="get"
>
  <input type="text" name="termo" placeholder="Pesquisar espécie..." autocomplete="off" />
  <input type="hidden" name="origem" value="<%= request.getRequestURI() %>" />
  <button type="submit">Buscar</button>
</form>
