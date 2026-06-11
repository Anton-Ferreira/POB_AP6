const formPesquisa = document.getElementById("form-pesquisa-especie");

function obterAreaPrincipal() {
  return (
    document.querySelector(".wiki-content") ||
    document.querySelector(".article-content") ||
    document.querySelector(".page-layout") ||
    document.querySelector("main")
  );
}

function ocultarErroPesquisa() {
  const panel = document.getElementById("pesquisa-erro");
  if (panel) {
    panel.hidden = true;
  }
}

function mostrarErroPesquisa() {
  let panel = document.getElementById("pesquisa-erro");
  const areaPrincipal = obterAreaPrincipal();

  if (!areaPrincipal) {
    return;
  }

  if (!panel) {
    panel = document.createElement("div");
    panel.id = "pesquisa-erro";
    panel.className = "pesquisa-erro";
    panel.setAttribute("role", "alert");
    areaPrincipal.insertBefore(panel, areaPrincipal.firstChild);
  } else if (panel.parentElement !== areaPrincipal) {
    areaPrincipal.insertBefore(panel, areaPrincipal.firstChild);
  }

  panel.textContent = "Espécie não encontrada.";
  panel.hidden = false;
}

function limparParametroErroPesquisa() {
  const url = new URL(window.location.href);
  if (!url.searchParams.has("pesquisaErro")) {
    return;
  }

  url.searchParams.delete("pesquisaErro");
  history.replaceState({}, "", url.pathname + url.search + url.hash);
}

if (formPesquisa) {
  const inputPesquisa = formPesquisa.querySelector("input[name='termo']");
  const contextPath = window.APP_CONTEXT_PATH || "";

  async function pesquisarEspecie(event) {
    event.preventDefault();

    const termo = inputPesquisa.value.trim();
    if (!termo) {
      return;
    }

    ocultarErroPesquisa();

    try {
      const url =
        contextPath +
        "/pesquisar?termo=" +
        encodeURIComponent(termo);

      const response = await fetch(url, {
        headers: { Accept: "application/json" },
      });

      if (!response.ok) {
        mostrarErroPesquisa();
        return;
      }

      const data = await response.json();

      if (data.found && data.url) {
        window.location.href = data.url;
      } else {
        mostrarErroPesquisa();
      }
    } catch (error) {
      formPesquisa.submit();
    }
  }

  formPesquisa.addEventListener("submit", pesquisarEspecie);
  inputPesquisa.addEventListener("input", ocultarErroPesquisa);

  if (new URLSearchParams(window.location.search).get("pesquisaErro") === "1") {
    mostrarErroPesquisa();
    limparParametroErroPesquisa();
  }
}
