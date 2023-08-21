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
import it.unibo.model.entities.Company;
import it.unibo.model.tables.TableUtilities;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@code Association} entity, represented by {@link Company}.
 */
public class CompanyTable implements Table<Company, String> {

    private static final String NAME = "Nome";
    private static final String ADDRESS = "Indirizzo";

    private final Connection connection;
    private final String tableName;

    /**
     * Creates an instance of {@code AssociationTable}.
     * 
     * @param provider  the provider of the connection to the database the
     *                  connection to the database
     * @param tableName the name of the table
     */
    public CompanyTable(final ConnectionProvider provider, final String tableName) {
        this.connection = provider != null ? provider.getMySQLConnection() : null;
        this.tableName = tableName;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String getTableName() {
        return this.tableName;
    }

    /**
     * Checks if the name of the table is the name for associations.
     * 
     * @return true if the name is for association, false if it's a laboratory
     */
    private boolean checkTableNameIsAssociations() {
        return Constants.ASSOCIATIONS.equals(this.tableName);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public Optional<Company> findByPrimaryKey(final String primaryKey) {
        final String query1 = Constants.SELECT_ALL + Constants.ASSOCIATIONS + Constants.WHERE + NAME
                + Constants.QUESTION_MARK;
        final String query2 = Constants.SELECT_ALL + Constants.MANUFACTURERS + Constants.WHERE + NAME
                + Constants.QUESTION_MARK;
        if (checkTableNameIsAssociations()) {
            try (PreparedStatement statement = this.connection.prepareStatement(query1)) {
                statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, primaryKey);
                final ResultSet resultSet = statement.executeQuery();
                return readManufacturersFromResultSet(resultSet).stream().findFirst();
            } catch (final SQLException e) {
                TableUtilities.logSQLException(this, e);
                return Optional.empty();
            }
        } else {
            try (PreparedStatement statement = this.connection.prepareStatement(query2)) {
                statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, primaryKey);
                final ResultSet resultSet = statement.executeQuery();
                return readManufacturersFromResultSet(resultSet).stream().findFirst();
            } catch (final SQLException e) {
                TableUtilities.logSQLException(this, e);
                return Optional.empty();
            }
        }

    }

    /**
     * Given a ResultSet read all the associations in it and collects them in a
     * List.
     * 
     * @param resultSet a ResultSet from which the associations will be extracted
     * @return a List of all the associations in the ResultSet
     * @throws SQLException
     */
    private List<Company> readManufacturersFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<Company> manufacturers = new ArrayList<>();
        while (resultSet.next()) {
            manufacturers.add(new Company(resultSet.getString(NAME), resultSet.getString(ADDRESS)));
        }
        return manufacturers;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Company> findAll() {
        if (checkTableNameIsAssociations()) {
            try (Statement statement = this.connection.createStatement()) {
                final ResultSet resultSet = statement.executeQuery(Constants.SELECT_ALL + Constants.ASSOCIATIONS);
                return readManufacturersFromResultSet(resultSet);
            } catch (final SQLException e) {
                TableUtilities.logSQLException(this, e);
                return Collections.emptyList();
            }
        } else {
            try (Statement statement = this.connection.createStatement()) {
                final ResultSet resultSet = statement.executeQuery(Constants.SELECT_ALL + Constants.MANUFACTURERS);
                return readManufacturersFromResultSet(resultSet);
            } catch (final SQLException e) {
                TableUtilities.logSQLException(this, e);
                return Collections.emptyList();
            }
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Company value) {
        final String query1 = "INSERT INTO " + Constants.ASSOCIATIONS + " VALUES (?, ?)";
        final String query2 = "INSERT INTO " + Constants.MANUFACTURERS + " VALUES (?, ?)";
        if (checkTableNameIsAssociations()) {
            try (PreparedStatement statement = this.connection.prepareStatement(query1)) {
                final Counter counter = new Counter(1);
                statement.setString(counter.getValueAndIncrement(), value.getName());
                statement.setString(counter.getValue(), value.getAddress());
                return statement.executeUpdate() > 0;
            } catch (final SQLException e) {
                TableUtilities.logSQLException(this, e);
                return false;
            }
        } else {
            try (PreparedStatement statement = this.connection.prepareStatement(query2)) {
                final Counter counter = new Counter(1);
                statement.setString(counter.getValueAndIncrement(), value.getName());
                statement.setString(counter.getValue(), value.getAddress());
                return statement.executeUpdate() > 0;
            } catch (final SQLException e) {
                TableUtilities.logSQLException(this, e);
                return false;
            }
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean update(final Company updatedValue) {
        final String query1 = "UPDATE " + Constants.ASSOCIATIONS + " SET "
                + ADDRESS + Constants.QUESTION_MARK
                + Constants.WHERE + NAME + Constants.QUESTION_MARK;
        final String query2 = "UPDATE " + Constants.MANUFACTURERS + " SET "
                + ADDRESS + Constants.QUESTION_MARK
                + Constants.WHERE + NAME + Constants.QUESTION_MARK;
        if (checkTableNameIsAssociations()) {
            try (PreparedStatement statement = this.connection.prepareStatement(query1)) {
                final Counter counter = new Counter(1);
                statement.setString(counter.getValueAndIncrement(), updatedValue.getAddress());
                statement.setString(counter.getValue(), updatedValue.getName());
                return statement.executeUpdate() > 0;
            } catch (final SQLException e) {
                TableUtilities.logSQLException(this, e);
                return false;
            }
        } else {
            try (PreparedStatement statement = this.connection.prepareStatement(query2)) {
                final Counter counter = new Counter(1);
                statement.setString(counter.getValueAndIncrement(), updatedValue.getAddress());
                statement.setString(counter.getValue(), updatedValue.getName());
                return statement.executeUpdate() > 0;
            } catch (final SQLException e) {
                TableUtilities.logSQLException(this, e);
                return false;
            }
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean delete(final String primaryKey) {
        final String query1 = "DELETE FROM " + Constants.ASSOCIATIONS + Constants.WHERE + NAME
                + Constants.QUESTION_MARK;
        final String query2 = "DELETE FROM " + Constants.MANUFACTURERS + Constants.WHERE + NAME
                + Constants.QUESTION_MARK;
        if (checkTableNameIsAssociations()) {
            return TableUtilities.deleteOperation(query1, primaryKey, this.connection, this);
        } else {
            return TableUtilities.deleteOperation(query2, primaryKey, this.connection, this);
        }
    }

}
