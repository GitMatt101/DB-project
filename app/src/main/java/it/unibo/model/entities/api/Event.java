package it.unibo.model.entities.api;

import java.util.Optional;

/**
 * This interface models an event that may happen during an expedition.
 */
public interface Event {

    /**
     * Retrieves the code of the event.
     * 
     * @return the code
     */
    String getCode();

    /**
     * Retrieves the number of the event.
     * 
     * @return the number
     */
    int getNumber();

    /**
     * Retrieves the code of the expedition in which the event happened.
     * 
     * @return the expedition's code
     */
    String getExpeditionCode();

    /**
     * Retrieves the depth at which the event occured.
     * 
     * @return the depth
     */
    Optional<Integer> getDepth();

    /**
     * Retrieves the notes about the event.
     * 
     * @return the notes
     */
    Optional<String> getNotes();

}
