package it.unibo.entities;

import java.util.Objects;

import it.unibo.common.Constants;

/**
 * This class models an analysis, identified by a unique code.
 */
public class Analysis {

    private final String code;
    private final String extractionCode;
    private final String laboratoryID;
    private final String description;

    /**
     * Creates an instance of {@code Analysis}.
     * 
     * @param code           the code
     * @param extractionCode the code of the extraction
     * @param laboratoryID   the laboratory that conducted the analysis
     * @param description    the description
     */
    public Analysis(final String code, final String extractionCode, final String laboratoryID,
            final String description) {
        this.code = code;
        this.extractionCode = extractionCode;
        this.laboratoryID = laboratoryID;
        this.description = description;
    }

    /**
     * Retrieves the code of the analysis.
     * 
     * @return the analysis' code
     */
    public String getCode() {
        return this.code;
    }

    /**
     * Retrieves the code of the extraction.
     * 
     * @return the extraction's code
     */
    public String getExtractionCode() {
        return this.extractionCode;
    }

    /**
     * Retrieves the ID of the laboratory that conducted the analysis.
     * 
     * @return the laboratory's ID
     */
    public String getLaboratoryID() {
        return this.laboratoryID;
    }

    /**
     * Retrieves the description of the analysis.
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
        return new StringBuilder(Constants.STRINGBUILDER_INITIAL_SIZE)
                .append("Code: ").append(this.code)
                .append("\nExtraction: ").append(this.extractionCode)
                .append("\nLaboratory: ").append(this.laboratoryID)
                .append(Constants.SEPARATOR)
                .append(this.description)
                .append(Constants.SEPARATOR)
                .toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Analysis
                && this.code.equals(((Analysis) other).getCode())
                && this.extractionCode.equals(((Analysis) other).getExtractionCode())
                && this.laboratoryID.equals(((Analysis) other).getLaboratoryID())
                && this.description.equals(((Analysis) other).getDescription());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.code, this.extractionCode, this.laboratoryID, this.description);
    }

}
