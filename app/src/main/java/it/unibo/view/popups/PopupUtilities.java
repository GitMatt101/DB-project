package it.unibo.view.popups;

import java.util.ArrayList;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextField;

import it.unibo.common.Pair;

public class PopupUtilities {

    private static final int HORIZONTAL_CELL_SPACING = 0;
    private static final int VERTICAL_CELL_SPACING = 0;
    private static final int DEFAULT_SCROLLPANE_HEIGHT = 600;

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
        textFields.forEach(t -> loadFieldProperties(t, fontSize, size));
        return textFields;
    }

    public static void loadFieldProperties(final JTextField textField, final int fontSize,
            final Pair<Integer, Integer> size) {
        textField.setPreferredSize(new java.awt.Dimension(size.getX(), size.getY()));
        textField.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, fontSize));
        textField.setEditable(false);
    }

    public static JPanel createTopPanel(final List<JTextField> fields) {
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
        final JScrollPane scrollPane = new JScrollPane(centerPanel);
        centerPanel.setAutoscrolls(true);
        scrollPane.setPreferredSize(new java.awt.Dimension(width, DEFAULT_SCROLLPANE_HEIGHT));
        return scrollPane;
    }

}
