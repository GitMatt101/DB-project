package it.unibo.view.popups.api;

import it.unibo.controller.impl.ControllerImpl;

/**
 * This interface models a class that manages all the methods in charge of
 * taking the user's input and then sending it to the {@link ControllerImpl}.
 */
public interface InputManager {

    /**
     * Displays a popup that allows the user to register a new member.
     */
    void memberRegistration();

    /**
     * Displays a popup that allows the user to register a new ROV.
     */
    void rovRegistration();

    /**
     * Displays a popup that allows the user to register a new expedition.
     */
    void expeditionRegistration();

    /**
     * Displays a popup that allows the user to register a new sighting.
     */
    void sightingRegistration();

    /**
     * Displays a popup that allows the user to register a new extraction.
     */
    void extractionRegistration();

    /**
     * Displays a popup that allows the user to update the species of an organism.
     */
    void speciesUpdate();

    /**
     * Displays a popup that allows the user to register a new organism with a
     * temporary name.
     */
    void organismRegistration();

    /**
     * Displays a popup that allows the user to register a new wreck.
     */
    void wreckRegistration();

    /**
     * Displays a popup that allows the user to register a new geological formation.
     */
    void geologicalFormationRegistration();

    /**
     * Displays a popup that allows the user to filter sightings by inserting
     * certain parameters.
     */
    void sightingsFilter();

    /**
     * Displays a popup that allows the user to filter extractions by inserting
     * certain parameters.
     */
    void extractionsFilter();

    /**
     * Displays a popup that allows the user to filter expeditions by the
     * association that organized them.
     */
    void expeditionsFilterByAssociation();

    /**
     * Displays a popup that allows the user to filter organisms by the expedition
     * they were sighted in.
     */
    void organismsFilterByExpedition();

    /**
     * Displays a popup that allows the user to filter wrecks by name.
     */
    void wrecksFitlerByName();

    /**
     * Displays a popup that allows the user to filter analyses by the name of
     * material analyzed.
     */
    void analysesFilterByMaterial();

    /**
     * Displays a popup that allows the user to choose 2 years for scientific
     * progress range.
     */
    void yearChoice();

}
