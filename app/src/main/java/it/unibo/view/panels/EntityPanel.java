package it.unibo.view.panels;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JPanel;

import it.unibo.controller.Controller;

public class EntityPanel extends JPanel {

    private static final int NUMBER_OF_ENTITIES = 6;
    private static final int IMAGE_WIDTH = 75;
    private static final int IMAGE_HEIGHT = 75;
    
    public EntityPanel() {
        super();
        this.setLayout(new java.awt.GridLayout(1, NUMBER_OF_ENTITIES));

        final JButton organismButton = new JButton();
        organismButton.setText("Organismi");
        ImageIcon image = new ImageIcon("app\\src\\main\\resources\\button_images\\organisms.jpg");
        ImageIcon newImage = new ImageIcon(
                image.getImage().getScaledInstance(IMAGE_WIDTH, IMAGE_HEIGHT, java.awt.Image.SCALE_DEFAULT));
        organismButton.setIcon(newImage);
        organismButton.addActionListener(e -> {
            Controller.showAllOrganisms();
        });
        this.add(organismButton);

        final JButton wreckButton = new JButton();
        wreckButton.setText("Relitti");
        image = new ImageIcon("app\\src\\main\\resources\\button_images\\shipwreck.jpg");
        newImage = new ImageIcon(
                image.getImage().getScaledInstance(IMAGE_WIDTH, IMAGE_HEIGHT, java.awt.Image.SCALE_DEFAULT));
        wreckButton.setIcon(newImage);
        wreckButton.addActionListener(e -> {
            Controller.showAllWrecks();
        });
        this.add(wreckButton);

        final JButton geoButton = new JButton();
        geoButton.setText("<html>Formazioni<br />geologiche</html>");
        image = new ImageIcon("app\\src\\main\\resources\\button_images\\geo.jpg");
        newImage = new ImageIcon(
                image.getImage().getScaledInstance(IMAGE_WIDTH, IMAGE_HEIGHT, java.awt.Image.SCALE_DEFAULT));
        geoButton.setIcon(newImage);
        geoButton.addActionListener(e -> {
            Controller.showAllGeologicalFormations();
        });
        this.add(geoButton);

        final JButton sightingButton = new JButton();
        sightingButton.setText("Avvistamenti");
        image = new ImageIcon("app\\src\\main\\resources\\button_images\\sightings.jpg");
        newImage = new ImageIcon(
                image.getImage().getScaledInstance(IMAGE_WIDTH, IMAGE_HEIGHT, java.awt.Image.SCALE_DEFAULT));
        sightingButton.setIcon(newImage);
        sightingButton.addActionListener(e -> {
            Controller.showAllSightings();
        });
        this.add(sightingButton);

        final JButton associationButton = new JButton();
        associationButton.setText("Associazioni");
        image = new ImageIcon("app\\src\\main\\resources\\button_images\\associations.jpg");
        newImage = new ImageIcon(
                image.getImage().getScaledInstance(IMAGE_WIDTH, IMAGE_HEIGHT, java.awt.Image.SCALE_DEFAULT));
        associationButton.setIcon(newImage);
        associationButton.addActionListener(e -> {
            Controller.showAllAssociations();
        });
        this.add(associationButton);

        final JButton expeditionButton = new JButton();
        expeditionButton.setText("Spedizioni");
        image = new ImageIcon("app\\src\\main\\resources\\button_images\\expeditions.jpg");
        newImage = new ImageIcon(
                image.getImage().getScaledInstance(IMAGE_WIDTH, IMAGE_HEIGHT, java.awt.Image.SCALE_DEFAULT));
        expeditionButton.setIcon(newImage);
        expeditionButton.addActionListener(e -> {
            Controller.showAllExpeditions();
        });
        this.add(expeditionButton);
    }

}
