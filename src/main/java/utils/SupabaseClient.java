package utils;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import models.Ave;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class SupabaseClient {

    private static final String BASE_URL = env(
            "SUPABASE_URL",
            "https://ahvzzrxinxfzoxdvgweu.supabase.co"
    );
    private static final String ANON_KEY = env("SUPABASE_ANON_KEY", "");

    private static final String CAMPOS_AVE =
            "id,nome_popular,nome_cientifico,expectativa_vida,resumo_breve,"
            + "caracteristicas_fisicas,tamanho_medio_cm,comportamento_temperamento,"
            + "nivel_ruido,guia_alimentacao,alimentos_proibidos,requisitos_gaiola,"
            + "sinais_alerta_saude,legislacao_info,curiosidades,enriquecimento_ambiental,"
            + "status_legal_ave,dificuldade_de_criacao,image_url";

    private static final HttpClient HTTP = HttpClient.newHttpClient();
    private static final Gson GSON = new Gson();

    public static List<Ave> listarAves() throws Exception {
        return buscarAves("order=nome_popular.asc");
    }

    public static Optional<Ave> buscarPorSlug(String slug) throws Exception {
        if (slug == null || slug.isBlank()) {
            return Optional.empty();
        }

        String slugNormalizado = slug.trim().toLowerCase();

        for (Ave ave : listarAves()) {
            if (slugNormalizado.equals(ave.getSlug())) {
                return Optional.of(ave);
            }
        }

        return Optional.empty();
    }

    private static List<Ave> buscarAves(String queryParams) throws Exception {
        if (ANON_KEY.isBlank()) {
            throw new IllegalStateException(
                    "Chave da API nao configurada. Defina a variavel de ambiente SUPABASE_ANON_KEY."
            );
        }

        String url = BASE_URL.replaceAll("/$", "")
                + "/rest/v1/aves"
                + "?select=" + CAMPOS_AVE
                + "&" + queryParams;

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .header("apikey", ANON_KEY)
                .header("Authorization", "Bearer " + ANON_KEY)
                .header("Accept", "application/json")
                .GET()
                .build();

        HttpResponse<String> response = HTTP.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() != 200) {
            throw new RuntimeException(
                    "Supabase retornou " + response.statusCode() + ": " + response.body()
            );
        }

        JsonArray rows = GSON.fromJson(response.body(), JsonArray.class);
        List<Ave> aves = new ArrayList<>();

        for (int i = 0; i < rows.size(); i++) {
            aves.add(mapearAve(rows.get(i).getAsJsonObject()));
        }

        return aves;
    }

    private static Ave mapearAve(JsonObject row) {
        Ave ave = new Ave();
        ave.setId(getString(row, "id"));
        ave.setNomePopular(getString(row, "nome_popular"));
        ave.setNomeCientifico(getString(row, "nome_cientifico"));
        ave.setExpectativaVida(getString(row, "expectativa_vida"));
        ave.setResumoBreve(getString(row, "resumo_breve"));
        ave.setCaracteristicasFisicas(getString(row, "caracteristicas_fisicas"));
        ave.setTamanhoMedioCm(getInt(row, "tamanho_medio_cm"));
        ave.setComportamentoTemperamento(getString(row, "comportamento_temperamento"));
        ave.setNivelRuido(getString(row, "nivel_ruido"));
        ave.setGuiaAlimentacao(getString(row, "guia_alimentacao"));
        ave.setAlimentosProibidos(getString(row, "alimentos_proibidos"));
        ave.setRequisitosGaiola(getString(row, "requisitos_gaiola"));
        ave.setSinaisAlertaSaude(getString(row, "sinais_alerta_saude"));
        ave.setLegislacaoInfo(getString(row, "legislacao_info"));
        ave.setCuriosidades(getString(row, "curiosidades"));
        ave.setEnriquecimentoAmbiental(getString(row, "enriquecimento_ambiental"));
        ave.setStatusLegalAve(getString(row, "status_legal_ave"));
        ave.setDificuldadeDeCriacao(getString(row, "dificuldade_de_criacao"));
        ave.setImageUrl(getString(row, "image_url"));
        return ave;
    }

    private static String getString(JsonObject obj, String field) {
        if (!obj.has(field) || obj.get(field).isJsonNull()) {
            return null;
        }
        return obj.get(field).getAsString();
    }

    private static Integer getInt(JsonObject obj, String field) {
        if (!obj.has(field) || obj.get(field).isJsonNull()) {
            return null;
        }
        return obj.get(field).getAsInt();
    }

    private static String env(String key, String defaultValue) {
        String value = System.getenv(key);
        if (value == null || value.isBlank()) {
            return defaultValue;
        }
        return value.trim();
    }
}
