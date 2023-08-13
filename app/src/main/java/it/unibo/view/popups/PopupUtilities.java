package it.unibo.view.popups;

import java.util.ArrayList;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import it.unibo.common.Pair;

public class PopupUtilities {

    private static final int HORIZONTAL_CELL_SPACING = 0;
    private static final int VERTICAL_CELL_SPACING = 0;
    private static final int DEFAULT_TEXTAREA_WIDTH = 300;
    private static final int DEFAULT_TEXTAREA_HEIGHT = 300;
    private static final int SCROLL_SPEED = 16;
    private static final int SCROLLPANE_MAX_HEIGHT = 600;

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

    public static List<JTextField> createTextFields(final List<String> names, final int fontSize,
            final Pair<Integer, Integer> size) {
        final List<JTextField> textFields = new ArrayList<>();
        names.forEach(n -> textFields.add(new JTextField(n)));
        textFields.forEach(t -> {
            t.setPreferredSize(new java.awt.Dimension(size.getX(), size.getY()));
            t.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, fontSize));
            t.setEditable(false);
            t.setBorder(new javax.swing.border.LineBorder(java.awt.Color.BLACK, 1, true));
        });
        return textFields;
    }

    public static void loadTextProperties(final JTextArea textArea, final int fontSize,
            final Pair<Integer, Integer> size) {
        textArea.setPreferredSize(new java.awt.Dimension(size.getX(), size.getY()));
        textArea.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, fontSize));
        textArea.setEditable(false);
        textArea.setLineWrap(true);
        textArea.setWrapStyleWord(true);
        textArea.setBorder(new javax.swing.border.LineBorder(java.awt.Color.BLACK, 1, true));
    }

    public static JPanel createTopPanel(final List<JTextField> fields) {
        final JPanel topPanel = new JPanel();
        topPanel.setLayout(new java.awt.GridLayout(1, fields.size(), HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        fields.forEach(f -> {
            f.setBackground(java.awt.Color.YELLOW);
            topPanel.add(f);
        });
        return topPanel;
    }

    public static JPanel createCenterPanel(final int rows, final int columns) {
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(rows, columns, HORIZONTAL_CELL_SPACING,
                VERTICAL_CELL_SPACING));
        return centerPanel;
    }

    public static JScrollPane createScrollPane(final JPanel centerPanel, final int width, final int height) {
        final JScrollPane scrollPane = new JScrollPane(centerPanel,
                JScrollPane.VERTICAL_SCROLLBAR_ALWAYS,
                JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
        centerPanel.setAutoscrolls(true);
        final int h = height > SCROLLPANE_MAX_HEIGHT ? SCROLLPANE_MAX_HEIGHT : height;
        scrollPane.setPreferredSize(new java.awt.Dimension(width, h));
        scrollPane.getVerticalScrollBar().setUnitIncrement(SCROLL_SPEED);
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
