package it.unibo.entities;

import java.util.Objects;

import it.unibo.common.Constants;

/**
 * This interface models an event that may happen during an expedition.
 * The event is identified by a unique code or its number in the expedition.
 */
public class Event {

    private final String code;
    private final Expedition expedition;
    private final int number;

    /**
     * Creates an instance of {@code Event}.
     * 
     * @param code       the identifier of the extraction
     * @param expedition the {@link Expedition} the extraction belongs to
     * @param number     the number of the extraction
     */
    public Event(final String code, final Expedition expedition, final int number) {
        this.code = code;
        this.expedition = expedition;
        this.number = number;
    }

    /**
     * Retrieves the code of the event.
     * 
     * @return the code
     */
    public String getCode() {
        return code;
    }

    /**
     * Retrieves the {@link Expedition}.
     * 
     * @return the expedition
     */
    public Expedition getExpedition() {
        return expedition;
    }

    /**
     * Retrieves the number of the event in the expedition.
     * 
     * @return the number
     */
    public int getNumber() {
        return number;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return new StringBuilder("Sighting code: ").append(this.code)
                .append(Constants.SEPARATOR)
                .append("Expedition:\n").append(this.expedition)
                .append(Constants.SEPARATOR)
                .append("Sighting number: ").append(this.number)
                .toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Event
                && this.code.equals(((Event) other).getCode())
                && this.expedition.equals(((Event) other).getExpedition())
                && this.number == ((Event) other).getNumber();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.code, this.expedition, this.number);
    }

}
