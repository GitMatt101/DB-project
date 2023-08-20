package it.unibo;

import it.unibo.view.GraphicUtilities;

/**
 * Class that starts the application.
 */
public final class StartApp {

    private StartApp() {
    }

    /**
     * Starts the application.
     * 
     * @param args
     */
    public static void main(final String[] args) {
        GraphicUtilities.createMainFrame().setVisible(true);
    }

}
