package it.unibo.view.panels;

import javax.swing.JButton;
import javax.swing.JPanel;

import it.unibo.common.Constants;
import it.unibo.controller.Controller;

public class OperationPanel extends JPanel {

    private static final int ROWS = 5;
    private static final int COLUMNS = 3;
    private static final int HORIZONTAL_SPACING = 10;
    private static final int VERTICAL_SPACING = 10;

    /**
     * Creates a {@code JPanel} with the buttons.
     */
    public OperationPanel() {
        super();
        this.setLayout(new java.awt.GridLayout(ROWS, COLUMNS, HORIZONTAL_SPACING, VERTICAL_SPACING));
        this.setBackground(Constants.BACKGROUND_COLOR);
        final JButton o1 = new JButton();
        o1.setText("O1 - Aggiungi un operatore");
        o1.addActionListener(e -> Controller.openOperatorRegistrationPopup());
        final JButton o2 = new JButton();
        o2.setText("O2 - Registra un ROV");
        o2.addActionListener(e -> Controller.openROVRegistrationPopup());
        final JButton o3 = new JButton();
        o3.setText("O3 - Registra una spedizione");
        o3.addActionListener(e -> Controller.openExpeditionRegistrationPopup());
        final JButton o4A = new JButton();
        o4A.setText("<html>O4_A - Aggiungi un avvistamento<br />ad una spedizione</html>");
        o4A.addActionListener(e -> Controller.openSightingRegistrationPopup());
        final JButton o4B = new JButton();
        o4B.setText("<html>O4_B - Aggiungi un prelievo<br />ad una spedizione</html>");
        o4B.addActionListener(e -> Controller.openExtractionRegistrationPopup());
        final JButton o5 = new JButton();
        o5.setText("<html>O5 - Modifica la specie di<br />un organismo non identificato</html>");
        o5.addActionListener(e -> Controller.openSpeciesUpdatePopup());
        final JButton o6A = new JButton();
        o6A.setText("O6_A - Visualizza avvistamenti con filtri");
        o6A.addActionListener(e -> Controller.openSightingsFilterPopup());
        final JButton o6B = new JButton();
        o6B.setText("O6_B - Visualizza prelievi con filtri");
        o6B.addActionListener(e -> Controller.openExtractionsFilterPopup());
        final JButton o7 = new JButton();
        o7.setText("<html>O7 - Visualizza le spedizioni organizzate<br />da un'associazione</html>");
        o7.addActionListener(e -> Controller.openExpeditionsFilterPopup());
        final JButton o8 = new JButton();
        o8.setText("<html>O8 - Visualizza gli organismi avvistati<br />in una spedizione</html>");
        o8.addActionListener(e -> Controller.openOrganismsFilterPopup());
        final JButton o9 = new JButton();
        o9.setText("<html>O9 - Visualizza le formazioni geologiche<br />filtrando per grado di pericolo</html>");
        o9.addActionListener(e -> Controller.openDangerLevelFilterPopup());
        final JButton o10 = new JButton();
        o10.setText("<html>O10 - Visualizza i luoghi dove sono<br />affondati dei relitti</html>");
        o10.addActionListener(e -> Controller.openLocationWreckFilterPopup());
        final JButton o11 = new JButton();
        o11.setText("O11 - Visualizza le analisi fatte su un materiale");
        o11.addActionListener(e -> Controller.openAnalysesSearch());
        this.add(o1);
        this.add(o2);
        this.add(o3);
        this.add(o4A);
        this.add(o4B);
        this.add(o5);
        this.add(o6A);
        this.add(o6B);
        this.add(o7);
        this.add(o8);
        this.add(o9);
        this.add(o10);
        this.add(o11);
    }

}
