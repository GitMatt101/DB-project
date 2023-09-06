package it.unibo;

import javax.swing.SwingUtilities;

import it.unibo.view.AppWindow;

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
        SwingUtilities.invokeLater(() -> new AppWindow().display());
    }

}
