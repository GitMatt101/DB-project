package it.unibo.view;

import javax.swing.ImageIcon;
import javax.swing.JFrame;

import it.unibo.view.panels.MainPanel;

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

    /**
     * Creates the main frame for the application.
     * 
     * @return a {@link JFrame}
     */
    public static JFrame createMainFrame() {
        final JFrame frame = new JFrame();
        frame.setTitle("DeepSea Expeditions");
        frame.setIconImage(new ImageIcon("app\\src\\main\\resources\\app_icon.jpg").getImage());
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().add(new MainPanel());
        frame.pack();
        frame.setLocationRelativeTo(null);
        frame.setResizable(false);
        return frame;
    }

}
