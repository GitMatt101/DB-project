package it.unibo.model.tables.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

import it.unibo.common.Constants;
import it.unibo.model.entities.Organism;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link Organism} entity.
 */
public class OrganismTable implements Table<Organism, String> {

    private static final String TABLE_NAME = "organismi";
    private static final String ID = "ID";
    private static final String SPECIES = "Specie";
    private static final String TEMPORARY_NAME = "NomeProvvisorio";
    private static final String COMMON_NAME = "NomeComune";
    private static final String DESCRIPTION = "Descrizione";
    private static final String PREPARE_FIELD = " = ?";

    private final Connection connection;

    /**
     * Creates an instance of {@code OrganismTable}.
     * 
     * @param connection the connection to the database
     */
    public OrganismTable(final Connection connection) {
        this.connection = connection;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String getTableName() {
        return TABLE_NAME;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public Optional<Organism> findByPrimaryKey(final String primaryKey) {
        final String query = "SELECT * FROM " + TABLE_NAME + " WHERE " + ID + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readOrganismsFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            Logger.getLogger(OrganismTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the organisms in it and collects them in a List.
     * 
     * @param resultSet a ResultSet from which the organisms will be extracted
     * @return a List of all the organisms in the ResultSet
     * @throws SQLException
     */
    private List<Organism> readOrganismsFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<Organism> organisms = new ArrayList<>();
        while (resultSet.next()) {
            organisms.add(new Organism(
                    resultSet.getString(ID),
                    Optional.ofNullable(resultSet.getString(SPECIES)),
                    Optional.ofNullable(resultSet.getString(TEMPORARY_NAME)),
                    Optional.ofNullable(resultSet.getString(COMMON_NAME)),
                    resultSet.getString(DESCRIPTION)));
        }
        return organisms;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Organism> findAll() {
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery("SELECT * FROM " + TABLE_NAME);
            return readOrganismsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(OrganismTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Collections.emptyList();
        }
    }

    public List<Organism> filterByExpedition(final String expeditionCode) {
        final SightingTable sighting = new SightingTable(null);
        final String query = "SELECT " + ID + ", " + SPECIES + ", " + TEMPORARY_NAME + ", " + COMMON_NAME + ", "
                + DESCRIPTION
                + " FROM " + TABLE_NAME + ", " + sighting.getTableName()
                + " WHERE " + sighting.getTableName() + "." + sighting.getExpeditionCodeName() + "='" + expeditionCode + "'"
                + " AND " + sighting.getTableName() + "." + sighting.getOrganismIDName() + "=" + TABLE_NAME + "." + ID;
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery(query);
            return readOrganismsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(OrganismTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Organism value) {
        final String query = "INSERT INTO " + TABLE_NAME + "("
                + ID + ", " + SPECIES + ", " + TEMPORARY_NAME + ", " + COMMON_NAME + ", " + DESCRIPTION
                + ") VALUES (?,?,?,?,?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, value.getId());
            statement.setString(2, value.getSpecies().orElse(null));
            statement.setString(3, value.getTemporaryName().orElse(null));
            statement.setString(4, value.getCommonName().orElse(null));
            statement.setString(5, value.getDescription());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(OrganismTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean update(final Organism updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + SPECIES + PREPARE_FIELD + ", "
                + TEMPORARY_NAME + PREPARE_FIELD + ", "
                + COMMON_NAME + PREPARE_FIELD + ", "
                + DESCRIPTION + PREPARE_FIELD
                + " WHERE " + ID + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, updatedValue.getSpecies().orElse(null));
            statement.setString(2, updatedValue.getTemporaryName().orElse(null));
            statement.setString(3, updatedValue.getCommonName().orElse(null));
            statement.setString(4, updatedValue.getDescription());
            statement.setString(5, updatedValue.getId());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(OrganismTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean delete(final String primaryKey) {
        final String query = "DELETE FROM " + TABLE_NAME + " WHERE " + ID + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(OrganismTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
