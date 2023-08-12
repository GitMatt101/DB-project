package it.unibo.view.popups;

import java.util.ArrayList;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

import it.unibo.common.Pair;

public class PopupUtilities {

    private static final int HORIZONTAL_CELL_SPACING = 0;
    private static final int VERTICAL_CELL_SPACING = 0;
    private static final int DEFAULT_SCROLLPANE_HEIGHT = 600;
    private static final int DEFAULT_TEXTAREA_WIDTH = 300;
    private static final int DEFAULT_TEXTAREA_HEIGHT = 300;

    public PopupUtilities() {
    }

    public static JFrame createFrame(final String title, final JPanel mainPanel) {
        final JFrame frame = new JFrame();
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setTitle(title);
        frame.getContentPane().add(mainPanel);
        frame.pack();
        frame.setLocationRelativeTo(null);
        return frame;
    }

    public static List<JTextArea> createTextFields(final List<String> names, final int fontSize,
            final Pair<Integer, Integer> size) {
        final List<JTextArea> textAreas = new ArrayList<>();
        names.forEach(n -> textAreas.add(new JTextArea(n)));
        textAreas.forEach(t -> loadTextProperties(t, fontSize, size));
        return textAreas;
    }

    public static void loadTextProperties(final JTextArea textArea, final int fontSize,
            final Pair<Integer, Integer> size) {
        textArea.setPreferredSize(new java.awt.Dimension(size.getX(), size.getY()));
        textArea.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, fontSize));
        textArea.setEditable(false);
        textArea.setLineWrap(true);
        textArea.setLineWrap(true);
        textArea.setWrapStyleWord(true);
        textArea.setBorder(new javax.swing.border.LineBorder(java.awt.Color.BLACK, 1, true));
    }

    public static JPanel createTopPanel(final List<JTextArea> fields) {
        final JPanel topPanel = new JPanel();
        topPanel.setLayout(new java.awt.GridLayout(1, fields.size(), HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        fields.forEach(topPanel::add);
        return topPanel;
    }

    public static JPanel createCenterPanel(final int rows, final int columns) {
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(rows, columns, HORIZONTAL_CELL_SPACING,
                VERTICAL_CELL_SPACING));
        return centerPanel;
    }

    public static JScrollPane createScrollPane(final JPanel centerPanel, final int width) {
        final JScrollPane scrollPane = new JScrollPane(centerPanel,
                JScrollPane.VERTICAL_SCROLLBAR_ALWAYS,
                JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
        centerPanel.setAutoscrolls(true);
        scrollPane.setPreferredSize(new java.awt.Dimension(width, DEFAULT_SCROLLPANE_HEIGHT));
        return scrollPane;
    }

    public static void showPopup(final String text, final String title) {
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

}
