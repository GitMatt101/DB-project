package it.unibo.view;

/**
 * Utility class used to get graphic values used for popups.
 */
public final class GraphicUtilities {

    private GraphicUtilities() {
    }

    /**
     * Retrieves the resolution of the screen.
     * 
     * @return a {@link java.awt.Dimension} that contains the screen's width and
     *         height
     */
    public static java.awt.Dimension getScreenSize() {
        return java.awt.Toolkit.getDefaultToolkit().getScreenSize();
    }

    /**
     * Retrieves the width of the screen.
     * 
     * @return the width of the screen in pixels
     */
    public static int getScreenWidth() {
        return Double.valueOf(getScreenSize().getWidth()).intValue();
    }

    /**
     * Retrieves the height of the screeen.
     * 
     * @return the height of the screen in pixels
     */
    public static int getScreenHeight() {
        return Double.valueOf(getScreenSize().getHeight()).intValue();
    }

}
