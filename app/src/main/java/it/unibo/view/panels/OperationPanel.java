package it.unibo.view.panels;

import javax.swing.JButton;
import javax.swing.JPanel;
import java.awt.event.ActionListener;

import it.unibo.common.Constants;
import it.unibo.controller.api.Controller;
import it.unibo.controller.impl.ControllerImpl;

/**
 * This class is used to contain all the buttons for operations.
 */
public class OperationPanel extends JPanel {

    private static final long serialVersionUID = 1L;

    private static final int ROWS = 5;
    private static final int COLUMNS = 3;
    private static final int HORIZONTAL_SPACING = 10;
    private static final int VERTICAL_SPACING = 10;

    private final transient Controller controller;

    /**
     * Creates a {@code JPanel} with the buttons.
     */
    public OperationPanel() {
        super();
        this.controller = new ControllerImpl();
        this.setLayout(new java.awt.GridLayout(ROWS, COLUMNS, HORIZONTAL_SPACING, VERTICAL_SPACING));
        this.setBackground(Constants.BACKGROUND_COLOR);
        addButton("O1 - Aggiungi un membro ad un gruppo", e -> this.controller.openMemberRegistration());
        addButton("O2 - Registra un ROV", e -> this.controller.openROVRegistration());
        addButton("O3 - Registra una spedizione", e -> this.controller.openExpeditionRegistration());
        addButton("<html>O4_A - Aggiungi un avvistamento<br />ad una spedizione</html>",
                e -> this.controller.openSightingRegistration());
        addButton("<html>O4_B - Aggiungi un prelievo<br />ad una spedizione</html>",
                e -> this.controller.openExtractionRegistration());
        addButton("<html>O5 - Modifica la specie di<br />un organismo non identificato</html>",
                e -> this.controller.openSpeciesUpdate());
        addButton("O6_A - Visualizza avvistamenti con filtri", e -> this.controller.openSightingsFilter());
        addButton("O6_B - Visualizza prelievi con filtri", e -> this.controller.openExtractionsFilter());
        addButton("<html>O7 - Visualizza le spedizioni organizzate<br />da un'associazione</html>",
                e -> this.controller.openExpeditionsFilterByAssociation());
        addButton("<html>O8 - Visualizza gli organismi avvistati<br />in una spedizione</html>",
                e -> this.controller.openOrganismsFilterByExpedition());
        addButton("<html>O9 - Visualizza i luoghi più pericolosi",
                e -> this.controller.showLocationsByMostDangerous());
        addButton("<html>O10 - Visualizza i luoghi dove sono<br />affondati dei relitti</html>",
                e -> this.controller.openWrecksFilterByName());
        addButton("O11 - Visualizza le analisi fatte su un materiale",
                e -> this.controller.openAnalysesFilterByMaterial());
        addButton("O12 - Visualizza il progresso scientifico",
                e -> this.controller.openYearChoice());
    }

    /**
     * Adds a {@link JButton} to he panel.
     * 
     * @param text           the text of the button
     * @param actionListener the action listener of the button
     */
    private void addButton(final String text, final ActionListener actionListener) {
        final JButton button = new JButton(text);
        button.addActionListener(actionListener);
        this.add(button);
    }

}
