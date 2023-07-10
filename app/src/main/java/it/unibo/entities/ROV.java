package it.unibo.entities;

import java.util.Objects;

/**
 * This class models a {@code Remotely Operated Vehicle}.
 */
public class ROV {

    private final String licensePlate;
    private final Manufacturer manufacturer;
    private final String serialNumber;

    /**
     * Creates an instance of a {@code ROV}.
     * 
     * @param licensePlate the license plate
     * @param manufacturer the {@link Manufacturer}
     * @param serialNumber the serial number given by the manufacturer
     */
    public ROV(final String licensePlate, final Manufacturer manufacturer, final String serialNumber) {
        this.licensePlate = licensePlate;
        this.manufacturer = manufacturer;
        this.serialNumber = serialNumber;
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
     * Retrieves the {@code ROV}'s {@link Manufacturer}.
     * 
     * @return the manufacturer
     */
    public Manufacturer getManufacturer() {
        return this.manufacturer;
    }

    /**
     * Retrieves the {@code ROV}'s serial number.
     * 
     * @return the serial number given by the {@link Manufacturer}
     */
    public String getSerialNumber() {
        return this.serialNumber;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return new StringBuilder("License plate: ").append(this.licensePlate)
                .append("\nManufacturer: ").append(this.manufacturer.getName())
                .append("\nSerial Number: ").append(this.serialNumber)
                .toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof ROV
                && this.licensePlate.equals(((ROV) other).getLicensePlate())
                && this.manufacturer.equals(((ROV) other).getManufacturer())
                && this.serialNumber.equals(((ROV) other).getSerialNumber());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.licensePlate, this.manufacturer, this.serialNumber);
    }

}
