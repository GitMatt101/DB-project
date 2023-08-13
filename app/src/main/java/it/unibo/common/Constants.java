package it.unibo.common;

/**
 * Class used to store the constants that are used multiple times in other
 * classes.
 * 
 */
public final class Constants {

    /**
     * Separator used for {@code toString()} methods.
     */
    public static final String SEPARATOR = "\n--------------------------------------------------------\n";

    /**
     * Size for long {@code StringBuilder}.
     */
    public static final int STRINGBUILDER_INITIAL_SIZE = 50;

    /**
     * Error message for {@code Statement} creation.
     */
    public static final String STATEMENT_CREATION_ERROR = "Error while creating the statement";

    /**
     * Background color for every panel.
     */
    public static final java.awt.Color BACKGROUND_COLOR = java.awt.Color.BLACK;

    /**
     * Name of the database.
     */
    public static final String DATABASE_NAME = "spedizioni";

    /**
     * Username to access the database.
     */
    public static final String USERNAME = "root";

    /**
     * Password to access the database.
     */
    public static final String PASSWORD = "frtMTT02%101";

    public static final String SUCCESSFUL_REGISTRATION = "Registrazione avvenuta con successo";

    public static final String UNSUCCESSFUL_REGISTRATION = "Registrazione fallita";

    public static final String POPUP_MESSAGE = "Notifica di fine operazione";

    public static final int MAX_IMAGE_WIDTH = 200;

    public static final int MAX_IMAGE_HEIGHT = 200;

    private Constants() {
    }

}
