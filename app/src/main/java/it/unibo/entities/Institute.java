package it.unibo.entities;

import java.util.Objects;

import it.unibo.common.Address;

/**
 * This class models an institute identified by a unique ID.
 */
public class Institute {

    private final String name;
    private final String id;
    private final Address address;

    /**
     * Creates an instance of {@code Institute}.
     * 
     * @param name    the name of the institute
     * @param id      the ID of the institute
     * @param address the {@link Address} of the institute
     */
    public Institute(final String name, final String id, final Address address) {
        this.name = name;
        this.id = id;
        this.address = address;
    }

    /**
     * Retrieves the name of the institute.
     * 
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Retrieves the id of the institute.
     * 
     * @return the ID
     */
    public String getID() {
        return id;
    }

    /**
     * Retrieves the {@link Address} of the institute.
     * 
     * @return the address
     */
    public Address getAddress() {
        return address;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return new StringBuilder("Name: ").append(this.name)
                .append("\nid: ").append(this.id)
                .append("\nAddress: ").append(this.address)
                .toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Institute
                && this.name.equals(((Institute) other).getName())
                && this.id.equals(((Institute) other).getID())
                && this.address.equals(((Institute) other).getAddress());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.name, this.id, this.address);
    }

}
