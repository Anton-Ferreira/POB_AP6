const locais = [
  {
    id: 1,
    lat: -23.55,
    lng: -46.634,
    titulo: "Criadouro Bem-Te-Vi",
    endereco: "Rua dos Pássaros, 123",
    avaliacao: "★ 4.8",
    categoria: "criadouro",
    tagLabel: "Criadouro Autorizado",
    tagClass: "",
  },
  {
    id: 2,
    lat: -23.5615,
    lng: -46.656,
    titulo: "Pet Shop Aves & Cia",
    endereco: "Av. Paulista, 2001",
    avaliacao: "★ 4.6",
    categoria: "petshop",
    tagLabel: "Pet Shop Especializado",
    tagClass: "brown",
  },
  {
    id: 3,
    lat: -23.5874,
    lng: -46.6576,
    titulo: "Parque Ibirapuera",
    endereco: "Av. Pedro Álvares Cabral",
    avaliacao: "★ 4.9",
    categoria: "parque",
    tagLabel: "Parque",
    tagClass: "",
  },
];

const coresMarcador = {
  criadouro: "#889063",
  petshop: "#4c3d19",
  parque: "#354024",
};

const emojiMarcador = {
  criadouro: "🌿",
  petshop: "🐾",
  parque: "🌳",
};

const estiloMapa = [
  { elementType: "geometry", stylers: [{ color: "#f5f1ea" }] },
  { elementType: "labels.text.stroke", stylers: [{ color: "#f5f1ea" }] },
  { elementType: "labels.text.fill", stylers: [{ color: "#4a4030" }] },
  {
    featureType: "administrative.locality",
    elementType: "labels.text.fill",
    stylers: [{ color: "#354024" }],
  },
  {
    featureType: "poi",
    elementType: "labels.text.fill",
    stylers: [{ color: "#888060" }],
  },
  {
    featureType: "poi.park",
    elementType: "geometry",
    stylers: [{ color: "#d4e0b8" }],
  },
  {
    featureType: "poi.park",
    elementType: "labels.text.fill",
    stylers: [{ color: "#354024" }],
  },
  {
    featureType: "road",
    elementType: "geometry",
    stylers: [{ color: "#e8e0d0" }],
  },
  {
    featureType: "road",
    elementType: "geometry.stroke",
    stylers: [{ color: "#d5c9b5" }],
  },
  {
    featureType: "road.highway",
    elementType: "geometry",
    stylers: [{ color: "#d4c09a" }],
  },
  {
    featureType: "road.highway",
    elementType: "geometry.stroke",
    stylers: [{ color: "#c4ae82" }],
  },
  {
    featureType: "transit",
    elementType: "geometry",
    stylers: [{ color: "#e8dfc8" }],
  },
  {
    featureType: "water",
    elementType: "geometry",
    stylers: [{ color: "#b8cfc0" }],
  },
  {
    featureType: "water",
    elementType: "labels.text.fill",
    stylers: [{ color: "#354024" }],
  },
];

let mapaGoogle = null;
let marcadores = [];
let infoWindowAberta = null;
let userMarker = null;

window.initMap = async function () {
  const loading = document.getElementById("map-loading");

  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement, PinElement } =
    await google.maps.importLibrary("marker");

  mapaGoogle = new Map(document.getElementById("map"), {
    center: { lat: -23.56, lng: -46.645 },
    zoom: 13,
    styles: estiloMapa,
    mapId: "DEMO_MAP_ID",
    mapTypeControl: false,
    streetViewControl: false,
    fullscreenControl: true,
    zoomControlOptions: { position: google.maps.ControlPosition.RIGHT_CENTER },
  });

  const { PlaceAutocompleteElement } =
    await google.maps.importLibrary("places");

  const autoCompleteEl = new PlaceAutocompleteElement({
    componentRestrictions: { country: "br" },
  });

  const searchBox = document.querySelector(".search-box");
  const oldInput = document.getElementById("search-input");
  autoCompleteEl.style.cssText =
    "flex:1; border:none; background:transparent; font-size:15px; font-family:'Poppins',sans-serif; outline:none;";
  searchBox.replaceChild(autoCompleteEl, oldInput);

  autoCompleteEl.addEventListener("gmp-placeselect", async (event) => {
    const place = event.place;
    await place.fetchFields({ fields: ["location"] });
    if (place.location) {
      mapaGoogle.panTo(place.location);
      mapaGoogle.setZoom(15);
    }
  });

  locais.forEach((local) => {
    const cor = coresMarcador[local.categoria];

    const pin = new PinElement({
      background: cor,
      borderColor: "#fff",
      glyphColor: "#fff",
      glyph: emojiMarcador[local.categoria],
    });

    const marcador = new AdvancedMarkerElement({
      position: { lat: local.lat, lng: local.lng },
      map: mapaGoogle,
      title: local.titulo,
      content: pin.element,
    });

    const conteudo = `
      <div class="info-window">
        <h4>${local.titulo}</h4>
        <p>${local.endereco}</p>
        <span class="info-tag ${local.tagClass}">${local.tagLabel}</span>
      </div>`;

    const infoWindow = new google.maps.InfoWindow({ content: conteudo });

    marcador.addListener("click", () => {
      if (infoWindowAberta) infoWindowAberta.close();
      infoWindow.open(mapaGoogle, marcador);
      infoWindowAberta = infoWindow;
      destacarCard(local.id);
    });

    marcadores.push({ marcador, local, infoWindow });
  });

  document.querySelectorAll(".card").forEach((card, i) => {
    if (locais[i]) card.dataset.id = locais[i].id;
  });

  document.querySelectorAll(".card").forEach((card) => {
    card.addEventListener("click", () => {
      const id = parseInt(card.dataset.id);
      const item = marcadores.find((m) => m.local.id === id);
      if (!item) return;
      mapaGoogle.panTo({ lat: item.local.lat, lng: item.local.lng });
      mapaGoogle.setZoom(15);
      if (infoWindowAberta) infoWindowAberta.close();
      item.infoWindow.open(mapaGoogle, item.marcador);
      infoWindowAberta = item.infoWindow;
      destacarCard(item.local.id);
    });
  });

  loading.classList.add("hidden");
  setTimeout(() => loading.remove(), 500);
};

function aplicarFiltros() {
  const ativos = {
    criadouro: document.getElementById("cb-criadouro").checked,
    petshop: document.getElementById("cb-petshop").checked,
    parque: document.getElementById("cb-parque").checked,
  };

  let visiveis = 0;

  marcadores.forEach(({ marcador, local }) => {
    const mostrar = ativos[local.categoria];
    marcador.map = mostrar ? mapaGoogle : null;
    if (mostrar) visiveis++;
  });

  document.querySelectorAll(".card").forEach((card) => {
    const cat = card.dataset.categoria;
    card.classList.toggle("hidden", !ativos[cat]);
  });

  document.getElementById("count-label").textContent = `(${visiveis})`;
}

function limparFiltros() {
  ["cb-criadouro", "cb-petshop", "cb-parque"].forEach((id) => {
    document.getElementById(id).checked = false;
  });
  aplicarFiltros();
}

document
  .getElementById("btn-aplicar")
  .addEventListener("click", aplicarFiltros);
document.getElementById("btn-limpar").addEventListener("click", limparFiltros);

["cb-criadouro", "cb-petshop", "cb-parque"].forEach((id) => {
  document.getElementById(id).addEventListener("change", aplicarFiltros);
});

document
  .getElementById("btn-location")
  .addEventListener("click", async function () {
    const btn = this;
    if (!navigator.geolocation) {
      alert("Geolocalização não suportada neste navegador.");
      return;
    }

    btn.classList.add("locating");
    btn.innerHTML =
      '<i class="fa-solid fa-spinner fa-spin"></i> Localizando...';

    navigator.geolocation.getCurrentPosition(
      async (pos) => {
        const coords = { lat: pos.coords.latitude, lng: pos.coords.longitude };

        mapaGoogle.panTo(coords);
        mapaGoogle.setZoom(15);

        if (userMarker) userMarker.map = null;

        const { AdvancedMarkerElement, PinElement } =
          await google.maps.importLibrary("marker");
        const pinUser = new PinElement({
          background: "#354024",
          borderColor: "#fff",
          glyphColor: "#fff",
          glyph: "📍",
          scale: 1.2,
        });

        userMarker = new AdvancedMarkerElement({
          position: coords,
          map: mapaGoogle,
          title: "Você está aqui",
          content: pinUser.element,
        });

        btn.classList.remove("locating");
        btn.innerHTML =
          '<i class="fa-solid fa-location-crosshairs"></i> Minha localização';
      },
      () => {
        btn.classList.remove("locating");
        btn.innerHTML =
          '<i class="fa-solid fa-location-crosshairs"></i> Minha localização';
        alert(
          "Não foi possível obter sua localização. Verifique as permissões do navegador.",
        );
      },
    );
  });

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
