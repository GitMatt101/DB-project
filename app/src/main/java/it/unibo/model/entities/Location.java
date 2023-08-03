package it.unibo.model.entities;

import java.util.Objects;
import java.util.Optional;

/**
 * Simple class for the management of the seas and oceans where a {@link ROV} is
 * dispatched for an {@link Expedition}.
 */
public class Location {

    private final String name;
    private final Optional<String> countryName;

    /**
     * Creates an instance of {@code Location}.
     * 
     * @param name        the name
     * @param countryName the name of the country it belongs to
     */
    public Location(final String name, final Optional<String> countryName) {
        this.name = name;
        this.countryName = countryName;
    }

    /**
     * Retrieves the name of the location.
     * 
     * @return the name
     */
    public String getName() {
        return this.name;
    }

    /**
     * Retrieves the name of the country where the location is.
     * 
     * @return the country's name
     */
    public Optional<String> getCountryName() {
        return this.countryName;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Location
                && this.name.equals(((Location) other).getName())
                && this.countryName.equals(((Location) other).getCountryName());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.name, this.countryName);
    }

}
