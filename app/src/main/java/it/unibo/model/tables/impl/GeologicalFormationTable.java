package it.unibo.model.tables.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import it.unibo.common.Constants;
import it.unibo.common.Counter;
import it.unibo.connection.ConnectionProvider;
import it.unibo.model.entities.impl.GeologicalFormation;
import it.unibo.model.tables.TableUtilities;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link GeologicalFormation} entity.
 */
public class GeologicalFormationTable implements Table<GeologicalFormation, String> {

    private static final String TABLE_NAME = "formazioni_geologiche";
    private static final String ID = "ID";
    private static final String TYPE = "Tipologia";
    private static final String SIZE = "Dimensioni";
    private static final String DANGER_LEVEL = "GradoPericolo";
    private static final String DESCRIPTION = "Descrizione";

    private final Connection connection;

    /**
     * Creates an instance of {@code OrganismTable}.
     * 
     * @param provider the provider of the connection to the database the connection
     *                 to the database
     */
    public GeologicalFormationTable(final ConnectionProvider provider) {
        this.connection = provider != null ? provider.getMySQLConnection() : null;
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
        final String query = Constants.SELECT_ALL + TABLE_NAME + Constants.WHERE + ID + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readGeologicalFormationsFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
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
                    resultSet.getString(ID),
                    resultSet.getString(TYPE),
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
        try (PreparedStatement statement = this.connection.prepareStatement(Constants.SELECT_ALL + TABLE_NAME)) {
            final ResultSet resultSet = statement.executeQuery();
            return readGeologicalFormationsFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Collections.emptyList();
        }
    }

    /**
     * Retrieves all the geological formations with the given danger level.
     * 
     * @param dangerLevel the danger level
     * @return a List of all the geological formations with the given danger level
     */
    public List<GeologicalFormation> filterByDangerLevel(final int dangerLevel) {
        final String query = Constants.SELECT_ALL + TABLE_NAME + Constants.WHERE + DANGER_LEVEL + "=" + dangerLevel;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final ResultSet resultSet = statement.executeQuery();
            return readGeologicalFormationsFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final GeologicalFormation value) {
        final String query = "INSERT INTO " + TABLE_NAME + " ("
                + ID + ", " + TYPE + ", " + SIZE + ", " + DANGER_LEVEL + ", " + DESCRIPTION
                + ") VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), value.getID());
            statement.setString(counter.getValueAndIncrement(), value.getType());
            statement.setInt(counter.getValueAndIncrement(), value.getSize());
            statement.setInt(counter.getValueAndIncrement(), value.getDangerLevel());
            statement.setString(counter.getValue(), value.getDescription());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean update(final GeologicalFormation updatedValue) {
        // We are going to assume that type of geological formation doesn't change
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + SIZE + Constants.QUESTION_MARK + ", "
                + DANGER_LEVEL + Constants.QUESTION_MARK + ", "
                + DESCRIPTION + Constants.QUESTION_MARK
                + Constants.WHERE + ID + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setInt(counter.getValueAndIncrement(), updatedValue.getSize());
            statement.setInt(counter.getValueAndIncrement(), updatedValue.getDangerLevel());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getDescription());
            statement.setString(counter.getValue(), updatedValue.getID());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean delete(final String primaryKey) {
        final String query = "DELETE FROM " + TABLE_NAME + Constants.WHERE + ID + Constants.QUESTION_MARK;
        return TableUtilities.deleteOperation(query, primaryKey, this.connection, this);
    }

}
