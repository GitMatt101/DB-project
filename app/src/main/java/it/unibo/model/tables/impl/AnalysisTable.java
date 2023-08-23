package it.unibo.model.tables.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import it.unibo.common.ConnectionProvider;
import it.unibo.common.Constants;
import it.unibo.common.Counter;
import it.unibo.model.entities.Analysis;
import it.unibo.model.tables.TableUtilities;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link Analysis} entity.
 */
public class AnalysisTable implements Table<Analysis, String> {

    private static final String TABLE_NAME = "analisi";
    private static final String CODE = "Codice";
    private static final String EXTRACTION_CODE = "CodicePrelievo";
    private static final String DESCRIPTION = "Descrizione";
    private static final String LABORATORY_ID = "IDlaboratorio";

    private final Connection connection;

    /**
     * Creates an instance of {@code AnalysisTable}.
     * 
     * @param provider the provider of the connection to the database
     */
    public AnalysisTable(final ConnectionProvider provider) {
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
    public Optional<Analysis> findByPrimaryKey(final String primaryKey) {
        final String query = Constants.SELECT_ALL + TABLE_NAME + Constants.WHERE + CODE + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readAnalysesFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the analyses in it and collects them in a List.
     * 
     * @param resultSet a ResultSet from which the analyses will be extracted
     * @return a List of all the analyses in the ResultSet
     * @throws SQLException
     */
    private List<Analysis> readAnalysesFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<Analysis> analyses = new ArrayList<>();
        while (resultSet.next()) {
            analyses.add(new Analysis(
                    resultSet.getString(CODE),
                    resultSet.getString(EXTRACTION_CODE),
                    resultSet.getString(DESCRIPTION),
                    resultSet.getString(LABORATORY_ID)));
        }
        return analyses;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Analysis> findAll() {
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery(Constants.SELECT_ALL + TABLE_NAME);
            return readAnalysesFromResultSet(resultSet);
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return new ArrayList<>();
        }
    }

    /**
     * Retrieves the {@link Analysis} with the given extraction code.
     * 
     * @param extractionCode the extraction code
     * @return the {@link Analysis} with the given extraction code if present, an
     *         empty {@link Optional} otherwise
     */
    public Optional<Analysis> findByExtractionCode(final String extractionCode) {
        final String query = Constants.SELECT_ALL + TABLE_NAME + Constants.WHERE + EXTRACTION_CODE
                + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, extractionCode);
            final ResultSet resultSet = statement.executeQuery();
            return readAnalysesFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
            return Optional.empty();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Analysis value) {
        final String query = "INSERT INTO " + TABLE_NAME + " ("
                + CODE + ", " + EXTRACTION_CODE + ", " + DESCRIPTION + ", " + LABORATORY_ID
                + ") VALUES (?, ?, ?, ?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), value.getCode());
            statement.setString(counter.getValueAndIncrement(), value.getExtractionCode());
            statement.setString(counter.getValueAndIncrement(), value.getDescription());
            statement.setString(counter.getValue(), value.getLaboratoryID());
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
    public boolean update(final Analysis updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + EXTRACTION_CODE + Constants.QUESTION_MARK + ", "
                + DESCRIPTION + Constants.QUESTION_MARK + ", "
                + LABORATORY_ID + Constants.QUESTION_MARK
                + Constants.WHERE + CODE + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final Counter counter = new Counter(1);
            statement.setString(counter.getValueAndIncrement(), updatedValue.getExtractionCode());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getDescription());
            statement.setString(counter.getValueAndIncrement(), updatedValue.getLaboratoryID());
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
