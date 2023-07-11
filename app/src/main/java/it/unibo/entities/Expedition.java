package it.unibo.entities;

import java.util.Date;
import java.util.Objects;

/**
 * This class models a simple expedition identified by a unique code.
 */
public class Expedition {

    private final String code;
    private final Date date;

    /**
     * Creates an instance of {@code Expedition}.
     * 
     * @param code the identifier of the expedition
     * @param date the date of the expedition
     */
    public Expedition(final String code, final Date date) {
        this.code = code;
        this.date = new Date(date.getTime());
    }

    /**
     * Retrieves the code of the expedition.
     * 
     * @return the code
     */
    public String getCode() {
        return this.code;
    }

    /**
     * Retrieves the date of the expedition.
     * 
     * @return the date
     */
    public Date getDate() {
        return new Date(this.date.getTime());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return new StringBuilder("Expedition code: ").append(this.code)
                .append("\nDate: ").append(this.date)
                .toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Expedition
                && this.code.equals(((Expedition) other).getCode())
                && this.date.equals(((Expedition) other).getDate());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.code, this.date);
    }

}
