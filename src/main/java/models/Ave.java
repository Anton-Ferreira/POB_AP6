package models;

/**
 * Entidade que representa uma espécie cadastrada em public.aves.
 */
public class Ave {

    /** Limite em cm entre aves pequenas e médias (criação doméstica). */
    public static final int LIMITE_PEQUENA_CM = 25;

    private static final String IMAGEM_PADRAO =
            "https://images.unsplash.com/photo-1452570053594-1b985d6ea890?q=80&w=800&auto=format&fit=crop";

    private String id;
    private String nomePopular;
    private String nomeCientifico;
    private String expectativaVida;
    private String resumoBreve;
    private String caracteristicasFisicas;
    private Integer tamanhoMedioCm;
    private String comportamentoTemperamento;
    private String nivelRuido;
    private String guiaAlimentacao;
    private String alimentosProibidos;
    private String requisitosGaiola;
    private String sinaisAlertaSaude;
    private String legislacaoInfo;
    private String curiosidades;
    private String enriquecimentoAmbiental;
    private String statusLegalAve;
    private String dificuldadeDeCriacao;
    private String imageUrl;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNomePopular() {
        return nomePopular;
    }

    public void setNomePopular(String nomePopular) {
        this.nomePopular = nomePopular;
    }

    public String getNomeCientifico() {
        return nomeCientifico;
    }

    public void setNomeCientifico(String nomeCientifico) {
        this.nomeCientifico = nomeCientifico;
    }

    public String getExpectativaVida() {
        return expectativaVida;
    }

    public void setExpectativaVida(String expectativaVida) {
        this.expectativaVida = expectativaVida;
    }

    public String getResumoBreve() {
        return resumoBreve;
    }

    public void setResumoBreve(String resumoBreve) {
        this.resumoBreve = resumoBreve;
    }

    public String getCaracteristicasFisicas() {
        return caracteristicasFisicas;
    }

    public void setCaracteristicasFisicas(String caracteristicasFisicas) {
        this.caracteristicasFisicas = caracteristicasFisicas;
    }

    public Integer getTamanhoMedioCm() {
        return tamanhoMedioCm;
    }

    public void setTamanhoMedioCm(Integer tamanhoMedioCm) {
        this.tamanhoMedioCm = tamanhoMedioCm;
    }

    public String getComportamentoTemperamento() {
        return comportamentoTemperamento;
    }

    public void setComportamentoTemperamento(String comportamentoTemperamento) {
        this.comportamentoTemperamento = comportamentoTemperamento;
    }

    public String getNivelRuido() {
        return nivelRuido;
    }

    public void setNivelRuido(String nivelRuido) {
        this.nivelRuido = nivelRuido;
    }

    public String getGuiaAlimentacao() {
        return guiaAlimentacao;
    }

    public void setGuiaAlimentacao(String guiaAlimentacao) {
        this.guiaAlimentacao = guiaAlimentacao;
    }

    public String getAlimentosProibidos() {
        return alimentosProibidos;
    }

    public void setAlimentosProibidos(String alimentosProibidos) {
        this.alimentosProibidos = alimentosProibidos;
    }

    public String getRequisitosGaiola() {
        return requisitosGaiola;
    }

    public void setRequisitosGaiola(String requisitosGaiola) {
        this.requisitosGaiola = requisitosGaiola;
    }

    public String getSinaisAlertaSaude() {
        return sinaisAlertaSaude;
    }

    public void setSinaisAlertaSaude(String sinaisAlertaSaude) {
        this.sinaisAlertaSaude = sinaisAlertaSaude;
    }

    public String getLegislacaoInfo() {
        return legislacaoInfo;
    }

    public void setLegislacaoInfo(String legislacaoInfo) {
        this.legislacaoInfo = legislacaoInfo;
    }

    public String getCuriosidades() {
        return curiosidades;
    }

    public void setCuriosidades(String curiosidades) {
        this.curiosidades = curiosidades;
    }

    public String getEnriquecimentoAmbiental() {
        return enriquecimentoAmbiental;
    }

    public void setEnriquecimentoAmbiental(String enriquecimentoAmbiental) {
        this.enriquecimentoAmbiental = enriquecimentoAmbiental;
    }

    public String getStatusLegalAve() {
        return statusLegalAve;
    }

    public void setStatusLegalAve(String statusLegalAve) {
        this.statusLegalAve = statusLegalAve;
    }

    public String getDificuldadeDeCriacao() {
        return dificuldadeDeCriacao;
    }

    public void setDificuldadeDeCriacao(String dificuldadeDeCriacao) {
        this.dificuldadeDeCriacao = dificuldadeDeCriacao;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    /**
     * Pequenas: até 25 cm (periquitos, canários, agapornis).
     * Médias: acima de 25 cm (calopsitas, ringnecks, papagaios médios).
     */
    public boolean isPequena() {
        if (tamanhoMedioCm == null) {
            return true;
        }
        return tamanhoMedioCm <= LIMITE_PEQUENA_CM;
    }

    public String getImagemExibicao() {
        if (imageUrl == null || imageUrl.isBlank()) {
            return IMAGEM_PADRAO;
        }
        return imageUrl;
    }

    public String getDificuldadeFormatada() {
        return "Dificuldade de criação: " + formatarEnum(dificuldadeDeCriacao, "Não informado");
    }

    public String getNivelRuidoFormatado() {
        return "Nível " + formatarEnum(nivelRuido, "Não informado") + " de ruído";
    }

    public String getDificuldadeExibicao() {
        return formatarEnum(dificuldadeDeCriacao, "Não informado");
    }

    public String getNivelRuidoExibicao() {
        return formatarEnum(nivelRuido, "Não informado");
    }

    public String getPorte() {
        if (tamanhoMedioCm == null) {
            return "Não informado";
        }
        return isPequena() ? "Pequeno" : "Médio";
    }

    public String getDificuldadeQuiz() {
        return classificarDificuldade(normalizarTexto(
                dificuldadeDeCriacao != null ? dificuldadeDeCriacao : ""));
    }

    public String getRuidoQuiz() {
        return classificarRuido(normalizarTexto(
                nivelRuido != null ? nivelRuido : ""));
    }

    public String getPorteQuiz() {
        if (tamanhoMedioCm == null) {
            return "pequeno";
        }
        return isPequena() ? "pequeno" : "medio";
    }

    private String classificarDificuldade(String valor) {
        if (valor.contains("facil")) {
            return "facil";
        }
        if (valor.contains("dificil")) {
            return "dificil";
        }
        if (valor.contains("medio") || valor.contains("media")) {
            return "medio";
        }
        return "medio";
    }

    private String classificarRuido(String valor) {
        if (valor.contains("baixo")) {
            return "baixo";
        }
        if (valor.contains("alto")) {
            return "alto";
        }
        if (valor.contains("medio") || valor.contains("media")) {
            return "medio";
        }
        return "medio";
    }

    public String getIdealPara() {
        if (dificuldadeDeCriacao == null || dificuldadeDeCriacao.isBlank()) {
            return "Não informado";
        }

        String normalizado = normalizarTexto(dificuldadeDeCriacao);

        if (normalizado.contains("facil")) {
            return "Iniciantes";
        }
        if (normalizado.contains("medio") || normalizado.contains("media")) {
            return "Tutores dedicados/Intermediários";
        }
        if (normalizado.contains("dificil")) {
            return "Experientes";
        }

        return "Não informado";
    }

    public String getStatusLegalFormatado() {
        return formatarEnum(statusLegalAve, "Não informado");
    }

    public String getTextoOuPadrao(String texto) {
        if (texto == null || texto.isBlank()) {
            return "Não informado";
        }
        return texto.trim();
    }

    public static String gerarSlug(String nomePopular) {
        if (nomePopular == null) {
            return "";
        }

        return normalizarParaBusca(nomePopular);
    }

    public static String normalizarParaBusca(String texto) {
        if (texto == null) {
            return "";
        }

        return texto
                .toLowerCase()
                .trim()
                .replace("á", "a")
                .replace("é", "e")
                .replace("í", "i")
                .replace("ó", "o")
                .replace("ú", "u")
                .replace("ã", "a")
                .replace("õ", "o")
                .replace("ç", "c")
                .replaceAll("\\s+", " ");
    }

    public String getSlug() {
        return gerarSlug(nomePopular);
    }

    public String getArtigoPath() {
        String slug = getSlug();
        if (slug.isEmpty()) {
            return "#";
        }
        return "/" + slug;
    }

    private String normalizarTexto(String valor) {
        return valor
                .trim()
                .toLowerCase()
                .replace('_', ' ')
                .replace("á", "a")
                .replace("é", "e")
                .replace("í", "i")
                .replace("ó", "o")
                .replace("ú", "u")
                .replace("ã", "a")
                .replace("õ", "o")
                .replace("ç", "c");
    }

    private String formatarEnum(String valor, String fallback) {
        if (valor == null || valor.isBlank()) {
            return fallback;
        }

        String normalizado = valor.trim().toLowerCase().replace('_', ' ');
        return Character.toUpperCase(normalizado.charAt(0)) + normalizado.substring(1);
    }
}
