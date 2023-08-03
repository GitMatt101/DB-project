package it.unibo.entities;

import java.util.Objects;

/**
 * This class a generic material obtained during an {@link Expedition}.
 */
public class Material {

    private final String name;

    /**
     * Creates an instance of {@code Material} without any specific notes to add.
     * 
     * @param name     the name of the material.
     */
    public Material(final String name) {
        this.name = name;
    }

    /**
     * Retrieves the name of the {@code Material}.
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
        return "Material: " + this.name;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Material && this.name.equals(((Material) other).getName());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.name);
    }

}
