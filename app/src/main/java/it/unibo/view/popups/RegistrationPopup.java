package it.unibo.view.popups;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;

import it.unibo.common.Constants;
import it.unibo.controller.Controller;

public class RegistrationPopup {

    private static final int TEXT_WIDTH = 200;
    private static final int TEXT_HEIGHT = 40;
    private static final int HORIZONTAL_CELL_SPACING = 20;
    private static final int VERTICAL_CELL_SPACING = 0;
    private static final java.awt.Font TEXT_FONT = new java.awt.Font("Arial", java.awt.Font.PLAIN, 20);

    public RegistrationPopup() {
    }

    private static void showResultPopup(final boolean result) {
        if (result) {
            JOptionPane.showMessageDialog(null, Constants.SUCCESSFUL_REGISTRATION, Constants.POPUP_MESSAGE,
                    JOptionPane.INFORMATION_MESSAGE);
        } else {
            JOptionPane.showMessageDialog(null, Constants.UNSUCCESSFUL_REGISTRATION, Constants.POPUP_MESSAGE,
                    JOptionPane.ERROR_MESSAGE);
        }
    }

    private static void loadTextProperties(final List<JTextField> buttons) {
        buttons.forEach(button -> {
            button.setPreferredSize(new java.awt.Dimension(TEXT_WIDTH, TEXT_HEIGHT));
            button.setFont(TEXT_FONT);
        });
    }

    public static void operatorRegistration() {
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(3, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        final JTextField firstName = new JTextField("Nome");
        final JTextField secondName = new JTextField("Cognome");
        final JTextField fiscalCode = new JTextField("Codice fiscale");
        final JTextField association = new JTextField("Associazione");
        final JTextField groupID = new JTextField("ID gruppo");
        final JTextField id = new JTextField("ID");
        loadTextProperties(List.of(firstName, secondName, fiscalCode, association, groupID, id));
        centerPanel.add(firstName);
        centerPanel.add(association);
        centerPanel.add(secondName);
        centerPanel.add(groupID);
        centerPanel.add(fiscalCode);
        centerPanel.add(id);
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = new JFrame();
        frame.getContentPane().add(mainPanel);
        frame.pack();
        frame.setLocationRelativeTo(null);
        frame.setResizable(false);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final boolean result = Controller.registerOperator(
                    firstName.getText(),
                    secondName.getText(),
                    fiscalCode.getText(),
                    association.getText(),
                    groupID.getText(),
                    id.getText());
            frame.dispose();
            showResultPopup(result);
        });
    }

    public static void rovRegistration() {
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(2, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        final JTextField licensePlate = new JTextField("Targa");
        final JTextField manufacturer = new JTextField("Casa produttrice");
        final JTextField serialNumber = new JTextField("Numero di serie");
        final JTextField productionDate = new JTextField("Data (YYYY-MM-DD)");
        loadTextProperties(List.of(licensePlate, manufacturer, serialNumber, productionDate));
        centerPanel.add(licensePlate);
        centerPanel.add(productionDate);
        centerPanel.add(manufacturer);
        centerPanel.add(serialNumber);
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = new JFrame();
        frame.getContentPane().add(mainPanel);
        frame.pack();
        frame.setLocationRelativeTo(null);
        frame.setResizable(false);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            boolean result = false;
            try {
                final Date date = new SimpleDateFormat("yyyy-MM-dd").parse(productionDate.getText());
                result = Controller.registerROV(
                        licensePlate.getText(),
                        manufacturer.getText(),
                        serialNumber.getText(),
                        date);
            } catch (final ParseException e1) {
                Logger.getLogger(RegistrationPopup.class.getName()).log(Level.SEVERE, "Error parsing date", e1);
                result = false;
            }
            frame.dispose();
            showResultPopup(result);
        });
    }

    public static void expeditionRegistration() {
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(3, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        final JTextField code = new JTextField("Codice");
        final JTextField date = new JTextField("Data");
        final JTextField locationName = new JTextField("Luogo");
        final JTextField rovLicensePlate = new JTextField("Targa del ROV");
        final JTextField associationName = new JTextField("Associazione");
        final JTextField groupID = new JTextField("ID gruppo");
        loadTextProperties(List.of(code, date, locationName, rovLicensePlate, associationName, groupID));
        centerPanel.add(code);
        centerPanel.add(date);
        centerPanel.add(locationName);
        centerPanel.add(rovLicensePlate);
        centerPanel.add(associationName);
        centerPanel.add(groupID);
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = new JFrame();
        frame.getContentPane().add(mainPanel);
        frame.pack();
        frame.setLocationRelativeTo(null);
        frame.setResizable(false);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            boolean result = false;
            try {
                final Date tmpDate = new SimpleDateFormat("yyyy-MM-dd").parse(date.getText());
                result = Controller.registerExpedition(
                        code.getText(),
                        tmpDate,
                        locationName.getText(),
                        rovLicensePlate.getText(),
                        associationName.getText(),
                        groupID.getText()
                );
            } catch (final ParseException e1) {
                Logger.getLogger(RegistrationPopup.class.getName()).log(Level.SEVERE, "Error parsing date", e1);
                result = false;
            }
            frame.dispose();
            showResultPopup(result);
        });
    }

    public static void sightingRegistration() {
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(3, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        final JTextField code = new JTextField("Codice");
        final JTextField expeditionCode = new JTextField("Codice spedizione");
        final JTextField depth = new JTextField("Profondita'");
        final JTextField rovLicensePlate = new JTextField("Targa del ROV");
        final JTextField associationName = new JTextField("Associazione");
        final JTextField groupID = new JTextField("ID gruppo");
        loadTextProperties(List.of(code, expeditionCode, depth, rovLicensePlate, associationName, groupID));
        centerPanel.add(code);
        centerPanel.add(expeditionCode);
        centerPanel.add(depth);
        centerPanel.add(rovLicensePlate);
        centerPanel.add(associationName);
        centerPanel.add(groupID);
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = new JFrame();
        frame.getContentPane().add(mainPanel);
        frame.pack();
        frame.setLocationRelativeTo(null);
        frame.setResizable(false);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            boolean result = false;
            try {
                final Date tmpDate = new SimpleDateFormat("yyyy-MM-dd").parse(date.getText());
                result = Controller.registerExpedition(
                        code.getText(),
                        tmpDate,
                        locationName.getText(),
                        rovLicensePlate.getText(),
                        associationName.getText(),
                        groupID.getText()
                );
            } catch (final ParseException e1) {
                Logger.getLogger(RegistrationPopup.class.getName()).log(Level.SEVERE, "Error parsing date", e1);
                result = false;
            }
            frame.dispose();
            showResultPopup(result);
        });
    }

}
