<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Legalização - Wiki das Aves</title>

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
          <h1>Legalização</h1>

          <p class="intro">
            Manter uma ave de forma legal no Brasil é um ato de responsabilidade
            ambiental e social. Entender a legislação vigente, os documentos
            necessários e os canais oficiais garante a posse segura e protege
            tanto o tutor quanto os animais silvestres.
          </p>

          <section class="content-section">
            <h2>Por que Legalizar?</h2>
            <p>
              A legalização da ave é a única forma de comprovar que ela foi
              obtida por meios lícitos, proveniente de criadouro autorizado pelo
              IBAMA. Aves sem documentação podem ter origem no tráfico de
              animais silvestres, uma das maiores ameaças à biodiversidade
              brasileira. Além disso, a posse irregular de animais silvestres é
              crime ambiental previsto na Lei nº 9.605/1998, sujeito a multa e
              até prisão.
            </p>
          </section>

          <section class="content-section">
            <h2>Legislação Vigente</h2>
            <p>
              As principais normas que regulamentam a posse de aves no Brasil
              são:
            </p>
            <ul>
              <li>
                <strong>Lei nº 9.605/1998</strong> — Lei de Crimes Ambientais,
                que criminaliza a posse ilegal de animais silvestres.
              </li>
              <li>
                <strong>Instrução Normativa IBAMA nº 07/2015</strong> —
                regulamenta os criadouros comerciais e não comerciais de animais
                silvestres.
              </li>
              <li>
                <strong>Portaria MMA nº 300/2022</strong> — lista as espécies da
                fauna brasileira ameaçadas de extinção.
              </li>
              <li>
                <strong>Resolução CONAMA nº 457/2013</strong> — dispõe sobre
                procedimentos de licenciamento ambiental para criadouros.
              </li>
            </ul>
          </section>

          <section class="content-section">
            <h2>Espécies Permitidas</h2>
            <p>
              Nem todas as aves podem ser criadas legalmente no Brasil. As
              espécies permitidas para criação em cativeiro são aquelas listadas
              pelo IBAMA como passíveis de criação por criadouros comerciais
              autorizados. Entre as mais comuns estão calopsitas, agapornis,
              periquitos australianos, canários e algumas espécies de papagaios.
              Sempre verifique a listagem atualizada no portal do IBAMA antes de
              adquirir uma ave.
            </p>
          </section>

          <section class="content-section">
            <h2>Anilhamento</h2>
            <p>
              A anilha é um anel metálico ou plástico numerado colocado na pata
              da ave ainda filhote, que funciona como documento de
              identificação. Ela comprova que a ave nasceu em cativeiro em
              criadouro legalizado. Ao adquirir uma ave, exija sempre a anilha
              original e verifique se o número consta nos registros do
              criadouro. Aves sem anilha ou com anilha adulterada não possuem
              origem comprovada.
            </p>
          </section>

          <section class="content-section">
            <h2>Nota Fiscal de Origem</h2>
            <p>
              Além da anilha, a nota fiscal emitida pelo criadouro no momento da
              compra é um documento essencial. Ela deve conter o nome científico
              da espécie, o número da anilha, os dados do criadouro e do
              comprador. Guarde esse documento com segurança — ele pode ser
              exigido por autoridades ambientais em fiscalizações.
            </p>
          </section>

          <section class="content-section">
            <h2>Registro no SISPASS</h2>
            <p>
              O SISPASS é o Sistema de Passarinheiros e Criadores de Pássaros do
              IBAMA. Nele, tutores de aves silvestres podem registrar seus
              animais e emitir documentação oficial de posse. O cadastro é
              gratuito e pode ser feito pelo portal do IBAMA. Manter o registro
              atualizado é fundamental para comprovar a legalidade da posse em
              qualquer situação.
            </p>
          </section>

          <section class="content-section">
            <h2>Criadouros Autorizados</h2>
            <p>
              Adquira aves somente de criadouros com registro ativo no IBAMA. É
              possível consultar a lista de criadouros autorizados diretamente
              no portal oficial do órgão. Desconfie de preços muito abaixo do
              mercado, vendas em feiras livres sem documentação e anúncios que
              não mencionam anilha ou nota fiscal. Esses são sinais comuns de
              animais provenientes do tráfico.
            </p>
          </section>

          <section class="content-section">
            <h2>Transporte de Aves</h2>
            <p>
              O transporte de aves silvestres exige documentação específica.
              Para viagens interestaduais ou internacionais, é necessária a Guia
              de Transporte Animal (GTA), emitida pelo serviço veterinário
              oficial do estado de origem. Mesmo para deslocamentos locais,
              recomenda-se portar a nota fiscal e comprovante de registro sempre
              que transportar a ave.
            </p>
          </section>

          <section class="content-section">
            <h2>O que Fazer em Caso de Apreensão</h2>
            <p>
              Se uma ave for apreendida por falta de documentação, o tutor pode
              responder administrativamente e criminalmente. Em caso de
              fiscalização, apresente toda a documentação disponível. Se a ave
              for apreendida indevidamente, é possível contestar a decisão junto
              ao IBAMA mediante apresentação dos documentos comprobatórios.
              Procure sempre orientação jurídica especializada nesses casos.
            </p>
          </section>

          <section class="content-section">
            <h2>Dicas Gerais</h2>
            <ul>
              <li>
                Nunca adquira aves de vendedores ambulantes ou sem documentação.
              </li>
              <li>
                Verifique o número da anilha no momento da compra, antes de
                fechar negócio.
              </li>
              <li>
                Guarde nota fiscal, comprovante de anilha e registros do SISPASS
                em local seguro.
              </li>
              <li>
                Em caso de dúvida sobre a legalidade de uma espécie, consulte o
                IBAMA.
              </li>
              <li>
                Denuncie o tráfico de animais pelo telefone 0800 61 8080 (linha
                verde do IBAMA).
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
