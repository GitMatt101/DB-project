package it.unibo.entities;

import java.util.Objects;

import it.unibo.common.Address;

/**
 * This class models a manufactorer of {@link ROV}.
 */
public class Manufacturer {

    private final String name;
    private final Address address;

    /**
     * Creates an instance of {@code Manufacturer}.
     * 
     * @param name    name of the manufacturer
     * @param address the address of the manufacturer
     */
    public Manufacturer(final String name, final Address address) {
        this.name = name;
        this.address = address;
    }

    /**
     * Retrieves the name of the {@code Manufacturer}.
     * 
     * @return the manufacturer's name
     */
    public String getName() {
        return this.name;
    }

    /**
     * Retrieves the {@link Address} of the {@code Manufacturer}.
     * 
     * @return the manufacturer's address
     */
    public Address getAddress() {
        return this.address;
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
        return other instanceof Manufacturer
                && this.name.equals(((Manufacturer) other).getName())
                && this.address.equals(((Manufacturer) other).getAddress());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.name, this.address);
    }

}
