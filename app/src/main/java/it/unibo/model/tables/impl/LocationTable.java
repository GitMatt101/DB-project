package it.unibo.model.tables.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

import it.unibo.common.Constants;
import it.unibo.model.entities.Location;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link Location} entity.
 */
public class LocationTable implements Table<Location, String> {

    private static final String TABLE_NAME = "luoghi";
    private static final String NAME = "Nome";
    private static final String COUNTRY_NAME = "NomePaese";
    private static final String PREPARE_FIELD = " = ?";

    private final Connection connection;

    /**
     * Creates an instance of {@code LocationTable}.
     * 
     * @param connection
     */
    public LocationTable(final Connection connection) {
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
     * Retrieves the name of the primary key of the table.
     * 
     * @return the name of the attribute
     */
    public String getName() {
        return NAME;
    }

    /**
     * Retrieves the name of the attribute that is the foreign key of the table.
     * 
     * @return the name of the attribute
     */
    public String getCountryName() {
        return COUNTRY_NAME;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public Optional<Location> findByPrimaryKey(final String primaryKey) {
        final String query = "SELECT * FROM " + TABLE_NAME + " WHERE " + NAME + " = ?";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readLocationsFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            Logger.getLogger(LocationTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the locations in it and collects them in a List.
     * 
     * @param resultSet a ResultSet from which the Organism(s) will be extracted
     * @return a List of all the locations in the ResultSet
     * @throws SQLException
     */
    private List<Location> readLocationsFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<Location> locations = new ArrayList<>();
        while (resultSet.next()) {
            final Location location = new Location(
                    resultSet.getString(NAME),
                    Optional.ofNullable(resultSet.getString(COUNTRY_NAME)));
            locations.add(location);
        }
        return locations;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Location> findAll() {
        final String query = "SELECT * FROM " + TABLE_NAME;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final ResultSet resultSet = statement.executeQuery();
            return readLocationsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(LocationTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return new ArrayList<>();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Location value) {
        final String query = "INSERT INTO " + TABLE_NAME + " VALUES (?, ?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, value.getName());
            statement.setString(2, value.getCountryName().orElse(null));
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(LocationTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean update(final Location updatedValue) {
        // We are going to assume that a contry will never claim the property of a
        // location
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
            Logger.getLogger(LocationTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
