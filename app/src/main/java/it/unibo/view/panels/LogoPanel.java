package it.unibo.view.panels;

import java.awt.Color;
import java.awt.Font;
import java.awt.Image;

import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import it.unibo.common.Constants;

/**
 * This class is used to create the logo and title of the app.
 */
public class LogoPanel extends JPanel {

    private static final long serialVersionUID = 1L;

    private static final int IMAGE_WIDTH = 275;
    private static final int IMAGE_HEIGHT = 275;
    private static final int FONT_SIZE = 20;

    /**
     * Creates a new {@link JPanel} that contains the logo of the app and the title.
     */
    public LogoPanel() {
        super();
        this.setLayout(new java.awt.BorderLayout());
        final JTextField text = new JTextField("DeepSea Expeditions");
        text.setFont(new Font("Serif", Font.CENTER_BASELINE, FONT_SIZE));
        text.setForeground(Color.CYAN);
        text.setBackground(Constants.BACKGROUND_COLOR);
        text.setBorder(new javax.swing.border.LineBorder(Color.CYAN, 0));
        text.setEditable(false);
        final JLabel logo = new JLabel();
        final ImageIcon image = new ImageIcon("app\\src\\main\\resources\\app_icon.jpg");
        final ImageIcon resizedImage = new ImageIcon(
                image.getImage().getScaledInstance(IMAGE_WIDTH, IMAGE_HEIGHT, Image.SCALE_DEFAULT));
        logo.setIcon(resizedImage);
        this.add(text, java.awt.BorderLayout.NORTH);
        this.add(logo, java.awt.BorderLayout.CENTER);
    }

}
