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

    private Constants() {
    }

}
