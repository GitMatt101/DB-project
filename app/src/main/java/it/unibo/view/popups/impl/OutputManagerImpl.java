package it.unibo.view.popups.impl;

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

import it.unibo.view.popups.PopupUtilities;
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
    private static final int FIELD_WIDTH = 290;
    private static final int FIELD_HEIGHT = 40;

    private JTextArea createDefaultTextArea(final String text) {
        final JTextArea textArea = new JTextArea(text);
        PopupUtilities.loadTextAreaProperties(textArea, FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        return textArea;
    }

    private JButton createPopupButton(final String text, final ActionListener actionListener) {
        final JButton button = new JButton(text);
        button.addActionListener(actionListener);
        return button;
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showSightings(final List<List<String>> sightings) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(
                List.of("Codice avvistamento", "Codice spedizione", "Numero", "Profondità", NOTES,
                        "ID organismo", "ID relitto", "ID formazione geologica"),
                FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(sightings.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * sightings.size());
        sightings.forEach(s -> {
            for (int i = 0; i < textFields.size(); i++) {
                final String text = s.get(i);
                if (i == 4) {
                    final Component component = text.length() > 0
                            ? createPopupButton(OPEN_NOTES, e -> PopupUtilities.showPopup(text, NOTES))
                            : createDefaultTextArea("");
                    centerPanel.add(component);
                } else {
                    centerPanel.add(createDefaultTextArea(text));
                }
            }
        });
        final JPanel mainPanel = PopupUtilities.createMainPanel(topPanel, scrollPane);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showExtractions(final List<List<String>> extractions) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(
                List.of("Codice prelievo", "Codice spedizione", "Numero", "Materiale", "Profondità", "Quantità",
                        NOTES),
                FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(extractions.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * extractions.size());
        extractions.forEach(e -> {
            for (int i = 0; i < textFields.size() - 1; i++) {
                centerPanel.add(createDefaultTextArea(e.get(i)));
            }
            final String description = e.get(textFields.size() - 1);
            final Component component = description.length() > 0
                    ? createPopupButton(OPEN_DESCRIPTION, ev -> PopupUtilities.showPopup(description, DESCRIPTION))
                    : createDefaultTextArea("");
            centerPanel.add(component);
        });
        final JPanel mainPanel = PopupUtilities.createMainPanel(topPanel, scrollPane);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showExpeditions(final List<List<Object>> expeditions) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(
                List.of("Codice", "Data", "Luogo", "Associazione", "Gruppo", "Membri-Ruoli"),
                FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(topPanel, java.awt.BorderLayout.NORTH);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(expeditions.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * expeditions.size());
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
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showOrganisms(final List<List<String>> organisms) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(List.of("ID", "Specie", "Nome provvisorio",
                "Nome comune", DESCRIPTION), FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(organisms.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * organisms.size());
        organisms.forEach(o -> {
            for (int i = 0; i < textFields.size() - 1; i++) {
                centerPanel.add(createDefaultTextArea(o.get(i)));
            }
            centerPanel.add(createPopupButton(OPEN_DESCRIPTION, e -> {
                final String descriptionStart = "[NON IDENTIFICATO]".equals(o.get(1)) ? o.get(2) : o.get(1);
                PopupUtilities.showPopup(descriptionStart + ":\n" + o.get(textFields.size() - 1), DESCRIPTION);
            }));
        });
        final JPanel mainPanel = PopupUtilities.createMainPanel(topPanel, scrollPane);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showWrecks(final List<List<String>> wrecks) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(
                List.of("ID", "Nome modello", "Data affondamento", "Lunghezza", DESCRIPTION),
                FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(wrecks.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * wrecks.size());
        wrecks.forEach(w -> {
            for (int i = 0; i < textFields.size() - 1; i++) {
                centerPanel.add(createDefaultTextArea(w.get(i)));
            }
            centerPanel.add(createPopupButton(OPEN_DESCRIPTION,
                    e -> PopupUtilities.showPopup(w.get(textFields.size() - 1), FRAME_TITLE)));
        });
        final JPanel mainPanel = PopupUtilities.createMainPanel(topPanel, scrollPane);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showGeologicalFormations(final List<List<String>> geos) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(
                List.of("ID", "Tipologia", "Grado di pericolo", "Dimensioni", DESCRIPTION), FONT_SIZE,
                FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(geos.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * geos.size());
        geos.forEach(g -> {
            for (int i = 0; i < textFields.size() - 1; i++) {
                centerPanel.add(createDefaultTextArea(g.get(i)));
            }
            centerPanel.add(createPopupButton(OPEN_DESCRIPTION,
                    e -> PopupUtilities.showPopup(g.get(textFields.size() - 1), DESCRIPTION)));
        });
        final JPanel mainPanel = PopupUtilities.createMainPanel(topPanel, scrollPane);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showAssociations(final List<List<String>> associations) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(
                List.of("Nome", "Indirizzo"),
                FONT_SIZE, FIELD_WIDTH + 300, FIELD_HEIGHT);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(associations.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * associations.size());
        associations.forEach(w -> {
            w.forEach(a -> {
                centerPanel.add(createDefaultTextArea(a));
            });
        });
        final JPanel mainPanel = PopupUtilities.createMainPanel(topPanel, scrollPane);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showGeologicalFormationsAndLocations(final List<List<String>> geologicalFormations) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(
                List.of("ID", "Tipologia", "Dimensioni", DESCRIPTION, "Luogo", "Paese"),
                FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(geologicalFormations.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * geologicalFormations.size());
        geologicalFormations.forEach(g -> {
            for (int i = 0; i < textFields.size(); i++) {
                final String text = g.get(i);
                if (i == 3) {
                    final Component component = text.length() > 0
                            ? createPopupButton(OPEN_NOTES, e -> PopupUtilities.showPopup(text, NOTES))
                            : createDefaultTextArea("");
                    centerPanel.add(component);
                } else {
                    centerPanel.add(createDefaultTextArea(text));
                }
            }
        });
        final JPanel mainPanel = PopupUtilities.createMainPanel(topPanel, scrollPane);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showWrecksAndLocations(final List<List<String>> values) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(List.of("ID", "Luogo", "Paese"),
                FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(values.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * values.size());
        values.forEach(s -> {
            s.forEach(e -> {
                centerPanel.add(createDefaultTextArea(e));
            });
        });
        final JPanel mainPanel = PopupUtilities.createMainPanel(topPanel, scrollPane);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    /**
     * {@inheritDoc}.
     */
    @Override
    public void showAnalysesAndLaboratories(final List<List<String>> values) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(
                List.of("Codice analisi", DESCRIPTION, "Nome laboratorio", "ID laboratorio", "Indirizzo laboratorio"),
                FONT_SIZE, FIELD_WIDTH, FIELD_HEIGHT);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(values.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * values.size());
        values.forEach(v -> {
            v.forEach(e -> {
                centerPanel.add(createDefaultTextArea(e));
            });
        });
        final JPanel mainPanel = PopupUtilities.createMainPanel(topPanel, scrollPane);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

}
