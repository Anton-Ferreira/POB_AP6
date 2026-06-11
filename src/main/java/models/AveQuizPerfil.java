package models;

/**
 * Representação enxuta de uma ave para o quiz da página inicial.
 */
public class AveQuizPerfil {

    private String id;
    private String nome;
    private String url;
    private String imagem;
    private String resumo;
    private String dificuldade;
    private String ruido;
    private String porte;

    public static AveQuizPerfil from(Ave ave, String contextPath) {
        AveQuizPerfil perfil = new AveQuizPerfil();
        perfil.id = ave.getId();
        perfil.nome = ave.getNomePopular();
        perfil.url = contextPath + ave.getArtigoPath();
        perfil.imagem = ave.getImagemExibicao();
        perfil.resumo = ave.getTextoOuPadrao(ave.getResumoBreve());
        perfil.dificuldade = ave.getDificuldadeQuiz();
        perfil.ruido = ave.getRuidoQuiz();
        perfil.porte = ave.getPorteQuiz();
        return perfil;
    }

    public String getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public String getUrl() {
        return url;
    }

    public String getImagem() {
        return imagem;
    }

    public String getResumo() {
        return resumo;
    }

    public String getDificuldade() {
        return dificuldade;
    }

    public String getRuido() {
        return ruido;
    }

    public String getPorte() {
        return porte;
    }
}
