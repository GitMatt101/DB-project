package it.unibo;

import it.unibo.view.MainFrame;

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
        new MainFrame();
    }

}
