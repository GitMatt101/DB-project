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
import it.unibo.model.entities.impl.Organism;
import it.unibo.model.entities.impl.Sighting;
import it.unibo.model.tables.TableUtilities;
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
     * @param provider the provider of the connection to the database the connection
     *                 to the database
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
        final String query = Constants.SELECT_ALL + TABLE_NAME + Constants.WHERE + CODE + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readSightingsFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
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
            final ResultSet resultSet = statement.executeQuery(Constants.SELECT_ALL + TABLE_NAME);
            return readSightingsFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Collections.emptyList();
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
        final String query = Constants.SELECT_ALL + TABLE_NAME + Constants.WHERE + ORGANISM + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, organismID);
            final ResultSet resultSet = statement.executeQuery();
            return readSightingsFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
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
        final StringBuilder queryBuilder = new StringBuilder(1000);
        locationName.ifPresent(l -> {
            queryBuilder.append(appendToQuery(queryBuilder.toString()));
            queryBuilder.append(EXPEDITION + Constants.EQUALS + Constants.EXPEDITIONS + "." + CODE
                    + Constants.AND + Constants.EXPEDITIONS + ".NomeLuogo" + Constants.QUESTION_MARK);
        });
        minDepth.ifPresent(m -> {
            queryBuilder.append(appendToQuery(queryBuilder.toString()));
            queryBuilder.append(DEPTH + " >= ?");
        });
        maxDepth.ifPresent(m -> {
            queryBuilder.append(appendToQuery(queryBuilder.toString()));
            queryBuilder.append(DEPTH + " <= ?");
        });
        expeditionCode.ifPresent(e -> {
            queryBuilder.append(appendToQuery(queryBuilder.toString()));
            queryBuilder.append(EXPEDITION + Constants.QUESTION_MARK);
        });
        organismID.ifPresentOrElse(o -> {
            queryBuilder.append(appendToQuery(queryBuilder.toString()));
            queryBuilder.append(ORGANISM + Constants.QUESTION_MARK);
        }, () -> {
            wreckID.ifPresentOrElse(w -> {
                queryBuilder.append(appendToQuery(queryBuilder.toString()));
                queryBuilder.append(WRECK + Constants.QUESTION_MARK);
            }, () -> {
                geologicalFormationID.ifPresent(g -> {
                    queryBuilder.append(appendToQuery(queryBuilder.toString()));
                    queryBuilder.append(GEOLOGICAL_FORMATION + Constants.QUESTION_MARK);
                });
            });
        });
        final String query = "SELECT " + TABLE_NAME + ".Codice, " + EXPEDITION + ", " + NUMBER + ", " + DEPTH
                + ", " + NOTES + ", " + ORGANISM + ", " + WRECK + ", " + GEOLOGICAL_FORMATION
                + " FROM " + TABLE_NAME + "," + Constants.EXPEDITIONS + queryBuilder.toString();
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            int c = 1;
            if (locationName.isPresent()) {
                statement.setString(c, locationName.get());
                c++;
            }
            if (minDepth.isPresent()) {
                statement.setInt(c, minDepth.get());
                c++;
            }
            if (maxDepth.isPresent()) {
                statement.setInt(c, maxDepth.get());
                c++;
            }
            if (expeditionCode.isPresent()) {
                statement.setString(c, expeditionCode.get());
                c++;
            }
            if (organismID.isPresent()) {
                statement.setString(c, organismID.get());
            } else if (wreckID.isPresent()) {
                statement.setString(c, wreckID.get());
            } else if (geologicalFormationID.isPresent()) {
                statement.setString(c, geologicalFormationID.get());
            }
            final ResultSet resultSet = statement.executeQuery();
            return readSightingsFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
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
            TableUtilities.logSQLException(this, e);
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
            TableUtilities.logSQLException(this, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean delete(final String primaryKey) {
        final String query = "DELETE FROM " + TABLE_NAME + Constants.WHERE + CODE + Constants.QUESTION_MARK;
        return TableUtilities.deleteOperation(query, primaryKey, this.connection, this);
    }

}
