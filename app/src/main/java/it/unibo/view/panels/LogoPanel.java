package it.unibo.view.panels;

import java.awt.Color;
import java.awt.Font;
import java.awt.Image;

import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import it.unibo.common.Constants;
import it.unibo.controller.Controller;

public class LogoPanel extends JPanel {

    private static final int IMAGE_WIDTH = 275;
    private static final int IMAGE_HEIGHT = 275;

    public LogoPanel() {
        super();
        this.setLayout(new java.awt.BorderLayout());
        final JTextField text = new JTextField("DeepSea Expeditions");
        text.setFont(new Font("Serif", Font.CENTER_BASELINE, 30));
        text.setForeground(Color.CYAN);
        text.setBackground(Constants.BACKGROUND_COLOR);
        text.setBorder(new javax.swing.border.LineBorder(Color.CYAN, 0));
        text.setEditable(false);
        final JLabel logo = new JLabel();
        ImageIcon image = new ImageIcon("app\\src\\main\\resources\\app_icon.jpg");
        ImageIcon newImage = new ImageIcon(
                image.getImage().getScaledInstance(IMAGE_WIDTH, IMAGE_HEIGHT, Image.SCALE_DEFAULT));
        logo.setIcon(newImage);
        this.add(text, java.awt.BorderLayout.NORTH);
        this.add(logo, java.awt.BorderLayout.CENTER);
        this.add(new InfoPanel(), java.awt.BorderLayout.SOUTH);
    }

}
