package it.unibo.view.popups;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.ImageIcon;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextField;

public class VisualizationPopups {

    private static final int FIELD_WIDTH = 190;
    private static final int FIELD_HEIGHT = 40;
    private static final int HORIZONTAL_CELL_SPACING = 0;
    private static final int VERTICAL_CELL_SPACING = 0;
    private static final java.awt.Font FIELD_FONT = new java.awt.Font("Arial", java.awt.Font.PLAIN, 16);

    public VisualizationPopups() {
    }

    private static void loadFieldProperties(final List<JTextField> textFields) {
        textFields.forEach(t -> {
            t.setPreferredSize(new java.awt.Dimension(FIELD_WIDTH, FIELD_HEIGHT));
            t.setFont(FIELD_FONT);
            t.setEditable(false);
        });
    }

    public static void showSightingsResults(final List<List<Object>> sightings) {
        final JTextField code = new JTextField("Codice");
        final JTextField expedition = new JTextField("Codice spedizione");
        final JTextField depth = new JTextField("Profondità");
        final JTextField image = new JTextField("Foto");
        final JTextField notes = new JTextField("Note");
        final JTextField organism = new JTextField("ID organismo");
        final JTextField wreck = new JTextField("ID relitto");
        final JTextField geo = new JTextField("ID formazione geologica");
        final List<JTextField> textFields = List.of(code, expedition, depth, image, notes, organism, wreck, geo);
        loadFieldProperties(textFields);
        final JPanel topPanel = new JPanel();
        topPanel.setLayout(
                new java.awt.GridLayout(1, textFields.size(), HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        textFields.forEach(topPanel::add);
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(sightings.size(), textFields.size(), HORIZONTAL_CELL_SPACING,
                VERTICAL_CELL_SPACING));
        final JScrollPane scrollFrame = new JScrollPane(centerPanel);
        centerPanel.setAutoscrolls(true);
        scrollFrame.setPreferredSize(topPanel.getPreferredSize());
        sightings.forEach(s -> {
            for (int i = 0; i < textFields.size(); i++) {
                if (i != 4) {
                    final JTextField field = s.get(i) != null ? new JTextField((String) s.get(i)) : new JTextField();
                    loadFieldProperties(List.of(field));
                    centerPanel.add(field);
                } else {
                    final File imageFile = new File("app\\src\\main\\resources\\placeholder.jpg");
                    try (FileOutputStream fos = new FileOutputStream(imageFile)) {
                        fos.write((byte[]) s.get(i));
                        centerPanel.add(new JLabel(new ImageIcon("app\\src\\main\\resources\\placeholder.jpg")));
                    } catch (final IOException e) {
                        Logger.getLogger(VisualizationPopups.class.getName()).log(Level.SEVERE,
                                "Error retrieving the image", e);
                    } finally {
                        imageFile.delete();
                    }
                }
            }
        });
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(topPanel, java.awt.BorderLayout.NORTH);
        mainPanel.add(scrollFrame, java.awt.BorderLayout.CENTER);
        final JFrame frame = new JFrame();
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setTitle("Risultati");
        frame.getContentPane().add(mainPanel);
        frame.pack();
        frame.setVisible(true);
    }

    public static void showExtractionsResults(final List<List<String>> extractions) {
        final JTextField code = new JTextField("Codice");
        final JTextField expedition = new JTextField("Codice spedizione");
        final JTextField depth = new JTextField("Profondità");
        final JTextField image = new JTextField("Foto");
        final JTextField notes = new JTextField("Note");
        final JTextField organism = new JTextField("ID organismo");
        final JTextField wreck = new JTextField("ID relitto");
        final JTextField geo = new JTextField("ID formazione geologica");
        final List<JTextField> textFields = List.of(code, expedition, depth, image, notes, organism, wreck, geo);
        loadFieldProperties(textFields);
        final JPanel topPanel = new JPanel();
        topPanel.setLayout(
                new java.awt.GridLayout(1, textFields.size(), HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        textFields.forEach(topPanel::add);
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(extractions.size(), textFields.size(), HORIZONTAL_CELL_SPACING,
                VERTICAL_CELL_SPACING));
        final JScrollPane scrollFrame = new JScrollPane(centerPanel);
        centerPanel.setAutoscrolls(true);
        scrollFrame.setPreferredSize(topPanel.getPreferredSize());
        extractions.forEach(s -> {
            s.forEach(e -> {
                final JTextField field = e != null ? new JTextField(e) : new JTextField();
                loadFieldProperties(List.of(field));
                centerPanel.add(field);
            });
        });
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(topPanel, java.awt.BorderLayout.NORTH);
        mainPanel.add(scrollFrame, java.awt.BorderLayout.CENTER);
        final JFrame frame = new JFrame();
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setTitle("Risultati");
        frame.getContentPane().add(mainPanel);
        frame.pack();
        frame.setVisible(true);
    }

    public static void showExpeditionsResults(final List<List<Object>> expeditions) {
        final JTextField code = new JTextField("Codice");
        final JTextField date = new JTextField("Data");
        final JTextField location = new JTextField("Luogo");
        final JTextField association = new JTextField("Associazione");
        final JTextField group = new JTextField("Gruppo");
        final JTextField operators = new JTextField("Operatori");
        final JTextField fiscalCodes = new JTextField("Codici fiscali");
        final List<JTextField> textFields = List.of(code, date, location, association, group, operators, fiscalCodes);
        loadFieldProperties(textFields);
        final JPanel topPanel = new JPanel();
        topPanel.setLayout(
                new java.awt.GridLayout(1, textFields.size(), HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        textFields.forEach(topPanel::add);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(topPanel, java.awt.BorderLayout.NORTH);
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(expeditions.size(), textFields.size(), HORIZONTAL_CELL_SPACING,
                VERTICAL_CELL_SPACING));
        final JScrollPane scrollFrame = new JScrollPane(centerPanel);
        centerPanel.setAutoscrolls(true);
        scrollFrame.setPreferredSize(mainPanel.getPreferredSize());
        expeditions.forEach(s -> {
            for (int i = 0; i < textFields.size() - 2; i++) {
                final JTextField field = s.get(i) != null ? new JTextField((String) s.get(i)) : new JTextField();
                loadFieldProperties(List.of(field));
                centerPanel.add(field);
            }
            Object obj = s.get(textFields.size() - 2);
            final List<String> list = new ArrayList<>();
            if (obj instanceof List) {
                ((List<?>) obj).forEach(o -> {
                    if (o instanceof String) {
                        list.add((String) o);
                    }
                });
            }
            final JComboBox<String> names = new JComboBox<>((String[]) list.toArray());
            names.setFont(FIELD_FONT);
            names.setEditable(false);
            centerPanel.add(names);
            obj = s.get(textFields.size() - 1);
            list.clear();
            if (obj instanceof List) {
                ((List<?>) obj).forEach(o -> {
                    if (o instanceof String) {
                        list.add((String) o);
                    }
                });
            }
            final JComboBox<String> fiscals = new JComboBox<>((String[]) list.toArray());
            fiscals.setFont(FIELD_FONT);
            fiscals.setEditable(false);
            centerPanel.add(fiscals);
        });
        mainPanel.add(scrollFrame, java.awt.BorderLayout.CENTER);
        final JFrame frame = new JFrame();
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setTitle("Risultati");
        frame.getContentPane().add(mainPanel);
        frame.pack();
        frame.setVisible(true);
    }

}
