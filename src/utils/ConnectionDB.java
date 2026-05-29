/*
 * Arquivo: src/utils/ConnectionDB.java
 * 
 * Descrição:
 * Gerenciador centralizado de conexões com o banco de dados
 * Implementa o padrão Singleton para garantir uma única instância
 */

package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Classe para gerenciar conexões com o banco de dados
 * Utiliza padrão Singleton para garantir instância única
 */
public class ConnectionDB {
    
    // Configurações do banco de dados - AJUSTE CONFORME NECESSÁRIO
    private static final String DB_URL = "jdbc:mysql://localhost:3306/pob_ap6";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
    
    private static Connection connection;
    
    /**
     * Inicializa o driver JDBC
     */
    static {
        try {
            Class.forName(DB_DRIVER);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Obtém a conexão com o banco de dados
     * Implementa padrão Singleton
     */
    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return connection;
    }
    
    /**
     * Fecha a conexão com o banco de dados
     */
    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
