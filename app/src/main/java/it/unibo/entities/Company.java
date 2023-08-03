package it.unibo.entities;

import java.util.Objects;

/**
 * This class models a company identified by a unique name.
 */
public class Company {

    private final String name;
    private final String address;

    /**
     * Creates an instance of {@code Company}.
     * 
     * @param name    the name of the company
     * @param address the address of the company
     */
    public Company(final String name, final String address) {
        this.name = name;
        this.address = address;
    }

    /**
     * Retrieves the name of the company.
     * 
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Retrieves the {@link Address} of the company.
     * 
     * @return the address
     */
    public String getAddress() {
        return address;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return new StringBuilder("Name: ").append(this.name)
                .append("\nAddress: ").append(this.address)
                .toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Company
                && this.name.equals(((Company) other).getName())
                && this.address.equals(((Company) other).getAddress());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.name, this.address);
    }

}
