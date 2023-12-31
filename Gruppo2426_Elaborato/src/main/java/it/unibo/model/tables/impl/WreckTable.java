package it.unibo.model.tables.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import it.unibo.common.ConnectionProvider;
import it.unibo.common.Constants;
import it.unibo.common.Counter;
import it.unibo.model.entities.impl.Wreck;
import it.unibo.model.tables.TableUtilities;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link Wreck} entity.
 */
public class WreckTable implements Table<Wreck, String> {

    private static final String TABLE_NAME = "relitti";
    private static final String ID = "ID";
    private static final String NAME = "Nome";
    private static final String WRECKAGE_DATE = "AnnoAffondamento";
    private static final String SIZE = "Dimensioni";
    private static final String DESCRIPTION = "Descrizione";

    private final Connection connection;

    /**
     * Creates an instance of {@code WreckTable}.
     * 
     * @param provider the provider of the connection to the database the connection
     *                 to the database
     */
    public WreckTable(final ConnectionProvider provider) {
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
    public Optional<Wreck> findByPrimaryKey(final String primaryKey) {
        final String query = Constants.SELECT_ALL + TABLE_NAME + Constants.WHERE + ID + " = ?";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readWrecksFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the wrecks in it and collects them in a List.
     * 
     * @param resultSet a ResultSet from which the wrecks will be extracted
     * @return a List of all the wrecks in the ResultSet
     */
    private List<Wreck> readWrecksFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<Wreck> wrecks = new LinkedList<>();
        while (resultSet.next()) {
            wrecks.add(new Wreck(resultSet.getString(ID),
                    Optional.ofNullable(resultSet.getString(NAME)),
                    Optional.ofNullable(resultSet.getInt(WRECKAGE_DATE)),
                    resultSet.getInt(SIZE),
                    resultSet.getString(DESCRIPTION)));
        }
        return wrecks;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Wreck> findAll() {
        try (PreparedStatement statement = this.connection.prepareStatement(Constants.SELECT_ALL + TABLE_NAME)) {
            final ResultSet resultSet = statement.executeQuery();
            return readWrecksFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Collections.emptyList();
        }
    }

    /**
     * Given a name, returns all the wrecks with that name.
     * 
     * @param wreckName the name of the wrecks to find
     * @return a List of all the wrecks with the given name
     */
    public List<Wreck> filterByName(final String wreckName) {
        final String query = Constants.SELECT_ALL + TABLE_NAME + Constants.WHERE + NAME + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, wreckName);
            final ResultSet resultSet = statement.executeQuery();
            return readWrecksFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Wreck value) {
        final String query = "INSERT INTO " + TABLE_NAME + " ("
                + ID + ", " + NAME + ", " + WRECKAGE_DATE + ", " + SIZE + ", " + DESCRIPTION
                + ") VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), value.getID());
            if (value.getName().isPresent()) {
                statement.setString(counter.getValueAndIncrement(), value.getName().get());
            } else {
                statement.setNull(counter.getValueAndIncrement(), java.sql.Types.CHAR);
            }
            if (value.getWreckageDate().isPresent()) {
                statement.setInt(counter.getValueAndIncrement(), value.getWreckageDate().get());
            } else {
                statement.setNull(counter.getValueAndIncrement(), java.sql.Types.DATE);
            }
            statement.setInt(counter.getValueAndIncrement(), value.getLength());
            statement.setString(counter.getValueAndIncrement(), value.getDescription());
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
    public boolean update(final Wreck updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + NAME + Constants.QUESTION_MARK + ", "
                + WRECKAGE_DATE + Constants.QUESTION_MARK + ", "
                + SIZE + Constants.QUESTION_MARK + ", "
                + DESCRIPTION + Constants.QUESTION_MARK
                + Constants.WHERE + ID + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            if (updatedValue.getName().isPresent()) {
                statement.setString(counter.getValueAndIncrement(), updatedValue.getName().get());
            } else {
                statement.setNull(counter.getValueAndIncrement(), java.sql.Types.CHAR);
            }
            if (updatedValue.getWreckageDate().isPresent()) {
                statement.setInt(counter.getValueAndIncrement(), updatedValue.getWreckageDate().get());
            } else {
                statement.setNull(counter.getValueAndIncrement(), java.sql.Types.SMALLINT);
            }
            statement.setInt(counter.getValueAndIncrement(), updatedValue.getLength());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getDescription());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getID());
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
        final String query = "DELETE FROM " + TABLE_NAME + Constants.WHERE + ID + Constants.QUESTION_MARK;
        return TableUtilities.deleteOperation(query, primaryKey, this.connection, this);
    }

}
