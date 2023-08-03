package it.unibo.tables.impl;

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
import it.unibo.entities.impl.Sighting;
import it.unibo.tables.api.Table;

/**
 * MySQL table for {@link Sighting} entity.
 */
public class SightingTable implements Table<Sighting, String> {

    private static final String TABLE_NAME = "avvistamento";
    private static final String CODE = "Codice";
    private static final String EXPEDITION = "CodiceSpedizione";
    private static final String NUMBER = "Numero";
    private static final String DEPTH = "Profondita";
    private static final String IMAGE = "Foto";
    private static final String NOTES = "Note";
    private static final String ORGANISM = "IDorganismo";
    private static final String WRECK = "IDrelitto";
    private static final String GEOLOGICAL_FORMATION = "NomeFormazioneGeologica";
    private static final String PREPARE_FIELD = " = ?";

    private final Connection connection;

    /**
     * Creates an instance of {@code AnalysisTable}.
     * 
     * @param connection the connection to the database
     */
    public SightingTable(final Connection connection) {
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
    public Optional<Sighting> findByPrimaryKey(final String primaryKey) {
        final String query = "SELECT * FROM " + TABLE_NAME + " WHERE " + CODE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
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
                    resultSet.getBlob(IMAGE),
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
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Sighting value) {
        final String query = "INSERT INTO " + TABLE_NAME + " ("
                + CODE + ", " + EXPEDITION + ", " + NUMBER + ", " + DEPTH + ", " + IMAGE + ", " + NOTES + ", "
                + ORGANISM + ", " + WRECK + ", " + GEOLOGICAL_FORMATION + ")"
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, value.getCode());
            statement.setString(2, value.getExpeditionCode());
            statement.setInt(3, value.getNumber());
            statement.setInt(4, value.getDepth().orElse(null));
            statement.setBlob(5, value.getImage());
            statement.setString(6, value.getNotes().orElse(null));
            statement.setString(7, value.getOrganismID().orElse(null));
            statement.setString(8, value.getWreckID().orElse(null));
            statement.setString(9, value.getGeologicalFormationName().orElse(null));
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
                + DEPTH + " = ?, " + IMAGE + " = ?, " + NOTES + " = ?, "
                + " WHERE " + CODE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setInt(1, updatedValue.getDepth().orElse(null));
            statement.setBlob(2, updatedValue.getImage());
            statement.setString(3, updatedValue.getNotes().orElse(null));
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
        final String query = "DELETE FROM " + TABLE_NAME + " WHERE " + CODE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(SightingTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
