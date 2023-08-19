package it.unibo.view;

public final class GraphicUtilities {

    private GraphicUtilities() {
    }

    public static java.awt.Dimension getScreenSize() {
        return java.awt.Toolkit.getDefaultToolkit().getScreenSize();
    }

    public static int getScreenWidth() {
        return Double.valueOf(getScreenSize().getWidth()).intValue();
    }
    
    public static int getScreenHeight() {
        return Double.valueOf(getScreenSize().getHeight()).intValue();
    }

}
