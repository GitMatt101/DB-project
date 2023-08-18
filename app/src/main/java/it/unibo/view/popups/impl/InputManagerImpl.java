package it.unibo.view.popups.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;

import it.unibo.common.Constants;
import it.unibo.controller.api.Controller;
import it.unibo.view.popups.PopupUtilities;
import it.unibo.view.popups.api.InputManager;
import it.unibo.view.popups.api.OutputManager;

/**
 * Implementation of {@link InputManager}.
 */
public class InputManagerImpl implements InputManager {

    private static final int FIELD_WIDTH = 300;
    private static final int FIELD_HEIGHT = 40;
    private static final int HORIZONTAL_CELL_SPACING = 0;
    private static final int VERTICAL_CELL_SPACING = 10;
    private static final java.awt.Font FIELD_FONT = new java.awt.Font("Arial", java.awt.Font.PLAIN, 20);

    private final OutputManager outputManager;
    private final Controller controller;

    /**
     * Creates an instance of {@code InputManagerImpl} that also uses an
     * {@link OutputManager}.
     */
    public InputManagerImpl(final Controller controller) {
        this.outputManager = new OutputManagerImpl();
        this.controller = controller;
    }

    /**
     * Displays a popup that shows the result of an operation.
     * 
     * @param result the result of the operation
     */
    private void showResultPopup(final boolean result) {
        if (result) {
            JOptionPane.showMessageDialog(null, Constants.SUCCESSFUL_REGISTRATION, Constants.POPUP_MESSAGE,
                    JOptionPane.INFORMATION_MESSAGE);
        } else {
            JOptionPane.showMessageDialog(null, Constants.UNSUCCESSFUL_REGISTRATION, Constants.POPUP_MESSAGE,
                    JOptionPane.ERROR_MESSAGE);
        }
    }

    /**
     * Loads the properties of the text fields.
     * 
     * @param textFields the text fields
     */
    private void loadFieldProperties(final List<JTextField> textFields) {
        textFields.forEach(t -> {
            t.setPreferredSize(new java.awt.Dimension(FIELD_WIDTH, FIELD_HEIGHT));
            t.setFont(FIELD_FONT);
            if (t.getText().length() != 0) {
                t.setEditable(false);
            }
        });
    }

    /**
     * {@inhertidoc}
     */
    @Override
    public void memberRegistration() {
        final JTextField firstNameTip = new JTextField("Nome*");
        final JTextField firstNameField = new JTextField();
        final JTextField secondNameTip = new JTextField("Cognome*");
        final JTextField secondNameField = new JTextField();
        final JTextField fiscalCodeTip = new JTextField("Codice fiscale*");
        final JTextField fiscalCodeField = new JTextField();
        final JTextField associationTip = new JTextField("Associazione*");
        final JTextField associationField = new JTextField();
        final JTextField groupTip = new JTextField("ID gruppo*");
        final JTextField groupField = new JTextField();
        final JTextField idTip = new JTextField("ID*");
        final JTextField idField = new JTextField();
        final JTextField roleTip = new JTextField("Ruolo*");
        final JTextField roleField = new JTextField();
        final List<JTextField> textFields = List.of(firstNameTip, firstNameField, secondNameTip, secondNameField,
                fiscalCodeTip, fiscalCodeField, associationTip, associationField, groupTip,
                groupField, idTip, idField, roleTip, roleField);
        loadFieldProperties(textFields);
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(
                new java.awt.GridLayout(textFields.size() / 2, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        textFields.forEach(centerPanel::add);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Registrazione membro", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final boolean result = this.controller.registerMember(
                    firstNameField.getText(),
                    secondNameField.getText(),
                    fiscalCodeField.getText(),
                    associationField.getText(),
                    groupField.getText(),
                    idField.getText(),
                    roleField.getText());
            frame.dispose();
            showResultPopup(result);
        });
    }

    /**
     * {@inhertidoc}
     */
    @Override
    public void rovRegistration() {
        final JTextField licensePlateTip = new JTextField("Targa*");
        final JTextField licensePlateField = new JTextField();
        final JTextField manufacturerTip = new JTextField("Casa produttrice*");
        final JTextField manufacturerField = new JTextField();
        final JTextField serialNumberTip = new JTextField("Numero di serie*");
        final JTextField serialNumberField = new JTextField();
        final JTextField productionDateTip = new JTextField("Data di produzione* (YYYY-MM-DD)");
        final JTextField productionDateField = new JTextField();
        final List<JTextField> textFields = List.of(licensePlateTip, licensePlateField, manufacturerTip,
                manufacturerField, serialNumberTip, serialNumberField, productionDateTip, productionDateField);
        loadFieldProperties(textFields);
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(
                new java.awt.GridLayout(textFields.size() / 2, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        textFields.forEach(centerPanel::add);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Registrazione ROV", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            boolean result = false;
            try {
                final Date date = new SimpleDateFormat("yyyy-MM-dd").parse(productionDateField.getText());
                result = this.controller.registerROV(
                        licensePlateField.getText(),
                        manufacturerField.getText(),
                        serialNumberField.getText(),
                        date);
            } catch (final ParseException e1) {
                Logger.getLogger(InputManagerImpl.class.getName()).log(Level.SEVERE, "Error parsing date", e1);
                result = false;
            }
            frame.dispose();
            showResultPopup(result);
        });
    }

    /**
     * {@inhertidoc}
     */
    @Override
    public void expeditionRegistration() {
        final JTextField codeTip = new JTextField("Codice*");
        final JTextField codeField = new JTextField();
        final JTextField dateTip = new JTextField("Data* (YYYY-MM-DD)");
        final JTextField dateField = new JTextField();
        final JTextField locationTip = new JTextField("Luogo*");
        final JTextField locationField = new JTextField();
        final JTextField rovTip = new JTextField("Targa del ROV*");
        final JTextField rovField = new JTextField();
        final JTextField associationTip = new JTextField("Associazione*");
        final JTextField associationField = new JTextField();
        final JTextField groupTip = new JTextField("ID gruppo*");
        final JTextField groupField = new JTextField();
        final List<JTextField> textFields = List.of(codeTip, codeField, dateTip, dateField, locationTip, locationField,
                rovTip, rovField, associationTip, associationField, groupTip, groupField);
        loadFieldProperties(textFields);
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(
                new java.awt.GridLayout(textFields.size() / 2, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        textFields.forEach(centerPanel::add);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Registrazione spedizione", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            boolean result = false;
            try {
                final Date tmpDate = new SimpleDateFormat("yyyy-MM-dd").parse(dateField.getText());
                result = this.controller.registerExpedition(
                        codeField.getText(),
                        tmpDate,
                        locationField.getText(),
                        rovField.getText(),
                        associationField.getText(),
                        groupField.getText());
            } catch (final ParseException e1) {
                Logger.getLogger(InputManagerImpl.class.getName()).log(Level.SEVERE, "Error parsing date", e1);
                result = false;
            }
            frame.dispose();
            showResultPopup(result);
        });
    }

    /**
     * {@inhertidoc}
     */
    @Override
    public void sightingRegistration() {
        final JTextField codeTip = new JTextField("Codice*");
        final JTextField codeField = new JTextField();
        final JTextField expeditionTip = new JTextField("Codice spedizione*");
        final JTextField expeditionField = new JTextField();
        final JTextField depthTip = new JTextField("Profondità");
        final JTextField depthField = new JTextField();
        final JTextField notesTip = new JTextField("Note");
        final JTextField notesField = new JTextField();
        final JTextField organismTip = new JTextField("ID organismo");
        final JTextField organismField = new JTextField();
        final JTextField wreckTip = new JTextField("ID relitto");
        final JTextField wreckField = new JTextField();
        final JTextField geoTip = new JTextField("ID formazione geologica");
        final JTextField geoField = new JTextField();
        final List<JTextField> textFields = List.of(codeTip, codeField, expeditionTip, expeditionField, depthTip,
                depthField, notesTip, notesField, organismTip, organismField, wreckTip,
                wreckField, geoTip, geoField);
        loadFieldProperties(textFields);
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(
                new java.awt.GridLayout(textFields.size() / 2, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        textFields.forEach(centerPanel::add);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Registrazione avvistamento", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final Integer depth = depthField.getText().length() != 0 ? Integer.valueOf(depthField.getText()) : null;
            final String notes = notesField.getText().length() != 0 ? notesField.getText() : null;
            final String organismID = organismField.getText().length() != 0 ? organismField.getText() : null;
            final String wreckID = wreckField.getText().length() != 0 ? wreckField.getText() : null;
            final String geologicalFormationID = geoField.getText().length() != 0 ? geoField.getText() : null;
            final boolean result = this.controller.registerSighting(
                    codeField.getText(),
                    expeditionField.getText(),
                    depth,
                    notes,
                    organismID,
                    wreckID,
                    geologicalFormationID);
            frame.dispose();
            showResultPopup(result);
        });
    }

    /**
     * {@inhertidoc}
     */
    @Override
    public void extractionRegistration() {
        final JTextField codeTip = new JTextField("Codice*");
        final JTextField codeField = new JTextField();
        final JTextField expeditionTip = new JTextField("Codice spedizione*");
        final JTextField expeditionField = new JTextField();
        final JTextField materialTip = new JTextField("Materiale*");
        final JTextField materialField = new JTextField();
        final JTextField depthTip = new JTextField("Profondità");
        final JTextField depthField = new JTextField();
        final JTextField amountTip = new JTextField("Quantità*");
        final JTextField amountField = new JTextField();
        final JTextField notesTip = new JTextField("Note");
        final JTextField notesField = new JTextField();
        final List<JTextField> textFields = List.of(codeTip, codeField, expeditionTip, expeditionField, materialTip,
                materialField, depthTip, depthField, amountTip, amountField, notesTip, notesField);
        loadFieldProperties(textFields);
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(
                new java.awt.GridLayout(textFields.size() / 2, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        List.of(codeTip, codeField,
                expeditionTip, expeditionField,
                materialTip, materialField,
                amountTip, amountField,
                depthTip, depthField,
                notesTip, notesField)
                .forEach(centerPanel::add);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Registrazione prelievo", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final int depth = depthField.getText().length() != 0 ? Integer.valueOf(depthField.getText()) : null;
            final String notes = notesField.getText().length() != 0 ? notesField.getText() : null;
            final boolean result = this.controller.registerExtraction(
                    codeField.getText(),
                    expeditionField.getText(),
                    materialField.getText(),
                    depth,
                    Float.valueOf(amountField.getText()),
                    notes);
            frame.dispose();
            showResultPopup(result);
        });
    }

    /**
     * {@inhertidoc}
     */
    @Override
    public void speciesUpdate() {
        final JTextField idTip = new JTextField("ID*");
        final JTextField idField = new JTextField();
        final JTextField speciesTip = new JTextField("Nuova pecie*");
        final JTextField speciesField = new JTextField();
        final List<JTextField> textFields = List.of(idTip, idField, speciesTip, speciesField);
        loadFieldProperties(textFields);
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(
                new java.awt.GridLayout(textFields.size() / 2, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        textFields.forEach(centerPanel::add);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Aggiornamento specie", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final boolean result = this.controller.updateSpecies(
                    idField.getText(),
                    speciesField.getText());
            frame.dispose();
            showResultPopup(result);
        });
    }

    /**
     * {@inhertidoc}
     */
    @Override
    public void sightingsFilter() {
        final JTextField locationTip = new JTextField("Luogo");
        final JTextField locationField = new JTextField();
        final JTextField minDepthTip = new JTextField("Profondità minima");
        final JTextField minDepthField = new JTextField();
        final JTextField maxDepthTip = new JTextField("Profondità massima");
        final JTextField maxDepthField = new JTextField();
        final JTextField expeditionTip = new JTextField("Codice spedizione");
        final JTextField expeditionField = new JTextField();
        final JTextField organismTip = new JTextField("ID organismo");
        final JTextField organismField = new JTextField();
        final JTextField wreckTip = new JTextField("ID relitto");
        final JTextField wreckField = new JTextField();
        final JTextField idTip = new JTextField("ID formazione geologica");
        final JTextField idField = new JTextField();
        final List<JTextField> textFields = List.of(locationTip, locationField, minDepthTip, minDepthField,
                maxDepthTip, maxDepthField, expeditionTip, expeditionField, organismTip, organismField, wreckTip,
                wreckField, idTip, idField);
        loadFieldProperties(textFields);
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(
                new java.awt.GridLayout(textFields.size() / 2, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        textFields.forEach(centerPanel::add);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Filtro avvistamenti", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final List<List<String>> result = this.controller.filterSightings(
                    locationField.getText().length() != 0 ? Optional.of(locationField.getText()) : Optional.empty(),
                    minDepthField.getText().length() != 0 ? Optional.of(Integer.valueOf(minDepthField.getText()))
                            : Optional.empty(),
                    maxDepthField.getText().length() != 0 ? Optional.of(Integer.valueOf(maxDepthField.getText()))
                            : Optional.empty(),
                    expeditionField.getText().length() != 0 ? Optional.of(expeditionField.getText()) : Optional.empty(),
                    organismField.getText().length() != 0 ? Optional.of(organismField.getText()) : Optional.empty(),
                    wreckField.getText().length() != 0 ? Optional.of(wreckField.getText()) : Optional.empty(),
                    idField.getText().length() != 0 ? Optional.of(idField.getText()) : Optional.empty());
            frame.dispose();
            this.outputManager.showSightings(result);
        });
    }

    /**
     * {@inhertidoc}
     */
    @Override
    public void extractionsFilter() {
        final JTextField locationTip = new JTextField("Luogo");
        final JTextField locationField = new JTextField();
        final JTextField minDepthTip = new JTextField("Profondità minima");
        final JTextField minDepthField = new JTextField();
        final JTextField maxDepthTip = new JTextField("Profondità massima");
        final JTextField maxDepthField = new JTextField();
        final JTextField expeditionTip = new JTextField("Codice spedizione");
        final JTextField expeditionField = new JTextField();
        final JTextField materialTip = new JTextField("Materiale");
        final JTextField materialField = new JTextField();
        final List<JTextField> textFields = List.of(locationTip, locationField, minDepthTip, minDepthField,
                maxDepthTip, maxDepthField, expeditionTip, expeditionField, materialTip, materialField);
        loadFieldProperties(textFields);
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(
                new java.awt.GridLayout(textFields.size() / 2, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        textFields.forEach(centerPanel::add);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Filtro prelievi", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final List<List<String>> result = this.controller.filterExtractions(
                    locationField.getText().length() != 0 ? Optional.of(locationField.getText()) : Optional.empty(),
                    minDepthField.getText().length() != 0 ? Optional.of(Integer.valueOf(minDepthField.getText()))
                            : Optional.empty(),
                    maxDepthField.getText().length() != 0 ? Optional.of(Integer.valueOf(maxDepthField.getText()))
                            : Optional.empty(),
                    expeditionField.getText().length() != 0 ? Optional.of(expeditionField.getText()) : Optional.empty(),
                    materialField.getText().length() != 0 ? Optional.of(materialField.getText()) : Optional.empty());
            frame.dispose();
            this.outputManager.showExtractions(result);
        });
    }

    /**
     * {@inhertidoc}
     */
    @Override
    public void expeditionsFilterByAssociation() {
        final JTextField associationTip = new JTextField("Associazione");
        final JTextField associationField = new JTextField();
        loadFieldProperties(List.of(associationTip, associationField));
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(1, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        centerPanel.add(associationTip);
        centerPanel.add(associationField);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Selezione associazione", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final List<List<Object>> result = this.controller.filterExpeditionsByAssociation(associationField.getText());
            frame.dispose();
            this.outputManager.showExpeditions(result);
        });
    }

    /**
     * {@inhertidoc}
     */
    @Override
    public void organismsFilterByExpedition() {
        final JTextField codeTip = new JTextField("Codice spedizione");
        final JTextField codeField = new JTextField();
        loadFieldProperties(List.of(codeTip, codeField));
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(1, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        centerPanel.add(codeTip);
        centerPanel.add(codeField);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Selezione codice spedizione", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final List<List<String>> result = this.controller.filterOrganismsByExpedition(codeField.getText());
            frame.dispose();
            this.outputManager.showOrganisms(result);
        });
    }

    /**
     * {@inhertidoc}
     */
    @Override
    public void geologicalFormationFilterByDangerLevel() {
        final JTextField dangerTip = new JTextField("Grado di pericolo (1-5)");
        final JTextField dangerField = new JTextField();
        loadFieldProperties(List.of(dangerTip, dangerField));
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(1, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        centerPanel.add(dangerTip);
        centerPanel.add(dangerField);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Selezione grado di pericolo", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            if (dangerField.getText().length() != 0) {
                final List<List<String>> result = this.controller
                        .filterGeologicalFormationsByDangerLevel(Integer.valueOf(dangerField.getText()));
                frame.dispose();
                this.outputManager.showGeologicalFormationsAndLocations(result);
            } else {
                frame.dispose();
                this.outputManager.showGeologicalFormationsAndLocations(Collections.emptyList());
            }
        });
    }

    /**
     * {@inhertidoc}
     */
    @Override
    public void wrecksFitlerByName() {
        final JTextField nameTip = new JTextField("Nome");
        final JTextField nameField = new JTextField();
        loadFieldProperties(List.of(nameTip, nameField));
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(1, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        centerPanel.add(nameTip);
        centerPanel.add(nameField);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Selezione nome relitto", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final List<List<String>> result = this.controller.filterLocationsByWreck(nameField.getText());
            frame.dispose();
            this.outputManager.showWrecksAndLocations(result);
        });
    }

    /**
     * {@inhertidoc}
     */
    @Override
    public void analysesFilterByMaterial() {
        final JTextField materialTip = new JTextField("Materiale");
        final JTextField materialField = new JTextField();
        loadFieldProperties(List.of(materialTip, materialField));
        final JPanel centerPanel = new JPanel();
        centerPanel.setLayout(new java.awt.GridLayout(1, 2, HORIZONTAL_CELL_SPACING, VERTICAL_CELL_SPACING));
        centerPanel.add(materialTip);
        centerPanel.add(materialField);
        final JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new java.awt.BorderLayout());
        mainPanel.add(centerPanel, java.awt.BorderLayout.CENTER);
        final JButton confirmButton = new JButton("Conferma");
        mainPanel.add(confirmButton, java.awt.BorderLayout.SOUTH);
        final JFrame frame = PopupUtilities.createFrame("Selezione materiale", mainPanel);
        frame.setVisible(true);
        confirmButton.addActionListener(e -> {
            final List<List<String>> result = this.controller.getAnalysesInfo(materialField.getText());
            frame.dispose();
            this.outputManager.showAnalysesAndLaboratories(result);
        });
    }

}
