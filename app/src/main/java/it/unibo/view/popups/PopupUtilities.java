package it.unibo.view.popups;

import java.util.ArrayList;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;

import it.unibo.common.Pair;

public class PopupUtilities {

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

    public static List<JTextField> createTextFields(final List<String> names, final int fontSize, final Pair<Integer, Integer> size) {
        final List<JTextField> textFields = new ArrayList<>();
        names.forEach(n -> textFields.add(new JTextField(n)));
        textFields.forEach(t -> loadFieldProperties(t, fontSize, size));
        return textFields;
    }

    public static void loadFieldProperties(final JTextField textField, final int fontSize, final Pair<Integer, Integer> size) {
        textField.setPreferredSize(new java.awt.Dimension(size.getX(), size.getY()));
        textField.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, fontSize));
        textField.setEditable(false);
    }

}
