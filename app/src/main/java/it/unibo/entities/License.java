package it.unibo.entities;

import java.util.Date;
import java.util.Objects;
import java.util.Optional;

import it.unibo.common.Constants;

/**
 * This class models a license that can be assigned to an operator or a
 * mainteiner.
 */
public class License {

    private final String id;
    private final Date releaseDate;
    private Date expirationDate;
    private Optional<Date> renewalDate;

    /**
     * Creates an instance of a {@code License} that has not been renewed yet.
     * 
     * @param id             the ID of the license
     * @param releaseDate    the release date of the license
     * @param expirationDate the expiration date of the license
     */
    public License(final String id, final Date releaseDate, final Date expirationDate) {
        this.id = id;
        this.releaseDate = new Date(releaseDate.getTime());
        this.expirationDate = new Date(expirationDate.getTime());
        this.renewalDate = Optional.empty();
    }

    /**
     * Creates an instance of a {@code License} that has already been renewed.
     * 
     * @param id             the ID of the license
     * @param releaseDate    the release date of the license
     * @param expirationDate the expiration date of the license
     * @param renewalDate    the renewal date of the license
     */
    public License(final String id, final Date releaseDate, final Date expirationDate, final Date renewalDate) {
        this(id, releaseDate, expirationDate);
        this.renewalDate = Optional.of(new Date(renewalDate.getTime()));
    }

    /**
     * Retrieves the ID of the license.
     * 
     * @return the ID
     */
    public String getID() {
        return id;
    }

    /**
     * Retrieves the release date of the license.
     * 
     * @return the release date
     */
    public Date getReleaseDate() {
        return new Date(releaseDate.getTime());
    }

    /**
     * Retrieves the expiration date of the license.
     * 
     * @return the expiration date
     */
    public Date getExpirationDate() {
        return new Date(expirationDate.getTime());
    }

    /**
     * Retrieves the renewal date of the license, if it has been renewed.
     * 
     * @return {@code Optional<Date>} containing the renewal date if the license was
     *         renewed, {@code Optional.empty()} otherwise
     */
    public Optional<Date> getRenewalDate() {
        return renewalDate;
    }

    /**
     * Sets the expiration date of the license.
     * 
     * @param expirationDate the expiration date
     */
    public void setExpirationDate(final Date expirationDate) {
        this.expirationDate = new Date(expirationDate.getTime());
    }

    /**
     * Sets the renewal date of the license.
     * 
     * @param renewalDate the renewal date
     */
    public void setRenewalDate(final Date renewalDate) {
        this.renewalDate = Optional.of(new Date(renewalDate.getTime()));
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        final StringBuilder description = new StringBuilder(Constants.STRINGBUILDER_INITIAL_SIZE);
        description.append("License ID: ").append(id)
                .append("\nRelease date: ").append(releaseDate);
        renewalDate.ifPresent(date -> description.append("\nRenewal date: ").append(date));
        description.append("\nExpiration date: ").append(expirationDate);
        return description.toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof License
                && this.id.equals(((License) other).getID())
                && this.releaseDate.equals(((License) other).getReleaseDate())
                && this.expirationDate.equals(((License) other).getExpirationDate())
                && this.renewalDate.equals(((License) other).getRenewalDate());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(id, releaseDate, this.expirationDate, this.renewalDate);
    }

}
