package it.unibo.entities.impl;

import java.sql.Blob;
import java.util.Objects;
import java.util.Optional;

import it.unibo.common.Constants;
import it.unibo.entities.GeologicalFormation;
import it.unibo.entities.Organism;
import it.unibo.entities.Wreck;
import it.unibo.entities.api.Event;

/**
 * This class models the sighting of an {@link Organism}, {@link Wreck} or
 * {@link GeologicalFormation}.
 */
public class Sighting implements Event {

    private final String code;
    private final String expeditionCode;
    private final int number;
    private final Optional<Integer> depth;
    private final Blob image;
    private final Optional<String> notes;
    private final Optional<String> organismID;
    private final Optional<String> wreckID;
    private final Optional<String> geologicalFormationName;

    /**
     * Creates an instance of {@code Sighting}.
     * 
     * @param code                    the code
     * @param number                  the number of the sighting relative to the
     *                                expedition
     * @param expeditionCode          the code of the expedition
     * @param depth                   the depth
     * @param image                   the image
     * @param notes                   the notes
     * @param organismID              the ID of the organism
     * @param wreckID                 the ID of the wreck
     * @param geologicalFormationName the name of the geological formation
     */
    public Sighting(final String code, final String expeditionCode, final int number, final Optional<Integer> depth,
            final Blob image, final Optional<String> notes, final Optional<String> organismID,
            final Optional<String> wreckID, final Optional<String> geologicalFormationName) {
        this.code = code;
        this.expeditionCode = expeditionCode;
        this.number = number;
        this.depth = depth;
        this.image = image;
        this.notes = notes;
        this.organismID = organismID;
        this.wreckID = wreckID;
        this.geologicalFormationName = geologicalFormationName;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String getCode() {
        return this.code;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int getNumber() {
        return this.number;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String getExpeditionCode() {
        return this.expeditionCode;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public Optional<Integer> getDepth() {
        return this.depth;
    }

    /**
     * Retrieves the image.
     * 
     * @return the image as a blob
     */
    public Blob getImage() {
        return this.image;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public Optional<String> getNotes() {
        return this.notes;
    }

    /**
     * Retrieves the organism.
     * 
     * @return the organism
     */
    public Optional<String> getOrganismID() {
        return this.organismID;
    }

    /**
     * Retrieves the ID of the wreck.
     * 
     * @return the wreck
     */
    public Optional<String> getWreckID() {
        return this.wreckID;
    }

    /**
     * Retrieves the geological formation.
     * 
     * @return the geological formation
     */
    public Optional<String> getGeologicalFormationName() {
        return this.geologicalFormationName;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        final StringBuilder description = new StringBuilder(Constants.STRINGBUILDER_INITIAL_SIZE);
        description.append("Sighting: ").append(this.code)
                .append("\nExpedition: ").append(this.expeditionCode)
                .append("\tn° ").append(this.number);
        this.depth.ifPresent(d -> description.append("\nDepth: ").append(d));
        this.organismID.ifPresent(o -> description.append("\nOrganism ID: ").append(o));
        this.wreckID.ifPresent(w -> description.append("\nWreck ID: ").append(w));
        this.geologicalFormationName.ifPresent(g -> description.append("\nGeological Formation: ").append(g));
        this.notes.ifPresent(n -> description.append(Constants.SEPARATOR).append(n).append(Constants.SEPARATOR));
        return description.toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Sighting
                && this.code.equals(((Sighting) other).getCode())
                && this.number == ((Sighting) other).getNumber()
                && this.expeditionCode.equals(((Sighting) other).getExpeditionCode())
                && this.depth.equals(((Sighting) other).getDepth())
                && this.image.equals(((Sighting) other).getImage())
                && this.notes.equals(((Sighting) other).getNotes())
                && this.organismID.equals(((Sighting) other).getOrganismID())
                && this.wreckID.equals(((Sighting) other).getWreckID())
                && this.geologicalFormationName.equals(((Sighting) other).getGeologicalFormationName());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.code, this.number, this.expeditionCode, this.depth, this.image, this.notes,
                this.organismID, this.wreckID, this.geologicalFormationName);
    }

}
