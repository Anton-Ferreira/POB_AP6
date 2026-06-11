<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mapa do Tutor</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/styles/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/styles/map.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
    />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;700&family=Poppins:wght@300;400;500;600&display=swap"
      rel="stylesheet"
    />
  </head>

  <body>
    <header>
      <nav>
        <div class="logo">Aves Legalizadas</div>

        <%@ include file="includes/nav-site.jsp" %>
      </nav>
    </header>

    <main class="container">
      <aside class="sidebar">
        <div>
          <h1>Filtros</h1>

          <div class="filter-section">
            <h3>Categorias</h3>

            <label class="checkbox">
              <input type="checkbox" id="cb-criadouro" checked />
              <span>Criadouros Autorizados</span>
            </label>

            <label class="checkbox">
              <input type="checkbox" id="cb-petshop" checked />
              <span>Pet Shops Especializados</span>
            </label>

            <label class="checkbox">
              <input type="checkbox" id="cb-veterinario" checked />
              <span>Veterinários Especializados</span>
            </label>

            <label class="checkbox">
              <input type="checkbox" id="cb-parque" checked />
              <span>Parques e Áreas Verdes</span>
            </label>
          </div>
        </div>

        <div class="buttons">
          <button class="btn-outline" id="btn-limpar">Limpar</button>
          <button class="btn-primary" id="btn-aplicar">Aplicar</button>
        </div>
      </aside>

      <section class="map-section">
        <div class="top-bar">
          <div class="search-box">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input
              type="text"
              id="search-input"
              placeholder="Buscar locais..."
            />
          </div>

          <button class="location-btn" id="btn-location">
            <i class="fa-solid fa-location-crosshairs"></i>
            Minha localização
          </button>
        </div>

        <div id="map" class="map"></div>

        <div class="map-loading" id="map-loading">
          <div class="loading-spinner"></div>
          <p>Carregando mapa...</p>
        </div>

        <div class="results">
          <div class="results-header">
            <h2>Locais encontrados <span id="count-label">(0)</span></h2>
            <a href="#" id="ver-todos">Ver todos</a>
          </div>

          <div class="cards" id="cards-container">
            <p class="cards-loading" id="cards-loading">Buscando locais próximos...</p>
          </div>
        </div>
      </section>
    </main>

    <footer>
      <p>© 2026 - Plataforma de Apoio à Posse Responsável de Aves</p>
    </footer>

    <script src="${pageContext.request.contextPath}/pages/scripts/map.js"></script>

    <%
      String googleMapsApiKey = (String) request.getAttribute("googleMapsApiKey");
      boolean mapaDisponivel = googleMapsApiKey != null && !googleMapsApiKey.isBlank();
    %>
    <% if (mapaDisponivel) { %>
    <script
      src="https://maps.googleapis.com/maps/api/js?key=<%= googleMapsApiKey %>&callback=initMap&loading=async&libraries=places,marker"
      async
      defer
    ></script>
    <% } else { %>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const mapEl = document.getElementById("map");
        if (mapEl) {
          mapEl.innerHTML =
            "<p class=\"map-config-error\">O mapa não está disponível. Configure a variável GOOGLE_MAPS_API_KEY no servidor.</p>";
        }
      });
    </script>
    <% } %>
  </body>
</html>
