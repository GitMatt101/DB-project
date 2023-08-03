package it.unibo.entities;

import java.util.Date;
import java.util.Objects;
import java.util.Optional;

import it.unibo.common.Constants;

/**
 * This class models a ship/plane wreck, identified by a unique ID.
 */
public class Wreck {

    private final String id;
    private final Optional<String> name;
    private final Optional<Date> wreckageDate;
    private final int length;
    private final String description;

    /**
     * Creates an instance of {@code Wreck}.
     * 
     * @param id           the id of the wreck
     * @param name         the name of the wreck
     * @param wreckageDate the date of the wreckage
     * @param length       the length of the wreck
     * @param description  the description of the wreck
     */
    public Wreck(final String id, final Optional<String> name, final Optional<Date> wreckageDate, final int length,
            final String description) {
        this.id = id;
        this.name = name;
        this.wreckageDate = wreckageDate;
        this.length = length;
        this.description = description;
    }

    /**
     * Retrieves the id of the wreck.
     * 
     * @return the id
     */
    public String getId() {
        return this.id;
    }

    /**
     * Retrieves the name of the wreck.
     * 
     * @return the name
     */
    public Optional<String> getName() {
        return this.name;
    }

    /**
     * Retrieves the date of the wreckage.
     * 
     * @return the date
     */
    public Optional<Date> getWreckageDate() {
        return this.wreckageDate;
    }

    /**
     * Retrieves the length of the wreck.
     * 
     * @return the length
     */
    public int getLength() {
        return this.length;
    }

    /**
     * Retrieves the description of the wreck.
     * 
     * @return the description
     */
    public String getDescription() {
        return this.description;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        final StringBuilder description = new StringBuilder(Constants.STRINGBUILDER_INITIAL_SIZE)
                .append("ID: ").append(this.id)
                .append("\nModel: ");
        this.name.ifPresentOrElse(description::append, () -> description.append("unknown"));
        description.append("\nWreckage date: ");
        this.wreckageDate.ifPresentOrElse(description::append, () -> description.append("unknown"));
        description.append("\nLength: ").append(this.length).append(" m")
                .append(Constants.SEPARATOR)
                .append("Description: ").append(this.description)
                .append(Constants.SEPARATOR);
        return description.toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Wreck
                && this.id.equals(((Wreck) other).getId())
                && this.name.equals(((Wreck) other).getName())
                && this.wreckageDate.equals(((Wreck) other).getWreckageDate())
                && this.length == ((Wreck) other).getLength()
                && this.description.equals(((Wreck) other).getDescription());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.id, this.name, this.wreckageDate, this.length, this.description);
    }

}
