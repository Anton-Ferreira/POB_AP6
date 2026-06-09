package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Gerenciador centralizado de conexões com o PostgreSQL do Supabase.
 */
public class ConnectionDB {

    private static final String DB_HOST = env("SUPABASE_DB_HOST", "db.ahvzzrxinxfzoxdvgweu.supabase.co");
    private static final String DB_PORT = env("SUPABASE_DB_PORT", "5432");
    private static final String DB_NAME = env("SUPABASE_DB_NAME", "postgres");
    private static final String DB_USER = env("SUPABASE_DB_USER", "postgres");
    private static final String DB_PASSWORD = env("SUPABASE_DB_PASSWORD", "");

    private static final String DB_URL = String.format(
            "jdbc:postgresql://%s:%s/%s?sslmode=require",
            DB_HOST, DB_PORT, DB_NAME
    );

    private static Connection connection;

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new IllegalStateException("Driver PostgreSQL nao encontrado no classpath.", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (DB_PASSWORD == null || DB_PASSWORD.isBlank()) {
            throw new SQLException(
                    "Senha do banco nao configurada. Defina a variavel de ambiente SUPABASE_DB_PASSWORD."
            );
        }

        if (connection == null || connection.isClosed()) {
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        }

        return connection;
    }

    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                connection = null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static String env(String key, String defaultValue) {
        String value = System.getenv(key);
        if (value == null || value.isBlank()) {
            return defaultValue;
        }
        return value.trim();
    }
}
