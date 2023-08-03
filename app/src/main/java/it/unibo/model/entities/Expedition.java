package it.unibo.model.entities;

import java.util.Date;
import java.util.Objects;

/**
 * This class models a simple expedition identified by a unique code.
 */
public class Expedition {

    private final String code;
    private final Date date;
    private final String locationName;
    private final String rovLicencePlate;
    private final String associationName;
    private final String groupID;

    /**
     * Creates an instance of {@code Expedition}.
     * 
     * @param code            the code of the expedition
     * @param date            the date of the expedition
     * @param locationName    the name of the location of the expedition
     * @param rovLicencePlate the licence plate of the ROV used for the expedition
     * @param groupID         the ID of the group that manages the expedition
     * @param associationName the name of the association that organizes the
     *                        expedition
     */
    public Expedition(final String code, final Date date, final String locationName, final String rovLicencePlate,
            final String groupID, final String associationName) {
        this.code = code;
        this.date = new Date(date.getTime());
        this.locationName = locationName;
        this.rovLicencePlate = rovLicencePlate;
        this.groupID = groupID;
        this.associationName = associationName;
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
     * Retrieves the location of the expedition.
     * 
     * @return the location
     */
    public String getLocationName() {
        return this.locationName;
    }

    /**
     * Retrieves the license plate of the ROV used for the expedition.
     * 
     * @return the license plate
     */
    public String getROVLicencePlate() {
        return this.rovLicencePlate;
    }

    /**
     * Retrieves the group that manages the expedition.
     * 
     * @return the group
     */
    public String getGroupID() {
        return this.groupID;
    }

    /**
     * Retrieves the company that manages the expedition.
     * 
     * @return the company
     */
    public String getAssociationName() {
        return this.associationName;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return new StringBuilder("Expedition code: ").append(this.code)
                .append("\nDate: ").append(this.date)
                .append("\nLocation: ").append(this.locationName)
                .append("\nROV: ").append(this.rovLicencePlate)
                .append("\nGroup ID: ").append(this.groupID)
                .append("\nAssociation: ").append(this.associationName)
                .toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Expedition
                && this.code.equals(((Expedition) other).getCode())
                && this.date.equals(((Expedition) other).getDate())
                && this.locationName.equals(((Expedition) other).getLocationName())
                && this.rovLicencePlate.equals(((Expedition) other).getROVLicencePlate())
                && this.groupID.equals(((Expedition) other).getGroupID())
                && this.associationName.equals(((Expedition) other).getAssociationName());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.code, this.date, this.locationName, this.rovLicencePlate, this.groupID,
                this.associationName);
    }

}
