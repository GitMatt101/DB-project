package it.unibo.model.entities.impl;

import java.util.Objects;
import it.unibo.common.Constants;
import it.unibo.model.entities.ROV;
import it.unibo.model.entities.api.Person;

/**
 * This class models a {@link ROV} member's.
 */
public class Member implements Person {

    private final String firstName;
    private final String lastName;
    private final String fiscalCode;
    private final String associationName;
    private final String groupID;
    private final String id;
    private final String role;

    /**
     * Creates an instance of {@code member's}.
     * 
     * @param firstName       the first name of the member
     * @param lastName        the last name of the member
     * @param fiscalCode      the fiscal code of the member
     * @param id              the ID of the member
     * @param groupID         groupID the member is part of
     * @param associationName the name of the association the member works for
     */
    public Member(final String firstName, final String lastName, final String fiscalCode,
            final String associationName, final String groupID, final String id, final String role) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.fiscalCode = fiscalCode;
        this.associationName = associationName;
        this.groupID = groupID;
        this.id = id;
        this.role = role;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String getFirstName() {
        return this.firstName;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String getLastName() {
        return this.lastName;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String getFiscalCode() {
        return this.fiscalCode;
    }

    /**
     * Retrieves the name of the association the member is part of.
     * 
     * @return the association's name
     */
    public String getAssociationName() {
        return this.associationName;
    }

    /**
     * Retrieves the ID of the group the member is part of.
     * 
     * @return the group'ID
     */
    public String getGroupID() {
        return this.groupID;
    }

    /**
     * Retrieves the member's ID.
     * 
     * @return the ID
     */
    public String getID() {
        return this.id;
    }

    /**
     * Retrieves the member's role.
     * 
     * @return the role
     */
    public String getRole() {
        return this.role;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        final StringBuilder description = new StringBuilder(Constants.STRINGBUILDER_INITIAL_SIZE);
        description.append("First name: ").append(firstName)
                .append("\nLast name: ").append(lastName)
                .append("\nFiscal code: ").append(fiscalCode)
                .append("\nAssociation: ").append(associationName)
                .append("\nGroup ID: ").append(groupID)
                .append("\nID: ").append(id)
                .append("\nRole: ").append(role);
        return description.toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Member
                && this.firstName.equals(((Member) other).getFirstName())
                && this.lastName.equals(((Member) other).getLastName())
                && this.fiscalCode.equals(((Member) other).getFiscalCode())
                && this.id.equals(((Member) other).getID())
                && this.groupID.equals(((Member) other).getGroupID())
                && this.associationName.equals(((Member) other).getAssociationName());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.firstName, this.lastName, this.fiscalCode, this.id, this.groupID,
                this.associationName);
    }

}
