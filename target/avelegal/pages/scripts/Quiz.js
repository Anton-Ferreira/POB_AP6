const avesQuiz = window.AVES_QUIZ || [];

const perguntas = [
  {
    texto: "Quanto tempo livre você possui diariamente?",
    opcoes: [
      {
        label: "Muito tempo (4h+)",
        ajustes: {
          dificuldade: { medio: 2, dificil: 3 },
          ruido: { medio: 1, alto: 2 },
          porte: { medio: 2 },
        },
      },
      {
        label: "Tempo moderado (1–3h)",
        ajustes: {
          dificuldade: { facil: 1, medio: 3 },
          ruido: { medio: 2 },
          porte: { pequeno: 1, medio: 2 },
        },
      },
      {
        label: "Pouco tempo (menos de 1h)",
        ajustes: {
          dificuldade: { facil: 3 },
          ruido: { baixo: 2 },
          porte: { pequeno: 3 },
        },
      },
    ],
  },
  {
    texto: "Qual é o seu nível de experiência com aves?",
    opcoes: [
      {
        label: "Nenhuma experiência",
        ajustes: {
          dificuldade: { facil: 4 },
          porte: { pequeno: 2 },
          ruido: { baixo: 1 },
        },
      },
      {
        label: "Alguma experiência",
        ajustes: {
          dificuldade: { facil: 2, medio: 3 },
          porte: { pequeno: 1, medio: 2 },
        },
      },
      {
        label: "Experiente com aves",
        ajustes: {
          dificuldade: { medio: 2, dificil: 4 },
          ruido: { alto: 2, medio: 1 },
          porte: { medio: 3 },
        },
      },
    ],
  },
  {
    texto: "Como é o seu ambiente doméstico?",
    opcoes: [
      {
        label: "Apartamento pequeno",
        ajustes: {
          porte: { pequeno: 4 },
          ruido: { baixo: 2, medio: 1 },
          dificuldade: { facil: 2 },
        },
      },
      {
        label: "Apartamento espaçoso",
        ajustes: {
          porte: { pequeno: 2, medio: 3 },
          dificuldade: { facil: 1, medio: 2 },
        },
      },
      {
        label: "Casa com área externa",
        ajustes: {
          porte: { medio: 4 },
          dificuldade: { medio: 2, dificil: 2 },
          ruido: { alto: 1, medio: 2 },
        },
      },
    ],
  },
  {
    texto: "Você prefere uma ave que interaja verbalmente?",
    opcoes: [
      {
        label: "Sim, adoro conversas!",
        ajustes: {
          ruido: { alto: 4, medio: 2 },
          dificuldade: { medio: 2, dificil: 2 },
        },
      },
      {
        label: "Um pouco está ótimo",
        ajustes: {
          ruido: { medio: 4, alto: 1 },
          dificuldade: { facil: 1, medio: 2 },
        },
      },
      {
        label: "Prefiro algo mais silencioso",
        ajustes: {
          ruido: { baixo: 4 },
          porte: { pequeno: 2 },
          dificuldade: { facil: 2 },
        },
      },
    ],
  },
  {
    texto: "Qual é o seu orçamento mensal para cuidados?",
    opcoes: [
      {
        label: "Econômico (até R$100)",
        ajustes: {
          porte: { pequeno: 3 },
          dificuldade: { facil: 3 },
          ruido: { baixo: 1 },
        },
      },
      {
        label: "Moderado (R$100–250)",
        ajustes: {
          porte: { pequeno: 2, medio: 2 },
          dificuldade: { facil: 1, medio: 3 },
        },
      },
      {
        label: "Sem restrições",
        ajustes: {
          porte: { medio: 3 },
          dificuldade: { medio: 2, dificil: 3 },
          ruido: { alto: 1, medio: 2 },
        },
      },
    ],
  },
];

let etapa = 0;
let preferencias = criarPreferencias();

function criarPreferencias() {
  return {
    dificuldade: { facil: 0, medio: 0, dificil: 0 },
    ruido: { baixo: 0, medio: 0, alto: 0 },
    porte: { pequeno: 0, medio: 0 },
  };
}

function aplicarAjustes(ajustes) {
  for (const eixo in ajustes) {
    for (const chave in ajustes[eixo]) {
      preferencias[eixo][chave] += ajustes[eixo][chave];
    }
  }
}

function pontuarAve(ave) {
  let score = 0;

  score += preferencias.dificuldade[ave.dificuldade] || 0;
  score += preferencias.ruido[ave.ruido] || 0;
  score += preferencias.porte[ave.porte] || 0;

  return score;
}

function obterIconePorte(porte) {
  if (porte === "pequeno") {
    return "🐦";
  }
  return "🦜";
}

function renderPergunta() {
  const total = perguntas.length;
  const q = perguntas[etapa];

  document.getElementById("progressBar").style.width =
    (etapa / total) * 100 + "%";
  document.getElementById("stepLabel").textContent =
    `Pergunta ${etapa + 1} de ${total}`;

  const qEl = document.getElementById("quizQuestion");
  qEl.classList.remove("slide-in");
  void qEl.offsetWidth;
  qEl.textContent = q.texto;
  qEl.classList.add("slide-in");

  const optsEl = document.getElementById("quizOptions");
  optsEl.innerHTML = "";
  optsEl.classList.remove("slide-in");
  void optsEl.offsetWidth;
  optsEl.classList.add("slide-in");

  q.opcoes.forEach((op) => {
    const btn = document.createElement("button");
    btn.textContent = op.label;
    btn.onclick = () => escolher(op.ajustes);
    optsEl.appendChild(btn);
  });
}

function escolher(ajustes) {
  aplicarAjustes(ajustes);
  etapa++;

  if (etapa < perguntas.length) {
    renderPergunta();
  } else {
    mostrarResultado();
  }
}

function encontrarMelhorAve() {
  if (!avesQuiz.length) {
    return null;
  }

  const ranking = avesQuiz
    .map((ave) => ({ ave, score: pontuarAve(ave) }))
    .sort((a, b) => b.score - a.score);

  return ranking[0].score > 0 ? ranking[0].ave : avesQuiz[0];
}

function mostrarResultado() {
  document.getElementById("progressBar").style.width = "100%";
  document.getElementById("stepLabel").textContent = "Resultado";
  document.getElementById("quizQuestion").style.display = "none";
  document.getElementById("quizOptions").style.display = "none";

  const vencedora = encontrarMelhorAve();
  const iconEl = document.getElementById("resultIcon");
  const imageWrap = document.getElementById("resultImageWrap");
  const imageEl = document.getElementById("resultImage");
  const titleEl = document.getElementById("resultTitle");
  const descEl = document.getElementById("resultDesc");
  const linkEl = document.getElementById("resultLink");

  if (!vencedora) {
    iconEl.textContent = "🕊️";
    imageWrap.style.display = "none";
    titleEl.textContent = "Nenhuma espécie disponível";
    descEl.textContent =
      "Não foi possível carregar as espécies do banco de dados para recomendar uma ave.";
    linkEl.style.display = "none";
  } else {
    iconEl.textContent = obterIconePorte(vencedora.porte);
    imageEl.src = vencedora.imagem;
    imageEl.alt = vencedora.nome;
    imageWrap.style.display = "block";
    titleEl.textContent = vencedora.nome;
    descEl.textContent = vencedora.resumo;
    linkEl.href = vencedora.url;
    linkEl.style.display = "inline-block";
  }

  const res = document.getElementById("quizResult");
  res.style.display = "block";
  res.classList.add("slide-in");
}

function restartQuiz() {
  etapa = 0;
  preferencias = criarPreferencias();
  document.getElementById("quizResult").style.display = "none";
  document.getElementById("quizQuestion").style.display = "block";
  document.getElementById("quizOptions").style.display = "flex";
  document.getElementById("resultLink").style.display = "none";
  document.getElementById("resultImageWrap").style.display = "none";
  renderPergunta();
}

renderPergunta();
