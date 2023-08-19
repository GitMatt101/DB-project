package it.unibo.model.tables.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

import it.unibo.common.Constants;
import it.unibo.connection.ConnectionProvider;
import it.unibo.model.entities.Wreck;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link Wreck} entity.
 */
public class WreckTable implements Table<Wreck, String> {

    private static final String TABLE_NAME = "relitti";
    private static final String ID = "ID";
    private static final String NAME = "Nome";
    private static final String WRECKAGE_DATE = "DataAffondamento";
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
        final String query = "SELECT * FROM " + TABLE_NAME + Constants.WHERE + ID + " = ?";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readWrecksFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            Logger.getLogger(WreckTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
        final List<Wreck> wrecks = List.of();
        while (resultSet.next()) {
            wrecks.add(new Wreck(resultSet.getString(ID),
                    Optional.ofNullable(resultSet.getString(NAME)),
                    Optional.ofNullable(resultSet.getDate(WRECKAGE_DATE)),
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
        try (PreparedStatement statement = this.connection.prepareStatement("SELECT * FROM " + TABLE_NAME)) {
            final ResultSet resultSet = statement.executeQuery();
            return readWrecksFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(WreckTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
        final String query = "SELECT * FROM " + TABLE_NAME + Constants.WHERE + NAME + "='" + wreckName + "'";
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery(query);
            return readWrecksFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(WreckTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
            statement.setString(1, value.getId());
            statement.setString(2, value.getName().orElse(null));
            if (value.getWreckageDate().isPresent()) {
                statement.setDate(3, new java.sql.Date(value.getWreckageDate().get().getTime()));
            } else {
                statement.setDate(3, null);
            }
            statement.setInt(4, value.getLength());
            statement.setString(4, value.getDescription());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(WreckTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
            statement.setString(1, updatedValue.getName().orElse(null));
            if (updatedValue.getWreckageDate().isPresent()) {
                statement.setDate(2, new java.sql.Date(updatedValue.getWreckageDate().get().getTime()));
            } else {
                statement.setDate(2, null);
            }
            statement.setInt(3, updatedValue.getLength());
            statement.setString(4, updatedValue.getDescription());
            statement.setString(5, updatedValue.getId());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(WreckTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean delete(final String primaryKey) {
        final String query = "DELETE FROM " + TABLE_NAME + Constants.WHERE + ID + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(WreckTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
