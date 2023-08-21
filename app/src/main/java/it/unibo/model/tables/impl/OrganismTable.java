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

import it.unibo.common.Constants;
import it.unibo.common.Counter;
import it.unibo.connection.ConnectionProvider;
import it.unibo.model.entities.Expedition;
import it.unibo.model.entities.impl.Organism;
import it.unibo.model.tables.TableUtilities;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link Organism} entity.
 */
public class OrganismTable implements Table<Organism, String> {

    private static final String TABLE_NAME = Constants.ORGANISMS;
    private static final String ID = "ID";
    private static final String SPECIES = "Specie";
    private static final String TEMPORARY_NAME = "NomeProvvisorio";
    private static final String COMMON_NAME = "NomeComune";
    private static final String DESCRIPTION = "Descrizione";

    private final Connection connection;

    /**
     * Creates an instance of {@code OrganismTable}.
     * 
     * @param provider the provider of the connection to the database the connection
     *                 to the database
     */
    public OrganismTable(final ConnectionProvider provider) {
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
    public Optional<Organism> findByPrimaryKey(final String primaryKey) {
        final String query = Constants.SELECT_ALL + TABLE_NAME + Constants.WHERE + ID + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readOrganismsFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the organisms in it and collects them in a List.
     * 
     * @param resultSet a ResultSet from which the organisms will be extracted
     * @return a List of all the organisms in the ResultSet
     * @throws SQLException
     */
    private List<Organism> readOrganismsFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<Organism> organisms = new ArrayList<>();
        while (resultSet.next()) {
            organisms.add(new Organism(
                    resultSet.getString(ID),
                    Optional.ofNullable(resultSet.getString(SPECIES)),
                    Optional.ofNullable(resultSet.getString(TEMPORARY_NAME)),
                    Optional.ofNullable(resultSet.getString(COMMON_NAME)),
                    resultSet.getString(DESCRIPTION)));
        }
        return organisms;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Organism> findAll() {
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery(Constants.SELECT_ALL + TABLE_NAME);
            return readOrganismsFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Collections.emptyList();
        }
    }

    /**
     * Retrieves all {@link Organism}s that have been sighted during a certain
     * {@link Expedition}.
     * 
     * @param expeditionCode the code of the expedition
     * @return a List of all the organisms, or an empty List if no organisms have
     *         been sighted during the expedition or something went wrong
     */
    public List<Organism> filterByExpedition(final String expeditionCode) {
        final String query = "SELECT " + ID + ", " + SPECIES + ", " + TEMPORARY_NAME + ", " + COMMON_NAME
                + ", " + DESCRIPTION + " FROM " + TABLE_NAME + ", " + Constants.SIGHTINGS
                + Constants.WHERE + Constants.SIGHTINGS + ".CodiceSpedizione" + Constants.QUESTION_MARK
                + Constants.AND + Constants.SIGHTINGS + ".IDorganismo" + Constants.EQUALS + TABLE_NAME + "." + ID;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, expeditionCode);
            final ResultSet resultSet = statement.executeQuery();
            return readOrganismsFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Organism value) {
        final String query = "INSERT INTO " + TABLE_NAME + "("
                + ID + ", " + SPECIES + ", " + TEMPORARY_NAME + ", " + COMMON_NAME + ", " + DESCRIPTION
                + ") VALUES (?,?,?,?,?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), value.getID());
            if (value.getSpecies().isPresent()) {
                statement.setString(counter.getValueAndIncrement(), value.getSpecies().get());
            } else {
                statement.setNull(counter.getValueAndIncrement(), java.sql.Types.CHAR);
            }
            if (value.getTemporaryName().isPresent()) {
                statement.setString(counter.getValueAndIncrement(), value.getTemporaryName().get());
            } else {
                statement.setNull(counter.getValueAndIncrement(), java.sql.Types.CHAR);
            }
            if (value.getCommonName().isPresent()) {
                statement.setString(counter.getValueAndIncrement(), value.getCommonName().get());
            } else {
                statement.setNull(counter.getValueAndIncrement(), java.sql.Types.CHAR);
            }
            statement.setString(counter.getValue(), value.getDescription());
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
    public boolean update(final Organism updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + SPECIES + Constants.QUESTION_MARK + ", "
                + TEMPORARY_NAME + Constants.QUESTION_MARK + ", "
                + COMMON_NAME + Constants.QUESTION_MARK + ", "
                + DESCRIPTION + Constants.QUESTION_MARK
                + Constants.WHERE + ID + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter ct = new Counter(1);
            statement.setString(ct.getValueAndIncrement(), updatedValue.getSpecies().orElse(null));
            statement.setString(ct.getValueAndIncrement(), updatedValue.getTemporaryName().orElse(null));
            statement.setString(ct.getValueAndIncrement(), updatedValue.getCommonName().orElse(null));
            statement.setString(ct.getValueAndIncrement(), updatedValue.getDescription());
            statement.setString(ct.getValue(), updatedValue.getID());
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
