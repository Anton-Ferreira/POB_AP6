package utils;

public class GoogleMapsConfig {

    public static String getApiKey() {
        return env("GOOGLE_MAPS_API_KEY", "");
    }

    public static boolean isConfigured() {
        return !getApiKey().isBlank();
    }

    private static String env(String key, String defaultValue) {
        String value = System.getenv(key);
        if (value == null || value.isBlank()) {
            return defaultValue;
        }
        return value.trim();
    }
}
