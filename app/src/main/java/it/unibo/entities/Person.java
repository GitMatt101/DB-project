package it.unibo.entities;

import java.util.Objects;
import java.util.Optional;

import it.unibo.common.Address;
import it.unibo.common.Constants;

/**
 * This class models a person identified by the fiscal code.
 * A person can be either an operator or a maintainer but not both.
 */
public class Person {

    private final String firstName;
    private final String lastName;
    private final String fiscalCode;
    private final Address address;
    private final Optional<String> maintainerID;
    private final Optional<String> operatorID;

    /**
     * Creates a new instance of {@code Person}.
     * 
     * @param firstName    the first name of the person
     * @param lastName     the last name of the person
     * @param fiscalCode   the fiscal code of the person
     * @param address      the address of the person
     * @param maintainerID the ID of the maintainer, if the person is a maintainer
     * @param operatorID   the ID of the operator, if the person is an operator
     */
    public Person(final String firstName, final String lastName, final String fiscalCode, final Address address,
            final Optional<String> maintainerID, final Optional<String> operatorID) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.fiscalCode = fiscalCode;
        this.address = address;
        this.maintainerID = maintainerID;
        this.operatorID = operatorID;
    }

    /**
     * Retrieves the first name of the person.
     * 
     * @return the first name
     */
    public String getFirstName() {
        return firstName;
    }

    /**
     * Retrieves the last name of the person.
     * 
     * @return the last name
     */
    public String getLastName() {
        return lastName;
    }

    /**
     * Retrieves the {@link Address} of the person.
     * 
     * @return the address
     */
    public Address getAddress() {
        return address;
    }

    /**
     * Retrieves the maintainer ID.
     * 
     * @return {@code Optional.empty()} if the person is an operator,
     *         {@code Optional.of(maintainerID)} otherwise
     */
    public Optional<String> getMaintainerID() {
        return maintainerID;
    }

    /**
     * Retrieves the operator ID.
     * 
     * @return {@code Optional.empty()} if the person is a maintainer,
     *         {@code Optional.of(operatorID)} otherwise
     */
    public Optional<String> getOperatorID() {
        return operatorID;
    }

    /**
     * Retrieves the fiscal code of the person.
     * 
     * @return the fiscal code
     */
    public String getFiscalCode() {
        return fiscalCode;
    }

    /**
     * Retrieves the ID of the person.
     * 
     * @return the ID
     */
    public String getID() {
        return maintainerID.isPresent() ? maintainerID.get() : operatorID.get();
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
                .append("\nAddress: ").append(address);
        maintainerID.ifPresent(id -> description.append("\nMaintainer ID: ").append(id));
        operatorID.ifPresent(id -> description.append("\nOperator ID: ").append(id));
        return description.toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Person
                && this.firstName.equals(((Person) other).getFirstName())
                && this.lastName.equals(((Person) other).getLastName())
                && this.fiscalCode.equals(((Person) other).getFiscalCode())
                && this.address.equals(((Person) other).getAddress())
                && this.maintainerID.equals(((Person) other).getMaintainerID())
                && this.operatorID.equals(((Person) other).getOperatorID());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(firstName, lastName, fiscalCode, address, maintainerID, operatorID);
    }

}
