package models.dao;

import models.Ave;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ThreadLocalRandom;

import utils.SupabaseClient;

public class AveDAO {

    private static final List<String> TERMOS_ESPECIES_POPULARES = List.of(
            "Calopsita",
            "Canário",
            "Periquito-australiano"
    );

    public List<Ave> buscarTodas() throws Exception {
        return SupabaseClient.listarAves();
    }

    public Optional<Ave> buscarPorSlug(String slug) throws Exception {
        return SupabaseClient.buscarPorSlug(slug);
    }

    public Optional<Ave> buscarPorNome(String termo) throws Exception {
        if (termo == null || termo.isBlank()) {
            return Optional.empty();
        }

        String termoNorm = Ave.normalizarParaBusca(termo);
        String termoCompacto = compactar(termoNorm);
        List<Ave> aves = buscarTodas();
        List<Ave> candidatos = new ArrayList<>();

        for (Ave ave : aves) {
            String nomeNorm = Ave.normalizarParaBusca(ave.getNomePopular());
            String nomeCompacto = compactar(nomeNorm);
            String slugCompacto = compactar(ave.getSlug());

            if (termoNorm.equals(nomeNorm) || termoCompacto.equals(slugCompacto)) {
                return Optional.of(ave);
            }

            if (nomeNorm.contains(termoNorm) || slugCompacto.contains(termoCompacto)) {
                candidatos.add(ave);
                continue;
            }

            for (String parte : dividirNome(nomeNorm)) {
                if (parte.equals(termoNorm) || parte.startsWith(termoNorm)) {
                    candidatos.add(ave);
                    break;
                }
            }
        }

        if (candidatos.isEmpty()) {
            return Optional.empty();
        }

        if (candidatos.size() == 1) {
            return Optional.of(candidatos.get(0));
        }

        List<Ave> palavraExata = new ArrayList<>();
        for (Ave ave : candidatos) {
            for (String parte : dividirNome(Ave.normalizarParaBusca(ave.getNomePopular()))) {
                if (parte.equals(termoNorm)) {
                    palavraExata.add(ave);
                    break;
                }
            }
        }

        if (palavraExata.size() == 1) {
            return Optional.of(palavraExata.get(0));
        }

        if (palavraExata.size() > 1) {
            return Optional.empty();
        }

        List<Ave> inicioNome = new ArrayList<>();
        for (Ave ave : candidatos) {
            if (Ave.normalizarParaBusca(ave.getNomePopular()).startsWith(termoNorm)) {
                inicioNome.add(ave);
            }
        }

        if (inicioNome.size() == 1) {
            return Optional.of(inicioNome.get(0));
        }

        return Optional.empty();
    }

    public Optional<Ave> buscarAleatoria() throws Exception {
        List<Ave> aves = buscarTodas();
        if (aves.isEmpty()) {
            return Optional.empty();
        }

        int index = ThreadLocalRandom.current().nextInt(aves.size());
        return Optional.of(aves.get(index));
    }

    public List<Ave> buscarPopulares() throws Exception {
        List<Ave> populares = new ArrayList<>();

        for (String termo : TERMOS_ESPECIES_POPULARES) {
            buscarPorNome(termo).ifPresent(populares::add);
        }

        return populares;
    }

    private static String compactar(String valor) {
        return valor.replace(" ", "").replace("-", "").replace("/", "");
    }

    private static String[] dividirNome(String nomeNorm) {
        return nomeNorm.split("[\\s/\\-]+");
    }
}
