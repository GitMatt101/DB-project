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
import it.unibo.model.entities.impl.Operator;
import it.unibo.model.tables.api.Table;

/**
 * This class models the table of the {@link Operator}.
 */
public class OperatorTable implements Table<Operator, String> {

    private static final String TABLE_NAME = "operatore";
    private static final String FIRST_NAME = "Nome";
    private static final String LAST_NAME = "Cognome";
    private static final String FISCAL_CODE = "Codice_Fiscale";
    private static final String ASSOCIATION = "NomeAssociazione";
    private static final String GROUP = "IDgruppo";
    private static final String ID = "ID";
    private static final String PREPARE_FIELD = " = ?";

    private final Connection connection;

    /**
     * Creates an instance of {@code OrganismTable}.
     * 
     * @param connection the connection to the database
     */
    public OperatorTable(final Connection connection) {
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
    public Optional<Operator> findByPrimaryKey(final String primaryKey) {
        final String query = "SELECT * FROM " + TABLE_NAME + " WHERE " + FISCAL_CODE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readOperatorsFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            Logger.getLogger(OperatorTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the operators in it and collects them in a List.
     * 
     * @param resultSet a ResultSet from which the operators will be extracted
     * @return a List of all the operators in the ResultSet
     * @throws SQLException
     */
    private List<Operator> readOperatorsFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<Operator> operators = new ArrayList<>();
        while (resultSet.next()) {
            operators.add(new Operator(
                    resultSet.getString(FIRST_NAME),
                    resultSet.getString(LAST_NAME),
                    resultSet.getString(FISCAL_CODE),
                    resultSet.getString(ASSOCIATION),
                    resultSet.getString(GROUP),
                    resultSet.getString(ID)));
        }
        return operators;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Operator> findAll() {
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery("SELECT * FROM " + TABLE_NAME);
            return readOperatorsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(OperatorTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Collections.emptyList();
        }
    }

    public List<Operator> getExpeditionPartecipants(final String associationName, final String groupID) {
        final String query = "SELECT (" + FISCAL_CODE + ") FROM " + TABLE_NAME
                + " WHERE " + ASSOCIATION + "='" + associationName + "' AND " + GROUP + "='" + groupID + "'";
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery(query);
            return readOperatorsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(OperatorTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Operator value) {
        final String query = "INSERT INTO " + TABLE_NAME + " ("
                + FIRST_NAME + ", " + LAST_NAME + ", " + FISCAL_CODE + ", " + ASSOCIATION + ", " + GROUP + ", " + ID
                + ") VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, value.getFirstName());
            statement.setString(2, value.getLastName());
            statement.setString(3, value.getFiscalCode());
            statement.setString(4, value.getAssociationName());
            statement.setString(5, value.getGroupID());
            statement.setString(6, value.getID());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(OperatorTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean update(final Operator updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + FIRST_NAME + PREPARE_FIELD + ", "
                + LAST_NAME + PREPARE_FIELD + ", "
                + ASSOCIATION + PREPARE_FIELD + ", "
                + GROUP + PREPARE_FIELD + ", "
                + ID + PREPARE_FIELD
                + " WHERE " + FISCAL_CODE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, updatedValue.getFirstName());
            statement.setString(2, updatedValue.getLastName());
            statement.setString(3, updatedValue.getAssociationName());
            statement.setString(4, updatedValue.getGroupID());
            statement.setString(5, updatedValue.getID());
            statement.setString(6, updatedValue.getFiscalCode());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(OperatorTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean delete(final String primaryKey) {
        final String query = "DELETE FROM " + TABLE_NAME + " WHERE " + FISCAL_CODE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(OperatorTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
