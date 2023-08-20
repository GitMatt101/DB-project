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

    /**
     * Message for a successful registration query operation.
     */
    public static final String SUCCESSFUL_REGISTRATION = "Registrazione avvenuta con successo";

    /**
     * Message for an unsuccessful registration query operation.
     */
    public static final String UNSUCCESSFUL_REGISTRATION = "Registrazione fallita";

    /**
     * Title for the popup message.
     */
    public static final String POPUP_MESSAGE = "Notifica di fine operazione";

    /**
     * String used for query conditions.
     */
    public static final String EQUALS = " = ";

    /**
     * String used for query condition with a given string.
     */
    public static final String EQUALS_GIVEN_STRING = " = '";

    /**
     * Question mark used to prepare queries.
     */
    public static final String QUESTION_MARK = " = ?";

    /**
     * String used to create conditions for queries.
     */
    public static final String WHERE = " WHERE ";

    /**
     * String used to add conditions in queries.
     */
    public static final String AND = " AND ";

    /**
     * Number used for prepared statements when the query only has one "?".
     */
    public static final int SINGLE_QUERY_VALUE_INDEX = 1;

    /**
     * Minimum value for geological formations' danger level.
     */
    public static final int MINIMUM_DANGER_LEVEL = 0;

    /**
     * Maximum value for geological formations' danger level.
     */
    public static final int MAXIMUM_DANGER_LEVEL = 5;

    /**
     * String used when the depth isn't specified.
     */
    public static final String DEPTH_NOT_SPECIFIED = "[NON SPECIFICATA]";

    /**
     * Font used in the popups.
     */
    public static final String DEFAULT_FONT = "Arial";

    private Constants() {
    }

}
