package it.unibo.view.panels;

import javax.swing.JPanel;
import javax.swing.JTextField;

/**
 * Panel that contains the {@link OperationPanel} and the text for operations
 * and generic search.
 */
public class CenterPanel extends JPanel {

    private static final int FONT_SIZE = 17;

    /**
     * Creates a new {@code CenterPanel}.
     */
    public CenterPanel() {
        super();
        this.setLayout(new java.awt.BorderLayout());
        final JTextField operationText = new JTextField("Operazioni");
        operationText.setFont(new java.awt.Font("Serif", java.awt.Font.CENTER_BASELINE, FONT_SIZE));
        operationText.setForeground(java.awt.Color.CYAN);
        operationText.setBackground(java.awt.Color.BLACK);
        operationText.setEditable(false);
        operationText.setBorder(new javax.swing.border.LineBorder(java.awt.Color.CYAN, 0));
        this.add(operationText, java.awt.BorderLayout.NORTH);
        this.add(new OperationPanel(), java.awt.BorderLayout.CENTER);
        final JTextField searchText = new JTextField("Ricerche generiche");
        searchText.setFont(new java.awt.Font("Serif", java.awt.Font.CENTER_BASELINE, 17));
        searchText.setForeground(java.awt.Color.CYAN);
        searchText.setBackground(it.unibo.common.Constants.BACKGROUND_COLOR);
        searchText.setEditable(false);
        searchText.setBorder(new javax.swing.border.LineBorder(java.awt.Color.CYAN, 0));
        this.add(searchText, java.awt.BorderLayout.SOUTH);
    }

}
