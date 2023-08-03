package it.unibo.entities;

import java.util.Date;
import java.util.Objects;

/**
 * This class models a {@code Remotely Operated Vehicle}.
 */
public class ROV {

    private final String licensePlate;
    private final String manufacturerName;
    private final String serialNumber;
    private final Date productionDate;

    /**
     * Creates an instance of a {@code ROV}.
     * 
     * @param licensePlate     the license plate
     * @param manufacturerName the manufacturer's name
     * @param serialNumber     the serial number given by the String
     * @param productionDate   the production date
     */
    public ROV(final String licensePlate, final String manufacturerName, final String serialNumber,
            final Date productionDate) {
        this.licensePlate = licensePlate;
        this.manufacturerName = manufacturerName;
        this.serialNumber = serialNumber;
        this.productionDate = productionDate;
    }

    /**
     * Retrieves the {@code ROV}'s licese plate.
     * 
     * @return the license plate
     */
    public String getLicensePlate() {
        return this.licensePlate;
    }

    /**
     * Retrieves the {@code ROV}'s manufacturerName.
     * 
     * @return the manufacturerName
     */
    public String getManufacturerName() {
        return this.manufacturerName;
    }

    /**
     * Retrieves the {@code ROV}'s serial number.
     * 
     * @return the serial number given by the manufacturerName
     */
    public String getSerialNumber() {
        return this.serialNumber;
    }

    /**
     * Retrieves the {@code ROV}'s production date.
     * 
     * @return the production date
     */
    public Date getProductionDate() {
        return this.productionDate;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return new StringBuilder("License plate: ").append(this.licensePlate)
                .append("\nmanufacturerName: ").append(this.manufacturerName)
                .append("\nSerial Number: ").append(this.serialNumber)
                .append("\nProduction Date: ").append(this.productionDate)
                .toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof ROV
                && this.licensePlate.equals(((ROV) other).getLicensePlate())
                && this.manufacturerName.equals(((ROV) other).getManufacturerName())
                && this.serialNumber.equals(((ROV) other).getSerialNumber())
                && this.productionDate.equals(((ROV) other).getProductionDate());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.licensePlate, this.manufacturerName, this.serialNumber, this.productionDate);
    }

}
