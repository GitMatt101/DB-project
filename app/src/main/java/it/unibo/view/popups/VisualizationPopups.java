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

import it.unibo.common.Pair;

public class VisualizationPopups {

    private static final String FRAME_TITLE = "Risultati";
    private static final int LARGE_FONT_SIZE = 18;
    private static final int SMALL_FONT_SIZE = 14;
    private static final Pair<Integer, Integer> LARGE_FIELD = new Pair<>(200, 40);
    private static final Pair<Integer, Integer> SMALL_FIELD = new Pair<>(160, 30);

    public VisualizationPopups() {
    }

    public static void showSightings(final List<List<Object>> sightings) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(
                List.of("Codice avvistamento", "Codice spedizione", "Numero", "Profondità", "Foto", "Note",
                        "ID organismo", "ID relitto", "ID formazione geologica"),
                SMALL_FONT_SIZE, SMALL_FIELD);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(sightings.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue());
        sightings.forEach(s -> {
            for (int i = 0; i < textFields.size(); i++) {
                if (i != 4) {
                    final JTextField field = new JTextField((String) s.get(i));
                    PopupUtilities.loadFieldProperties(field, SMALL_FONT_SIZE, SMALL_FIELD);
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
        mainPanel.add(scrollPane, java.awt.BorderLayout.CENTER);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    public static void showExtractions(final List<List<String>> extractions) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(
                List.of("Codice prelievo", "Codice spedizione", "Numero", "Materiale", "Profondità", "Quantità",
                        "Note"),
                LARGE_FONT_SIZE, LARGE_FIELD);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(extractions.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue());
        extractions.forEach(s -> {
            s.forEach(e -> {
                final JTextField field = new JTextField(e);
                PopupUtilities.loadFieldProperties(field, LARGE_FONT_SIZE, LARGE_FIELD);
                centerPanel.add(field);
            });
        });
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(topPanel, java.awt.BorderLayout.NORTH);
        mainPanel.add(scrollPane, java.awt.BorderLayout.CENTER);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    public static void showExpeditions(final List<List<Object>> expeditions) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(
                List.of("Codice", "Data", "Luogo", "Associazione", "Gruppo", "Operatori", "Codici fiscali"),
                LARGE_FONT_SIZE, LARGE_FIELD);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(topPanel, java.awt.BorderLayout.NORTH);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(expeditions.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue());
        expeditions.forEach(s -> {
            for (int i = 0; i < textFields.size() - 2; i++) {
                final JTextField field = new JTextField((String) s.get(i));
                PopupUtilities.loadFieldProperties(field, LARGE_FONT_SIZE, LARGE_FIELD);
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
            names.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, LARGE_FONT_SIZE));
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
            fiscals.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, LARGE_FONT_SIZE));
            fiscals.setEditable(false);
            centerPanel.add(fiscals);
        });
        mainPanel.add(scrollPane, java.awt.BorderLayout.CENTER);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    public static void showOrganisms(final List<List<String>> organisms) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(List.of("ID", "Specie", "Nome provvisorio",
                "Nome comune", "Descrizione"), LARGE_FONT_SIZE, LARGE_FIELD);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(organisms.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue());
        organisms.forEach(s -> {
            s.forEach(e -> {
                final JTextField field = new JTextField(e);
                PopupUtilities.loadFieldProperties(field, LARGE_FONT_SIZE, LARGE_FIELD);
                centerPanel.add(field);
            });
        });
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(topPanel, java.awt.BorderLayout.NORTH);
        mainPanel.add(scrollPane, java.awt.BorderLayout.CENTER);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    public static void showGeologicalFormationsAndLocations(final List<List<String>> geologicalFormations) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(
                List.of("ID", "Tipologia", "Dimensioni", "Descrizione", "Luogo", "Paese"),
                LARGE_FONT_SIZE, LARGE_FIELD);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(geologicalFormations.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue());
        geologicalFormations.forEach(s -> {
            s.forEach(e -> {
                final JTextField field = new JTextField(e);
                PopupUtilities.loadFieldProperties(field, LARGE_FONT_SIZE, LARGE_FIELD);
                centerPanel.add(field);
            });
        });
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(topPanel, java.awt.BorderLayout.NORTH);
        mainPanel.add(scrollPane, java.awt.BorderLayout.CENTER);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    public static void showWrecksAndLocations(final List<List<String>> values) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(List.of("ID", "Luogo", "Paese"),
                LARGE_FONT_SIZE, LARGE_FIELD);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(values.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue());
        values.forEach(s -> {
            s.forEach(e -> {
                final JTextField field = new JTextField(e);
                PopupUtilities.loadFieldProperties(field, LARGE_FONT_SIZE, LARGE_FIELD);
                centerPanel.add(field);
            });
        });
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(topPanel, java.awt.BorderLayout.NORTH);
        mainPanel.add(scrollPane, java.awt.BorderLayout.CENTER);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    public static void showSightingsAndLocations(final List<List<Object>> values) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(
                List.of("Codice avvistamento", "Profondità", "Foto", "Note", "Luogo", "Paese"),
                LARGE_FONT_SIZE, LARGE_FIELD);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(values.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue());
        values.forEach(s -> {
            for (int i = 0; i < textFields.size(); i++) {
                if (i != 2) {
                    final JTextField field = new JTextField((String) s.get(i));
                    PopupUtilities.loadFieldProperties(field, LARGE_FONT_SIZE, LARGE_FIELD);
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
        mainPanel.add(scrollPane, java.awt.BorderLayout.CENTER);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    public static void showAnalysesAndLaboratories(final List<List<String>> analyses) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(
                List.of("Codice analisi", "Descrizione", "Nome laboratorio", "ID laboratorio", "Indirizzo laboratorio"),
                LARGE_FONT_SIZE, LARGE_FIELD);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(analyses.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue());
        analyses.forEach(s -> {
            s.forEach(e -> {
                final JTextField field = new JTextField(e);
                PopupUtilities.loadFieldProperties(field, LARGE_FONT_SIZE, LARGE_FIELD);
                centerPanel.add(field);
            });
        });
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(topPanel, java.awt.BorderLayout.NORTH);
        mainPanel.add(scrollPane, java.awt.BorderLayout.CENTER);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

}
