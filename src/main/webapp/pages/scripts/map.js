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

let mostrandoTodos = false;

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

function formatarDistancia(km) {
  if (km < 1) {
    return `${Math.round(km * 1000)} m`;
  }

  return `${km.toFixed(1)} km`;
}

// =====================================================================
// BUSCA GOOGLE PLACES
// =====================================================================

async function buscarLocaisGoogle(keyword, categoria, location = null) {
  return new Promise((resolve, reject) => {
    const service = new google.maps.places.PlacesService(mapaGoogle);

    service.nearbySearch(
      {
        location: location || mapaGoogle.getCenter(),

        radius: 15000,

        keyword,
      },

      (results, status) => {
        if (status !== google.maps.places.PlacesServiceStatus.OK) {
          reject(status);

          return;
        }

        const locais = results.map((place, index) => ({
          id: Date.now() + index,

          lat: place.geometry.location.lat(),

          lng: place.geometry.location.lng(),

          titulo: place.name,

          endereco: place.vicinity || "Endereço não informado",

          avaliacao: place.rating || 0,

          categoria,

          tagLabel:
            categoria === "petshop"
              ? "Pet Shop Especializado"
              : categoria === "criadouro"
                ? "Criadouro"
                : "Parque",

          tagClass: categoria === "petshop" ? "brown" : "",

          imagem:
            categoria === "petshop"
              ? "https://images.unsplash.com/photo-1544923408-75c5cef46f14?q=80&w=400"
              : categoria === "criadouro"
                ? "https://images.unsplash.com/photo-1522926193341-e9ffd686c60f?q=80&w=400"
                : "https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=400",
        }));

        resolve(locais);
      },
    );
  });
}

// =====================================================================
// CARREGA LOCAIS AUTOMÁTICOS
// =====================================================================

async function carregarLocaisAutomaticos(location = null) {
  const petshops = await buscarLocaisGoogle(
    "pet shop aves",
    "petshop",
    location,
  );

  const criadouros = await buscarLocaisGoogle(
    "criadouro de aves",
    "criadouro",
    location,
  );

  const parques = await buscarLocaisGoogle("parque", "parque", location);

  const veterinarios = await buscarLocaisGoogle(
    "veterinário aves",
    "veterinario",
    location,
  );

  bancoDeDados = [...petshops, ...criadouros, ...parques, ...veterinarios];

  limparMarcadores();

  criarMarcadores();

  aplicarFiltros();
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
    if (!userCoords) return 0;

    const da = haversine(userCoords.lat, userCoords.lng, a.lat, a.lng);

    const db = haversine(userCoords.lat, userCoords.lng, b.lat, b.lng);

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
    const distKm = userCoords
      ? haversine(userCoords.lat, userCoords.lng, local.lat, local.lng)
      : null;

    const distLabel = distKm !== null ? formatarDistancia(distKm) : "—";

    const card = document.createElement("div");

    card.className = "card";

    card.dataset.id = local.id;

    card.innerHTML = `
        <img src="${local.imagem}" alt="${local.titulo}" />

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

    if (parseInt(card.dataset.id) === id) {
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
// MAPA
// =====================================================================

window.initMap = async function () {
  const loading = document.getElementById("map-loading");

  const { Map } = await google.maps.importLibrary("maps");

  await google.maps.importLibrary("marker");

  mapaGoogle = new Map(document.getElementById("map"), {
    center: {
      lat: -23.56,

      lng: -46.645,
    },

    zoom: 12,

    mapId: "DEMO_MAP_ID",

    mapTypeControl: false,

    streetViewControl: false,
  });

  await carregarLocaisAutomaticos();

  loading.classList.add("hidden");

  setTimeout(() => {
    loading.remove();
  }, 500);
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
  if (!navigator.geolocation) {
    alert("Geolocalização não suportada.");

    return;
  }

  navigator.geolocation.getCurrentPosition(
    async (position) => {
      userCoords = {
        lat: position.coords.latitude,

        lng: position.coords.longitude,
      };

      mapaGoogle.panTo(userCoords);

      mapaGoogle.setZoom(14);

      await carregarLocaisAutomaticos(userCoords);

      if (userMarker) {
        userMarker.map = null;
      }

      userMarker = new google.maps.Marker({
        position: userCoords,

        map: mapaGoogle,

        title: "Sua localização",
      });
    },

    () => {
      alert("Não foi possível obter sua localização.");
    },
  );
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

        bancoDeDados = results.map((place, index) => ({
          id: Date.now() + index,

          lat: place.geometry.location.lat(),

          lng: place.geometry.location.lng(),

          titulo: place.name,

          endereco: place.formatted_address || "Endereço não informado",

          avaliacao: place.rating || 0,

          categoria: "petshop",

          tagLabel: "Resultado da Busca",

          tagClass: "brown",

          imagem:
            "https://images.unsplash.com/photo-1544923408-75c5cef46f14?q=80&w=400",
        }));

        limparMarcadores();

        criarMarcadores();

        gerarCards(bancoDeDados);

        if (bancoDeDados.length > 0) {
          mapaGoogle.panTo({
            lat: bancoDeDados[0].lat,

            lng: bancoDeDados[0].lng,
          });
        }
      },
    );
  });
