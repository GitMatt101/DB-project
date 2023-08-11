package it.unibo.view.panels;

import java.awt.Image;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JPanel;

import it.unibo.common.Constants;

public class InfoPanel extends JPanel {

    private static final int WIDTH = 220;
    private static final int HEIGHT = 90;

    private final JButton noaaButton = new JButton();
    private final JButton jamstecButton = new JButton();
    private final JButton oetButton = new JButton();

    public InfoPanel() {
        super();
        this.setLayout(new java.awt.GridLayout(3,1));
        ImageIcon image = new ImageIcon("app\\src\\main\\resources\\button_images\\noaa.jpg");
        ImageIcon newImage = new ImageIcon(
                image.getImage().getScaledInstance(WIDTH, HEIGHT, Image.SCALE_DEFAULT));
        noaaButton.setIcon(newImage);
        image = new ImageIcon("app\\src\\main\\resources\\button_images\\jamstec.png");
        newImage = new ImageIcon(
                image.getImage().getScaledInstance(WIDTH, HEIGHT, Image.SCALE_DEFAULT));
        jamstecButton.setIcon(newImage);
        image = new ImageIcon("app\\src\\main\\resources\\button_images\\oet.jpg");
        newImage = new ImageIcon(
                image.getImage().getScaledInstance(WIDTH, HEIGHT, Image.SCALE_DEFAULT));
        oetButton.setIcon(newImage);
        this.setButtonProperties(this.noaaButton);
        this.setButtonProperties(this.jamstecButton);
        this.setButtonProperties(this.oetButton);
        this.add(this.noaaButton);
        this.add(this.jamstecButton);
        this.add(this.oetButton);
    }

    private void setButtonProperties(final JButton button) {
        button.setBackground(Constants.BACKGROUND_COLOR);
        button.setBorderPainted(false);
    }
    
}
