package it.unibo.tables.impl;

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
import it.unibo.entities.ROV;
import it.unibo.tables.api.Table;

/**
 * MySQL table for {@link ROV} entity.
 */
public class ROVTable implements Table<ROV, String> {

    private static final String TABLE_NAME = "rov";
    private static final String LICENSE_PLATE = "Targa";
    private static final String SERIAL_NUMBER = "Numero_di_serie";
    private static final String MANUFACTURER = "NomeCasaProduttrice";
    private static final String DATE = "DataProduzione";
    private static final String PREPARE_FIELD = " = ?";

    private final Connection connection;

    /**
     * Creates an instance of {@code OrganismTable}.
     * 
     * @param connection the connection to the database
     */
    public ROVTable(final Connection connection) {
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
    public Optional<ROV> findByPrimaryKey(final String primaryKey) {
        final String query = "SELECT * FROM " + TABLE_NAME + " WHERE " + LICENSE_PLATE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readROVsFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            Logger.getLogger(ROVTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
        final String query = "SELECT * FROM " + TABLE_NAME;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final ResultSet resultSet = statement.executeQuery();
            return readROVsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(ROVTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
            statement.setString(1, value.getLicensePlate());
            statement.setString(2, value.getSerialNumber());
            statement.setString(3, value.getManufacturerName());
            statement.setDate(4, new java.sql.Date(value.getProductionDate().getTime()));
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(ROVTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean update(final ROV updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + SERIAL_NUMBER + PREPARE_FIELD + ", "
                + MANUFACTURER + PREPARE_FIELD + ", "
                + DATE + PREPARE_FIELD
                + " WHERE " + LICENSE_PLATE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, updatedValue.getSerialNumber());
            statement.setString(2, updatedValue.getManufacturerName());
            statement.setDate(3, new java.sql.Date(updatedValue.getProductionDate().getTime()));
            statement.setString(4, updatedValue.getLicensePlate());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(ROVTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean delete(final String primaryKey) {
        final String query = "DELETE FROM " + TABLE_NAME + " WHERE " + LICENSE_PLATE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(ROVTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
