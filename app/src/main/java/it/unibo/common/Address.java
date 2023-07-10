package it.unibo.common;

import java.util.Objects;

/**
 * This class models a basic address.
 */
public class Address {

    private final String city;
    private final String street;
    private final int houseNumber;

    /**
     * Creates an instance of {@code Address}.
     * 
     * @param city        name of the city
     * @param street      name of the street
     * @param houseNumber the house number
     */
    public Address(final String city, final String street, final int houseNumber) {
        this.city = city;
        this.street = city;
        this.houseNumber = houseNumber;
    }

    /**
     * Retrieves the city specified in the address.
     * 
     * @return the name of the city
     */
    public String getCity() {
        return this.city;
    }

    /**
     * Retrieves the street specified in the address.
     * 
     * @return the name of the street
     */
    public String getStreet() {
        return this.street;
    }

    /**
     * Retrieves the house number specified in the address.
     * 
     * @return the house number
     */
    public int getHouseNumber() {
        return this.houseNumber;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return new StringBuilder(this.city)
                .append(", ").append(this.street)
                .append(", ").append(this.houseNumber)
                .toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Address
                && this.city.equals(((Address) other).getCity())
                && this.street.equals(((Address) other).getStreet())
                && this.houseNumber == ((Address) other).getHouseNumber();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.city, this.street, this.houseNumber);
    }

}
