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

        <div class="menu">
          <a href="${pageContext.request.contextPath}/">Início</a>
          <a href="${pageContext.request.contextPath}/#quiz">Quiz</a>
          <a href="${pageContext.request.contextPath}/wiki">Espécies</a>
          <a href="${pageContext.request.contextPath}/mapa">Mapa</a>
        </div>
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
            <h2>Locais encontrados <span id="count-label">(3)</span></h2>
            <a href="#" id="ver-todos">Ver todos</a>
          </div>

          <div class="cards" id="cards-container">
            <div class="card" data-categoria="criadouro">
              <img
                src="https://images.unsplash.com/photo-1522926193341-e9ffd686c60f?q=80&w=400"
                alt="Criadouro Bem-Te-Vi"
              />
              <div class="card-content">
                <span class="tag">Criadouro Autorizado</span>
                <h3>Criadouro Bem-Te-Vi</h3>
                <p>Rua dos Pássaros, 123</p>
                <div class="card-footer">
                  <span>★ 4.8</span>
                  <span>1,2 km</span>
                </div>
              </div>
            </div>

            <div class="card" data-categoria="petshop">
              <img
                src="https://images.unsplash.com/photo-1544923408-75c5cef46f14?q=80&w=400"
                alt="Pet Shop Aves e Cia"
              />
              <div class="card-content">
                <span class="tag brown-tag">Pet Shop Especializado</span>
                <h3>Pet Shop Aves &amp; Cia</h3>
                <p>Av. Paulista, 2001</p>
                <div class="card-footer">
                  <span>★ 4.6</span>
                  <span>1,8 km</span>
                </div>
              </div>
            </div>

            <div class="card" data-categoria="parque">
              <img
                src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=400"
                alt="Parque Ibirapuera"
              />
              <div class="card-content">
                <span class="tag">Parque</span>
                <h3>Parque Ibirapuera</h3>
                <p>Av. Pedro Álvares Cabral</p>
                <div class="card-footer">
                  <span>★ 4.9</span>
                  <span>2,3 km</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </main>

    <footer>
      <p>© 2026 - Plataforma de Apoio à Posse Responsável de Aves</p>
    </footer>

    <script src="${pageContext.request.contextPath}/pages/scripts/map.js"></script>

    <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBS7Dl9PjDrdM5Df_nauM6qnxqR9Mbziks&callback=initMap&loading=async&libraries=places,marker"
      async
      defer
    ></script>
  </body>
</html>
