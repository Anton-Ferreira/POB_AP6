<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Cuidados Gerais - Wiki das Aves</title>

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

        <div class="menu">
          <a href="${pageContext.request.contextPath}/">Início</a>
          <a href="${pageContext.request.contextPath}/#quiz">Quiz</a>
          <a href="${pageContext.request.contextPath}/wiki">Espécies</a>
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
        <section class="article-content">
          <h1>Cuidados Gerais</h1>

          <p class="intro">
            Ter uma ave como companheira é uma responsabilidade que vai além de
            oferecer comida e água. Um tutor consciente garante bem-estar
            físico, mental e social ao seu animal, respeitando suas necessidades
            naturais e comportamentais.
          </p>

          <section class="content-section">
            <h2>Ambiente e Gaiola</h2>
            <p>
              A gaiola deve ser espaçosa o suficiente para que a ave se mova com
              conforto, abra as asas e interaja com enriquecimentos ambientais.
              Prefira gaiolas horizontais para aves que gostam de escalar, e
              verticais para as que preferem voar. Mantenha o ambiente limpo,
              seco e longe de correntes de ar frio ou luz solar direta intensa.
            </p>
          </section>

          <section class="content-section">
            <h2>Alimentação Saudável</h2>
            <p>
              A base alimentar varia por espécie, mas em geral inclui ração
              extrusada balanceada, sementes controladas, frutas frescas sem
              agrotóxicos e vegetais folhosos. Evite alimentos tóxicos como
              abacate, cebola, alho, chocolate e alimentos muito salgados ou
              gordurosos. Água fresca e limpa deve estar sempre disponível.
            </p>
          </section>

          <section class="content-section">
            <h2>Higiene e Limpeza</h2>
            <p>
              Limpe a gaiola ao menos uma vez por semana com produtos seguros
              para aves, trocando o fundo e lavando poleiros e comedouros. O
              banho é importante para a saúde da plumagem — ofereça recipientes
              rasos com água limpa ou borrifador, respeitando a preferência de
              cada ave. Nunca use produtos químicos fortes perto das aves, pois
              seu sistema respiratório é muito sensível.
            </p>
          </section>

          <section class="content-section">
            <h2>Saúde e Veterinário</h2>
            <p>
              Consulte um veterinário especializado em aves ao menos uma vez por
              ano para check-ups preventivos. Fique atento a sinais de doença
              como penas arrepiadas, perda de apetite, fezes alteradas, descarga
              nasal ou ocular e letargia. O diagnóstico precoce é fundamental
              para o tratamento eficaz.
            </p>
          </section>

          <section class="content-section">
            <h2>Enriquecimento Ambiental</h2>
            <p>
              Aves são animais inteligentes e necessitam de estimulação mental e
              física. Ofereça brinquedos variados, poleiros de diferentes
              texturas e espessuras, espelhos, balanços e itens para roer.
              Reveze os brinquedos periodicamente para manter o interesse da
              ave. O tempo fora da gaiola, em ambiente seguro e supervisionado,
              também é muito benéfico.
            </p>
          </section>

          <section class="content-section">
            <h2>Interação Social</h2>
            <p>
              A maioria das aves domésticas é altamente social e sofre com o
              isolamento. Reserve tempo diário para interagir com sua ave —
              conversar, oferecer petiscos na mão e permitir o contato físico
              fortalece o vínculo e reduz o estresse. Se não for possível
              dedicar muito tempo, considere adotar um par compatível da mesma
              espécie.
            </p>
          </section>

          <section class="content-section">
            <h2>Temperatura e Iluminação</h2>
            <p>
              Aves tropicais geralmente se adaptam bem a temperaturas entre 18°C
              e 30°C. Evite variações bruscas de temperatura e exposição a
              ambientes com ar condicionado ou ventiladores diretamente
              apontados para a gaiola. A iluminação natural é importante para a
              regulação do ciclo circadiano — garanta ao menos algumas horas de
              luz natural indireta por dia.
            </p>
          </section>

          <section class="content-section">
            <h2>Dicas Gerais</h2>
            <ul>
              <li>
                Nunca use spray de cozinha ou frituras perto das aves — vapores
                são tóxicos.
              </li>
              <li>
                Remova objetos potencialmente perigosos antes de soltar a ave no
                ambiente.
              </li>
              <li>
                Mantenha janelas e portas fechadas durante o tempo livre da ave.
              </li>
              <li>
                Evite plantas ornamentais tóxicas como comigo-ninguém-pode e
                lírio.
              </li>
              <li>
                Registre mudanças de comportamento e leve ao veterinário se
                necessário.
              </li>
              <li>
                Adquira sempre aves de criadouros legalizados e com
                documentação.
              </li>
            </ul>
          </section>
        </section>
      </div>
    </main>

    <footer>
      <p>© 2026 - Plataforma de Apoio à Posse Responsável de Aves</p>
    </footer>
  </body>
</html>
