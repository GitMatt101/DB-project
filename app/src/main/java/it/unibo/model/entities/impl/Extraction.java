package it.unibo.model.entities.impl;

import java.util.Objects;
import java.util.Optional;

import it.unibo.common.Constants;
import it.unibo.model.entities.api.Event;

/**
 * This class models the extraction of a {@link String}, identified by a
 * unique ID.
 */
public class Extraction implements Event {

    private final String code;
    private final String expeditionCode;
    private final int number;
    private final String materialName;
    private final Optional<Integer> depth;
    private final float amount;
    private final Optional<String> notes;

    /**
     * Creates an instance of {@code Extraction}.
     * 
     * @param code           the code
     * @param expeditionCode the expedition's code
     * @param number         the number
     * @param materialName   the material
     * @param depth          the depth
     * @param amount         the amount
     * @param notes          the notes
     */
    public Extraction(final String code, final String expeditionCode, final int number, final String materialName,
            final Optional<Integer> depth, final float amount,
            final Optional<String> notes) {
        this.code = code;
        this.expeditionCode = expeditionCode;
        this.number = number;
        this.materialName = materialName;
        this.depth = depth;
        this.amount = amount;
        this.notes = notes;
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
    public String getExpeditionCode() {
        return this.expeditionCode;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int getNumber() {
        return this.number;
    }

    /**
     * Retrieves the material extracted.
     * 
     * @return the material
     */
    public String getMaterialName() {
        return this.materialName;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public Optional<Integer> getDepth() {
        return this.depth;
    }

    /**
     * Retrieves the amount of material extracted.
     * 
     * @return the amount
     */
    public float getAmount() {
        return this.amount;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public Optional<String> getNotes() {
        return this.notes;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        final StringBuilder description = new StringBuilder(Constants.STRINGBUILDER_INITIAL_SIZE);
        description.append("Extraction: ").append(this.code)
                .append("\nExpedition: ").append(this.expeditionCode)
                .append("\tn° ").append(this.number);
        this.depth.ifPresent(d -> description.append("\tDepth: ").append(d));
        this.notes.ifPresent(n -> description.append(Constants.SEPARATOR).append(n).append(Constants.SEPARATOR));
        description.append("\tString: ").append(this.materialName);
        return description.toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Extraction
                && this.code.equals(((Extraction) other).getCode())
                && this.number == ((Extraction) other).getNumber()
                && this.expeditionCode.equals(((Extraction) other).getExpeditionCode())
                && this.depth.equals(((Extraction) other).getDepth())
                && this.notes.equals(((Extraction) other).getNotes())
                && this.materialName.equals(((Extraction) other).getMaterialName());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.code, this.number, this.expeditionCode, this.depth, this.notes, this.materialName);
    }

}
