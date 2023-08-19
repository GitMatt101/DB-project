package it.unibo.view;

import javax.swing.ImageIcon;
import javax.swing.JFrame;

import it.unibo.view.panels.MainPanel;

/**
 * Window of the application.
 */
public class MainFrame extends JFrame {

    private static final long serialVersionUID = 1L;

    /**
     * Creates and displays a new {@link MainFrame}.
     */
    public MainFrame() {
        super("DeepSea Expeditions");
        this.setIconImage(new ImageIcon("app\\src\\main\\resources\\app_icon.jpg").getImage());
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.getContentPane().add(new MainPanel());
        this.pack();
        this.setLocationRelativeTo(null);
        this.setResizable(false);
        this.setVisible(true);
    }

}
