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

import it.unibo.common.ConnectionProvider;
import it.unibo.common.Constants;
import it.unibo.common.Counter;
import it.unibo.model.entities.impl.Member;
import it.unibo.model.tables.TableUtilities;
import it.unibo.model.tables.api.Table;

/**
 * This class models the table of the {@link Member}.
 */
public class MemberTable implements Table<Member, String> {

    private static final String TABLE_NAME = Constants.MEMBERS;
    private static final String FIRST_NAME = "Nome";
    private static final String LAST_NAME = "Cognome";
    private static final String FISCAL_CODE = "CodiceFiscale";
    private static final String ASSOCIATION = "NomeAssociazione";
    private static final String GROUP = "IDgruppo";
    private static final String ID = "ID";
    private static final String ROLE = "Ruolo";

    private final Connection connection;

    /**
     * Creates an instance of {@code OrganismTable}.
     * 
     * @param provider the provider of the connection to the database the connection
     *                 to the database
     */
    public MemberTable(final ConnectionProvider provider) {
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
    public Optional<Member> findByPrimaryKey(final String primaryKey) {
        final String query = Constants.SELECT_ALL + TABLE_NAME + Constants.WHERE + FISCAL_CODE + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readOperatorsFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
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
            final ResultSet resultSet = statement.executeQuery(Constants.SELECT_ALL + TABLE_NAME);
            return readOperatorsFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
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
        final String query = Constants.SELECT_ALL + TABLE_NAME
                + Constants.WHERE + ASSOCIATION + Constants.QUESTION_MARK + " AND " + GROUP + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), associationName);
            statement.setString(counter.getValue(), groupID);
            final ResultSet resultSet = statement.executeQuery();
            return readOperatorsFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
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
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), value.getFirstName());
            statement.setString(counter.getValueAndIncrement(), value.getLastName());
            statement.setString(counter.getValueAndIncrement(), value.getFiscalCode());
            statement.setString(counter.getValueAndIncrement(), value.getAssociationName());
            statement.setString(counter.getValueAndIncrement(), value.getGroupID());
            statement.setString(counter.getValueAndIncrement(), value.getID());
            statement.setString(counter.getValue(), value.getRole());
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
    public boolean update(final Member updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + FIRST_NAME + Constants.QUESTION_MARK + ", "
                + LAST_NAME + Constants.QUESTION_MARK + ", "
                + ASSOCIATION + Constants.QUESTION_MARK + ", "
                + GROUP + Constants.QUESTION_MARK + ", "
                + ID + Constants.QUESTION_MARK
                + ROLE + Constants.QUESTION_MARK
                + Constants.WHERE + FISCAL_CODE + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), updatedValue.getFirstName());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getLastName());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getAssociationName());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getGroupID());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getID());
            statement.setString(counter.getValue(), updatedValue.getFiscalCode());
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
        final String query = "DELETE FROM " + TABLE_NAME + Constants.WHERE + FISCAL_CODE + Constants.QUESTION_MARK;
        return TableUtilities.deleteOperation(query, primaryKey, this.connection, this);
    }

}
