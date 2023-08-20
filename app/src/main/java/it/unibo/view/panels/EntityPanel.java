package it.unibo.view.panels;

import java.awt.event.ActionListener;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JPanel;

import it.unibo.controller.api.Controller;
import it.unibo.controller.impl.ControllerImpl;

/**
 * This class is used to contain all the buttons for generic search.
 */
public class EntityPanel extends JPanel {

    private static final long serialVersionUID = 1L;

    private static final int NUMBER_OF_ENTITIES = 6;
    private static final int IMAGE_WIDTH = 75;
    private static final int IMAGE_HEIGHT = 75;
    private static final String ICONS_PATH = "app\\src\\\\main\\resources\\button_images\\";

    private final transient Controller controller;

    /**
     * Creates a new {@link JPanel} with all the {@link JButton}s for the main
     * entities.
     */
    public EntityPanel() {
        super();
        this.controller = new ControllerImpl();
        this.setLayout(new java.awt.GridLayout(1, NUMBER_OF_ENTITIES));
        addButton("Organismi", e -> this.controller.showAllOrganisms(), "organisms.jpg");
        addButton("Relitti", e -> this.controller.showAllWrecks(), "shipwreck.jpg");
        addButton("<html>Formazioni<br />geologiche</html>", e -> this.controller.showAllGeologicalFormations(), "geo.jpg");
        addButton("Avvistamenti", e -> this.controller.showAllSightings(), "sightings.jpg");
        addButton("Associazioni", e -> this.controller.showAllAssociations(), "associations.jpg");
        addButton("Spedizioni", e -> this.controller.showAllExpeditions(), "expeditions.jpg");
    }

    /**
     * Adds a {@link JButton} to the panel.
     * 
     * @param text           the text of the button
     * @param actionListener the action listener of the button
     * @param imageName      the name of the image to use as icon
     */
    private void addButton(final String text, final ActionListener actionListener, final String imageName) {
        final JButton button = new JButton(text);
        final ImageIcon image = new ImageIcon(ICONS_PATH + imageName);
        final ImageIcon resizedImage = new ImageIcon(
                image.getImage().getScaledInstance(IMAGE_WIDTH, IMAGE_HEIGHT, java.awt.Image.SCALE_DEFAULT));
        button.setIcon(resizedImage);
        button.addActionListener(actionListener);
        this.add(button);
    }

}
