package it.unibo.view.popups;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import it.unibo.common.Pair;

public class VisualizationPopups {

    private static final String FRAME_TITLE = "Risultati";
    private static final int LARGE_FONT_SIZE = 17;
    private static final int SMALL_FONT_SIZE = 14;
    private static final int TOP_TEXT_SIZE = 20;
    private static final Pair<Integer, Integer> LARGE_FIELD = new Pair<>(200, 50);
    private static final Pair<Integer, Integer> SMALL_FIELD = new Pair<>(160, 35);

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
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * sightings.size());
        for (var s : sightings) {
            for (int i = 0; i < textFields.size(); i++) {
                if (i != 4) {
                    final JTextArea field = new JTextArea((String) s.get(i));
                    PopupUtilities.loadTextProperties(field, SMALL_FONT_SIZE, SMALL_FIELD);
                    centerPanel.add(field);
                } else {
                    final File imageFile = (File) s.get(i);
                    ImageIcon image = new ImageIcon(imageFile.getAbsolutePath());
                    ImageIcon newImage = new ImageIcon(
                            image.getImage().getScaledInstance(SMALL_FIELD.getX(),
                                    SMALL_FIELD.getX() * image.getIconHeight() / image.getIconWidth(),
                                    java.awt.Image.SCALE_DEFAULT));
                    centerPanel.add(new JLabel(newImage));
                    imageFile.delete();
                }
            }
        }
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
                TOP_TEXT_SIZE, LARGE_FIELD);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(extractions.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * extractions.size());
        extractions.forEach(e -> {
            e.forEach(s -> {
                final JTextArea field = new JTextArea(s);
                PopupUtilities.loadTextProperties(field, LARGE_FONT_SIZE, LARGE_FIELD);
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
                TOP_TEXT_SIZE, LARGE_FIELD);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(topPanel, java.awt.BorderLayout.NORTH);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(expeditions.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * expeditions.size());
        expeditions.forEach(e -> {
            for (int i = 0; i < textFields.size() - 2; i++) {
                final JTextArea field = new JTextArea((String) e.get(i));
                PopupUtilities.loadTextProperties(field, LARGE_FONT_SIZE, LARGE_FIELD);
                centerPanel.add(field);
            }
            Object obj = e.get(textFields.size() - 2);
            String[] list = new String[((List<?>) obj).size()];
            if (obj instanceof List) {
                for (int i = 0; i < ((List<?>) obj).size(); i++) {
                    if (((List<?>) obj).get(i) instanceof String) {
                        list[i] = (String) ((List<?>) obj).get(i);
                    }
                }
            }
            final JComboBox<String> names = new JComboBox<>(list);
            names.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, LARGE_FONT_SIZE));
            names.setEditable(false);
            names.setPreferredSize(new java.awt.Dimension(LARGE_FIELD.getX(), LARGE_FIELD.getY()));
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
            fiscals.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, LARGE_FONT_SIZE));
            fiscals.setEditable(false);
            fiscals.setPreferredSize(new java.awt.Dimension(LARGE_FIELD.getX(), LARGE_FIELD.getY()));
            centerPanel.add(fiscals);
        });
        mainPanel.add(scrollPane, java.awt.BorderLayout.CENTER);
        final JFrame frame = PopupUtilities.createFrame(FRAME_TITLE, mainPanel);
        frame.setVisible(true);
    }

    public static void showOrganisms(final List<List<String>> organisms) {
        final List<JTextField> textFields = PopupUtilities.createTextFields(List.of("ID", "Specie", "Nome provvisorio",
                "Nome comune", "Descrizione"), TOP_TEXT_SIZE, LARGE_FIELD);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(organisms.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * organisms.size());
        organisms.forEach(o -> {
            for (int i = 0; i < textFields.size() - 1; i++) {
                final JTextArea field = new JTextArea(o.get(i));
                PopupUtilities.loadTextProperties(field, LARGE_FONT_SIZE, LARGE_FIELD);
                centerPanel.add(field);
            }
            final JButton button = new JButton("Apri descrizione");
            button.addActionListener(e -> {
                final String descriptionStart;
                if (o.get(1).equals("[NON IDENTIFICATO]")) {
                    descriptionStart = o.get(2);
                } else {
                    descriptionStart = o.get(1);
                }
                PopupUtilities.showPopup(descriptionStart + ":\n" + o.get(textFields.size() - 1), "Descrizione");
            });
            centerPanel.add(button);
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
                TOP_TEXT_SIZE, LARGE_FIELD);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(geologicalFormations.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * geologicalFormations.size());
        geologicalFormations.forEach(s -> {
            s.forEach(e -> {
                final JTextArea field = new JTextArea(e);
                PopupUtilities.loadTextProperties(field, LARGE_FONT_SIZE, LARGE_FIELD);
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
                TOP_TEXT_SIZE, LARGE_FIELD);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(values.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * values.size());
        values.forEach(s -> {
            s.forEach(e -> {
                final JTextArea field = new JTextArea(e);
                PopupUtilities.loadTextProperties(field, LARGE_FONT_SIZE, LARGE_FIELD);
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
                TOP_TEXT_SIZE, LARGE_FIELD);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(values.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * values.size());
        values.forEach(s -> {
            for (int i = 0; i < textFields.size(); i++) {
                if (i != 2) {
                    final JTextArea field = new JTextArea((String) s.get(i));
                    PopupUtilities.loadTextProperties(field, LARGE_FONT_SIZE, LARGE_FIELD);
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
                TOP_TEXT_SIZE, LARGE_FIELD);
        final JPanel topPanel = PopupUtilities.createTopPanel(textFields);
        final JPanel centerPanel = PopupUtilities.createCenterPanel(analyses.size(), textFields.size());
        final JScrollPane scrollPane = PopupUtilities.createScrollPane(centerPanel,
                Double.valueOf(topPanel.getPreferredSize().getWidth()).intValue(),
                Double.valueOf(topPanel.getPreferredSize().getHeight()).intValue() * analyses.size());
        analyses.forEach(s -> {
            s.forEach(e -> {
                final JTextArea field = new JTextArea(e);
                PopupUtilities.loadTextProperties(field, LARGE_FONT_SIZE, LARGE_FIELD);
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
