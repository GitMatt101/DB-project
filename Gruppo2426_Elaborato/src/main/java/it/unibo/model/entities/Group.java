package it.unibo.model.entities;

import java.util.Objects;

import it.unibo.common.Constants;
import it.unibo.common.Pair;

/**
 * This class models a group of operators, identified by a unique ID in the
 * association it is part of.
 */
public class Group {

    private final Pair<String, String> associationID;
    private final String name;

    /**
     * Creates an instance of {@code Group}.
     * 
     * @param associationName the name of the association that the group is part of
     * @param id              the ID of the group
     * @param name            the name of the group
     */
    public Group(final String associationName, final String id, final String name) {
        this.associationID = new Pair<>(associationName, id);
        this.name = name;
    }

    /**
     * Retrieves the association the group is part of.
     * 
     * @return the association
     */
    public String getAssociationName() {
        return this.associationID.getX();
    }

    /**
     * Retrieves the ID of the group.
     * 
     * @return the ID
     */
    public String getID() {
        return this.associationID.getY();
    }

    /**
     * Retrieves the name of the group.
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
        return new StringBuilder(Constants.STRINGBUILDER_INITIAL_SIZE)
                .append("Association: ").append(this.associationID.getX())
                .append("\nID: ").append(this.associationID.getY())
                .append("\nName: ").append(this.name)
                .toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Group
                && this.associationID.getX().equals(((Group) other).getAssociationName())
                && this.associationID.getY().equals(((Group) other).getID())
                && this.name.equals(((Group) other).getName());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.associationID, this.name);
    }

}
