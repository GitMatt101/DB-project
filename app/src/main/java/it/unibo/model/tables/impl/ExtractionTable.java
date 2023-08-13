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
import it.unibo.model.entities.impl.Extraction;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link Extraction} entity.
 */
public class ExtractionTable implements Table<Extraction, String> {

    private static final String TABLE_NAME = "prelievo";
    private static final String CODE = "Codice";
    private static final String EXPEDITION = "CodiceSpedizione";
    private static final String NUMBER = "Numero";
    private static final String MATERIAL = "NomeMateriale";
    private static final String DEPTH = "Profondita";
    private static final String AMOUNT = "Quantita";
    private static final String NOTES = "Note";
    private static final String PREPARE_FIELD = " = ?";

    private final Connection connection;

    /**
     * Creates an instance of {@code AnalysisTable}.
     * 
     * @param connection the connection to the database
     */
    public ExtractionTable(final Connection connection) {
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
    public Optional<Extraction> findByPrimaryKey(final String primaryKey) {
        final String query = "SELECT * FROM " + TABLE_NAME + " WHERE " + CODE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readExtractionsFromResultSet(resultSet).stream().findFirst();
        } catch (SQLException e) {
            Logger.getLogger(ExtractionTable.class.getName()).log(Level.SEVERE, e.getMessage());
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the extractions in it and collects them in a List.
     * 
     * @param resultSet a ResultSet from which the extractions will be extracted
     * @return a List of all the extractions in the ResultSet
     * @throws SQLException
     */
    private List<Extraction> readExtractionsFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<Extraction> extractions = new ArrayList<>();
        while (resultSet.next()) {
            extractions.add(new Extraction(
                    resultSet.getString(CODE),
                    resultSet.getString(EXPEDITION),
                    resultSet.getInt(NUMBER),
                    resultSet.getString(MATERIAL),
                    Optional.ofNullable(resultSet.getInt(DEPTH)),
                    resultSet.getFloat(AMOUNT),
                    Optional.ofNullable(resultSet.getString(NOTES))));
        }
        return extractions;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Extraction> findAll() {
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery("SELECT * FROM " + TABLE_NAME);
            return readExtractionsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(ExtractionTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Collections.emptyList();
        }
    }

    /**
     * Retrieves the next number for an extraction in a given expedition.
     * 
     * @param expeditionCode the code of the expedition
     * @return the next number if everything went fine, -1 otherwise
     */
    public int getNextNumber(final String expeditionCode) {
        final String query = "SELECT MAX(" + NUMBER + ") FROM " + TABLE_NAME + " WHERE " + EXPEDITION + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, expeditionCode);
            final ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1) + 1;
            }
            return -1;
        } catch (final SQLException e) {
            Logger.getLogger(ExtractionTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return -1;
        }
    }

    /**
     * Retrieves all the extractions of a material.
     * 
     * @param materialName the name of the material
     * @return a list of all the extractions, or an empty list if something went
     *         wrong
     */
    public List<Extraction> filterByMaterial(final String materialName) {
        final String query = "SELECT * FROM " + TABLE_NAME + " WHERE " + MATERIAL + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, materialName);
            final ResultSet resultSet = statement.executeQuery();
            return readExtractionsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(ExtractionTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Collections.emptyList();
        }
    }

    private String appendToQuery(final String query) {
        return query.length() > 0 ? " AND " : " WHERE ";
    }

    public List<Extraction> filter(final Optional<String> locationName,
            final Optional<Integer> minDepth, final Optional<Integer> maxDepth,
            final Optional<String> expeditionCode, final Optional<String> materialName) {
        final ExpeditionTable exp = new ExpeditionTable(null);
        final StringBuilder queryBuilder = new StringBuilder(1000);
        locationName.ifPresent(l -> {
            queryBuilder.append(appendToQuery(queryBuilder.toString()));
            queryBuilder.append(EXPEDITION + " = " + exp.getTableName() + "." + exp.getCodeName()
                    + " AND " + exp.getTableName() + "." + exp.getLocationName() + "='" + locationName.get() + "'");
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
            queryBuilder.append(EXPEDITION + " = '" + expeditionCode.get() + "'");
        });
        materialName.ifPresent(m -> {
            queryBuilder.append(appendToQuery(queryBuilder.toString()));
            queryBuilder.append(MATERIAL + " = '" + materialName.get() + "'");
        });
        final String query = "SELECT " + TABLE_NAME + "." + CODE + "," + EXPEDITION + "," + NUMBER + "," + MATERIAL + "," + DEPTH + ","
                + AMOUNT + "," + NOTES + " FROM " + TABLE_NAME + "," + exp.getTableName() + queryBuilder.toString();
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery(query);
            return readExtractionsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(SightingTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Extraction value) {
        final String query = "INSERT INTO " + TABLE_NAME + "("
                + CODE + ", " + EXPEDITION + ", " + NUMBER + ", " + MATERIAL + ", " + DEPTH + ", " + AMOUNT + ", "
                + NOTES
                + ") VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, value.getCode());
            statement.setString(2, value.getExpeditionCode());
            statement.setInt(3, value.getNumber());
            statement.setString(4, value.getMaterialName());
            statement.setInt(5, value.getDepth().orElse(null));
            statement.setFloat(6, value.getAmount());
            statement.setString(7, value.getNotes().orElse(null));
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(ExtractionTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean update(final Extraction updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + EXPEDITION + PREPARE_FIELD + ", "
                + NUMBER + PREPARE_FIELD + ", "
                + MATERIAL + PREPARE_FIELD + ", "
                + DEPTH + PREPARE_FIELD + ", "
                + AMOUNT + PREPARE_FIELD + ", "
                + NOTES + PREPARE_FIELD
                + " WHERE " + CODE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, updatedValue.getExpeditionCode());
            statement.setInt(2, updatedValue.getNumber());
            statement.setString(3, updatedValue.getMaterialName());
            statement.setInt(4, updatedValue.getDepth().orElse(null));
            statement.setFloat(5, updatedValue.getAmount());
            statement.setString(6, updatedValue.getNotes().orElse(null));
            statement.setString(7, updatedValue.getCode());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(ExtractionTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
            Logger.getLogger(ExtractionTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
