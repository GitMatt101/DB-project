package it.unibo.view.popups.impl;

import java.util.ArrayList;
import java.util.List;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import java.awt.Component;
import java.awt.event.ActionListener;

import it.unibo.view.popups.api.OutputManager;

/**
 * Implementation of {@link OutputManager}.
 */
public class OutputManagerImpl implements OutputManager {

    private static final String OPEN_DESCRIPTION = "Apri descrizione";
    private static final String OPEN_NOTES = "Apri note";
    private static final String DESCRIPTION = "Descrizione";
    private static final String NOTES = "Note";
    private static final String FRAME_TITLE = "Risultati";
    private static final int FONT_SIZE = 15;
    private static final int FIELD_WIDTH = 150;
    private static final int FIELD_HEIGHT = 40;

    private static final int HORIZONTAL_CELL_SPACING = 0;
    private static final int VERTICAL_CELL_SPACING = 0;
    private static final int DEFAULT_TEXTAREA_WIDTH = 300;
    private static final int DEFAULT_TEXTAREA_HEIGHT = 300;
    private static final int SCROLL_SPEED = 16;
    private static final int SCROLLPANE_MAX_HEIGHT = 600;

    /**
     * Creates a {@link JTextArea}.
     * 
     * @param text the text to use
     * @return a {@link JTextArea} with the given text
     */
    private JTextArea createDefaultTextArea(final String text) {
        final JTextArea textArea = new JTextArea(text);
        loadTextAreaProperties(textArea, FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        return textArea;
    }

    /**
     * Creates a {@link JButton} for the popup.
     * 
     * @param text           the text of the button
     * @param actionListener the {@link ActionListener} the button will use
     * @return a {@link JButton} with the given text and the given action to perform
     *         on click
     */
    private JButton createPopupButton(final String text, final ActionListener actionListener) {
        final JButton button = new JButton(text);
        button.addActionListener(actionListener);
        button.setPreferredSize(new java.awt.Dimension(FIELD_WIDTH, FIELD_HEIGHT));
        return button;
    }

    /**
     * Creates a frame to contatin the panels with the results of the operations.
     * 
     * @param title     the title of the window
     * @param mainPanel the panel containing the results of the operation
     * @return a {@link JFrame} containing the given mainPanel
     */
    private JFrame createFrame(final String title, final JPanel mainPanel) {
        final JFrame frame = new JFrame();
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setTitle(title);
        frame.getContentPane().add(mainPanel);
        frame.pack();
        frame.setLocationRelativeTo(null);
        return frame;
    }

    /**
     * Creates the fields that will be used to show the results of an operation.
     * 
     * @param names    the texts to put in the fields
     * @param fontSize the text size
     * @param width    the width of each field
     * @param height   the height of each field
     * @return a List of {@link JTextField}
     */
    private List<JTextField> createTextFields(final List<String> names, final int fontSize, final int width,
            final int height) {
        final List<JTextField> textFields = new ArrayList<>();
        names.forEach(n -> textFields.add(new JTextField(n)));
        textFields.forEach(t -> {
            t.setPreferredSize(new java.awt.Dimension(width, height));
            t.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, fontSize));
            t.setEditable(false);
            t.setBorder(new javax.swing.border.LineBorder(java.awt.Color.BLACK, 1, true));
        });
        return textFields;
    }

    private void loadTextAreaProperties(final JTextArea textArea, final int fontSize, final int width,
            final int height) {
        textArea.setPreferredSize(new java.awt.Dimension(width, height));
        textArea.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, fontSize));
        textArea.setEditable(false);
        textArea.setLineWrap(true);
        textArea.setWrapStyleWord(true);
        textArea.setBorder(new javax.swing.border.LineBorder(java.awt.Color.BLACK, 1, true));
    }

    private JPanel createTopPanel(final List<JTextField> fields) {
        final JPanel topPanel = new JPanel();
        topPanel.setLayout(new java.awt.GridLayout(1, fields.size(), HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        fields.forEach(f -> {
            f.setBackground(java.awt.Color.YELLOW);
            topPanel.add(f);
        });
        return topPanel;
    }

    private JPanel createCenterPanel(final int rows, final int columns) {
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(rows, columns, HORIZONTAL_CELL_SPACING,
                VERTICAL_CELL_SPACING));
        return centerPanel;
    }

    private JScrollPane createScrollPane(final JPanel centerPanel, final int width, final int height) {
        final JScrollPane scrollPane = new JScrollPane(centerPanel,
                JScrollPane.VERTICAL_SCROLLBAR_ALWAYS,
                JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
        centerPanel.setAutoscrolls(true);
        final int h = height > SCROLLPANE_MAX_HEIGHT ? SCROLLPANE_MAX_HEIGHT : height;
        scrollPane.setPreferredSize(new java.awt.Dimension(width, h));
        scrollPane.getVerticalScrollBar().setUnitIncrement(SCROLL_SPEED);
        return scrollPane;
    }

    private void showPopup(final String text, final String title) {
        final JFrame frame = new JFrame();
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setTitle(title);
        final JTextArea textArea = new JTextArea(text);
        textArea.setEditable(false);
        textArea.setLineWrap(true);
        textArea.setWrapStyleWord(true);
        textArea.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, 20));
        textArea.setPreferredSize(new java.awt.Dimension(DEFAULT_TEXTAREA_WIDTH, DEFAULT_TEXTAREA_HEIGHT));
        frame.getContentPane().add(textArea);
        frame.pack();
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }

    private JPanel createMainPanel(final JPanel topPanel, final JScrollPane scrollPane) {
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(topPanel, java.awt.BorderLayout.NORTH);
        mainPanel.add(scrollPane, java.awt.BorderLayout.CENTER);
        return mainPanel;
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showSightings(final List<List<String>> sightings) {
        final List<JTextField> textFields = createTextFields(
                List.of("Codice avvistamento", "Codice spedizione", "Numero", "Profondità", NOTES,
                        "ID organismo", "ID relitto", "ID formazione geologica"),
                FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = createTopPanel(textFields);
        final JPanel centerPanel = createCenterPanel(sightings.size(), textFields.size());
        final JScrollPane scrollPane = createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * sightings.size());
        sightings.forEach(s -> {
            for (int i = 0; i < textFields.size(); i++) {
                final String text = s.get(i);
                if (i == 4) {
                    final Component component = text.length() > 0
                            ? createPopupButton(OPEN_NOTES, e -> showPopup(text, NOTES))
                            : createDefaultTextArea("");
                    centerPanel.add(component);
                } else {
                    centerPanel.add(createDefaultTextArea(text));
                }
            }
        });
        final JPanel mainPanel = createMainPanel(topPanel, scrollPane);
        final JFrame frame = createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showExtractions(final List<List<String>> extractions) {
        final List<JTextField> textFields = createTextFields(
                List.of("Codice prelievo", "Codice spedizione", "Numero", "Materiale", "Profondità", "Quantità",
                        NOTES),
                FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = createTopPanel(textFields);
        final JPanel centerPanel = createCenterPanel(extractions.size(), textFields.size());
        final JScrollPane scrollPane = createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * extractions.size());
        extractions.forEach(e -> {
            for (int i = 0; i < textFields.size() - 1; i++) {
                centerPanel.add(createDefaultTextArea(e.get(i)));
            }
            final String description = e.get(textFields.size() - 1);
            final Component component = description.length() > 0
                    ? createPopupButton(OPEN_DESCRIPTION, ev -> showPopup(description, DESCRIPTION))
                    : createDefaultTextArea("");
            centerPanel.add(component);
        });
        final JPanel mainPanel = createMainPanel(topPanel, scrollPane);
        final JFrame frame = createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showExpeditions(final List<List<Object>> expeditions) {
        final List<JTextField> textFields = createTextFields(
                List.of("Codice", "Data", "Luogo", "Associazione", "Gruppo", "Membri-Ruoli"),
                FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = createTopPanel(textFields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(topPanel, java.awt.BorderLayout.NORTH);
        final JPanel centerPanel = createCenterPanel(expeditions.size(), textFields.size());
        final JScrollPane scrollPane = createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * expeditions.size());
        System.out.println(topPanel.getPreferredSize());
        System.out.println(scrollPane.getPreferredSize());
        expeditions.forEach(e -> {
            for (int i = 0; i < textFields.size() - 1; i++) {
                centerPanel.add(createDefaultTextArea((String) e.get(i)));
            }
            Object obj = e.get(textFields.size() - 1);
            String[] list = new String[((List<?>) obj).size()];
            if (obj instanceof List) {
                for (int i = 0; i < ((List<?>) obj).size(); i++) {
                    if (((List<?>) obj).get(i) instanceof String) {
                        list[i] = (String) ((List<?>) obj).get(i);
                    }
                }
            }
            final JComboBox<String> names = new JComboBox<>(list);
            names.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, FONT_SIZE));
            names.setEditable(false);
            names.setPreferredSize(new java.awt.Dimension(FIELD_WIDTH, FIELD_HEIGHT));
            centerPanel.add(names);
            obj = e.get(textFields.size() - 1);
            list = new String[((List<?>) obj).size()];
            if (obj instanceof List) {
                for (int i = 0; i < ((List<?>) obj).size(); i++) {
                    if (((List<?>) obj).get(i) instanceof String) {
                        list[i] = (String) ((List<?>) obj).get(i);
                    }
                }
            }
            final JComboBox<String> fiscals = new JComboBox<>(list);
            fiscals.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, FONT_SIZE));
            fiscals.setEditable(false);
            fiscals.setPreferredSize(new java.awt.Dimension(FIELD_WIDTH, FIELD_HEIGHT));
            centerPanel.add(fiscals);
        });
        mainPanel.add(scrollPane, java.awt.BorderLayout.CENTER);
        final JFrame frame = createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showOrganisms(final List<List<String>> organisms) {
        final List<JTextField> textFields = createTextFields(List.of("ID", "Specie", "Nome provvisorio",
                "Nome comune", DESCRIPTION), FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = createTopPanel(textFields);
        final JPanel centerPanel = createCenterPanel(organisms.size(), textFields.size());
        final JScrollPane scrollPane = createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * organisms.size());
        organisms.forEach(o -> {
            for (int i = 0; i < textFields.size() - 1; i++) {
                centerPanel.add(createDefaultTextArea(o.get(i)));
            }
            centerPanel.add(createPopupButton(OPEN_DESCRIPTION, e -> {
                final String descriptionStart = "[NON IDENTIFICATO]".equals(o.get(1)) ? o.get(2) : o.get(1);
                showPopup(descriptionStart + ":\n" + o.get(textFields.size() - 1), DESCRIPTION);
            }));
        });
        final JPanel mainPanel = createMainPanel(topPanel, scrollPane);
        final JFrame frame = createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showWrecks(final List<List<String>> wrecks) {
        final List<JTextField> textFields = createTextFields(
                List.of("ID", "Nome modello", "Data affondamento", "Lunghezza", DESCRIPTION),
                FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = createTopPanel(textFields);
        final JPanel centerPanel = createCenterPanel(wrecks.size(), textFields.size());
        final JScrollPane scrollPane = createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * wrecks.size());
        wrecks.forEach(w -> {
            for (int i = 0; i < textFields.size() - 1; i++) {
                centerPanel.add(createDefaultTextArea(w.get(i)));
            }
            centerPanel.add(createPopupButton(OPEN_DESCRIPTION,
                    e -> showPopup(w.get(textFields.size() - 1), FRAME_TITLE)));
        });
        final JPanel mainPanel = createMainPanel(topPanel, scrollPane);
        final JFrame frame = createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showGeologicalFormations(final List<List<String>> geos) {
        final List<JTextField> textFields = createTextFields(
                List.of("ID", "Tipologia", "Grado di pericolo", "Dimensioni", DESCRIPTION), FONT_SIZE,
                FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = createTopPanel(textFields);
        final JPanel centerPanel = createCenterPanel(geos.size(), textFields.size());
        final JScrollPane scrollPane = createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * geos.size());
        geos.forEach(g -> {
            for (int i = 0; i < textFields.size() - 1; i++) {
                centerPanel.add(createDefaultTextArea(g.get(i)));
            }
            centerPanel.add(createPopupButton(OPEN_DESCRIPTION,
                    e -> showPopup(g.get(textFields.size() - 1), DESCRIPTION)));
        });
        final JPanel mainPanel = createMainPanel(topPanel, scrollPane);
        final JFrame frame = createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showAssociations(final List<List<String>> associations) {
        final List<JTextField> textFields = createTextFields(
                List.of("Nome", "Indirizzo"),
                FONT_SIZE, FIELD_WIDTH + 300, FIELD_HEIGHT);
        final JPanel topPanel = createTopPanel(textFields);
        final JPanel centerPanel = createCenterPanel(associations.size(), textFields.size());
        final JScrollPane scrollPane = createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * associations.size());
        associations.forEach(w -> {
            w.forEach(a -> {
                centerPanel.add(createDefaultTextArea(a));
            });
        });
        final JPanel mainPanel = createMainPanel(topPanel, scrollPane);
        final JFrame frame = createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showGeologicalFormationsAndLocations(final List<List<String>> geologicalFormations) {
        final List<JTextField> textFields = createTextFields(
                List.of("ID", "Tipologia", "Dimensioni", DESCRIPTION, "Luogo", "Paese"),
                FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = createTopPanel(textFields);
        final JPanel centerPanel = createCenterPanel(geologicalFormations.size(), textFields.size());
        final JScrollPane scrollPane = createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * geologicalFormations.size());
        geologicalFormations.forEach(g -> {
            for (int i = 0; i < textFields.size(); i++) {
                final String text = g.get(i);
                if (i == 3) {
                    final Component component = text.length() > 0
                            ? createPopupButton(OPEN_NOTES, e -> showPopup(text, NOTES))
                            : createDefaultTextArea("");
                    centerPanel.add(component);
                } else {
                    centerPanel.add(createDefaultTextArea(text));
                }
            }
        });
        final JPanel mainPanel = createMainPanel(topPanel, scrollPane);
        final JFrame frame = createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showWrecksAndLocations(final List<List<String>> values) {
        final List<JTextField> textFields = createTextFields(List.of("ID", "Luogo", "Paese"),
                FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = createTopPanel(textFields);
        final JPanel centerPanel = createCenterPanel(values.size(), textFields.size());
        final JScrollPane scrollPane = createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * values.size());
        values.forEach(s -> {
            s.forEach(e -> {
                centerPanel.add(createDefaultTextArea(e));
            });
        });
        final JPanel mainPanel = createMainPanel(topPanel, scrollPane);
        final JFrame frame = createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showAnalysesAndLaboratories(final List<List<String>> values) {
        final List<JTextField> textFields = createTextFields(
                List.of("Codice analisi", DESCRIPTION, "Nome laboratorio", "ID laboratorio", "Indirizzo laboratorio"),
                FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = createTopPanel(textFields);
        final JPanel centerPanel = createCenterPanel(values.size(), textFields.size());
        final JScrollPane scrollPane = createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * values.size());
        values.forEach(v -> {
            v.forEach(e -> {
                centerPanel.add(createDefaultTextArea(e));
            });
        });
        final JPanel mainPanel = createMainPanel(topPanel, scrollPane);
        final JFrame frame = createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

}
