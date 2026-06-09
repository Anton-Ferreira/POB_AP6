<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Espécies - Wiki das Aves</title>

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
        <div class="menu">
          <a href="${pageContext.request.contextPath}/">Início</a>
          <a href="${pageContext.request.contextPath}/#quiz">Quiz</a>
          <a href="${pageContext.request.contextPath}/especies">Espécies</a>
          <a href="${pageContext.request.contextPath}/mapa">Mapa</a>
        </div>
      </nav>
    </header>

    <main class="wiki-layout">
      <aside class="sidebar">
        <div class="search-box">
          <input type="text" placeholder="Pesquisar espécie..." />
          <button>Buscar</button>
        </div>

        <h3>Navegação</h3>
        <ul>
          <li><a href="${pageContext.request.contextPath}/wiki">Página Principal</a></li>
          <li><a href="${pageContext.request.contextPath}/especies">Espécies</a></li>
          <li><a href="${pageContext.request.contextPath}/cuidados">Cuidados</a></li>
          <li><a href="${pageContext.request.contextPath}/alimentacao">Alimentação</a></li>
          <li><a href="${pageContext.request.contextPath}/legalizacao">Legalização</a></li>
        </ul>

        <h3>Categorias</h3>
        <ul>
          <li><a href="#">Aves Pequenas</a></li>
          <li><a href="#">Aves Médias</a></li>
        </ul>
      </aside>

      <div class="page-layout care-layout">
        <section class="article-content full-width">
          <div class="species-list-header">
            <h1>Espécies</h1>
            <p>
              Conheça as principais aves domésticas legalizadas no Brasil. Cada
              espécie possui características únicas de comportamento, cuidado e
              manejo — encontre a companheira ideal para o seu perfil de tutor.
            </p>
          </div>

          <h2 class="divider-title">Aves Pequenas</h2>

          <div class="species-grid">
            <div class="species-card">
              <img
                src="https://images.unsplash.com/photo-1452570053594-1b985d6ea890?q=80&w=800&auto=format&fit=crop"
                alt="Canário"
              />
              <div class="species-card-body">
                <h3>Canário</h3>
                <span class="sci-name">Serinus canaria</span>
                <p>
                  Ave canora muito apreciada pelo canto melodioso e cuidado
                  relativamente simples. Ideal para quem aprecia música ambiente
                  natural.
                </p>
                <div class="species-tags">
                  <span class="tag">Pequena</span>
                  <span class="tag">Baixo Ruído</span>
                  <span class="tag">Iniciantes</span>
                </div>
                <a href="#" class="species-card-link">Ver artigo</a>
              </div>
            </div>

            <div class="species-card">
              <img
                src="https://images.unsplash.com/photo-1444464666168-49d633b86797?q=80&w=800&auto=format&fit=crop"
                alt="Agapornis"
              />
              <div class="species-card-body">
                <h3>Agapornis</h3>
                <span class="sci-name">Agapornis roseicollis</span>
                <p>
                  Conhecida como "pássaro do amor", é extremamente afetiva e
                  interativa. Vive melhor em pares e cria laços intensos com
                  seus tutores.
                </p>
                <div class="species-tags">
                  <span class="tag">Pequena</span>
                  <span class="tag">Interativa</span>
                </div>
                <a href="#" class="species-card-link">Ver artigo</a>
              </div>
            </div>

            <div class="species-card">
              <img
                src="https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?q=80&w=800&auto=format&fit=crop"
                alt="Periquito Australiano"
              />
              <div class="species-card-body">
                <h3>Periquito Australiano</h3>
                <span class="sci-name">Melopsittacus undulatus</span>
                <p>
                  Um dos psitacídeos mais populares do mundo. Alegre, curioso e
                  fácil de criar, pode aprender a imitar sons e palavras
                  simples.
                </p>
                <div class="species-tags">
                  <span class="tag">Pequena</span>
                  <span class="tag">Falante</span>
                  <span class="tag">Iniciantes</span>
                </div>
                <a href="#" class="species-card-link">Ver artigo</a>
              </div>
            </div>

            <div class="species-card">
              <img
                src="https://images.unsplash.com/photo-1559181567-c3190ca9d6a7?q=80&w=800&auto=format&fit=crop"
                alt="Diamante Mandarim"
              />
              <div class="species-card-body">
                <h3>Diamante Mandarim</h3>
                <span class="sci-name">Taeniopygia guttata</span>
                <p>
                  Pequeno pássaro canoro com plumagem colorida e canto
                  característico. Prefere viver em grupos e é ideal para
                  aviários internos.
                </p>
                <div class="species-tags">
                  <span class="tag">Pequena</span>
                  <span class="tag">Baixo Ruído</span>
                </div>
                <a href="#" class="species-card-link">Ver artigo</a>
              </div>
            </div>
          </div>

          <h2 class="divider-title">Aves Médias</h2>

          <div class="species-grid">
            <div class="species-card">
              <img
                src="https://images.unsplash.com/photo-1522858547137-f1dcec554f55?q=80&w=800&auto=format&fit=crop"
                alt="Calopsita"
              />
              <div class="species-card-body">
                <h3>Calopsita</h3>
                <span class="sci-name">Nymphicus hollandicus</span>
                <p>
                  Uma das aves domésticas mais populares entre iniciantes por
                  seu comportamento sociável, inteligência e facilidade de
                  adaptação.
                </p>
                <div class="species-tags">
                  <span class="tag">Média</span>
                  <span class="tag">Iniciantes</span>
                  <span class="tag">Sociável</span>
                </div>
                <a href="${pageContext.request.contextPath}/calopsita" class="species-card-link"
                  >Ver artigo</a
                >
              </div>
            </div>

            <div class="species-card">
              <img
                src="https://images.unsplash.com/photo-1508599589920-14cfa1d1ac0b?q=80&w=800&auto=format&fit=crop"
                alt="Papagaio Cinzento"
              />
              <div class="species-card-body">
                <h3>Papagaio Cinzento</h3>
                <span class="sci-name">Psittacus erithacus</span>
                <p>
                  Considerado um dos papagaios mais inteligentes do mundo,
                  possui capacidade vocal excepcional e grande necessidade de
                  estímulo mental.
                </p>
                <div class="species-tags">
                  <span class="tag">Média</span>
                  <span class="tag">Falante</span>
                  <span class="tag">Avançado</span>
                </div>
                <a href="#" class="species-card-link">Ver artigo</a>
              </div>
            </div>

            <div class="species-card">
              <img
                src="https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?q=80&w=800&auto=format&fit=crop"
                alt="Ringneck Indiano"
              />
              <div class="species-card-body">
                <h3>Ringneck Indiano</h3>
                <span class="sci-name">Psittacula krameri</span>
                <p>
                  Elegante e inteligente, é conhecida pela capacidade de falar e
                  pela plumagem vibrante. Requer tutores com experiência prévia
                  em psitacídeos.
                </p>
                <div class="species-tags">
                  <span class="tag">Média</span>
                  <span class="tag">Falante</span>
                </div>
                <a href="#" class="species-card-link">Ver artigo</a>
              </div>
            </div>

            <div class="species-card">
              <img
                src="https://images.unsplash.com/photo-1484406566174-9da000fda645?q=80&w=800&auto=format&fit=crop"
                alt="Eclectus"
              />
              <div class="species-card-body">
                <h3>Eclectus</h3>
                <span class="sci-name">Eclectus roratus</span>
                <p>
                  Ave de dimorfismo sexual marcante — machos são verdes e fêmeas
                  vermelhas. Tranquila, afetiva e com vocabulário extenso quando
                  bem socializada.
                </p>
                <div class="species-tags">
                  <span class="tag">Média</span>
                  <span class="tag">Falante</span>
                  <span class="tag">Baixo Ruído</span>
                </div>
                <a href="#" class="species-card-link">Ver artigo</a>
              </div>
            </div>
          </div>
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
