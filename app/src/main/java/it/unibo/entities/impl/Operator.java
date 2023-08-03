package it.unibo.entities.impl;

import java.util.Objects;
import it.unibo.common.Constants;
import it.unibo.entities.ROV;
import it.unibo.entities.api.Person;

/**
 * This class models a {@link ROV} operator.
 */
public class Operator implements Person {

    private final String firstName;
    private final String lastName;
    private final String fiscalCode;
    private final String id;
    private final String groupID;
    private final String associationName;

    /**
     * Creates an instance of {@code Operator}.
     * 
     * @param firstName       the first name of the operator
     * @param lastName        the last name of the operator
     * @param fiscalCode      the fiscal code of the operator
     * @param id              the ID of the operator
     * @param groupID         groupID the operator is part of
     * @param associationName the name of the association the operator is part of
     */
    public Operator(final String firstName, final String lastName, final String fiscalCode,
            final String associationName, final String groupID, final String id) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.fiscalCode = fiscalCode;
        this.associationName = associationName;
        this.groupID = groupID;
        this.id = id;
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
     * Retrieves the name of the association the operator is part of.
     * 
     * @return the association's name
     */
    public String getAssociationName() {
        return this.associationName;
    }

    /**
     * Retrieves the ID of the group the operator is part of.
     * 
     * @return the group'ID
     */
    public String getGroupID() {
        return this.groupID;
    }

    /**
     * Retrieves the operator ID.
     * 
     * @return the ID
     */
    public String getID() {
        return this.id;
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
                .append("\nID: ").append(id)
                .append("\nGroup ID: ").append(groupID)
                .append("\nAssociation: ").append(associationName);
        return description.toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Operator
                && this.firstName.equals(((Operator) other).getFirstName())
                && this.lastName.equals(((Operator) other).getLastName())
                && this.fiscalCode.equals(((Operator) other).getFiscalCode())
                && this.id.equals(((Operator) other).getID())
                && this.groupID.equals(((Operator) other).getGroupID())
                && this.associationName.equals(((Operator) other).getAssociationName());
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
