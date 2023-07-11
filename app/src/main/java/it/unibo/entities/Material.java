package it.unibo.entities;

import java.util.Objects;
import java.util.Optional;

import it.unibo.common.Constants;

/**
 * This class a generic material obtained during an {@link Expedition}.
 */
public class Material {

    private final String name;
    private final float quantity;
    private final Optional<String> notes;

    /**
     * Creates an instance of {@code Material} without any specific notes to add.
     * 
     * @param name     the name of the material.
     * @param quantity the mass of the material in kg.
     */
    public Material(final String name, final float quantity) {
        this.name = name;
        this.quantity = quantity;
        this.notes = Optional.empty();
    }

    /**
     * Creates an instance of {@code Material} with some notes.
     * 
     * @param name     the name of the material
     * @param quantity the mass of the material in kg
     * @param notes    the notes
     */
    public Material(final String name, final float quantity, final String notes) {
        this.name = name;
        this.quantity = quantity;
        this.notes = Optional.of(notes);
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
     * Retrieves the quantity of the {@code Material}.
     * 
     * @return the mass
     */
    public float getQuantity() {
        return this.quantity;
    }

    /**
     * Retrieves the notes.
     * 
     * @return {@code Optional.empty()} if there are no notes, {@code String} of
     *         notes otherwise
     */
    public Optional<String> getNotes() {
        return this.notes;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        final StringBuilder description = new StringBuilder("Material: ").append(this.name)
                .append("\nQuantity: ").append(this.quantity).append("kg");
        this.notes.ifPresent(notes -> {
            description.append(Constants.SEPARATOR)
                    .append(this.notes.get())
                    .append(Constants.SEPARATOR);
        });
        return description.toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Material
                && this.name.equals(((Material) other).getName())
                && Math.abs(this.quantity - ((Material) other).getQuantity()) < Math.ulp(this.quantity)
                && this.notes.equals(((Material) other).getNotes());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.name, this.quantity, this.notes);
    }

}
