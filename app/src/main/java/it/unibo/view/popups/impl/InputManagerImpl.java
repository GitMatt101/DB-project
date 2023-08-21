package it.unibo.view.popups.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import it.unibo.view.popups.api.InputManager;
import it.unibo.view.popups.api.OutputManager;

/**
 * Implementation of {@link InputManager}.
 */
public class InputManagerImpl implements InputManager {

    private static final String CONFIRM = "Conferma";
    private static final String OBLIGATORY_ID = "ID*";
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
     * input.
     * 
     * @param number the number of blank String
     * @return a list of empty Strings
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
            textFields.put(counter.getValueAndIncrement(), jtf);
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
     * Checks if a String is empty and decides what to return.
     * 
     * @param text the string to check
     * @return the string if its length isn't 0, null otherwise
     */
    private String getStringOrNull(final String text) {
        return text.length() != 0 ? text : null;
    }

    /**
     * Checks if a String is empty and decides what to return.
     * 
     * @param text the string to check
     * @return the string's int value if its length isn't 0, null otherwise
     */
    private Integer getIntegerOrNull(final String text) {
        return text.length() != 0 ? Integer.valueOf(text) : null;
    }

    /**
     * Checks if a String is empty and decides what to return.
     * 
     * @param text the string to check
     * @return the string's float value if its length isn't 0, null otherwise
     */
    private Float getFloatOrNull(final String text) {
        return text.length() != 0 ? Float.valueOf(text) : null;
    }

    private void createFrame(final String title, final JPanel mainPanel) {
        final JFrame frame = new JFrame();
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setTitle(title);
        frame.getContentPane().add(mainPanel);
        frame.pack();
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }

    private void showUserInputPopup(final List<String> fieldNames, final Map<Integer, JTextField> fields,
            final JButton confirmButton, final String title) {
        final Map<Integer, JTextField> tips = createTextFields(fieldNames);
        final JPanel centerPanel = createCenterPanel(tips.size(), COLUMNS, tips, fields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        createFrame(title, mainPanel);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void memberRegistration() {
        final List<String> fieldNames = List.of("Nome*", "Cognome*", "Codice fiscale*", "Associazione*", "ID gruppo*",
                OBLIGATORY_ID, "Ruolo*");
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(fieldNames.size()));
        final JButton confirmButton = new JButton(CONFIRM);
        confirmButton.addActionListener(e -> {
            final Counter counter = new Counter();
            final boolean result = this.controller.registerMember(
                    fields.get(counter.getValueAndIncrement()).getText(),
                    fields.get(counter.getValueAndIncrement()).getText(),
                    fields.get(counter.getValueAndIncrement()).getText(),
                    fields.get(counter.getValueAndIncrement()).getText(),
                    fields.get(counter.getValueAndIncrement()).getText(),
                    fields.get(counter.getValueAndIncrement()).getText(),
                    fields.get(counter.getValue()).getText());
            showResultPopup(result);
        });
        showUserInputPopup(fieldNames, fields, confirmButton, "Registrazione membro");
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void rovRegistration() {
        final List<String> fieldNames = List.of("Targa*", "Casa produttrice*", "Numero di serie*",
                "Data di produzione (YYYY-MM-DD)*");
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(fieldNames.size()));
        final JButton confirmButton = new JButton(CONFIRM);
        confirmButton.addActionListener(e -> {
            boolean result;
            try {
                final Counter counter = new Counter();
                result = this.controller.registerROV(
                        fields.get(counter.getValueAndIncrement()).getText(),
                        fields.get(counter.getValueAndIncrement()).getText(),
                        fields.get(counter.getValueAndIncrement()).getText(),
                        new SimpleDateFormat("yyyy-MM-dd", Locale.ITALIAN)
                                .parse(fields.get(counter.getValue()).getText()));
            } catch (final ParseException e1) {
                Logger.getLogger(InputManagerImpl.class.getName()).log(Level.SEVERE, "Error parsing date", e1);
                result = false;
            }
            showResultPopup(result);
        });
        showUserInputPopup(fieldNames, fields, confirmButton, "Registrazione ROV");

    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void expeditionRegistration() {
        final List<String> fieldNames = List.of("Codice*", "Data* (YYYY-MM-DD)*", "Luogo*", "Targa del ROV*",
                "Associazione*", "ID gruppo*");
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(fieldNames.size()));
        final JButton confirmButton = new JButton(CONFIRM);
        confirmButton.addActionListener(e -> {
            boolean result;
            try {
                final Counter counter = new Counter();
                result = this.controller.registerExpedition(
                        fields.get(counter.getValueAndIncrement()).getText(),
                        new SimpleDateFormat("yyyy-MM-dd", Locale.ITALIAN)
                                .parse(fields.get(counter.getValueAndIncrement()).getText()),
                        fields.get(counter.getValueAndIncrement()).getText(),
                        fields.get(counter.getValueAndIncrement()).getText(),
                        fields.get(counter.getValueAndIncrement()).getText(),
                        fields.get(counter.getValue()).getText());
            } catch (final ParseException e1) {
                Logger.getLogger(InputManagerImpl.class.getName()).log(Level.SEVERE, "Error parsing date", e1);
                result = false;
            }
            showResultPopup(result);
        });
        showUserInputPopup(fieldNames, fields, confirmButton, "Registrazione spedizione");
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void sightingRegistration() {
        final List<String> fieldNames = List.of("Codice*", "Codice spedizione*", "Profondità", "Note", "ID organismo",
                "ID relitto", "ID formazione geologica");
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(fieldNames.size()));
        final JButton confirmButton = new JButton(CONFIRM);
        confirmButton.addActionListener(e -> {
            final Counter counter = new Counter();
            final boolean result = this.controller.registerSighting(
                    fields.get(counter.getValueAndIncrement()).getText(),
                    fields.get(counter.getValueAndIncrement()).getText(),
                    getIntegerOrNull(fields.get(counter.getValueAndIncrement()).getText()),
                    getStringOrNull(fields.get(counter.getValueAndIncrement()).getText()),
                    getStringOrNull(fields.get(counter.getValueAndIncrement()).getText()),
                    getStringOrNull(fields.get(counter.getValueAndIncrement()).getText()),
                    getStringOrNull(fields.get(counter.getValue()).getText()));
            showResultPopup(result);
        });
        showUserInputPopup(fieldNames, fields, confirmButton, "Registrazione avvistamento");
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void extractionRegistration() {
        final List<String> fieldNames = List.of("Codice*", "Codice spedizione*", "Materiale*", "Profondità",
                "Quantità*", "Note");
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(fieldNames.size()));
        final JButton confirmButton = new JButton(CONFIRM);
        confirmButton.addActionListener(e -> {
            final Counter counter = new Counter();
            final boolean result = this.controller.registerExtraction(
                    fields.get(counter.getValueAndIncrement()).getText(),
                    fields.get(counter.getValueAndIncrement()).getText(),
                    fields.get(counter.getValueAndIncrement()).getText(),
                    getIntegerOrNull(fields.get(counter.getValueAndIncrement()).getText()),
                    getFloatOrNull(fields.get(counter.getValueAndIncrement()).getText()),
                    getStringOrNull(fields.get(counter.getValue()).getText()));
            showResultPopup(result);
        });
        showUserInputPopup(fieldNames, fields, confirmButton, "Registrazione prelievo");
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void speciesUpdate() {
        final List<String> fieldNames = List.of(OBLIGATORY_ID, "Nuova Specie*");
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(fieldNames.size()));
        final JButton confirmButton = new JButton(CONFIRM);
        confirmButton.addActionListener(e -> {
            final Counter counter = new Counter();
            final boolean result = this.controller.updateSpecies(
                    fields.get(counter.getValueAndIncrement()).getText(),
                    fields.get(counter.getValue()).getText());
            showResultPopup(result);
        });
        showUserInputPopup(fieldNames, fields, confirmButton, "Aggiornamento specie");
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void organismRegistration() {
        final List<String> fieldNames = List.of(OBLIGATORY_ID, "Nome provvisorio*", "Descrizione*");
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(fieldNames.size()));
        final JButton confirmButton = new JButton(CONFIRM);
        confirmButton.addActionListener(e -> {
            final Counter counter = new Counter();
            final boolean result = this.controller.registerOrganism(
                    fields.get(counter.getValueAndIncrement()).getText(),
                    fields.get(counter.getValueAndIncrement()).getText(),
                    fields.get(counter.getValue()).getText());
            showResultPopup(result);
        });
        showUserInputPopup(fieldNames, fields, confirmButton, "Registrazione organismo");
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void wreckRegistration() {
        final List<String> fieldNames = List.of(OBLIGATORY_ID, "Nome", "Data affondamento", "Lunghezza*", "Descrizione*");
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(fieldNames.size()));
        final JButton confirmButton = new JButton(CONFIRM);
        confirmButton.addActionListener(e -> {
            final Counter counter = new Counter();
            Date date;
            try {
                date = fields.get(2).getText().length() == 0 ? null
                        : new SimpleDateFormat("yyyy-MM-dd", Locale.ITALIAN).parse(fields.get(2).getText());
            } catch (final ParseException e1) {
                Logger.getLogger(InputManagerImpl.class.getName()).log(Level.SEVERE, "Error parsing date", e1);
                date = null;
            }
            final boolean result = this.controller.registerWreck(
                    fields.get(counter.getValueAndIncrement()).getText(),
                    Optional.ofNullable(getStringOrNull(fields.get(counter.getValueAndIncrement()).getText())),
                    Optional.ofNullable(date),
                    Integer.valueOf(fields.get(counter.getValueAndIncrement() + 1).getText()),
                    fields.get(counter.getValue() + 1).getText());
            showResultPopup(result);
        });
        showUserInputPopup(fieldNames, fields, confirmButton, "Registrazione relitto");
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void geologicalFormationRegistration() {
        final List<String> fieldNames = List.of(OBLIGATORY_ID, "Tipologia*", "Dimensioni*", "Grado di pericolo* (1-5)",
                "Descrizione*");
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(fieldNames.size()));
        final JButton confirmButton = new JButton(CONFIRM);
        confirmButton.addActionListener(e -> {
            final Counter counter = new Counter();
            final boolean result = this.controller.registerGeologicalFormation(
                    fields.get(counter.getValueAndIncrement()).getText(),
                    fields.get(counter.getValueAndIncrement()).getText(),
                    Integer.valueOf(fields.get(counter.getValueAndIncrement()).getText()),
                    Integer.valueOf(fields.get(counter.getValueAndIncrement()).getText()),
                    fields.get(counter.getValue()).getText());
            showResultPopup(result);
        });
        showUserInputPopup(fieldNames, fields, confirmButton, "Registrazione formazione geologica");
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void sightingsFilter() {
        final List<String> fieldNames = List.of("Luogo", "Profondità minima", "Profondità massima", "Codice spedizione",
                "ID organismo", "ID relitto", "ID formazione geologica");
        final Map<Integer, JTextField> fieldsValues = createTextFields(createEmptyStrings(fieldNames.size()));
        final JButton confirmButton = new JButton(CONFIRM);
        confirmButton.addActionListener(e -> {
            final Counter counter = new Counter();
            final List<List<String>> result = this.controller.filterSightings(
                    Optional.ofNullable(getStringOrNull(fieldsValues.get(counter.getValueAndIncrement()).getText())),
                    Optional.ofNullable(getIntegerOrNull(fieldsValues.get(counter.getValueAndIncrement()).getText())),
                    Optional.ofNullable(getIntegerOrNull(fieldsValues.get(counter.getValueAndIncrement()).getText())),
                    Optional.ofNullable(getStringOrNull(fieldsValues.get(counter.getValueAndIncrement()).getText())),
                    Optional.ofNullable(getStringOrNull(fieldsValues.get(counter.getValueAndIncrement()).getText())),
                    Optional.ofNullable(getStringOrNull(fieldsValues.get(counter.getValueAndIncrement()).getText())),
                    Optional.ofNullable(getStringOrNull(fieldsValues.get(counter.getValue()).getText())));
            this.outputManager.showSightings(result);
        });
        showUserInputPopup(fieldNames, fieldsValues, confirmButton, "Filtro avvistamenti");
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void extractionsFilter() {
        final List<String> fieldNames = List.of("Luogo", "Profondità minima", "Profondità massima", "Codice spedizione",
                "Materiale");
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(fieldNames.size()));
        final JButton confirmButton = new JButton(CONFIRM);
        confirmButton.addActionListener(e -> {
            final Counter counter = new Counter();
            final List<List<String>> result = this.controller.filterExtractions(
                    Optional.ofNullable(getStringOrNull(fields.get(counter.getValueAndIncrement()).getText())),
                    Optional.ofNullable(getIntegerOrNull(fields.get(counter.getValueAndIncrement()).getText())),
                    Optional.ofNullable(getIntegerOrNull(fields.get(counter.getValueAndIncrement()).getText())),
                    Optional.ofNullable(getStringOrNull(fields.get(counter.getValueAndIncrement()).getText())),
                    Optional.ofNullable(getStringOrNull(fields.get(counter.getValue()).getText())));
            this.outputManager.showExtractions(result);
        });
        showUserInputPopup(fieldNames, fields, confirmButton, "Filtro prelievi");
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void expeditionsFilterByAssociation() {
        final List<String> fieldNames = List.of("Associazione");
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(fieldNames.size()));
        final JButton confirmButton = new JButton(CONFIRM);
        confirmButton.addActionListener(e -> {
            final List<List<Object>> result = this.controller
                    .filterExpeditionsByAssociation(fields.get(0).getText());
            this.outputManager.showExpeditions(result);
        });
        showUserInputPopup(fieldNames, fields, confirmButton, "Ricerca spedizioni di un'associazione");
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void organismsFilterByExpedition() {
        final List<String> fieldNames = List.of("Codice spedizione");
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(fieldNames.size()));
        final JButton confirmButton = new JButton(CONFIRM);
        confirmButton.addActionListener(e -> {
            final List<List<String>> result = this.controller.filterOrganismsByExpedition(fields.get(0).getText());
            this.outputManager.showOrganisms(result);
        });
        showUserInputPopup(fieldNames, fields, confirmButton, "Ricerca organismi in una spedizione");
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void wrecksFitlerByName() {
        final List<String> fieldNames = List.of("Nome");
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(fieldNames.size()));
        final JButton confirmButton = new JButton(CONFIRM);
        confirmButton.addActionListener(e -> {
            final List<List<String>> result = this.controller.filterLocationsByWreck(fields.get(0).getText());
            this.outputManager.showWrecksAndLocations(result);
        });
        showUserInputPopup(fieldNames, fields, confirmButton, "Ricerca relitti per nome");
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void analysesFilterByMaterial() {
        final List<String> fieldNames = List.of("Materiale");
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(fieldNames.size()));
        final JButton confirmButton = new JButton(CONFIRM);
        confirmButton.addActionListener(e -> {
            final List<List<String>> result = this.controller.getAnalysesInfo(fields.get(0).getText());
            this.outputManager.showAnalysesAndLaboratories(result);
        });
        showUserInputPopup(fieldNames, fields, confirmButton, "Ricerca analisi per materiale");
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void yearChoice() {
        final List<String> fieldNames = List.of("Anno minimo", "Anno massimo");
        final Map<Integer, JTextField> fields = createTextFields(createEmptyStrings(fieldNames.size()));
        final JButton confirmButton = new JButton(CONFIRM);
        confirmButton.addActionListener(e -> {
            Integer minYear = 0;
            Integer maxYear = 0;
            if (getIntegerOrNull(fields.get(0).getText()) != null) {
                minYear = Integer.valueOf(fields.get(0).getText());
            }
            if (getIntegerOrNull(fields.get(1).getText()) != null) {
                maxYear = Integer.valueOf(fields.get(1).getText());
            }
            final List<List<String>> result = this.controller.getScientificprogress(minYear, maxYear);
            this.outputManager.showScientificProgress(result);
        });
        showUserInputPopup(fieldNames, fields, confirmButton, "Ricerca analisi per materiale");
    }

}
