package it.unibo.model.entities.api;

/**
 * This interface models a subject of a sighting, represented by a unique ID and
 * a description.
 */
public interface Subject {

    /**
     * Retrieves the ID of the subject.
     * 
     * @return the ID as a String
     */
    String getID();

    /**
     * Retrieves the description of the subject.
     * 
     * @return the description as a String
     */
    String getDescription();

}
