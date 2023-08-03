package it.unibo.model.entities;

import java.util.Objects;
import java.util.Optional;

import it.unibo.common.Constants;

/**
 * Class modelling a generic organism.
 */
public class Organism {

    private final String id;
    private Optional<String> species;
    private Optional<String> temporaryName;
    private final Optional<String> commonName;
    private final String description;

    /**
     * Creates an instance of {@code Organism}.
     * 
     * @param id            the identifier of the organism
     * @param species       the species of the organism
     * @param temporaryName the temporary name of the organism
     * @param commonName    the common name of the organism
     * @param description   the description of the organism
     */
    public Organism(final String id, final Optional<String> species, final Optional<String> temporaryName,
            final Optional<String> commonName, final String description) {
        this.id = id;
        this.species = species;
        this.temporaryName = temporaryName;
        this.commonName = commonName;
        this.description = description;
    }

    /**
     * Retrieves the identifier of the organism.
     * 
     * @return the identifier
     */
    public String getId() {
        return this.id;
    }

    /**
     * Retrieves the species of the organism.
     * 
     * @return the species
     */
    public Optional<String> getSpecies() {
        return this.species;
    }

    /**
     * Updates the species of the organism.
     * 
     * @param species the new species
     */
    public void updateInfo(final String species) {
        this.species = Optional.of(species);
        this.temporaryName = Optional.empty();
    }

    /**
     * Retrieves the temporary name of the organism.
     * 
     * @return the temporary name
     */
    public Optional<String> getTemporaryName() {
        return this.temporaryName;
    }

    /**
     * Retrieves the common name of the organism.
     * 
     * @return the common name
     */
    public Optional<String> getCommonName() {
        return this.commonName;
    }

    /**
     * Retrieves the description of the organism.
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
        final StringBuilder description = new StringBuilder(Constants.STRINGBUILDER_INITIAL_SIZE);
        description.append("ID: ").append(this.id)
                .append("\nSpecies: ");
        this.species.ifPresentOrElse(description::append, () -> description.append("unknown"));
        this.temporaryName.ifPresent(tn -> description.append("\nTemporary name: ").append(tn));
        this.commonName.ifPresent(cn -> description.append("\nCommon name: ").append(cn));
        description.append(Constants.SEPARATOR)
                .append(this.description)
                .append(Constants.SEPARATOR);
        return description.toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Organism
                && this.id.equals(((Organism) other).getId())
                && this.species.equals(((Organism) other).getSpecies())
                && this.temporaryName.equals(((Organism) other).getTemporaryName())
                && this.commonName.equals(((Organism) other).getCommonName())
                && this.description.equals(((Organism) other).getDescription());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.id, this.species, this.temporaryName, this.commonName, this.description);
    }

}
