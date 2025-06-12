package com.tec.carpooling.data.connection;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Central access point to the database layer.
 *
 * <p>Configuration is externalised through {@code config/db.properties} or
 * environment variables. Lookup order:
 * <ol>
 *     <li>Environment variable {@code DB_CONF} pointing to a custom properties file</li>
 *     <li>File {@code config/db.properties} located next to the runnable JAR</li>
 *     <li>Classpath resource {@code /config/db.properties}</li>
 * </ol>
 *
 * <p>Individual keys can be overridden via {@code DB_URL}, {@code DB_USER},
 * {@code DB_PASSWORD} environment variables, which is useful in CI/CD pipelines.</p>
 *
 * <p>For real‑world workloads replace raw {@link DriverManager} usage with a
 * connection‑pool implementation such as HikariCP.</p>
 *
 * @author Mauricio González
 */
public final class ConnectDB {

    /* ---------- configuration keys ---------- */
    private static final String PROP_FILE = "config/db.properties";
    private static final String KEY_URL   = "db.url";
    private static final String KEY_USER  = "db.user";
    private static final String KEY_PASS  = "db.password";

    /* ---------- immutable configuration ---------- */
    private static final Properties PROPS = loadProperties();
    private static final String URL  = resolve(KEY_URL);
    private static final String USER = resolve(KEY_USER);
    private static final String PASS = resolve(KEY_PASS);

    /** Utility class — prevent instantiation. */
    private ConnectDB() { }

    /* ---------------------------------------------------------------------- */
    /*  Public API                                                            */
    /* ---------------------------------------------------------------------- */

    /**
     * Executes stored procedure {@code pu.InsertPhoneType}.
     *
     * @param id               primary key
     * @param name             phone‑type name
     * @param creator          record creator
     * @param creationDate     creation timestamp
     * @param modifier         last modifier
     * @param modificationDate timestamp of last modification
     * @throws RuntimeException if a {@link SQLException} occurs
     */
    public static void insertPhoneType(int id,
                                       String name,
                                       String creator,
                                       Date creationDate,
                                       String modifier,
                                       Date modificationDate) {

        final String call = "{call pu.InsertPhoneType(?,?,?,?,?,?)}";

        try (Connection        con = DriverManager.getConnection(URL, USER, PASS);
             CallableStatement cs  = con.prepareCall(call)) {

            cs.setInt   (1, id);
            cs.setString(2, name);
            cs.setString(3, creator);
            cs.setDate  (4, creationDate);
            cs.setString(5, modifier);
            cs.setDate  (6, modificationDate);

            cs.execute();

        } catch (SQLException ex) {
            throw new RuntimeException("Unable to execute InsertPhoneType", ex);
        }
    }

    /* ---------------------------------------------------------------------- */
    /*  Internal helpers                                                      */
    /* ---------------------------------------------------------------------- */

    /** Loads properties following the lookup order defined in the class Javadoc. */
    private static Properties loadProperties() {
        Properties p = new Properties();

        // 1) custom file via environment variable
        String custom = System.getenv("DB_CONF");
        if (custom != null && !custom.isBlank()) {
            try (InputStream in = new FileInputStream(custom)) {
                p.load(in);
                return p;
            } catch (IOException ignored) { /* fallback to next option */ }
        }

        // 2) file next to the JAR
        try (InputStream in = new FileInputStream(PROP_FILE)) {
            p.load(in);
            return p;
        } catch (IOException ignored) { /* fallback to classpath */ }

        // 3) classpath resource
        try (InputStream in = ConnectDB.class.getClassLoader()
                                             .getResourceAsStream(PROP_FILE)) {
            if (in != null) {
                p.load(in);
                return p;
            }
        } catch (IOException ignored) { /* fall through */ }

        throw new IllegalStateException("Could not locate database configuration file");
    }

    /** Resolves a key, letting environment variables override the properties file. */
    private static String resolve(String key) {
        return System.getenv().getOrDefault(toEnv(key), PROPS.getProperty(key));
    }

    private static String toEnv(String key) {
        return key.toUpperCase().replace('.', '_');
    }
    
    /**
 * Checks whether the database is reachable.
 *
 * @return {@code true} if the connection could be established and the driver
 *         reports it as valid; {@code false} otherwise.
 */
public static boolean ping() {
    try (Connection con = DriverManager.getConnection(URL, USER, PASS)) {
        // Timeout: 2 s. 0 = undefined
        System.out.println(URL);
        System.out.println(USER);
        System.out.println(PASS);
        return con.isValid(2);
    } catch (SQLException ex) {
                System.out.println(URL);
        System.out.println(USER);
        System.out.println(URL);
        System.err.println("❌  Error al conectar con la base de datos:");
        ex.printStackTrace();      // muestra motivo y stack‑trace
        return false; 
    }
}

}
