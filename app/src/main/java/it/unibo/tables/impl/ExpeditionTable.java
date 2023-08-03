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
import it.unibo.entities.Expedition;
import it.unibo.tables.api.Table;

/**
 * MySQL table for {@link Expedition} entity.
 */
public class ExpeditionTable implements Table<Expedition, String> {

    private static final String TABLE_NAME = "spedizione";
    private static final String CODE = "Codice";
    private static final String DATE = "Data";
    private static final String LOCATION = "NomeLuogo";
    private static final String ROV = "TargaROV";
    private static final String ASSOCIATION = "NomeAssociazione";
    private static final String GROUP = "IDgruppo";
    private static final String PREPARE_FIELD = " = ?";

    private final Connection connection;

    /**
     * Creates an instance of {@code ExpeditionTable}.
     * 
     * @param connection the connection to the database
     */
    public ExpeditionTable(final Connection connection) {
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
    public Optional<Expedition> findByPrimaryKey(final String primaryKey) {
        final String query = "SELECT * FROM " + TABLE_NAME + " WHERE " + CODE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readExpeditionsFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            Logger.getLogger(ExpeditionTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the expeditions in it and collects them in a List.
     * 
     * @param resultSet a ResultSet from which the expeditions will be extracted
     * @return a List of all the expeditions in the ResultSet
     * @throws SQLException
     */
    private List<Expedition> readExpeditionsFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<Expedition> expeditions = new ArrayList<>();
        while (resultSet.next()) {
            final Expedition expedition = new Expedition(
                    resultSet.getString(CODE),
                    resultSet.getDate(DATE),
                    resultSet.getString(LOCATION),
                    resultSet.getString(ROV),
                    resultSet.getString(ASSOCIATION),
                    resultSet.getString(GROUP));
            expeditions.add(expedition);
        }
        return expeditions;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Expedition> findAll() {
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery("SELECT * FROM " + TABLE_NAME);
            return readExpeditionsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(ExpeditionTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Expedition value) {
        final String query = "INSERT INTO " + TABLE_NAME + " ("
                + CODE + ", " + DATE + ", " + LOCATION + ", " + ROV + ", " + ASSOCIATION + ", " + GROUP
                + ") VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, value.getCode());
            statement.setDate(2, new java.sql.Date(value.getDate().getTime()));
            statement.setString(3, value.getLocationName());
            statement.setString(4, value.getROVLicencePlate());
            statement.setString(5, value.getLocationName());
            statement.setString(6, value.getGroupID());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(ExpeditionTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean update(final Expedition updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + DATE + PREPARE_FIELD + ", "
                + LOCATION + PREPARE_FIELD + ", "
                + ROV + PREPARE_FIELD + ", "
                + ASSOCIATION + PREPARE_FIELD + ", "
                + GROUP + PREPARE_FIELD
                + " WHERE " + CODE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setDate(1, new java.sql.Date(updatedValue.getDate().getTime()));
            statement.setString(2, updatedValue.getLocationName());
            statement.setString(3, updatedValue.getROVLicencePlate());
            statement.setString(4, updatedValue.getLocationName());
            statement.setString(5, updatedValue.getGroupID());
            statement.setString(6, updatedValue.getCode());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(ExpeditionTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean delete(final String primaryKey) {
        final String query = "DELETE FROM " + TABLE_NAME + " WHERE " + CODE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(ExpeditionTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
