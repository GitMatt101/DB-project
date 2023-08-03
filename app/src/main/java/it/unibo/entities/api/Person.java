package it.unibo.entities.api;

/**
 * This interface models a person with a first name, last name and fiscal code.
 */
public interface Person {

    /**
     * Retrieves the first name of the person.
     * 
     * @return the first name
     */
    String getFirstName();

    /**
     * Retrieves the last name of the person.
     * 
     * @return the last name
     */
    String getLastName();

    /**
     * Retrieves the fiscal code of the person.
     * 
     * @return the fiscal code
     */
    String getFiscalCode();

}
