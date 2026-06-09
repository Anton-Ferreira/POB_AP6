/*
 * Arquivo: src/models/dao/AveDAO.java
 * 
 * Descrição:
 * Data Access Object para a entidade Ave
 * Encapsula toda a lógica de acesso aos dados de aves no banco de dados
 * 
 * Padrão de Projeto: Data Access Object (DAO)
 */

package models.dao;

import models.Ave;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

/**
 * DAO para manipular dados de Aves no banco de dados
 * Fornece métodos CRUD (Create, Read, Update, Delete)
 */
public class AveDAO {
    
    // Você pode estender ou conectar com a classe ConnectionDB aqui
    private Connection connection;
    
    public AveDAO(Connection connection) {
        this.connection = connection;
    }
    
    /**
     * Busca todas as aves do banco de dados
     */
    public List<Ave> buscarTodas() {
        List<Ave> aves = new ArrayList<>();
        String sql = "SELECT * FROM aves";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Ave ave = mapearResultadoParaAve(rs);
                aves.add(ave);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return aves;
    }
    
    /**
     * Busca uma ave específica pelo ID
     */
    public Ave buscarPorId(int id) {
        String sql = "SELECT * FROM aves WHERE id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapearResultadoParaAve(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Busca aves por características como domesticabilidade
     */
    public List<Ave> buscarPorDomesticabilidade(boolean domesticavel) {
        List<Ave> aves = new ArrayList<>();
        String sql = "SELECT * FROM aves WHERE domesticavel = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setBoolean(1, domesticavel);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Ave ave = mapearResultadoParaAve(rs);
                aves.add(ave);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return aves;
    }
    
    /**
     * Insere uma nova ave no banco de dados
     */
    public boolean inserir(Ave ave) {
        String sql = "INSERT INTO aves (nome_comum, nome_cientifico, descricao, " +
                     "habitat, alimentacao, expectativa_vida, tamanho, temperamento, " +
                     "domesticavel, informacoes_legais, cuidados_especiais, imagem_url) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, ave.getNomeComum());
            pstmt.setString(2, ave.getNomeCientifico());
            pstmt.setString(3, ave.getDescricao());
            pstmt.setString(4, ave.getHabitat());
            pstmt.setString(5, ave.getAlimentacao());
            pstmt.setString(6, ave.getExpectativaVida());
            pstmt.setString(7, ave.getTamanho());
            pstmt.setString(8, ave.getTemperamento());
            pstmt.setBoolean(9, ave.isDomesticavel());
            pstmt.setString(10, ave.getInformacoesLegais());
            pstmt.setString(11, ave.getCuidadosEspeciais());
            pstmt.setString(12, ave.getImagemUrl());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Atualiza os dados de uma ave existente
     */
    public boolean atualizar(Ave ave) {
        String sql = "UPDATE aves SET nome_comum = ?, nome_cientifico = ?, " +
                     "descricao = ?, habitat = ?, alimentacao = ?, " +
                     "expectativa_vida = ?, tamanho = ?, temperamento = ?, " +
                     "domesticavel = ?, informacoes_legais = ?, " +
                     "cuidados_especiais = ?, imagem_url = ? WHERE id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, ave.getNomeComum());
            pstmt.setString(2, ave.getNomeCientifico());
            pstmt.setString(3, ave.getDescricao());
            pstmt.setString(4, ave.getHabitat());
            pstmt.setString(5, ave.getAlimentacao());
            pstmt.setString(6, ave.getExpectativaVida());
            pstmt.setString(7, ave.getTamanho());
            pstmt.setString(8, ave.getTemperamento());
            pstmt.setBoolean(9, ave.isDomesticavel());
            pstmt.setString(10, ave.getInformacoesLegais());
            pstmt.setString(11, ave.getCuidadosEspeciais());
            pstmt.setString(12, ave.getImagemUrl());
            pstmt.setInt(13, ave.getId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Deleta uma ave do banco de dados
     */
    public boolean deletar(int id) {
        String sql = "DELETE FROM aves WHERE id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Mapeia uma linha do ResultSet para um objeto Ave
     */
    private Ave mapearResultadoParaAve(ResultSet rs) throws SQLException {
        Ave ave = new Ave();
        ave.setId(rs.getInt("id"));
        ave.setNomeComum(rs.getString("nome_comum"));
        ave.setNomeCientifico(rs.getString("nome_cientifico"));
        ave.setDescricao(rs.getString("descricao"));
        ave.setHabitat(rs.getString("habitat"));
        ave.setAlimentacao(rs.getString("alimentacao"));
        ave.setExpectativaVida(rs.getString("expectativa_vida"));
        ave.setTamanho(rs.getString("tamanho"));
        ave.setTemperamento(rs.getString("temperamento"));
        ave.setDomesticavel(rs.getBoolean("domesticavel"));
        ave.setInformacoesLegais(rs.getString("informacoes_legais"));
        ave.setCuidadosEspeciais(rs.getString("cuidados_especiais"));
        ave.setImagemUrl(rs.getString("imagem_url"));
        
        return ave;
    }
}
