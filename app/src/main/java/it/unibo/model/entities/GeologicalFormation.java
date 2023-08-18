package it.unibo.model.entities;

import java.util.Objects;

import it.unibo.common.Constants;

/**
 * This class models a geological formation, identified by a unique id.
 */
public class GeologicalFormation {

    private final String id;
    private final String type;
    private final int size;
    private final int dangerLevel;
    private final String description;

    /**
     * Creates an instance of {@code GeologicalFormation}.
     * 
     * @param id          the id
     * @param size        the size
     * @param type        the type
     * @param dangerLevel the danger level
     * @param description the description
     */
    public GeologicalFormation(final String id, final String type, final int size, final int dangerLevel,
            final String description) {
        this.id = id;
        this.type = type;
        this.size = size;
        this.dangerLevel = dangerLevel;
        this.description = description;
    }

    /**
     * Retrieves the id of the geological formation.
     * 
     * @return the id
     */
    public String getID() {
        return this.id;
    }

    /**
     * Retrieves the type of the geological formation.
     * 
     * @return the type
     */
    public String getType() {
        return this.type;
    }

    /**
     * Retrieves the size of the geological formation.
     * 
     * @return the size
     */
    public int getSize() {
        return this.size;
    }

    /**
     * Retrieves the danger level of the geological formation.
     * 
     * @return the danger level
     */
    public int getDangerLevel() {
        return this.dangerLevel;
    }

    /**
     * Retrieves the description of the geological formation.
     * 
     * @return the description
     */
    public String getDescription() {
        return this.description;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return new StringBuilder(Constants.STRINGBUILDER_INITIAL_SIZE)
                .append("ID: ").append(this.id)
                .append("\nType: ").append(this.type)
                .append("\nSize: ").append(this.size).append(" m2")
                .append("\nDanger level: ").append(this.dangerLevel).append("\\5")
                .append(Constants.SEPARATOR)
                .append("\nDescription: ").append(this.description)
                .append(Constants.SEPARATOR)
                .toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof GeologicalFormation
                && this.id.equals(((GeologicalFormation) other).getID())
                && this.type.equals(((GeologicalFormation) other).getType())
                && this.size == ((GeologicalFormation) other).getSize()
                && this.dangerLevel == ((GeologicalFormation) other).getDangerLevel()
                && this.description.equals(((GeologicalFormation) other).getDescription());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.id, this.type, this.size, this.dangerLevel, this.description);
    }

}
