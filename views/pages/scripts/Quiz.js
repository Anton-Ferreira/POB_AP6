const perguntas = [
  {
    texto: "Quanto tempo livre você possui diariamente?",
    opcoes: [
      {
        label: "Muito tempo (4h+)",
        pontos: { calopsita: 3, papagaio: 3, periquito: 1 },
      },
      {
        label: "Tempo moderado (1–3h)",
        pontos: { calopsita: 2, papagaio: 1, periquito: 2 },
      },
      {
        label: "Pouco tempo (menos de 1h)",
        pontos: { calopsita: 0, papagaio: 0, periquito: 3 },
      },
    ],
  },
  {
    texto: "Qual é o seu nível de experiência com aves?",
    opcoes: [
      {
        label: "Nenhuma experiência",
        pontos: { calopsita: 2, papagaio: 0, periquito: 3 },
      },
      {
        label: "Alguma experiência",
        pontos: { calopsita: 3, papagaio: 1, periquito: 2 },
      },
      {
        label: "Experiente com aves",
        pontos: { calopsita: 1, papagaio: 3, periquito: 1 },
      },
    ],
  },
  {
    texto: "Como é o seu ambiente doméstico?",
    opcoes: [
      {
        label: "Apartamento pequeno",
        pontos: { calopsita: 2, papagaio: 1, periquito: 3 },
      },
      {
        label: "Apartamento espaçoso",
        pontos: { calopsita: 3, papagaio: 2, periquito: 2 },
      },
      {
        label: "Casa com área externa",
        pontos: { calopsita: 2, papagaio: 3, periquito: 1 },
      },
    ],
  },
  {
    texto: "Você prefere uma ave que interaja verbalmente?",
    opcoes: [
      {
        label: "Sim, adoro conversas!",
        pontos: { calopsita: 1, papagaio: 3, periquito: 0 },
      },
      {
        label: "Um pouco está ótimo",
        pontos: { calopsita: 3, papagaio: 1, periquito: 2 },
      },
      {
        label: "Prefiro algo mais silencioso",
        pontos: { calopsita: 1, papagaio: 0, periquito: 3 },
      },
    ],
  },
  {
    texto: "Qual é o seu orçamento mensal para cuidados?",
    opcoes: [
      {
        label: "Econômico (até R$100)",
        pontos: { calopsita: 1, papagaio: 0, periquito: 3 },
      },
      {
        label: "Moderado (R$100–250)",
        pontos: { calopsita: 3, papagaio: 1, periquito: 2 },
      },
      {
        label: "Sem restrições",
        pontos: { calopsita: 1, papagaio: 3, periquito: 1 },
      },
    ],
  },
];

const resultados = {
  calopsita: {
    icon: "🦜",
    titulo: "Calopsita",
    desc: "Carinhosa, sociável e de fácil manejo — a calopsita é perfeita para quem quer um companheiro afetivo sem precisar de muita experiência prévia. Ela adora atenção e aprende truques com facilidade.",
  },
  papagaio: {
    icon: "🦚",
    titulo: "Papagaio",
    desc: "Inteligente, vocal e cheio de personalidade! O papagaio exige dedicação, espaço e experiência, mas recompensa com anos de companhia única e conversas surpreendentes.",
  },
  periquito: {
    icon: "🐦",
    titulo: "Periquito Australiano",
    desc: "Alegre, resistente e adaptável — o periquito é ideal para rotinas mais corridas e espaços menores. Perfeito para iniciantes que querem começar a experiência com aves.",
  },
};

let etapa = 0;
let pontuacao = { calopsita: 0, papagaio: 0, periquito: 0 };

function renderPergunta() {
  const total = perguntas.length;
  const q = perguntas[etapa];

  document.getElementById("progressBar").style.width =
    (etapa / total) * 100 + "%";
  document.getElementById("stepLabel").textContent =
    `Pergunta ${etapa + 1} de ${total}`;

  const qEl = document.getElementById("quizQuestion");
  qEl.classList.remove("slide-in");
  void qEl.offsetWidth; // reflow para reiniciar a animação
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
    btn.onclick = () => escolher(op.pontos);
    optsEl.appendChild(btn);
  });
}

function escolher(pontos) {
  for (const ave in pontos) pontuacao[ave] += pontos[ave];
  etapa++;
  if (etapa < perguntas.length) {
    renderPergunta();
  } else {
    mostrarResultado();
  }
}

function mostrarResultado() {
  document.getElementById("progressBar").style.width = "100%";
  document.getElementById("stepLabel").textContent = "Resultado";
  document.getElementById("quizQuestion").style.display = "none";
  document.getElementById("quizOptions").style.display = "none";

  const vencedor = Object.entries(pontuacao).sort((a, b) => b[1] - a[1])[0][0];
  const r = resultados[vencedor];

  document.getElementById("resultIcon").textContent = r.icon;
  document.getElementById("resultTitle").textContent = r.titulo;
  document.getElementById("resultDesc").textContent = r.desc;

  const res = document.getElementById("quizResult");
  res.style.display = "block";
  res.classList.add("slide-in");
}

function restartQuiz() {
  etapa = 0;
  pontuacao = { calopsita: 0, papagaio: 0, periquito: 0 };
  document.getElementById("quizResult").style.display = "none";
  document.getElementById("quizQuestion").style.display = "block";
  document.getElementById("quizOptions").style.display = "flex";
  renderPergunta();
}

renderPergunta();
