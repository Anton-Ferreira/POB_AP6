const inputPesquisa = document.querySelector(".search-box input");

const botaoPesquisa = document.querySelector(".search-box button");

// =========================
// LISTA DE ESPÉCIES
// =========================

const especies = {
  calopsita: "calopsita.html",

  canario: "canario.html",

  agapornis: "agapornis.html",

  periquito: "periquito.html",

  cacatua: "cacatua.html",

  papagaio: "papagaio.html",
};

// =========================
// PESQUISAR
// =========================

function pesquisarEspecie() {
  let valor = inputPesquisa.value
    .toLowerCase()
    .trim()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "");

  // remove espaços extras
  valor = valor.replace(/\s+/g, " ");

  if (especies[valor]) {
    window.location.href = especies[valor];
  } else {
    alert("Espécie não encontrada.");
  }
}

// =========================
// EVENTOS
// =========================

// Clique no botão
botaoPesquisa.addEventListener("click", pesquisarEspecie);

// Enter no teclado
inputPesquisa.addEventListener("keydown", function (event) {
  if (event.key === "Enter") {
    pesquisarEspecie();
  }
});
