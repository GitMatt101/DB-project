package it.unibo.view.popups.api;

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
     * Displays a popup that allows the user to filter geological formations by
     * danger level.
     */
    void geologicalFormationFilterByDangerLevel();

    /**
     * Displays a popup that allows the user to filter wrecks by name.
     */
    void wrecksFitlerByName();

    /**
     * Displays a popup that allows the user to filter analyses by the name of
     * material analyzed.
     */
    void analysesFilterByMaterial();

}
