package it.unibo.view;

import javax.swing.ImageIcon;
import javax.swing.JFrame;

import it.unibo.view.panels.MainPanel;

/**
 * Window of the app.
 */
public class AppWindow extends JFrame {

    private static final long serialVersionUID = 1L;

    /**
     * Creates the window.
     */
    public AppWindow() {
        super("DeepSea Expeditions");
    }

    /**
     * Shows the window.
     */
    public void display() {
        this.setIconImage(new ImageIcon("app\\src\\main\\resources\\app_icon.jpg").getImage());
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.getContentPane().add(new MainPanel());
        this.pack();
        this.setLocationRelativeTo(null);
        this.setResizable(false);
        this.setVisible(true);
    }

}
