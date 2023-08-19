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
import java.util.logging.Level;
import java.util.logging.Logger;

import it.unibo.common.Constants;
import it.unibo.common.Counter;
import it.unibo.connection.ConnectionProvider;
import it.unibo.model.entities.Expedition;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link Expedition} entity.
 */
public class ExpeditionTable implements Table<Expedition, String> {

    private static final String TABLE_NAME = "spedizioni";
    private static final String CODE = "Codice";
    private static final String DATE = "Data";
    private static final String LOCATION = "NomeLuogo";
    private static final String ROV = "TargaROV";
    private static final String ASSOCIATION = "NomeAssociazione";
    private static final String GROUP = "IDgruppo";

    private final Connection connection;

    /**
     * Creates an instance of {@code ExpeditionTable}.
     * 
     * @param provider the provider of the connection to the database the connection
     *                 to the database
     */
    public ExpeditionTable(final ConnectionProvider provider) {
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
     * Retrieves the name of the code attribute according to the database.
     * 
     * @return the name of the code
     */
    public String getCodeName() {
        return CODE;
    }

    /**
     * Retrieves the name of the location attribute according to the database.
     * 
     * @return the name of the location attribute
     */
    public String getLocationName() {
        return LOCATION;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public Optional<Expedition> findByPrimaryKey(final String primaryKey) {
        final String query = "SELECT * FROM " + TABLE_NAME + Constants.WHERE + CODE + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, primaryKey);
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
                    resultSet.getString(GROUP),
                    resultSet.getString(ASSOCIATION));
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
     * Retrieves all the expeditions that have been organized by a certain
     * association.
     * 
     * @param associationName the name of the association
     * @return a list of {@link Expedition}, or an empty list if no expeditions were
     *         found
     */
    public List<Expedition> filterByAssociation(final String associationName) {
        final String query = "SELECT * FROM " + TABLE_NAME + Constants.WHERE + ASSOCIATION
                + Constants.EQUALS_GIVEN_STRING + associationName + "'";
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery(query);
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
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), value.getCode());
            statement.setDate(counter.getValueAndIncrement(), new java.sql.Date(value.getDate().getTime()));
            statement.setString(counter.getValueAndIncrement(), value.getLocationName());
            statement.setString(counter.getValueAndIncrement(), value.getROVLicencePlate());
            statement.setString(counter.getValueAndIncrement(), value.getAssociationName());
            statement.setString(counter.getValue(), value.getGroupID());
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
                + DATE + Constants.QUESTION_MARK + ", "
                + LOCATION + Constants.QUESTION_MARK + ", "
                + ROV + Constants.QUESTION_MARK + ", "
                + ASSOCIATION + Constants.QUESTION_MARK + ", "
                + GROUP + Constants.QUESTION_MARK
                + Constants.WHERE + CODE + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setDate(counter.getValueAndIncrement(), new java.sql.Date(updatedValue.getDate().getTime()));
            statement.setString(counter.getValueAndIncrement(), updatedValue.getLocationName());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getROVLicencePlate());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getLocationName());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getGroupID());
            statement.setString(counter.getValue(), updatedValue.getCode());
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
        final String query = "DELETE FROM " + TABLE_NAME + Constants.WHERE + CODE + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, primaryKey);
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(ExpeditionTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
