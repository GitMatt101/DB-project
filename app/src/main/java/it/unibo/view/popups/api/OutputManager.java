package it.unibo.view.popups.api;

import java.util.List;

/**
 * This interface models a class that mnages all the methods in charge of
 * displaying the results of the queries.
 */
public interface OutputManager {

    /**
     * Displays a popup that shows a list of sightings.
     * 
     * @param sightings a list of sigthings, each element represented by a list of
     *                  its attributes
     */
    void showSightings(List<List<String>> sightings);

    /**
     * Displays a popup that shows a list of extractions.
     * 
     * @param extractions a list of extractions, each element represented by a list
     *                    of its attributes
     */
    void showExtractions(List<List<String>> extractions);

    /**
     * Displays a popup that shows a list of expeditions.
     * 
     * @param expeditions a list of expeditions, each element represented by a list
     *                    of its attributes, plus the members of the group that
     *                    participated
     */
    void showExpeditions(List<List<Object>> expeditions);

    /**
     * Displays a popup that shows a list of orgamnisms.
     * 
     * @param organisms a list of organisms, each element represented by a list of
     *                  its attributes.
     */
    void showOrganisms(List<List<String>> organisms);

    /**
     * Displays a popup that shows a list of wrecks.
     * 
     * @param wrecks a list of wrecks, each element represented by a list of its
     *               attributes.
     */
    void showWrecks(List<List<String>> wrecks);

    /**
     * Displays a popup that shows a list of geological formations.
     * 
     * @param geologicalFormations a list of geological formations, each element
     *                             represented by a list of its attributes.
     */
    void showGeologicalFormations(List<List<String>> geologicalFormations);

    /**
     * Displays a popup that shows a list of associations.
     * 
     * @param associations a list of associations, each element represented by a
     *                     list of its attributes.
     */
    void showAssociations(List<List<String>> associations);

    /**
     * Displays a popup that shows a list of geological formations and the locations
     * they are situated in.
     * 
     * @param values a list of geological formations and locations, each element
     *               represented by a list of its attributes.
     */
    void showGeologicalFormationsAndLocations(List<List<String>> values);

    /**
     * Displays a popup that shows a list of wrecks' IDs and the
     * locations they have sunk in.
     * 
     * @param values a list of wrecks' IDs and locations.
     */
    void showWrecksAndLocations(List<List<String>> values);

    /**
     * Displays a popup that shows a list of analyses and the laboratories that
     * performed them.
     * 
     * @param values a list of analyses and laboratories, each element represented
     *               by a list of their attributes
     */
    void showAnalysesAndLaboratories(List<List<String>> values);

}
