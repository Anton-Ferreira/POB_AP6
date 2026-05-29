const inputPesquisa = document.querySelector(".search-box input");

const botaoPesquisa = document.querySelector(".search-box button");

// =========================
// LISTA DE ESPÉCIES
// =========================

const contextPath = window.APP_CONTEXT_PATH || "";

const especies = {
  calopsita: contextPath + "/calopsita",
  canario: contextPath + "/wiki",
  agapornis: contextPath + "/wiki",
  periquito: contextPath + "/wiki",
  cacatua: contextPath + "/wiki",
  papagaio: contextPath + "/wiki",
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
