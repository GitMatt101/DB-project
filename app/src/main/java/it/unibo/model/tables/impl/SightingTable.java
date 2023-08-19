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
import it.unibo.model.entities.Organism;
import it.unibo.model.entities.impl.Sighting;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link Sighting} entity.
 */
public class SightingTable implements Table<Sighting, String> {

    private static final String TABLE_NAME = "avvistamenti";
    private static final String CODE = "Codice";
    private static final String EXPEDITION = "CodiceSpedizione";
    private static final String NUMBER = "Numero";
    private static final String DEPTH = "Profondita";
    private static final String NOTES = "Note";
    private static final String ORGANISM = "IDorganismo";
    private static final String WRECK = "IDrelitto";
    private static final String GEOLOGICAL_FORMATION = "IDformazionegeologica";

    private final Connection connection;

    /**
     * Creates an instance of {@code AnalysisTable}.
     * 
     * @param provider the provider of the connection to the database the connection to the database
     */
    public SightingTable(final ConnectionProvider provider) {
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
     * Retrieves the name of the expedition code attribute according to the
     * database.
     * 
     * @return the name of the attribute
     */
    public String getExpeditionCodeName() {
        return EXPEDITION;
    }

    /**
     * Retrieves the name of the organism ID attribute according to the database.
     * 
     * @return the name of the attribute
     */
    public String getOrganismIDName() {
        return ORGANISM;
    }

    /**
     * Retrieves the name of the wreck ID attribute according to the database.
     * 
     * @return the name of the attribute
     */
    public String getWreckName() {
        return WRECK;
    }

    /**
     * Retrieves the name of the geological formation ID attribute according to the
     * database.
     * 
     * @return the name of the attribute
     */
    public String getGeologicalFormationName() {
        return GEOLOGICAL_FORMATION;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public Optional<Sighting> findByPrimaryKey(final String primaryKey) {
        final String query = "SELECT * FROM " + TABLE_NAME + Constants.WHERE + CODE + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readSightingsFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            Logger.getLogger(SightingTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the sightings in it and collects them in a List.
     * 
     * @param resultSet a ResultSet from which the sightings will be extracted
     * @return a List of all the sightings in the ResultSet
     * @throws SQLException
     */
    private List<Sighting> readSightingsFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<Sighting> sightings = new ArrayList<>();
        while (resultSet.next()) {
            sightings.add(new Sighting(
                    resultSet.getString(CODE),
                    resultSet.getString(EXPEDITION),
                    resultSet.getInt(NUMBER),
                    Optional.ofNullable(resultSet.getInt(DEPTH)),
                    Optional.ofNullable(resultSet.getString(NOTES)),
                    Optional.ofNullable(resultSet.getString(ORGANISM)),
                    Optional.ofNullable(resultSet.getString(WRECK)),
                    Optional.ofNullable(resultSet.getString(GEOLOGICAL_FORMATION))));
        }
        return sightings;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Sighting> findAll() {
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery("SELECT * FROM " + TABLE_NAME);
            return readSightingsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(SightingTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Collections.emptyList();
        }
    }

    /**
     * Retrieves the next number for a sighting in a given expedition.
     * 
     * @param expeditionCode the code of the expedition
     * @return the next number if everything went fine, -1 otherwise
     */
    public int getNextNumber(final String expeditionCode) {
        final String query = "SELECT MAX(" + NUMBER + ") FROM " + TABLE_NAME + Constants.WHERE + EXPEDITION
                + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, expeditionCode);
            final ResultSet resultSet = statement.executeQuery();
            return resultSet.next() ? resultSet.getInt(Constants.SINGLE_QUERY_VALUE_INDEX) + 1 : 1;
        } catch (final SQLException e) {
            Logger.getLogger(SightingTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return -1;
        }
    }

    /**
     * Retrieves all the sightings of an {@link Organism}.
     * 
     * @param organismID the ID of the organism
     * @return a list of {@link Sighting}, or an empty list if no sightings were
     *         found
     */
    public List<Sighting> filterByOrganism(final String organismID) {
        final String query = "SELECT * FROM " + TABLE_NAME + Constants.WHERE + ORGANISM + "='" + organismID + "'";
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery(query);
            return readSightingsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(SightingTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Collections.emptyList();
        }
    }

    /**
     * Method used to check if the next condition in a query is the first or not.
     * 
     * @param query the query
     * @return Constants.AND if the query already has other conditions,
     *         Constants.WHERE
     *         otherwise
     */
    private String appendToQuery(final String query) {
        return query.length() > 0 ? Constants.AND : Constants.WHERE;
    }

    /**
     * Applies some filters to retrieve {@link Sighting}s that match the
     * spcecified values.
     * 
     * @param locationName          the name of the location
     * @param minDepth              the minimum depth
     * @param maxDepth              the maximum depth
     * @param expeditionCode        the code of the expedition
     * @param organismID            the ID of the organism
     * @param wreckID               the ID of the wreck
     * @param geologicalFormationID the ID of the geological formation
     * @return a list of all the sightings, or an empty list if something went
     *         wrong
     */
    public List<Sighting> filter(final Optional<String> locationName, final Optional<Integer> minDepth,
            final Optional<Integer> maxDepth, final Optional<String> expeditionCode, final Optional<String> organismID,
            final Optional<String> wreckID, final Optional<String> geologicalFormationID) {
        final ExpeditionTable exp = new ExpeditionTable(null);
        final StringBuilder queryBuilder = new StringBuilder(1000);
        locationName.ifPresent(l -> {
            queryBuilder.append(appendToQuery(queryBuilder.toString()));
            queryBuilder.append(EXPEDITION + Constants.EQUALS + exp.getTableName() + "." + exp.getCodeName()
                    + Constants.AND + exp.getTableName() + "." + exp.getLocationName() + "='" + locationName.get()
                    + "'");
        });
        minDepth.ifPresent(m -> {
            queryBuilder.append(appendToQuery(queryBuilder.toString()));
            queryBuilder.append(DEPTH + " >= " + minDepth.get());
        });
        maxDepth.ifPresent(m -> {
            queryBuilder.append(appendToQuery(queryBuilder.toString()));
            queryBuilder.append(DEPTH + " <= " + maxDepth.get());
        });
        expeditionCode.ifPresent(e -> {
            queryBuilder.append(appendToQuery(queryBuilder.toString()));
            queryBuilder.append(EXPEDITION + Constants.EQUALS_GIVEN_STRING + expeditionCode.get() + "'");
        });
        if (organismID.isPresent()) {
            queryBuilder.append(appendToQuery(queryBuilder.toString()));
            queryBuilder.append(ORGANISM + Constants.EQUALS_GIVEN_STRING + organismID.get() + "'");
        } else if (wreckID.isPresent()) {
            queryBuilder.append(appendToQuery(queryBuilder.toString()));
            queryBuilder.append(WRECK + Constants.EQUALS_GIVEN_STRING + wreckID.get() + "'");
        } else if (geologicalFormationID.isPresent()) {
            queryBuilder.append(appendToQuery(queryBuilder.toString()));
            queryBuilder
                    .append(GEOLOGICAL_FORMATION + Constants.EQUALS_GIVEN_STRING + geologicalFormationID.get() + "'");
        }
        final String query = "SELECT " + TABLE_NAME + "." + CODE + ", " + EXPEDITION + ", " + NUMBER + ", " + DEPTH
                + ", " + NOTES + ", " + ORGANISM + ", " + WRECK + ", " + GEOLOGICAL_FORMATION
                + " FROM " + TABLE_NAME + ", "
                + exp.getTableName()
                + queryBuilder.toString();
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery(query);
            return readSightingsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(SightingTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Sighting value) {
        final String query = "INSERT INTO " + TABLE_NAME + " ("
                + CODE + ", " + EXPEDITION + ", " + NUMBER + ", " + DEPTH + ", " + NOTES + ", "
                + ORGANISM + ", " + WRECK + ", " + GEOLOGICAL_FORMATION + ")"
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), value.getCode());
            statement.setString(counter.getValueAndIncrement(), value.getExpeditionCode());
            statement.setInt(counter.getValueAndIncrement(), value.getNumber());
            if (value.getDepth().isEmpty()) {
                statement.setNull(counter.getValueAndIncrement(), java.sql.Types.INTEGER);
            } else {
                statement.setInt(counter.getValueAndIncrement(), value.getDepth().get());
            }
            if (value.getNotes().isEmpty()) {
                statement.setNull(counter.getValueAndIncrement(), java.sql.Types.NCHAR);
            } else {
                statement.setString(counter.getValueAndIncrement(), value.getNotes().get());
            }
            if (value.getOrganismID().isEmpty()) {
                statement.setNull(counter.getValueAndIncrement(), java.sql.Types.VARCHAR);
            } else {
                statement.setString(counter.getValueAndIncrement(), value.getOrganismID().get());
            }
            if (value.getWreckID().isEmpty()) {
                statement.setNull(counter.getValueAndIncrement(), java.sql.Types.VARCHAR);
            } else {
                statement.setString(counter.getValueAndIncrement(), value.getWreckID().get());
            }
            if (value.getGeologicalFormationID().isEmpty()) {
                statement.setNull(counter.getValue(), java.sql.Types.VARCHAR);
            } else {
                statement.setString(counter.getValue(), value.getGeologicalFormationID().get());
            }
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(SightingTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean update(final Sighting updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + DEPTH + " = ?, " + NOTES + " = ?, "
                + Constants.WHERE + CODE + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setInt(counter.getValueAndIncrement(), updatedValue.getDepth().orElse(null));
            statement.setString(counter.getValue(), updatedValue.getNotes().orElse(null));
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(SightingTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
            Logger.getLogger(SightingTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
