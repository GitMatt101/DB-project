package it.unibo.model.tables.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

import it.unibo.common.Constants;
import it.unibo.model.entities.GeologicalFormation;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link GeologicalFormation} entity.
 */
public class GeologicalFormationTable implements Table<GeologicalFormation, String> {

    private static final String TABLE_NAME = "formazione_geologica";
    private static final String NAME = "Nome";
    private static final String SIZE = "Dimensioni";
    private static final String DANGER_LEVEL = "Grado_di_pericolo";
    private static final String DESCRIPTION = "Descrizione";
    private static final String PREPARE_FIELD = " = ?";

    private final Connection connection;

    /**
     * Creates an instance of {@code OrganismTable}.
     * 
     * @param connection the connection to the database
     */
    public GeologicalFormationTable(final Connection connection) {
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
    public Optional<GeologicalFormation> findByPrimaryKey(final String primaryKey) {
        final String query = "SELECT * FROM " + TABLE_NAME + " WHERE " + NAME + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readGeologicalFormationsFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            Logger.getLogger(GeologicalFormationTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR,
                    e);
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the geological formations in it and collects them
     * in a List.
     * 
     * @param resultSet a ResultSet from which the geological formations will be
     *                  extracted
     * @return a List of all the geological formations in the ResultSet
     */
    private List<GeologicalFormation> readGeologicalFormationsFromResultSet(final ResultSet resultSet)
            throws SQLException {
        final List<GeologicalFormation> geologicalFormations = new ArrayList<>();
        while (resultSet.next()) {
            geologicalFormations.add(new GeologicalFormation(
                    resultSet.getString(NAME),
                    resultSet.getInt(SIZE),
                    resultSet.getInt(DANGER_LEVEL),
                    resultSet.getString(DESCRIPTION)));
        }
        return geologicalFormations;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<GeologicalFormation> findAll() {
        try (PreparedStatement statement = this.connection.prepareStatement("SELECT * FROM " + TABLE_NAME)) {
            final ResultSet resultSet = statement.executeQuery();
            return readGeologicalFormationsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(GeologicalFormationTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR,
                    e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final GeologicalFormation value) {
        final String query = "INSERT INTO " + TABLE_NAME + " ("
                + NAME + ", " + SIZE + ", " + DANGER_LEVEL + ", " + DESCRIPTION
                + ") VALUES (?, ?, ?, ?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, value.getName());
            statement.setInt(2, value.getSize());
            statement.setInt(3, value.getDangerLevel());
            statement.setString(4, value.getDescription());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(GeologicalFormationTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR,
                    e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean update(final GeologicalFormation updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + SIZE + PREPARE_FIELD + ", "
                + DANGER_LEVEL + PREPARE_FIELD + ", "
                + DESCRIPTION + PREPARE_FIELD
                + " WHERE " + NAME + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setInt(1, updatedValue.getSize());
            statement.setInt(2, updatedValue.getDangerLevel());
            statement.setString(3, updatedValue.getDescription());
            statement.setString(4, updatedValue.getName());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(GeologicalFormationTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR,
                    e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean delete(final String primaryKey) {
        final String query = "DELETE FROM " + TABLE_NAME + " WHERE " + NAME + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(GeologicalFormationTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR,
                    e);
            return false;
        }
    }

}
