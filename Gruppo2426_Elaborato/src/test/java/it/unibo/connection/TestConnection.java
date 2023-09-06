package it.unibo.connection;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;

import it.unibo.common.ConnectionProvider;
import it.unibo.common.Constants;

/**
 * Test class for {@link ConnectionProvider}.
 */
class TestConnection {

    @Test
    void testConnectionToDatabase() {
        final ConnectionProvider provider = new ConnectionProvider(
                Constants.USERNAME,
                Constants.PASSWORD,
                Constants.DATABASE_NAME);
        assertNotNull(provider.getMySQLConnection());
    }

}
