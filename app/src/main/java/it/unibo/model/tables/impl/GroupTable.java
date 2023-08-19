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
import it.unibo.common.Pair;
import it.unibo.connection.ConnectionProvider;
import it.unibo.model.entities.Group;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link Group} entity.
 */
public class GroupTable implements Table<Group, Pair<String, String>> {

    private static final String TABLE_NAME = "gruppi_di_esplorazione";
    private static final String ASSOCIATION = "NomeAssociazione";
    private static final String ID = "ID";
    private static final String NAME = "Nome";

    private final Connection connection;

    /**
     * Creates an instance of {@code OrganismTable}.
     * 
     * @param provider the provider of the connection to the database the connection to the database
     */
    public GroupTable(final ConnectionProvider provider) {
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
    public Optional<Group> findByPrimaryKey(final Pair<String, String> primaryKey) {
        final String query = "SELECT * FROM " + TABLE_NAME
                + Constants.WHERE + ASSOCIATION + Constants.QUESTION_MARK
                + Constants.AND + ID + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), primaryKey.getX());
            statement.setString(counter.getValue(), primaryKey.getY());
            final ResultSet resultSet = statement.executeQuery();
            return readGroupsFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            Logger.getLogger(GroupTable.class.getName()).log(Level.SEVERE, e.getMessage());
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the groups in it and collects them in a List.
     * 
     * @param resultSet a ResultSet from which the groups will be extracted
     * @return a List of all the groups in the ResultSet
     * @throws SQLException
     */
    private List<Group> readGroupsFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<Group> groups = new ArrayList<>();
        while (resultSet.next()) {
            groups.add(new Group(
                    resultSet.getString(ASSOCIATION),
                    resultSet.getString(ID),
                    resultSet.getString(NAME)));
        }
        return groups;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Group> findAll() {
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery("SELECT * FROM " + TABLE_NAME);
            return readGroupsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(GroupTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Group value) {
        final String query = "INSERT INTO " + TABLE_NAME + "("
                + ASSOCIATION + ", " + ID + ", " + NAME + ")"
                + " VALUES (?, ?, ?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), value.getAssociationName());
            statement.setString(counter.getValueAndIncrement(), value.getID());
            statement.setString(counter.getValue(), value.getName());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(OrganismTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean update(final Group updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + NAME + Constants.QUESTION_MARK
                + Constants.WHERE + ASSOCIATION + Constants.QUESTION_MARK
                + Constants.AND + ID + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), updatedValue.getName());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getAssociationName());
            statement.setString(counter.getValue(), updatedValue.getID());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(GroupTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean delete(final Pair<String, String> primaryKey) {
        final String query = "DELETE FROM " + TABLE_NAME
                + Constants.WHERE + ASSOCIATION + Constants.QUESTION_MARK
                + Constants.AND + ID + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), primaryKey.getX());
            statement.setString(counter.getValue(), primaryKey.getY());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(GroupTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
