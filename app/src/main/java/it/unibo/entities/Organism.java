package it.unibo.entities;

import java.util.Objects;
import java.util.Optional;

import it.unibo.common.Constants;

/**
 * Class modelling a generic organism.
 */
public class Organism {

    private final String species;
    private final Optional<String> commonName;
    private final float dimension;
    private final float depth;
    private final String behaviour;
    private final String imagePath;

    /**
     * Creates an instance of {@code Organism} without a common name.
     * 
     * @param species    name of the species
     * @param dimension  length of the organism
     * @param depth      depth where it was spotted
     * @param behaviour  description of the behaviour when it was spotted
     * @param imagePath path to the photo of the organism
     */
    public Organism(final String species, final float dimension, final float depth, final String behaviour,
            final String imagePath) {
        this.species = species;
        this.commonName = Optional.empty();
        this.dimension = dimension;
        this.depth = depth;
        this.behaviour = behaviour;
        this.imagePath = imagePath;
    }

    /**
     * Creates an instance of {@code Organism}.
     * 
     * @param species     name of the species
     * @param commonName common name of the organism
     * @param dimension   length of the organism
     * @param depth       depth where it was spotted
     * @param behaviour   description of the behaviour when it was spotted
     * @param imagePath  path to the photo of the organism
     */
    public Organism(final String species, final String commonName, final float dimension, final float depth,
            final String behaviour,
            final String imagePath) {
        this.species = species;
        this.commonName = Optional.of(commonName);
        this.dimension = dimension;
        this.depth = depth;
        this.behaviour = behaviour;
        this.imagePath = imagePath;
    }

    /**
     * Retrieves the species of the organism.
     * 
     * @return name of the species
     */
    public String getSpecies() {
        return this.species;
    }

    /**
     * Retrieves the common name of the organism if it has one.
     * 
     * @return the common name of the organism, if it doesn't have a common name it
     *         will return {@code Optional.empty()}
     */
    public Optional<String> getCommonName() {
        return this.commonName;
    }

    /**
     * Retrieves the dimension (lenght) of the organism.
     * 
     * @return length of the organism
     */
    public float getDimension() {
        return this.dimension;
    }

    /**
     * Retrieves the depth where the organism was found.
     * 
     * @return the depth
     */
    public float getDepth() {
        return this.depth;
    }

    /**
     * Retrieves the description of the behaviour of the organism.
     * 
     * @return the description of the behaviour
     */
    public String getBehaviour() {
        return this.behaviour;
    }

    /**
     * Retrieves the path to the image of the organism.
     * 
     * @return path to the image of the organism
     */
    public String getImagePath() {
        return this.imagePath;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        final StringBuilder description = new StringBuilder(Constants.STRINGBUILDER_INITIAL_SIZE);
        description.append("Species: ").append(this.species);
        if (!this.commonName.isEmpty()) {
            description.append("\nCommon name: ").append(this.commonName);
        }
        description.append("\nDimension: ").append(this.dimension)
                .append("\nDepth: ").append(Float.toString(this.depth))
                .append(Constants.SEPARATOR)
                .append(this.behaviour)
                .append(Constants.SEPARATOR)
                .append(this.imagePath);
        return description.toString();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(final Object other) {
        return other instanceof Organism
                && this.species.equals(((Organism) other).getSpecies())
                && this.commonName.equals(((Organism) other).getCommonName())
                && Math.abs(this.dimension - ((Organism) other).getDimension()) < Math.ulp(this.dimension)
                && Math.abs(this.depth - ((Organism) other).getDepth()) < Math.ulp(this.depth)
                && this.behaviour.equals(((Organism) other).getBehaviour())
                && this.imagePath.equals(((Organism) other).getImagePath());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int hashCode() {
        return Objects.hash(this.species, this.commonName, this.dimension, this.depth, this.behaviour,
                this.imagePath);
    }

}
