<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Aves Legalizadas</title>

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />

    <link
      href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;700&family=Poppins:wght@300;400;500;600&display=swap"
      rel="stylesheet"
    />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/styles/style.css" />
  </head>

  <body>
    <header>
      <nav>
        <div class="logo">Aves Legalizadas</div>

        <div class="menu">
          <a href="${pageContext.request.contextPath}/">Início</a>
          <a href="#quiz">Quiz</a>
          <a href="${pageContext.request.contextPath}/wiki">Espécies</a>
          <a href="${pageContext.request.contextPath}/mapa">Mapa</a>
        </div>
      </nav>
    </header>

    <section class="hero">
      <div class="overlay"></div>

      <div class="hero-content">
        <h1>Posse Responsável e Legal de Aves Domésticas</h1>

        <p>
          Uma plataforma criada para orientar futuros tutores sobre espécies,
          cuidados, legalização e bem-estar animal.
        </p>

        <div class="hero-buttons">
          <button
            class="primary-btn"
            onclick="
              document
                .getElementById('quiz')
                .scrollIntoView({ behavior: 'smooth' })
            "
          >
            Fazer Quiz
          </button>

          <button
            class="secondary-btn"
            onclick="window.location.href = '${pageContext.request.contextPath}/especies'"
          >
            Explorar Espécies
          </button>
        </div>
      </div>
    </section>

    <section class="resources-section">
      <div class="section-title">
        <span>PLATAFORMA</span>

        <h2>Recursos da Plataforma</h2>
      </div>

      <div class="cards-container">
        <div class="resource-card">
          <h3>Descubra sua Ave</h3>

          <p>Quiz inteligente baseado no seu estilo de vida e rotina.</p>
        </div>

        <div class="resource-card">
          <h3>Guia de Espécies</h3>

          <p>
            Informações completas sobre manejo, alimentação e comportamento.
          </p>
        </div>

        <div class="resource-card">
          <h3>Mapa do Tutor</h3>

          <p>Encontre criadouros e locais certificados próximos a você.</p>
        </div>

        <div class="resource-card">
          <h3>Conformidade Legal</h3>

          <p>Aprenda sobre documentação, anilhas e regulamentação.</p>
        </div>
      </div>
    </section>

    <section id="quiz" class="quiz-section">
      <div class="section-title">
        <span>QUIZ</span>
        <h2>Descubra Qual Ave Combina com Você</h2>
      </div>

      <div class="quiz-box">
        <div class="quiz-progress">
          <div class="quiz-progress-bar" id="progressBar"></div>
        </div>
        <p class="quiz-step-label" id="stepLabel">Pergunta 1 de 5</p>

        <div class="quiz-question" id="quizQuestion"></div>

        <div class="quiz-options" id="quizOptions"></div>

        <div class="quiz-result" id="quizResult" style="display: none">
          <div class="result-icon" id="resultIcon"></div>
          <h3 id="resultTitle"></h3>
          <p id="resultDesc"></p>
          <button class="quiz-restart-btn" onclick="restartQuiz()">
            Refazer Quiz
          </button>
        </div>
      </div>
    </section>

    <script src="${pageContext.request.contextPath}/pages/scripts/Quiz.js" defer></script>

    <section class="legal-section">
      <div class="legal-content">
        <span>CONSCIENTIZAÇÃO</span>

        <h2>Por que a legalização importa?</h2>

        <p>
          A compra legalizada ajuda a combater o tráfico de animais, promove o
          bem-estar das aves e garante que o tutor receba um animal saudável e
          devidamente documentado.
        </p>
      </div>
    </section>

    <footer>
      <p>© 2026 - Plataforma de Apoio à Posse Responsável de Aves</p>
    </footer>
  </body>
</html>
