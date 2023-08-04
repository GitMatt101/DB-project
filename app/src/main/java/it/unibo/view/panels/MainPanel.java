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
        final JPanel eastPanel = new JPanel();
        eastPanel.add(new LogoPanel());
        eastPanel.setBackground(Constants.BACKGROUND_COLOR);
        this.add(eastPanel, java.awt.BorderLayout.EAST);
        this.add(new CenterPanel(), java.awt.BorderLayout.CENTER);
        this.add(new EntityPanel(), java.awt.BorderLayout.SOUTH);
        this.setBackground(Constants.BACKGROUND_COLOR);
    }
    
}
