package it.unibo.model.tables.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

import it.unibo.common.Constants;
import it.unibo.model.entities.Country;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link Country} entity.
 */
public class CountryTable implements Table<Country, String> {

    private static final String TABLE_NAME = "paese";

    private static final String NAME = "Nome";
    private static final String PREPARE_FIELD = " = ?";

    private final Connection connection;

    /**
     * Creates an instance of {@code CountryTable}.
     * 
     * @param connection
     */
    public CountryTable(final Connection connection) {
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
    public Optional<Country> findByPrimaryKey(final String primaryKey) {
        final String query = "SELECT * FROM " + TABLE_NAME + " WHERE " + NAME + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readCountriesFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            Logger.getLogger(CountryTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
        final String query = "SELECT * FROM " + TABLE_NAME;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final ResultSet resultSet = statement.executeQuery();
            return readCountriesFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(CountryTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
            statement.setString(1, value.getName());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(CountryTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
        final String query = "DELETE FROM " + TABLE_NAME + " WHERE " + NAME + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(CountryTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
