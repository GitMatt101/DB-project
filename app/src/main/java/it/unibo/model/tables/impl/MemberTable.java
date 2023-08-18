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
import it.unibo.model.entities.impl.Member;
import it.unibo.model.tables.api.Table;

/**
 * This class models the table of the {@link Member}.
 */
public class MemberTable implements Table<Member, String> {

    private static final String TABLE_NAME = "membri";
    private static final String FIRST_NAME = "Nome";
    private static final String LAST_NAME = "Cognome";
    private static final String FISCAL_CODE = "CodiceFiscale";
    private static final String ASSOCIATION = "NomeAssociazione";
    private static final String GROUP = "IDgruppo";
    private static final String ID = "ID";
    private static final String ROLE = "Ruolo";
    private static final String PREPARE_FIELD = " = ?";

    private final Connection connection;

    /**
     * Creates an instance of {@code OrganismTable}.
     * 
     * @param connection the connection to the database
     */
    public MemberTable(final Connection connection) {
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
    public Optional<Member> findByPrimaryKey(final String primaryKey) {
        final String query = "SELECT * FROM " + TABLE_NAME + " WHERE " + FISCAL_CODE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readOperatorsFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            Logger.getLogger(MemberTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
    private List<Member> readOperatorsFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<Member> operators = new ArrayList<>();
        while (resultSet.next()) {
            operators.add(new Member(
                    resultSet.getString(FIRST_NAME),
                    resultSet.getString(LAST_NAME),
                    resultSet.getString(FISCAL_CODE),
                    resultSet.getString(ASSOCIATION),
                    resultSet.getString(GROUP),
                    resultSet.getString(ID),
                    resultSet.getString(ROLE)));
        }
        return operators;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Member> findAll() {
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery("SELECT * FROM " + TABLE_NAME);
            return readOperatorsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(MemberTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Collections.emptyList();
        }
    }

    /**
     * Retrieves all the {@link Member}s that have participated to a certain
     * expedition, knowing the association that organized it and the group that
     * participated.
     * 
     * @param associationName the name of the association
     * @param groupID         the ID of the group
     * @return a list of {@link Member}, or an empty list if no members were found
     */
    public List<Member> getExpeditionPartecipants(final String associationName, final String groupID) {
        final String query = "SELECT * FROM " + TABLE_NAME
                + " WHERE " + ASSOCIATION + "='" + associationName + "' AND " + GROUP + "='" + groupID + "'";
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery(query);
            return readOperatorsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(MemberTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Member value) {
        final String query = "INSERT INTO " + TABLE_NAME + " ("
                + FIRST_NAME + ", " + LAST_NAME + ", " + FISCAL_CODE + ", " + ASSOCIATION + ", " + GROUP + ", " + ID
                + ", " + ROLE
                + ") VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, value.getFirstName());
            statement.setString(2, value.getLastName());
            statement.setString(3, value.getFiscalCode());
            statement.setString(4, value.getAssociationName());
            statement.setString(5, value.getGroupID());
            statement.setString(6, value.getID());
            statement.setString(7, value.getRole());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(MemberTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean update(final Member updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + FIRST_NAME + PREPARE_FIELD + ", "
                + LAST_NAME + PREPARE_FIELD + ", "
                + ASSOCIATION + PREPARE_FIELD + ", "
                + GROUP + PREPARE_FIELD + ", "
                + ID + PREPARE_FIELD
                + ROLE + PREPARE_FIELD
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
            Logger.getLogger(MemberTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
            Logger.getLogger(MemberTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
