package it.unibo.model.tables.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import it.unibo.common.Constants;
import it.unibo.connection.ConnectionProvider;
import it.unibo.model.entities.Country;
import it.unibo.model.tables.TableUtilities;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link Country} entity.
 */
public class CountryTable implements Table<Country, String> {

    private static final String TABLE_NAME = "paesi";

    private static final String NAME = "Nome";

    private final Connection connection;

    /**
     * Creates an instance of {@code CountryTable}.
     * 
     * @param provider the provider of the connection to the database
     */
    public CountryTable(final ConnectionProvider provider) {
        this.connection = provider != null ? provider.getMySQLConnection() : null;
    }

    /**
     * Retrieves the name of the primary key of the table.
     * 
     * @return the name of the attribute
     */
    public String getName() {
        return NAME;
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
    public Optional<Country> findByPrimaryKey(final String primaryKey) {
        final String query = Constants.SELECT_ALL + TABLE_NAME + Constants.WHERE + NAME + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readCountriesFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the materials in it and collects them in a List.
     * 
     * @param resultSet a ResultSet from which the countries will be extracted
     * @return a List of all the countries in the ResultSet
     */
    private List<Country> readCountriesFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<Country> countries = List.of();
        while (resultSet.next()) {
            final Country country = new Country(resultSet.getString(NAME));
            countries.add(country);
        }
        return countries;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Country> findAll() {
        final String query = Constants.SELECT_ALL + TABLE_NAME;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final ResultSet resultSet = statement.executeQuery();
            return readCountriesFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Country value) {
        final String query = "INSERT INTO " + TABLE_NAME + " VALUES (?, ?, ?, ?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, value.getName());
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
    public boolean update(final Country updatedValue) {
        // Cannot update a table if its only attribute is its primary key
        return false;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean delete(final String primaryKey) {
        final String query = "DELETE FROM " + TABLE_NAME + Constants.WHERE + NAME + Constants.QUESTION_MARK;
        return TableUtilities.deleteOperation(query, primaryKey, this.connection, this);
    }

}
