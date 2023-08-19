package it.unibo.view.popups.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;

import it.unibo.common.Constants;
import it.unibo.common.Counter;
import it.unibo.common.Pair;
import it.unibo.controller.api.Controller;
import it.unibo.view.popups.PopupUtilities;
import it.unibo.view.popups.api.InputManager;
import it.unibo.view.popups.api.OutputManager;

/**
 * Implementation of {@link InputManager}.
 */
public class InputManagerImpl implements InputManager {

    private static final String CONFIRM = "Conferma";
    private static final int COLUMNS = 2;
    private static final int FIELD_WIDTH = 300;
    private static final int FIELD_HEIGHT = 40;
    private static final int HORIZONTAL_CELL_SPACING = 0;
    private static final int VERTICAL_CELL_SPACING = 10;
    private static final java.awt.Font FIELD_FONT = new java.awt.Font("Arial", java.awt.Font.PLAIN, 20);

    private final OutputManager outputManager;
    private final Controller controller;

    /**
     * Creates an instance of {@code InputManagerImpl} that also uses an
     * {@link OutputManager}.
     * 
     * @param controller the {@link Controller} used to execute operations
     */
    public InputManagerImpl(final Controller controller) {
        this.outputManager = new OutputManagerImpl();
        this.controller = controller;
    }

    /**
     * Displays a popup that shows the result of an operation.
     * 
     * @param result the result of the operation
     */
    private void showResultPopup(final boolean result) {
        final Pair<String, Integer> output = result
                ? new Pair<>(Constants.SUCCESSFUL_REGISTRATION, JOptionPane.INFORMATION_MESSAGE)
                : new Pair<>(Constants.UNSUCCESSFUL_REGISTRATION, JOptionPane.ERROR_MESSAGE);
        JOptionPane.showMessageDialog(null, output.getX(), Constants.POPUP_MESSAGE, output.getY());
    }

    /**
     * Creates empty Strings that will be used to create the text fields for user
     * input
     * 
     * @param number the number of blank String
     */
    private List<String> createEmptyStrings(final int number) {
        final List<String> list = new ArrayList<>();
        for (int i = 0; i < number; i++) {
            list.add("");
        }
        return list;
    }

    private Map<Integer, JTextField> createTextFields(final List<String> fields) {
        final Map<Integer, JTextField> textFields = new HashMap<>();
        final Counter counter = new Counter();
        fields.forEach(f -> {
            final JTextField jtf = new JTextField(f);
            jtf.setPreferredSize(new java.awt.Dimension(FIELD_WIDTH, FIELD_HEIGHT));
            jtf.setFont(FIELD_FONT);
            if (jtf.getText().length() != 0) {
                jtf.setEditable(false);
            }
            textFields.put(counter.getCounterAndIncrement(), jtf);
        });
        return textFields;
    }

    /**
     * Creates the center panel for the input popup.
     * 
     * @param rows    the number of rows the grid will have
     * @param columns the number of columns the grid will have
     * @param tips    the tips that indicate what the user has to type
     * @param fields  the text fields used for user input
     * @return a {@link JPanel} with the specified characteristics
     */
    private JPanel createCenterPanel(final int rows, final int columns, final Map<Integer, JTextField> tips,
            final Map<Integer, JTextField> fields) {
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(rows, columns, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        for (int i = 0; i < tips.size(); i++) {
            centerPanel.add(tips.get(i));
            centerPanel.add(fields.get(i));
        }
        return centerPanel;
    }

    /**
     * Checks if a String is empty and if it is, it will return null.
     * 
     * @param text the string to check
     * @return the string if its length isn't 0, null otherwise
     */
    private String getStringOrNull(final String text) {
        return text.length() != 0 ? text : null;
    }

    private Integer getIntegerOrNull(final String text) {
        return text.length() != 0 ? Integer.valueOf(text) : null;
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void memberRegistration() {
        final Map<Integer, JTextField> tips = createTextFields(
                List.of("Nome*", "Cognome*", "Codice fiscale*", "Associazione*", "ID gruppo*", "ID*", "Ruolo*"));
        final Map<Integer, JTextField> fields = createTextFields(List.of("", "", "", "", "", "", ""));
        final JPanel centerPanel = createCenterPanel(tips.size(), COLUMNS, tips, fields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton(CONFIRM);
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Registrazione membro", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final Counter counter = new Counter();
            final boolean result = this.controller.registerMember(
                    fields.get(counter.getCounterAndIncrement()).getText(),
                    fields.get(counter.getCounterAndIncrement()).getText(),
                    fields.get(counter.getCounterAndIncrement()).getText(),
                    fields.get(counter.getCounterAndIncrement()).getText(),
                    fields.get(counter.getCounterAndIncrement()).getText(),
                    fields.get(counter.getCounterAndIncrement()).getText(),
                    fields.get(counter.getCounter()).getText());
            frame.dispose();
            showResultPopup(result);
        });
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void rovRegistration() {
        final Map<Integer, JTextField> tips = createTextFields(
                List.of("Targa*", "Casa produttrice*", "Numero di serie*", "Data di produzione (YYYY-MM-DD)*"));
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(tips.size()));
        final JPanel centerPanel = createCenterPanel(tips.size(), COLUMNS, tips, fields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton(CONFIRM);
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Registrazione ROV", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            boolean result;
            try {
                final Counter counter = new Counter();
                result = this.controller.registerROV(
                        fields.get(counter.getCounterAndIncrement()).getText(),
                        fields.get(counter.getCounterAndIncrement()).getText(),
                        fields.get(counter.getCounterAndIncrement()).getText(),
                        new SimpleDateFormat("yyyy-MM-dd", Locale.ITALIAN)
                                .parse(fields.get(counter.getCounter()).getText()));
            } catch (final ParseException e1) {
                Logger.getLogger(InputManagerImpl.class.getName()).log(Level.SEVERE, "Error parsing date", e1);
                result = false;
            }
            frame.dispose();
            showResultPopup(result);
        });
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void expeditionRegistration() {
        final Map<Integer, JTextField> tips = createTextFields(
                List.of("Codice*", "Data* (YYYY-MM-DD)*", "Luogo*", "Targa del ROV*", "Associazione*", "ID gruppo*"));
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(tips.size()));
        final JPanel centerPanel = createCenterPanel(tips.size(), COLUMNS, tips, fields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton(CONFIRM);
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Registrazione spedizione", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            boolean result;
            try {
                final Counter counter = new Counter();
                result = this.controller.registerExpedition(
                        fields.get(counter.getCounterAndIncrement()).getText(),
                        new SimpleDateFormat("yyyy-MM-dd", Locale.ITALIAN)
                                .parse(fields.get(counter.getCounterAndIncrement()).getText()),
                        fields.get(counter.getCounterAndIncrement()).getText(),
                        fields.get(counter.getCounterAndIncrement()).getText(),
                        fields.get(counter.getCounterAndIncrement()).getText(),
                        fields.get(counter.getCounter()).getText());
            } catch (final ParseException e1) {
                Logger.getLogger(InputManagerImpl.class.getName()).log(Level.SEVERE, "Error parsing date", e1);
                result = false;
            }
            frame.dispose();
            showResultPopup(result);
        });
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void sightingRegistration() {
        final Map<Integer, JTextField> tips = createTextFields(
                List.of("Codice*", "Codice spedizione*", "Profondità", "Note", "ID organismo", "ID relitto*",
                        "ID formazione geologica"));
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(tips.size()));
        final JPanel centerPanel = createCenterPanel(tips.size(), COLUMNS, tips, fields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton(CONFIRM);
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Registrazione avvistamento", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final Counter counter = new Counter();
            final boolean result = this.controller.registerSighting(
                    fields.get(counter.getCounterAndIncrement()).getText(),
                    fields.get(counter.getCounterAndIncrement()).getText(),
                    getIntegerOrNull(fields.get(counter.getCounterAndIncrement()).getText()),
                    getStringOrNull(fields.get(counter.getCounterAndIncrement()).getText()),
                    getStringOrNull(fields.get(counter.getCounterAndIncrement()).getText()),
                    getStringOrNull(fields.get(counter.getCounterAndIncrement()).getText()),
                    getStringOrNull(fields.get(counter.getCounter()).getText()));
            frame.dispose();
            showResultPopup(result);
        });
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void extractionRegistration() {
        final Map<Integer, JTextField> tips = createTextFields(
                List.of("Codice*", "Codice spedizione*", "Materiale*", "Profondità", "Quantità*", "Note"));
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(tips.size()));
        final JPanel centerPanel = createCenterPanel(tips.size(), COLUMNS, tips, fields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton(CONFIRM);
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Registrazione prelievo", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final Counter counter = new Counter();
            final boolean result = this.controller.registerExtraction(
                    fields.get(counter.getCounterAndIncrement()).getText(),
                    fields.get(counter.getCounterAndIncrement()).getText(),
                    fields.get(counter.getCounterAndIncrement()).getText(),
                    getIntegerOrNull(fields.get(counter.getCounterAndIncrement()).getText()),
                    Float.valueOf(fields.get(counter.getCounterAndIncrement()).getText()),
                    getStringOrNull(fields.get(counter.getCounter()).getText()));
            frame.dispose();
            showResultPopup(result);
        });
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void speciesUpdate() {
        final Map<Integer, JTextField> tips = createTextFields(List.of("ID*", "Nuova Specie*"));
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(tips.size()));
        final JPanel centerPanel = createCenterPanel(tips.size(), COLUMNS, tips, fields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton(CONFIRM);
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Aggiornamento specie", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final Counter counter = new Counter();
            final boolean result = this.controller.updateSpecies(
                    fields.get(counter.getCounterAndIncrement()).getText(),
                    fields.get(counter.getCounter()).getText());
            frame.dispose();
            showResultPopup(result);
        });
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void sightingsFilter() {
        final Map<Integer, JTextField> tips = createTextFields(
                List.of("Luogo", "Profondità minima", "Profondità massima", "Codice spedizione", "ID organismo",
                        "ID relitto", "ID formazione geologica"));
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(tips.size()));
        final JPanel centerPanel = createCenterPanel(tips.size(), COLUMNS, tips, fields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton(CONFIRM);
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Filtro avvistamenti", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final Counter counter = new Counter();
            final List<List<String>> result = this.controller.filterSightings(
                    Optional.ofNullable(getStringOrNull(fields.get(counter.getCounterAndIncrement()).getText())),
                    Optional.ofNullable(getIntegerOrNull(fields.get(counter.getCounterAndIncrement()).getText())),
                    Optional.ofNullable(getIntegerOrNull(fields.get(counter.getCounterAndIncrement()).getText())),
                    Optional.ofNullable(getStringOrNull(fields.get(counter.getCounterAndIncrement()).getText())),
                    Optional.ofNullable(getStringOrNull(fields.get(counter.getCounterAndIncrement()).getText())),
                    Optional.ofNullable(getStringOrNull(fields.get(counter.getCounterAndIncrement()).getText())),
                    Optional.ofNullable(getStringOrNull(fields.get(counter.getCounter()).getText())));
            frame.dispose();
            this.outputManager.showSightings(result);
        });
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void extractionsFilter() {
        final Map<Integer, JTextField> tips = createTextFields(
                List.of("Luogo", "Profondità minima", "Profondità massima", "Codice spedizione", "Materiale"));
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(tips.size()));
        final JPanel centerPanel = createCenterPanel(tips.size(), COLUMNS, tips, fields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton(CONFIRM);
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Filtro prelievi", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final Counter counter = new Counter();
            final List<List<String>> result = this.controller.filterExtractions(
                    Optional.ofNullable(getStringOrNull(fields.get(counter.getCounterAndIncrement()).getText())),
                    Optional.ofNullable(getIntegerOrNull(fields.get(counter.getCounterAndIncrement()).getText())),
                    Optional.ofNullable(getIntegerOrNull(fields.get(counter.getCounterAndIncrement()).getText())),
                    Optional.ofNullable(getStringOrNull(fields.get(counter.getCounterAndIncrement()).getText())),
                    Optional.ofNullable(getStringOrNull(fields.get(counter.getCounter()).getText())));
            frame.dispose();
            this.outputManager.showExtractions(result);
        });
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void expeditionsFilterByAssociation() {
        final Map<Integer, JTextField> tips = createTextFields(List.of("Associazione"));
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(tips.size()));
        final JPanel centerPanel = createCenterPanel(tips.size(), COLUMNS, tips, fields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton(CONFIRM);
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Selezione associazione", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final List<List<Object>> result = this.controller
                    .filterExpeditionsByAssociation(fields.get(0).getText());
            frame.dispose();
            this.outputManager.showExpeditions(result);
        });
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void organismsFilterByExpedition() {
        final Map<Integer, JTextField> tips = createTextFields(List.of("Codice spedizione"));
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(tips.size()));
        final JPanel centerPanel = createCenterPanel(tips.size(), COLUMNS, tips, fields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton(CONFIRM);
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Selezione codice spedizione", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final List<List<String>> result = this.controller.filterOrganismsByExpedition(fields.get(0).getText());
            frame.dispose();
            this.outputManager.showOrganisms(result);
        });
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void geologicalFormationFilterByDangerLevel() {
        final Map<Integer, JTextField> tips = createTextFields(List.of("Grado di pericolo (1-5)"));
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(tips.size()));
        final JPanel centerPanel = createCenterPanel(tips.size(), COLUMNS, tips, fields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton(CONFIRM);
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Selezione grado di pericolo", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final String field = fields.get(0).getText();
            final Integer value = Integer.valueOf(field);
            if (field.length() != 0 && value >= 0 && value <= 5) {
                final List<List<String>> result = this.controller.filterGeologicalFormationsByDangerLevel(value);
                frame.dispose();
                this.outputManager.showGeologicalFormationsAndLocations(result);
            } else {
                frame.dispose();
                this.outputManager.showGeologicalFormationsAndLocations(Collections.emptyList());
            }
        });
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void wrecksFitlerByName() {
        final Map<Integer, JTextField> tips = createTextFields(List.of("Nome"));
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(tips.size()));
        final JPanel centerPanel = createCenterPanel(tips.size(), COLUMNS, tips, fields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton(CONFIRM);
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Selezione nome relitto", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final List<List<String>> result = this.controller.filterLocationsByWreck(fields.get(0).getText());
            frame.dispose();
            this.outputManager.showWrecksAndLocations(result);
        });
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void analysesFilterByMaterial() {
        final Map<Integer, JTextField> tips = createTextFields(List.of("Materiale"));
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(tips.size()));
        final JPanel centerPanel = createCenterPanel(tips.size(), COLUMNS, tips, fields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton(CONFIRM);
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Selezione materiale", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final List<List<String>> result = this.controller.getAnalysesInfo(fields.get(0).getText());
            frame.dispose();
            this.outputManager.showAnalysesAndLaboratories(result);
        });
    }

}
