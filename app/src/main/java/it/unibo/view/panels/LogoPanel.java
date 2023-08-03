package it.unibo.view.panels;

import java.awt.Color;
import java.awt.Font;
import java.awt.Image;

import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.Border;

import it.unibo.common.Constants;

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
        text.setBorder(new Border() {
            @Override
            public void paintBorder(final java.awt.Component c, final java.awt.Graphics g, final int x, final int y,
                    final int width, final int height) {
                g.setColor(new Color(0, 0, 0, 0));
                g.drawRoundRect(x, y, width - 1, height - 1, 10, 10);
            }

            @Override
            public boolean isBorderOpaque() {
                return false;
            }

            @Override
            public java.awt.Insets getBorderInsets(final java.awt.Component c) {
                return new java.awt.Insets(0, 0, 0, 0);
            }
        });
        text.setEditable(false);
        final JLabel logo = new JLabel();
        ImageIcon image = new ImageIcon("app\\src\\main\\resources\\app_icon.jpg");
        ImageIcon newImage = new ImageIcon(
                image.getImage().getScaledInstance(IMAGE_WIDTH, IMAGE_HEIGHT, Image.SCALE_DEFAULT));
        logo.setIcon(newImage);
        this.add(text, java.awt.BorderLayout.NORTH);
        this.add(logo, java.awt.BorderLayout.CENTER);
    }

}
