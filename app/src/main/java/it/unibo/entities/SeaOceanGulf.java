package it.unibo.entities;

import java.util.Objects;

/**
 * Simple class for the management of the seas and oceans where a {@link ROV} is
 * dispatched for an {@link Expedition}.
 */
public class SeaOceanGulf {

    private final String name;

    /**
     * Creates an instance of a {@code Sea}, {@code Ocean} or {@code Gulf}.
     * 
     * @param name the name
     */
    public SeaOceanGulf(final String name) {
        this.name = name;
    }

    /**
     * Retrieves the name of the {@code Sea}, {@code Ocean} or {@code Gulf}.
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
    public boolean equals(final Object other) {
        return other instanceof SeaOceanGulf && this.name.equals(((SeaOceanGulf) other).getName());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.name);
    }

}
