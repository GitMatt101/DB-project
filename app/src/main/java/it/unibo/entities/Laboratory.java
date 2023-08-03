package it.unibo.entities;

import java.util.Objects;

/**
 * This class models an laboratory identified by a unique ID.
 */
public class Laboratory {

    private final String name;
    private final String id;
    private final String address;

    /**
     * Creates an instance of {@code Laboratory}.
     * 
     * @param name    the name of the laboratory
     * @param id      the ID of the laboratory
     * @param address the address of the laboratory
     */
    public Laboratory(final String name, final String id, final String address) {
        this.name = name;
        this.id = id;
        this.address = address;
    }

    /**
     * Retrieves the name of the laboratory.
     * 
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Retrieves the id of the laboratory.
     * 
     * @return the ID
     */
    public String getID() {
        return id;
    }

    /**
     * Retrieves the {@link Address} of the laboratory.
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
                .append("\nid: ").append(this.id)
                .append("\nAddress: ").append(this.address)
                .toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Laboratory
                && this.name.equals(((Laboratory) other).getName())
                && this.id.equals(((Laboratory) other).getID())
                && this.address.equals(((Laboratory) other).getAddress());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.name, this.id, this.address);
    }

}
