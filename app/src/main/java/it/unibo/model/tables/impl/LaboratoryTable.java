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

import it.unibo.common.Constants;
import it.unibo.common.Counter;
import it.unibo.connection.ConnectionProvider;
import it.unibo.model.entities.Laboratory;
import it.unibo.model.tables.TableUtilities;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link Laboratory} entity.
 */
public class LaboratoryTable implements Table<Laboratory, String> {

    private static final String TABLE_NAME = "laboratori";
    private static final String ID = "ID";
    private static final String NAME = "Nome";
    private static final String ADDRESS = "Indirizzo";

    private final Connection connection;

    /**
     * Creates an instance of {@code LaboratoryTable}.
     * 
     * @param provider the provider of the connection to the database
     */
    public LaboratoryTable(final ConnectionProvider provider) {
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
    public Optional<Laboratory> findByPrimaryKey(final String primaryKey) {
        final String query = Constants.SELECT_ALL + TABLE_NAME + Constants.WHERE + ID + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readLaboratoriesFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the laboratories in it and collects them in a
     * List.
     * 
     * @param resultSet a ResultSet from which the Laboratories will be extracted
     * @return a List of all the laboratories in the ResultSet
     * @throws SQLException
     */
    private List<Laboratory> readLaboratoriesFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<Laboratory> laboratories = new ArrayList<>();
        while (resultSet.next()) {
            laboratories.add(new Laboratory(
                    resultSet.getString(ID),
                    resultSet.getString(NAME),
                    resultSet.getString(ADDRESS)));
        }
        return laboratories;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Laboratory> findAll() {
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery(Constants.SELECT_ALL + TABLE_NAME);
            return readLaboratoriesFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Laboratory value) {
        final String query = "INSERT INTO " + TABLE_NAME + "("
                + ID + ", " + NAME + ", " + ADDRESS
                + ") VALUES (?,?,?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), value.getID());
            statement.setString(counter.getValueAndIncrement(), value.getName());
            statement.setString(counter.getValue(), value.getAddress());
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
    public boolean update(final Laboratory updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + NAME + Constants.QUESTION_MARK + ", "
                + ADDRESS + Constants.QUESTION_MARK
                + Constants.WHERE + ID + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), updatedValue.getName());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getAddress());
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
