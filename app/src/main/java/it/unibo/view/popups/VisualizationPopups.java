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

    private static final int FIELD_WIDTH = 180;
    private static final int FIELD_HEIGHT = 40;
    private static final int HORIZONTAL_CELL_SPACING = 0;
    private static final int VERTICAL_CELL_SPACING = 0;
    private static final java.awt.Font FIELD_FONT = new java.awt.Font("Arial", java.awt.Font.PLAIN, 15);

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
        final JTextField number = new JTextField("Numero");
        final JTextField depth = new JTextField("Profondità");
        final JTextField image = new JTextField("Foto");
        final JTextField notes = new JTextField("Note");
        final JTextField organism = new JTextField("ID organismo");
        final JTextField wreck = new JTextField("ID relitto");
        final JTextField geo = new JTextField("ID formazione geologica");
        final List<JTextField> textFields = List.of(code, expedition, number, depth, image, notes, organism, wreck, geo);
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
                    final JTextField field = new JTextField((String) s.get(i));
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
        final JTextField number = new JTextField("Numero");
        final JTextField material = new JTextField("Materiale");
        final JTextField depth = new JTextField("Profondità");
        final JTextField amount = new JTextField("Quantità");
        final JTextField notes = new JTextField("Note");
        final List<JTextField> textFields = List.of(code, expedition, number, material, depth, amount, notes);
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
                final JTextField field = new JTextField(e);
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
                final JTextField field = new JTextField((String) s.get(i));
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

    public static void showOrganismsResults(final List<List<String>> organisms) {
        final JTextField id = new JTextField("ID");
        final JTextField species = new JTextField("Specie");
        final JTextField temporaryName = new JTextField("Nome provvisorio");
        final JTextField commonName = new JTextField("Nome comune");
        final JTextField description = new JTextField("Decrizione");
        final List<JTextField> textFields = List.of(id, species, temporaryName, commonName, description);
        loadFieldProperties(textFields);
        final JPanel topPanel = new JPanel();
        topPanel.setLayout(
                new java.awt.GridLayout(1, textFields.size(), HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        textFields.forEach(topPanel::add);
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(organisms.size(), textFields.size(), HORIZONTAL_CELL_SPACING,
                VERTICAL_CELL_SPACING));
        final JScrollPane scrollFrame = new JScrollPane(centerPanel);
        centerPanel.setAutoscrolls(true);
        scrollFrame.setPreferredSize(topPanel.getPreferredSize());
        organisms.forEach(s -> {
            s.forEach(e -> {
                final JTextField field = new JTextField(e);
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

    public static void showGeologicalFormationsResults(final List<List<String>> geologicalFormations) {
        final JTextField id = new JTextField("ID");
        final JTextField type = new JTextField("Tipologia");
        final JTextField size = new JTextField("Dimensioni");
        final JTextField description = new JTextField("Decrizione");
        final JTextField location = new JTextField("Luogo");
        final JTextField country = new JTextField("Paese");
        final List<JTextField> textFields = List.of(id, type, size, description, location, country);
        loadFieldProperties(textFields);
        final JPanel topPanel = new JPanel();
        topPanel.setLayout(
                new java.awt.GridLayout(1, textFields.size(), HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        textFields.forEach(topPanel::add);
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(geologicalFormations.size(), textFields.size(), HORIZONTAL_CELL_SPACING,
                VERTICAL_CELL_SPACING));
        final JScrollPane scrollFrame = new JScrollPane(centerPanel);
        centerPanel.setAutoscrolls(true);
        scrollFrame.setPreferredSize(topPanel.getPreferredSize());
        geologicalFormations.forEach(s -> {
            s.forEach(e -> {
                final JTextField field = new JTextField(e);
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

    public static void showIDAndLocation(final List<List<String>> values) {
        final JTextField id = new JTextField("ID");
        final JTextField location = new JTextField("Luogo");
        final JTextField country = new JTextField("Paese");
        final List<JTextField> textFields = List.of(id, location, country);
        loadFieldProperties(textFields);
        final JPanel topPanel = new JPanel();
        topPanel.setLayout(
                new java.awt.GridLayout(1, textFields.size(), HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        textFields.forEach(topPanel::add);
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(values.size(), textFields.size(), HORIZONTAL_CELL_SPACING,
                VERTICAL_CELL_SPACING));
        final JScrollPane scrollFrame = new JScrollPane(centerPanel);
        centerPanel.setAutoscrolls(true);
        scrollFrame.setPreferredSize(topPanel.getPreferredSize());
        values.forEach(s -> {
            s.forEach(e -> {
                final JTextField field = new JTextField(e);
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

    public static void showOrganismSightingsAndLocations(final List<List<Object>> values) {
        final JTextField code = new JTextField("Codice avvistamento");
        final JTextField depth = new JTextField("Profondità");
        final JTextField image = new JTextField("Foto");
        final JTextField notes = new JTextField("Note");
        final JTextField location = new JTextField("Luogo");
        final JTextField country = new JTextField("Paese");
        final List<JTextField> textFields = List.of(code, depth, image, notes, location, country);
        loadFieldProperties(textFields);
        final JPanel topPanel = new JPanel();
        topPanel.setLayout(
                new java.awt.GridLayout(1, textFields.size(), HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        textFields.forEach(topPanel::add);
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(values.size(), textFields.size(), HORIZONTAL_CELL_SPACING,
                VERTICAL_CELL_SPACING));
        final JScrollPane scrollFrame = new JScrollPane(centerPanel);
        centerPanel.setAutoscrolls(true);
        scrollFrame.setPreferredSize(topPanel.getPreferredSize());
        values.forEach(s -> {
            for (int i = 0; i < textFields.size(); i++) {
                if (i != 2) {
                    final JTextField field = new JTextField((String) s.get(i));
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

    public static void showAnalysesReuslts(final List<List<String>> analyses) {
        final JTextField code = new JTextField("Codice analisi");
        final JTextField description = new JTextField("Descrizione");
        final JTextField labName = new JTextField("Nome laboratorio");
        final JTextField labID = new JTextField("ID laboratorio");
        final JTextField labAddress = new JTextField("Indirizzo laboratorio");
        final List<JTextField> textFields = List.of(code, description, labName, labID, labAddress);
        loadFieldProperties(textFields);
        final JPanel topPanel = new JPanel();
        topPanel.setLayout(
                new java.awt.GridLayout(1, textFields.size(), HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        textFields.forEach(topPanel::add);
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(analyses.size(), textFields.size(), HORIZONTAL_CELL_SPACING,
                VERTICAL_CELL_SPACING));
        final JScrollPane scrollFrame = new JScrollPane(centerPanel);
        centerPanel.setAutoscrolls(true);
        scrollFrame.setPreferredSize(topPanel.getPreferredSize());
        analyses.forEach(s -> {
            s.forEach(e -> {
                final JTextField field = new JTextField(e);
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

}
