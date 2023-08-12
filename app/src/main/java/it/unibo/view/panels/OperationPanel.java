package it.unibo.view.panels;

import java.util.HashMap;
import java.util.Map;

import javax.swing.JButton;
import javax.swing.JPanel;

import it.unibo.common.Constants;
import it.unibo.controller.Controller;

public class OperationPanel extends JPanel {

    private static final int NUMBER_OF_OPERATIONS = 15;
    private static final int ROWS = 5;
    private static final int COLUMNS = 3;
    private static final int HORIZONTAL_SPACING = 10;
    private static final int VERTICAL_SPACING = 10;

    private final Map<Integer, JButton> buttons = new HashMap<>();

    /**
     * Creates a {@code JPanel} with the buttons.
     */
    public OperationPanel() {
        super();
        this.setLayout(new java.awt.GridLayout(ROWS, COLUMNS, HORIZONTAL_SPACING, VERTICAL_SPACING));
        for (int i = 0; i < NUMBER_OF_OPERATIONS; i++) {
            buttons.put(i+1, new JButton());
        }
        loadButtons();
        buttons.forEach((k, v) -> this.add(v));
        this.setBackground(Constants.BACKGROUND_COLOR);
    }

    /**
     * Loads the text of the operation in the buttons.
     */
    private void loadButtons() {
        buttons.get(1).setText("O1 - Aggiungi un operatore");
        buttons.get(1).addActionListener(e -> Controller.openOperatorRegistrationPopup());
        buttons.get(2).setText("O2 - Registra un ROV");
        buttons.get(2).addActionListener(e -> Controller.openROVRegistrationPopup());
        buttons.get(3).setText("O3 - Registra una spedizione");
        buttons.get(3).addActionListener(e -> Controller.openExpeditionRegistrationPopup());
        buttons.get(4).setText("<html>O4_A - Aggiungi un avvistamento<br />ad una spedizione</html>");
        buttons.get(4).addActionListener(e -> Controller.openSightingRegistrationPopup());
        buttons.get(5).setText("<html>O4_B - Aggiungi un prelievo<br />ad una spedizione</html>");
        buttons.get(5).addActionListener(e -> Controller.openExtractionRegistrationPopup());
        buttons.get(6).setText("<html>O5 - Modifica la specie di<br />un organismo non identificato</html>");
        buttons.get(6).addActionListener(e -> Controller.openSpeciesUpdatePopup());
        buttons.get(7).setText("O6_A - Visualizza avvistamenti con filtri");
        buttons.get(7).addActionListener(e -> Controller.openSightingsFilterPopup());
        buttons.get(8).setText("O6_B - Visualizza prelievi con filtri");
        buttons.get(8).addActionListener(e -> Controller.openExtractionsFilterPopup());
        buttons.get(9).setText("<html>O7 - Visualizza le spedizioni organizzate<br />da un'associazione</html>");
        buttons.get(9).addActionListener(e -> Controller.openExpeditionsFilterPopup());
        buttons.get(10).setText("O8 - Visualizza i dettagli di una spedizione");
        buttons.get(10).addActionListener(e -> Controller.openExpeditionsCodeFilterPopup());
        buttons.get(11).setText("<html>O9 - Visualizza gli organismi avvistati<br />in una spedizione</html>");
        buttons.get(11).addActionListener(e -> Controller.openOrganismsFilterPopup());
        buttons.get(12).setText("<html>O10 - Visualizza le formazioni geologiche<br />filtrando per grado di pericolo</html>");
        buttons.get(12).addActionListener(e -> Controller.openDangerLevelFilterPopup());
        buttons.get(13).setText("<html>O11 - Visualizza i luoghi dove sono<br />affondati dei relitti</html>");
        buttons.get(13).addActionListener(e -> Controller.openLocationWreckFilterPopup());
        buttons.get(14).setText("O12 - Visualizza avvistamenti di un organismo");
        buttons.get(14).addActionListener(e -> Controller.openSightingsSearchByOrganismID());
        buttons.get(15).setText("O13 - Visualizza le analisi fatte su un materiale");
        buttons.get(15).addActionListener(e -> Controller.openAnalysesSearch());
    }
    
}
