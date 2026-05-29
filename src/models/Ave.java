/*
 * Arquivo: src/models/Ave.java
 * 
 * Descrição:
 * Classe modelo que representa uma Ave no sistema
 * Encapsula os dados e comportamentos relacionados a aves
 */

package models;

/**
 * Entidade/Modelo que representa uma Ave
 * Contém informações gerais e específicas sobre cada espécie
 */
public class Ave {
    
    private int id;
    private String nomeComum;
    private String nomeCientifico;
    private String descricao;
    private String habitat;
    private String alimentacao;
    private String expectativaVida;
    private String tamanho;
    private String temperamento;
    private boolean domesticavel;
    private String informacoesLegais;
    private String cuidadosEspeciais;
    private String imagemUrl;
    
    // Construtores
    public Ave() {}
    
    public Ave(String nomeComum, String nomeCientifico) {
        this.nomeComum = nomeComum;
        this.nomeCientifico = nomeCientifico;
    }
    
    public Ave(String nomeComum, String nomeCientifico, String descricao) {
        this.nomeComum = nomeComum;
        this.nomeCientifico = nomeCientifico;
        this.descricao = descricao;
    }
    
    // Getters e Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getNomeComum() {
        return nomeComum;
    }
    
    public void setNomeComum(String nomeComum) {
        this.nomeComum = nomeComum;
    }
    
    public String getNomeCientifico() {
        return nomeCientifico;
    }
    
    public void setNomeCientifico(String nomeCientifico) {
        this.nomeCientifico = nomeCientifico;
    }
    
    public String getDescricao() {
        return descricao;
    }
    
    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }
    
    public String getHabitat() {
        return habitat;
    }
    
    public void setHabitat(String habitat) {
        this.habitat = habitat;
    }
    
    public String getAlimentacao() {
        return alimentacao;
    }
    
    public void setAlimentacao(String alimentacao) {
        this.alimentacao = alimentacao;
    }
    
    public String getExpectativaVida() {
        return expectativaVida;
    }
    
    public void setExpectativaVida(String expectativaVida) {
        this.expectativaVida = expectativaVida;
    }
    
    public String getTamanho() {
        return tamanho;
    }
    
    public void setTamanho(String tamanho) {
        this.tamanho = tamanho;
    }
    
    public String getTemperamento() {
        return temperamento;
    }
    
    public void setTemperamento(String temperamento) {
        this.temperamento = temperamento;
    }
    
    public boolean isDomesticavel() {
        return domesticavel;
    }
    
    public void setDomesticavel(boolean domesticavel) {
        this.domesticavel = domesticavel;
    }
    
    public String getInformacoesLegais() {
        return informacoesLegais;
    }
    
    public void setInformacoesLegais(String informacoesLegais) {
        this.informacoesLegais = informacoesLegais;
    }
    
    public String getCuidadosEspeciais() {
        return cuidadosEspeciais;
    }
    
    public void setCuidadosEspeciais(String cuidadosEspeciais) {
        this.cuidadosEspeciais = cuidadosEspeciais;
    }
    
    public String getImagemUrl() {
        return imagemUrl;
    }
    
    public void setImagemUrl(String imagemUrl) {
        this.imagemUrl = imagemUrl;
    }
    
    @Override
    public String toString() {
        return "Ave{" +
                "id=" + id +
                ", nomeComum='" + nomeComum + '\'' +
                ", nomeCientifico='" + nomeCientifico + '\'' +
                ", domesticavel=" + domesticavel +
                '}';
    }
}
