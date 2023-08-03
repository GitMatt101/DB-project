package it.unibo.model.entities;

import java.util.Objects;

/**
 * This class models a country.
 */
public class Country {

    private final String name;

    /**
     * Creates an instance of {@code Country}.
     * 
     * @param name the name
     */
    public Country(final String name) {
        this.name = name;
    }

    /**
     * Retrieves the name of the country.
     * 
     * @return the name
     */
    public String getName() {
        return this.name;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return this.name;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Country
                && this.name.equals(((Country) other).getName());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.name);
    }

}
