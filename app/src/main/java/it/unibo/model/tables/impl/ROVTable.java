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
import it.unibo.model.entities.ROV;
import it.unibo.model.tables.TableUtilities;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link ROV} entity.
 */
public class ROVTable implements Table<ROV, String> {

    private static final String TABLE_NAME = "rov";
    private static final String LICENSE_PLATE = "Targa";
    private static final String SERIAL_NUMBER = "NumeroSerie";
    private static final String MANUFACTURER = "NomeCasaProduttrice";
    private static final String DATE = "DataProduzione";

    private final Connection connection;

    /**
     * Creates an instance of {@code OrganismTable}.
     * 
     * @param provider the provider of the connection to the database the connection
     *                 to the database
     */
    public ROVTable(final ConnectionProvider provider) {
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
    public Optional<ROV> findByPrimaryKey(final String primaryKey) {
        final String query = Constants.SELECT_ALL + TABLE_NAME + Constants.WHERE + LICENSE_PLATE
                + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readROVsFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the ROVs in it and collects them in a List.
     * 
     * @param resultSet a ResultSet from which the ROVs will be extracted
     * @return a List of all the ROVs in the ResultSet
     * @throws SQLException
     */
    private List<ROV> readROVsFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<ROV> rovs = new ArrayList<>();
        while (resultSet.next()) {
            rovs.add(new ROV(
                    resultSet.getString(LICENSE_PLATE),
                    resultSet.getString(SERIAL_NUMBER),
                    resultSet.getString(MANUFACTURER),
                    resultSet.getDate(DATE)));
        }
        return rovs;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<ROV> findAll() {
        final String query = Constants.SELECT_ALL + TABLE_NAME;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final ResultSet resultSet = statement.executeQuery();
            return readROVsFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final ROV value) {
        final String query = "INSERT INTO " + TABLE_NAME + " VALUES (?,?,?,?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), value.getLicensePlate());
            statement.setString(counter.getValueAndIncrement(), value.getSerialNumber());
            statement.setString(counter.getValueAndIncrement(), value.getManufacturerName());
            statement.setDate(counter.getValue(), new java.sql.Date(value.getProductionDate().getTime()));
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
    public boolean update(final ROV updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + SERIAL_NUMBER + Constants.QUESTION_MARK + ", "
                + MANUFACTURER + Constants.QUESTION_MARK + ", "
                + DATE + Constants.QUESTION_MARK
                + Constants.WHERE + LICENSE_PLATE + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), updatedValue.getSerialNumber());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getManufacturerName());
            statement.setDate(counter.getValueAndIncrement(),
                    new java.sql.Date(updatedValue.getProductionDate().getTime()));
            statement.setString(counter.getValue(), updatedValue.getLicensePlate());
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
        final String query = "DELETE FROM " + TABLE_NAME + Constants.WHERE + LICENSE_PLATE + Constants.QUESTION_MARK;
        return TableUtilities.deleteOperation(query, primaryKey, this.connection, this);
    }

}
