package it.unibo.view.panels;

import java.util.HashMap;
import java.util.Map;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JPanel;

import it.unibo.controller.Controller;

public class EntityPanel extends JPanel {

    private static final int NUMBER_OF_ENTITIES = 6;
    private static final int IMAGE_WIDTH = 75;
    private static final int IMAGE_HEIGHT = 75;
    
    private final Map<Integer, JButton> buttons = new HashMap<>();
    
    public EntityPanel() {
        super();
        this.setLayout(new java.awt.GridLayout(1, NUMBER_OF_ENTITIES));
        for (int i = 0; i < NUMBER_OF_ENTITIES; i++) {
            this.buttons.put(i+1, new JButton());
        }
        loadButtons();
        this.buttons.forEach((k, v) -> this.add(v));
    }

    /**
     * Loads the text of the entity in the buttons.
     */
    private void loadButtons() {
        this.buttons.get(1).setText("Organismi");
        ImageIcon image = new ImageIcon("app\\src\\main\\resources\\button_images\\organisms.jpg");
        ImageIcon newImage = new ImageIcon(
                image.getImage().getScaledInstance(IMAGE_WIDTH, IMAGE_HEIGHT, java.awt.Image.SCALE_DEFAULT));
        this.buttons.get(1).setIcon(newImage);

        this.buttons.get(2).setText("Relitti");
        image = new ImageIcon("app\\src\\main\\resources\\button_images\\shipwreck.jpg");
        newImage = new ImageIcon(
                image.getImage().getScaledInstance(IMAGE_WIDTH, IMAGE_HEIGHT, java.awt.Image.SCALE_DEFAULT));
        this.buttons.get(2).setIcon(newImage);

        this.buttons.get(3).setText("<html>Formazioni<br />geologiche</html>");
        image = new ImageIcon("app\\src\\main\\resources\\button_images\\geo.jpg");
        newImage = new ImageIcon(
                image.getImage().getScaledInstance(IMAGE_WIDTH, IMAGE_HEIGHT, java.awt.Image.SCALE_DEFAULT));
        this.buttons.get(3).setIcon(newImage);

        this.buttons.get(4).setText("Avvistamenti");
        image = new ImageIcon("app\\src\\main\\resources\\button_images\\sightings.jpg");
        newImage = new ImageIcon(
                image.getImage().getScaledInstance(IMAGE_WIDTH, IMAGE_HEIGHT, java.awt.Image.SCALE_DEFAULT));
        this.buttons.get(4).setIcon(newImage);

        this.buttons.get(5).setText("Associazioni");
        image = new ImageIcon("app\\src\\main\\resources\\button_images\\associations.jpg");
        newImage = new ImageIcon(
                image.getImage().getScaledInstance(IMAGE_WIDTH, IMAGE_HEIGHT, java.awt.Image.SCALE_DEFAULT));
        this.buttons.get(5).setIcon(newImage);

        this.buttons.get(6).setText("Spedizioni");
        image = new ImageIcon("app\\src\\main\\resources\\button_images\\expeditions.jpg");
        newImage = new ImageIcon(
                image.getImage().getScaledInstance(IMAGE_WIDTH, IMAGE_HEIGHT, java.awt.Image.SCALE_DEFAULT));
        this.buttons.get(6).setIcon(newImage);
    }

}
