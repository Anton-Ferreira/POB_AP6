<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Alimentação - Wiki das Aves</title>

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
          <h1>Alimentação Geral</h1>

          <p class="intro">
            Uma alimentação equilibrada é um dos pilares mais importantes para a
            saúde e longevidade das aves domésticas. Entender o que oferecer, em
            quais quantidades e o que evitar faz toda a diferença no bem-estar
            do seu animal.
          </p>

          <section class="content-section">
            <h2>Ração Extrusada</h2>
            <p>
              A ração extrusada balanceada é considerada a base alimentar mais
              completa para psitacídeos e outras aves domésticas. Formulada com
              nutrientes essenciais em proporções adequadas, ela reduz a
              seletividade alimentar comum em dietas baseadas apenas em
              sementes. Prefira marcas com registro no Ministério da Agricultura
              e indicação veterinária.
            </p>
          </section>

          <section class="content-section">
            <h2>Sementes</h2>
            <p>
              As sementes podem compor parte da dieta, mas não devem ser a base
              exclusiva da alimentação. Misturas de sementes como milheto,
              girassol, aveia e linhaça são bem aceitas, porém o girassol em
              excesso pode causar obesidade e deficiência nutricional. Use as
              sementes como complemento ou petisco, não como refeição principal.
            </p>
          </section>

          <section class="content-section">
            <h2>Frutas Permitidas</h2>
            <p>
              Frutas frescas e sem agrotóxicos enriquecem a dieta com vitaminas,
              minerais e fibras. As mais indicadas para a maioria das espécies
              são:
            </p>
            <ul>
              <li>Maçã (sem sementes)</li>
              <li>Mamão</li>
              <li>Manga</li>
              <li>Melão e melancia (sem casca)</li>
              <li>Pera</li>
              <li>Banana (com moderação)</li>
              <li>Uva (sem sementes)</li>
            </ul>
          </section>

          <section class="content-section">
            <h2>Vegetais e Folhas</h2>
            <p>
              Vegetais frescos fornecem nutrientes fundamentais e estimulam o
              comportamento natural de forrageamento. Boas opções incluem couve,
              espinafre, brócolis, cenoura ralada, abobrinha, beterraba e milho
              verde. Lave bem todos os alimentos antes de oferecer e retire
              sobras após algumas horas para evitar proliferação de fungos e
              bactérias.
            </p>
          </section>

          <section class="content-section">
            <h2>Proteínas</h2>
            <p>
              Em períodos de reprodução, muda de penas ou recuperação, algumas
              espécies se beneficiam de fontes proteicas como ovo cozido picado,
              leguminosas cozidas (feijão, lentilha) e insetos. Consulte um
              veterinário especializado antes de incluir proteínas animais na
              dieta regularmente.
            </p>
          </section>

          <section class="content-section">
            <h2>Água</h2>
            <p>
              Água fresca e limpa deve estar disponível o tempo todo. Troque
              diariamente e higienize o bebedouro ao menos três vezes por semana
              com água quente e vinagre ou produto seguro para aves. Evite
              bebedouros abertos em que a ave possa defecar ou sujar facilmente.
            </p>
          </section>

          <section class="content-section">
            <h2>Alimentos Proibidos</h2>
            <p>
              Alguns alimentos são tóxicos e podem ser fatais para as aves.
              Nunca ofereça os itens abaixo:
            </p>
            <ul>
              <li>Abacate — altamente tóxico para todas as espécies</li>
              <li>Cebola e alho — causam anemia hemolítica</li>
              <li>Chocolate e cacau — tóxicos ao sistema nervoso</li>
              <li>Cafeína (café, chá preto, refrigerantes)</li>
              <li>Sal em excesso e alimentos processados</li>
              <li>Sementes de maçã, pera e cereja — contêm cianeto</li>
              <li>Álcool em qualquer forma</li>
              <li>Leite e derivados — aves são intolerantes à lactose</li>
            </ul>
          </section>

          <section class="content-section">
            <h2>Suplementação</h2>
            <p>
              A suplementação vitamínica e mineral pode ser necessária em casos
              específicos, como aves em crescimento, fêmeas em postura ou
              animais em recuperação. Nunca suplementar sem orientação
              veterinária, pois o excesso de certas vitaminas como A e D3 pode
              ser prejudicial.
            </p>
          </section>

          <section class="content-section">
            <h2>Dicas Gerais</h2>
            <ul>
              <li>Ofereça alimentos frescos sempre no período da manhã.</li>
              <li>
                Retire sobras após 2 a 3 horas, especialmente frutas e vegetais.
              </li>
              <li>
                Introduza novos alimentos gradualmente para evitar recusa.
              </li>
              <li>
                Varie o cardápio semanalmente para garantir diversidade
                nutricional.
              </li>
              <li>
                Consulte um veterinário de aves para montar um plano alimentar
                ideal.
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
