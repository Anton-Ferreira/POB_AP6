// =====================================================================
// BANCO DE DADOS DINÂMICO
// =====================================================================

let bancoDeDados = [];

// =====================================================================
// CONFIGURAÇÕES
// =====================================================================

const CARDS_PROXIMOS = 3;

const coresMarcador = {
  criadouro: "#889063",
  petshop: "#4c3d19",
  parque: "#354024",
  veterinario: "#7a4fa3",
};

const emojiMarcador = {
  criadouro: "🌿",
  petshop: "🐾",
  parque: "🌳",
  veterinario: "🩺",
};

// =====================================================================
// ESTADO GLOBAL
// =====================================================================

let mapaGoogle = null;

let marcadores = [];

let infoWindowAberta = null;

let userMarker = null;

let userCoords = null;

let centroReferencia = null;

let ultimoCentroBusca = null;

let mostrandoTodos = false;

let recarregandoLocais = false;

let debounceRecarga = null;

const DISTANCIA_MINIMA_RECARGA_KM = 0.4;

// =====================================================================
// HAVERSINE
// =====================================================================

function haversine(lat1, lng1, lat2, lng2) {
  const R = 6371;

  const dLat = ((lat2 - lat1) * Math.PI) / 180;

  const dLng = ((lng2 - lng1) * Math.PI) / 180;

  const a =
    Math.sin(dLat / 2) ** 2 +
    Math.cos((lat1 * Math.PI) / 180) *
      Math.cos((lat2 * Math.PI) / 180) *
      Math.sin(dLng / 2) ** 2;

  return R * 2 * Math.asin(Math.sqrt(a));
}

function obterCentroBusca(location = null) {
  if (location) {
    return location;
  }

  const center = mapaGoogle.getCenter();

  return {
    lat: center.lat(),
    lng: center.lng(),
  };
}

function centroMudouSignificativamente(centro) {
  if (!ultimoCentroBusca) {
    return true;
  }

  return (
    haversine(
      ultimoCentroBusca.lat,
      ultimoCentroBusca.lng,
      centro.lat,
      centro.lng,
    ) >= DISTANCIA_MINIMA_RECARGA_KM
  );
}

function definirCentroReferencia(centro) {
  centroReferencia = centro;
  ultimoCentroBusca = centro;
}

function indicarCarregamentoLocais(carregando) {
  const countLabel = document.getElementById("count-label");

  if (carregando) {
    countLabel.textContent = "(...)";
  }
}

function formatarDistancia(km) {
  if (km < 1) {
    return `${Math.round(km * 1000)} m`;
  }

  return `${km.toFixed(1)} km`;
}

function obterImagemDePhotos(photos) {
  if (!photos || photos.length === 0) {
    return null;
  }

  try {
    return photos[0].getUrl({ maxWidth: 400, maxHeight: 400 });
  } catch {
    return null;
  }
}

function buscarImagemPlace(place) {
  const imagemDireta = obterImagemDePhotos(place.photos);
  if (imagemDireta) {
    return Promise.resolve(imagemDireta);
  }

  if (!place.place_id) {
    return Promise.resolve(null);
  }

  return new Promise((resolve) => {
    const service = new google.maps.places.PlacesService(mapaGoogle);

    service.getDetails(
      { placeId: place.place_id, fields: ["photos"] },
      (detalhe, status) => {
        if (status !== google.maps.places.PlacesServiceStatus.OK) {
          resolve(null);
          return;
        }

        resolve(obterImagemDePhotos(detalhe.photos));
      },
    );
  });
}

async function montarLocal(place, index, categoria) {
  const imagem = await buscarImagemPlace(place);

  return {
    id: place.place_id || `${Date.now()}-${index}`,
    placeId: place.place_id || null,
    lat: place.geometry.location.lat(),
    lng: place.geometry.location.lng(),
    titulo: place.name,
    endereco: place.vicinity || place.formatted_address || "Endereço não informado",
    avaliacao: place.rating || 0,
    categoria,
    tagLabel:
      categoria === "petshop"
        ? "Pet Shop Especializado"
        : categoria === "criadouro"
          ? "Criadouro"
          : categoria === "veterinario"
            ? "Veterinário"
            : "Parque",
    tagClass: categoria === "petshop" ? "brown" : "",
    imagem,
  };
}

// =====================================================================
// BUSCA GOOGLE PLACES
// =====================================================================

async function buscarLocaisGoogle(keyword, categoria, location = null) {
  const results = await new Promise((resolve) => {
    const service = new google.maps.places.PlacesService(mapaGoogle);

    service.nearbySearch(
      {
        location: location || mapaGoogle.getCenter(),
        radius: 15000,
        keyword,
      },
      (places, status) => {
        if (status !== google.maps.places.PlacesServiceStatus.OK || !places) {
          resolve([]);
          return;
        }

        resolve(places);
      },
    );
  });

  return Promise.all(
    results.map((place, index) => montarLocal(place, index, categoria)),
  );
}

// =====================================================================
// CARREGA LOCAIS AUTOMÁTICOS
// =====================================================================

async function carregarLocaisAutomaticos(location = null, forcar = false) {
  if (!mapaGoogle || recarregandoLocais) {
    return;
  }

  const centro = obterCentroBusca(location);

  if (!forcar && !centroMudouSignificativamente(centro)) {
    return;
  }

  recarregandoLocais = true;
  indicarCarregamentoLocais(true);

  try {
    const [petshops, criadouros, parques, veterinarios] = await Promise.all([
      buscarLocaisGoogle("pet shop aves", "petshop", centro),
      buscarLocaisGoogle("criadouro de aves", "criadouro", centro),
      buscarLocaisGoogle("parque", "parque", centro),
      buscarLocaisGoogle("veterinário aves", "veterinario", centro),
    ]);

    bancoDeDados = [...petshops, ...criadouros, ...parques, ...veterinarios];
    definirCentroReferencia(centro);

    limparMarcadores();

    criarMarcadores();

    aplicarFiltros();
  } finally {
    recarregandoLocais = false;
  }
}

// =====================================================================
// LIMPA MARCADORES
// =====================================================================

function limparMarcadores() {
  marcadores.forEach(({ marcador }) => {
    marcador.map = null;
  });

  marcadores = [];
}

// =====================================================================
// CRIA MARCADORES
// =====================================================================

function criarMarcadores() {
  bancoDeDados.forEach((local) => {
    const cor = coresMarcador[local.categoria];

    const pin = new google.maps.marker.PinElement({
      background: cor,

      borderColor: "#fff",

      glyphColor: "#fff",

      glyph: emojiMarcador[local.categoria],
    });

    const marcador = new google.maps.marker.AdvancedMarkerElement({
      position: {
        lat: local.lat,

        lng: local.lng,
      },

      map: mapaGoogle,

      title: local.titulo,

      content: pin.element,
    });

    const conteudo = `
      <div class="info-window">

        <h4>${local.titulo}</h4>

        <p>${local.endereco}</p>

        <span class="info-tag ${local.tagClass}">
          ${local.tagLabel}
        </span>

      </div>
    `;

    const infoWindow = new google.maps.InfoWindow({
      content: conteudo,
    });

    marcador.addListener("click", () => {
      if (infoWindowAberta) {
        infoWindowAberta.close();
      }

      infoWindow.open(mapaGoogle, marcador);

      infoWindowAberta = infoWindow;

      destacarCard(local.id);
    });

    marcadores.push({
      marcador,

      local,

      infoWindow,
    });
  });
}

// =====================================================================
// GERA CARDS
// =====================================================================

function gerarCards(locaisFiltrados) {
  const container = document.getElementById("cards-container");

  const verTodosLink = document.getElementById("ver-todos");

  container.innerHTML = "";

  if (locaisFiltrados.length === 0) {
    container.innerHTML = `
      <div style="padding:20px; color:#888;">
        Nenhum local encontrado.
      </div>
    `;

    document.getElementById("count-label").textContent = "(0)";

    return;
  }

  const ordenados = [...locaisFiltrados].sort((a, b) => {
    if (!centroReferencia) return 0;

    const da = haversine(
      centroReferencia.lat,
      centroReferencia.lng,
      a.lat,
      a.lng,
    );

    const db = haversine(
      centroReferencia.lat,
      centroReferencia.lng,
      b.lat,
      b.lng,
    );

    return da - db;
  });

  const locaisParaExibir =
    !mostrandoTodos && ordenados.length > CARDS_PROXIMOS
      ? ordenados.slice(0, CARDS_PROXIMOS)
      : ordenados;

  verTodosLink.style.display =
    ordenados.length > CARDS_PROXIMOS ? "inline" : "none";

  verTodosLink.textContent = mostrandoTodos
    ? "Ver próximos"
    : `Ver todos (${ordenados.length})`;

  locaisParaExibir.forEach((local) => {
    const distKm = centroReferencia
      ? haversine(centroReferencia.lat, centroReferencia.lng, local.lat, local.lng)
      : null;

    const distLabel = distKm !== null ? formatarDistancia(distKm) : "—";

    const card = document.createElement("div");

    card.className = local.imagem ? "card" : "card card-sem-imagem";

    card.dataset.id = local.id;

    const imagemHtml = local.imagem
      ? `<img src="${local.imagem}" alt="${local.titulo}" />`
      : "";

    card.innerHTML = `
        ${imagemHtml}

        <div class="card-content">

          <span class="tag ${local.tagClass ? local.tagClass + "-tag" : ""}">
            ${local.tagLabel}
          </span>

          <h3>${local.titulo}</h3>

          <p>${local.endereco}</p>

          <div class="card-footer">
            <span>★ ${local.avaliacao.toFixed(1)}</span>

            <span>${distLabel}</span>
          </div>

        </div>
      `;

    card.addEventListener("click", () => {
      const item = marcadores.find((m) => m.local.id === local.id);

      if (!item) return;

      mapaGoogle.panTo({
        lat: local.lat,

        lng: local.lng,
      });

      mapaGoogle.setZoom(15);

      if (infoWindowAberta) {
        infoWindowAberta.close();
      }

      item.infoWindow.open(mapaGoogle, item.marcador);

      infoWindowAberta = item.infoWindow;

      destacarCard(local.id);
    });

    container.appendChild(card);
  });

  document.getElementById("count-label").textContent = `(${ordenados.length})`;
}

// =====================================================================
// FILTROS
// =====================================================================

function filtrosAtivos() {
  return {
    criadouro: document.getElementById("cb-criadouro").checked,

    petshop: document.getElementById("cb-petshop").checked,

    parque: document.getElementById("cb-parque").checked,

    veterinario: document.getElementById("cb-veterinario").checked,
  };
}

function aplicarFiltros() {
  const ativos = filtrosAtivos();

  marcadores.forEach(({ marcador, local }) => {
    marcador.map = ativos[local.categoria] ? mapaGoogle : null;
  });

  const locaisFiltrados = bancoDeDados.filter((l) => ativos[l.categoria]);

  gerarCards(locaisFiltrados);
}

function limparFiltros() {
  ["cb-criadouro", "cb-petshop", "cb-parque", "cb-veterinario"].forEach(
    (id) => {
      document.getElementById(id).checked = false;
    },
  );

  aplicarFiltros();
}

// =====================================================================
// DESTACA CARD
// =====================================================================

function destacarCard(id) {
  document.querySelectorAll(".card").forEach((card) => {
    card.classList.remove("active");

    if (parseInt(card.dataset.id) === id || card.dataset.id === String(id)) {
      card.classList.add("active");

      card.scrollIntoView({
        behavior: "smooth",

        inline: "center",

        block: "nearest",
      });
    }
  });
}

// =====================================================================
// GEOLOCALIZAÇÃO
// =====================================================================

async function obterEstadoPermissaoGeolocalizacao() {
  if (!navigator.geolocation) {
    return "unsupported";
  }

  if (!navigator.permissions?.query) {
    return "unknown";
  }

  try {
    const result = await navigator.permissions.query({ name: "geolocation" });
    return result.state;
  } catch {
    return "unknown";
  }
}

function obterPosicaoUsuario() {
  return new Promise((resolve, reject) => {
    navigator.geolocation.getCurrentPosition(resolve, reject, {
      enableHighAccuracy: false,
      maximumAge: 300000,
      timeout: 10000,
    });
  });
}

async function aplicarLocalizacaoUsuario(exibirErro = true) {
  if (!navigator.geolocation) {
    if (exibirErro) {
      alert("Geolocalização não suportada.");
    }

    return false;
  }

  try {
    const position = await obterPosicaoUsuario();

    userCoords = {
      lat: position.coords.latitude,
      lng: position.coords.longitude,
    };

    mapaGoogle.panTo(userCoords);
    mapaGoogle.setZoom(14);

    await carregarLocaisAutomaticos(userCoords, true);
    criarMarcadorUsuario(userCoords);

    return true;
  } catch {
    if (exibirErro) {
      alert("Não foi possível obter sua localização.");
    }

    return false;
  }
}

async function centralizarSePermissaoConcedida() {
  const permissao = await obterEstadoPermissaoGeolocalizacao();

  if (permissao !== "granted") {
    return null;
  }

  try {
    const position = await obterPosicaoUsuario();

    return {
      lat: position.coords.latitude,
      lng: position.coords.longitude,
    };
  } catch {
    return null;
  }
}

function criarMarcadorUsuario(coords) {
  if (userMarker) {
    userMarker.map = null;
  }

  userMarker = new google.maps.Marker({
    position: coords,
    map: mapaGoogle,
    title: "Sua localização",
  });
}

function configurarInteracaoMapa() {
  mapaGoogle.addListener("idle", () => {
    clearTimeout(debounceRecarga);

    debounceRecarga = setTimeout(() => {
      carregarLocaisAutomaticos();
    }, 700);
  });

  mapaGoogle.addListener("click", (event) => {
    const coords = {
      lat: event.latLng.lat(),
      lng: event.latLng.lng(),
    };

    clearTimeout(debounceRecarga);
    carregarLocaisAutomaticos(coords, true);
  });
}

// =====================================================================
// MAPA
// =====================================================================

window.initMap = async function () {
  const loading = document.getElementById("map-loading");

  try {
    const { Map } = await google.maps.importLibrary("maps");

    await google.maps.importLibrary("marker");

    const coordsUsuario = await centralizarSePermissaoConcedida();

    if (coordsUsuario) {
      userCoords = coordsUsuario;
    }

    mapaGoogle = new Map(document.getElementById("map"), {
      center: coordsUsuario || {
        lat: -23.56,
        lng: -46.645,
      },
      zoom: coordsUsuario ? 14 : 12,
      mapId: "DEMO_MAP_ID",
      mapTypeControl: false,
      streetViewControl: false,
    });

    configurarInteracaoMapa();

    if (coordsUsuario) {
      await carregarLocaisAutomaticos(coordsUsuario, true);
      criarMarcadorUsuario(coordsUsuario);
    } else {
      await carregarLocaisAutomaticos(null, true);
    }
  } catch (error) {
    console.error("Erro ao carregar o mapa:", error);
    gerarCards([]);
  } finally {
    loading.classList.add("hidden");

    setTimeout(() => {
      loading.remove();
    }, 500);
  }
};

// =====================================================================
// EVENTOS
// =====================================================================

document
  .getElementById("btn-aplicar")
  .addEventListener("click", aplicarFiltros);

document.getElementById("btn-limpar").addEventListener("click", limparFiltros);

document.getElementById("ver-todos").addEventListener("click", (e) => {
  e.preventDefault();

  mostrandoTodos = !mostrandoTodos;

  aplicarFiltros();
});

// =====================================================================
// GEOLOCALIZAÇÃO
// =====================================================================

document.getElementById("btn-location").addEventListener("click", () => {
  aplicarLocalizacaoUsuario(true);
});

// =====================================================================
// PESQUISA
// =====================================================================

document
  .getElementById("search-input")
  .addEventListener("keypress", async (e) => {
    if (e.key !== "Enter") return;

    const termo = e.target.value.trim();

    if (!termo) return;

    const service = new google.maps.places.PlacesService(mapaGoogle);

    service.textSearch(
      {
        query: termo,

        location: mapaGoogle.getCenter(),

        radius: 15000,
      },

      (results, status) => {
        if (status !== google.maps.places.PlacesServiceStatus.OK) {
          alert("Nenhum local encontrado.");

          return;
        }

        Promise.all(
          results.map(async (place, index) => ({
            ...(await montarLocal(place, index, "petshop")),
            tagLabel: "Resultado da Busca",
            tagClass: "brown",
          })),
        ).then((locais) => {
          bancoDeDados = locais;

          if (bancoDeDados.length > 0) {
            definirCentroReferencia({
              lat: bancoDeDados[0].lat,
              lng: bancoDeDados[0].lng,
            });
          }

          limparMarcadores();

          criarMarcadores();

          gerarCards(bancoDeDados);

          if (bancoDeDados.length > 0) {
            mapaGoogle.panTo({
              lat: bancoDeDados[0].lat,
              lng: bancoDeDados[0].lng,
            });
          }
        });
      },
    );
  });
