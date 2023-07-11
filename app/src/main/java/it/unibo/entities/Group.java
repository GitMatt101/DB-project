package it.unibo.entities;

import java.util.Objects;

import it.unibo.common.Constants;

/**
 * This class models a group of operators, identified by a unique ID in the
 * {@link Company} it is part of.
 */
public class Group {

    private final Company company;
    private final String id;
    private final String name;

    /**
     * Creates an instance of {@code Group}.
     * 
     * @param company the {@link Company} the group is part of
     * @param id      the ID of the group
     * @param name    the name of the group
     */
    public Group(final Company company, final String id, final String name) {
        this.company = company;
        this.id = id;
        this.name = name;
    }

    /**
     * Retrieves the {@link Company} the group is part of.
     * 
     * @return the company
     */
    public Company getCompany() {
        return company;
    }

    /**
     * Retrieves the ID of the group.
     * 
     * @return the ID
     */
    public String getID() {
        return id;
    }

    /**
     * Retrieves the name of the group.
     * 
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return new StringBuilder("Group ID: ").append(this.id)
                .append("\nName: ").append(this.name)
                .append(Constants.SEPARATOR)
                .append("Company:\n").append(this.company)
                .append(Constants.SEPARATOR)
                .toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Group
                && this.id.equals(((Group) other).getID())
                && this.name.equals(((Group) other).getName())
                && this.company.equals(((Group) other).getCompany());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.id, this.name, this.company);
    }

}
