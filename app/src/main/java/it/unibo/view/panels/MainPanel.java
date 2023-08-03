package it.unibo.view.panels;

import javax.swing.JPanel;

import it.unibo.common.Constants;

public class MainPanel extends JPanel {

    private static final int WIDTH = 1200;
    private static final int HEIGHT = 700;

    public MainPanel() {
        super();
        this.setPreferredSize(new java.awt.Dimension(WIDTH, HEIGHT));
        this.setLayout(new java.awt.BorderLayout());
        this.add(new LogoPanel(), java.awt.BorderLayout.CENTER);
        this.add(new OperationPanel(), java.awt.BorderLayout.WEST);
        this.add(new EntityPanel(), java.awt.BorderLayout.SOUTH);
        this.setBackground(Constants.BACKGROUND_COLOR);
    }
    
}
