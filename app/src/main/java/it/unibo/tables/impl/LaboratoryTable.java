package it.unibo.tables.impl;

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
import it.unibo.entities.Laboratory;
import it.unibo.tables.api.Table;

/**
 * MySQL table for {@link Laboratory} entity.
 */
public class LaboratoryTable implements Table<Laboratory, String> {

    private static final String TABLE_NAME = "laboratorio";
    private static final String ID = "ID";
    private static final String NAME = "Nome";
    private static final String ADDRESS = "Indirizzo";
    private static final String PREPARE_FIELD = " = ?";

    private final Connection connection;

    /**
     * Creates an instance of {@code LaboratoryTable}.
     * 
     * @param connection
     */
    public LaboratoryTable(final Connection connection) {
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
    public Optional<Laboratory> findByPrimaryKey(final String primaryKey) {
        final String query = "SELECT * FROM " + TABLE_NAME + " WHERE " + ID + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readLaboratoriesFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            Logger.getLogger(LaboratoryTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the laboratories in it and collects them in a List.
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
            final ResultSet resultSet = statement.executeQuery("SELECT * FROM " + TABLE_NAME);
            return readLaboratoriesFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(LaboratoryTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
            statement.setString(1, value.getID());
            statement.setString(2, value.getName());
            statement.setString(3, value.getAddress());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(LaboratoryTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean update(final Laboratory updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + NAME + PREPARE_FIELD + ", "
                + ADDRESS + PREPARE_FIELD
                + " WHERE " + ID + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, updatedValue.getName());
            statement.setString(2, updatedValue.getAddress());
            statement.setString(3, updatedValue.getID());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(LaboratoryTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
            Logger.getLogger(LaboratoryTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
