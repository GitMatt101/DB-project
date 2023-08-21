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
import it.unibo.model.entities.impl.Extraction;
import it.unibo.model.tables.TableUtilities;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link Extraction} entity.
 */
public class ExtractionTable implements Table<Extraction, String> {

    private static final String TABLE_NAME = Constants.EXTRACTIONS;
    private static final String CODE = "Codice";
    private static final String EXPEDITION = "CodiceSpedizione";
    private static final String NUMBER = "Numero";
    private static final String MATERIAL = "NomeMateriale";
    private static final String DEPTH = "Profondita";
    private static final String AMOUNT = "Quantita";
    private static final String NOTES = "Note";

    private final Connection connection;

    /**
     * Creates an instance of {@code AnalysisTable}.
     * 
     * @param provider the provider of the connection to the database the connection
     *                 to the database
     */
    public ExtractionTable(final ConnectionProvider provider) {
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
    public Optional<Extraction> findByPrimaryKey(final String primaryKey) {
        final String query = Constants.SELECT_ALL + TABLE_NAME + Constants.WHERE + CODE + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readExtractionsFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
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
            final ResultSet resultSet = statement.executeQuery(Constants.SELECT_ALL + TABLE_NAME);
            return readExtractionsFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Collections.emptyList();
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
        final String query = Constants.SELECT_ALL + TABLE_NAME + Constants.WHERE + MATERIAL + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, materialName);
            final ResultSet resultSet = statement.executeQuery();
            return readExtractionsFromResultSet(resultSet);
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
     *         Constants.WHERE otherwise
     */
    private String appendToQuery(final String query) {
        return query.length() > 0 ? Constants.AND : Constants.WHERE;
    }

    private void build(final StringBuilder builder, final Optional<?> obj, final String append) {
        obj.ifPresent(o -> {
            builder.append(appendToQuery(builder.toString()));
            builder.append(append);
        });
    }

    private void buildStringStatement(final PreparedStatement statement, final Optional<String> field,
            final Counter counter) throws SQLException {
        if (field.isPresent()) {
            statement.setString(counter.getValueAndIncrement(), field.get());
        }
    }

    private void buildIntStatement(final PreparedStatement statement, final Optional<Integer> field,
            final Counter counter) throws SQLException {
        if (field.isPresent()) {
            statement.setInt(counter.getValueAndIncrement(), field.get());
        }
    }

    /**
     * Applies some filters to retrieve {@link Extraction}s that match the
     * spcecified values.
     * 
     * @param locationName   the name of the location
     * @param minDepth       the minimum depth
     * @param maxDepth       the maximum depth
     * @param expeditionCode the code of the expedition
     * @param materialName   the name of the material
     * @return a list of all the extractions, or an empty list if something went
     *         wrong
     */
    public List<Extraction> filter(final Optional<String> locationName,
            final Optional<Integer> minDepth, final Optional<Integer> maxDepth,
            final Optional<String> expeditionCode, final Optional<String> materialName) {
        final StringBuilder queryBuilder = new StringBuilder(1000);
        build(queryBuilder, locationName, EXPEDITION + Constants.EQUALS + Constants.EXPEDITIONS + "." + CODE
                + Constants.AND + Constants.EXPEDITIONS + ".NomeLuogo" + Constants.QUESTION_MARK);
        build(queryBuilder, minDepth, DEPTH + " >= ?");
        build(queryBuilder, maxDepth, DEPTH + " <= ?");
        build(queryBuilder, expeditionCode, EXPEDITION + Constants.QUESTION_MARK);
        build(queryBuilder, materialName, MATERIAL + Constants.QUESTION_MARK);
        final String query = "SELECT " + TABLE_NAME + "." + CODE + "," + EXPEDITION + "," + NUMBER + "," + MATERIAL
                + "," + DEPTH + "," + AMOUNT + "," + NOTES + " FROM " + TABLE_NAME + "," + Constants.EXPEDITIONS
                + queryBuilder.toString();
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            buildStringStatement(statement, locationName, counter);
            buildIntStatement(statement, minDepth, counter);
            buildIntStatement(statement, maxDepth, counter);
            buildStringStatement(statement, expeditionCode, counter);
            buildStringStatement(statement, materialName, counter);
            final ResultSet resultSet = statement.executeQuery();
            return readExtractionsFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Extraction value) {
        final String query = "INSERT INTO " + TABLE_NAME + "("
                + CODE + ", " + EXPEDITION + ", " + NUMBER + ", " + MATERIAL + ", " + DEPTH + ", " + AMOUNT
                + ", " + NOTES + ") VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), value.getCode());
            statement.setString(counter.getValueAndIncrement(), value.getExpeditionCode());
            statement.setInt(counter.getValueAndIncrement(), value.getNumber());
            statement.setString(counter.getValueAndIncrement(), value.getMaterialName());
            statement.setInt(counter.getValueAndIncrement(), value.getDepth().orElse(null));
            statement.setFloat(counter.getValueAndIncrement(), value.getAmount());
            statement.setString(counter.getValue(), value.getNotes().orElse(null));
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
    public boolean update(final Extraction updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + EXPEDITION + Constants.QUESTION_MARK + ", "
                + NUMBER + Constants.QUESTION_MARK + ", "
                + MATERIAL + Constants.QUESTION_MARK + ", "
                + DEPTH + Constants.QUESTION_MARK + ", "
                + AMOUNT + Constants.QUESTION_MARK + ", "
                + NOTES + Constants.QUESTION_MARK
                + Constants.WHERE + CODE + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), updatedValue.getExpeditionCode());
            statement.setInt(counter.getValueAndIncrement(), updatedValue.getNumber());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getMaterialName());
            statement.setInt(counter.getValueAndIncrement(), updatedValue.getDepth().orElse(null));
            statement.setFloat(counter.getValueAndIncrement(), updatedValue.getAmount());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getNotes().orElse(null));
            statement.setString(counter.getValue(), updatedValue.getCode());
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
