package it.unibo.model.tables.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

import it.unibo.common.Constants;
import it.unibo.model.entities.Analysis;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link Analysis} entity.
 */
public class AnalysisTable implements Table<Analysis, String> {

    private static final String TABLE_NAME = "analisi";
    private static final String CODE = "CodiceAnalisi";
    private static final String EXTRACTION_CODE = "CodicePrelievo";
    private static final String DESCRIPTION = "Descrizione";
    private static final String LABORATORY_ID = "IDlaboratorio";
    private static final String PREPARE_FIELD = " = ?";

    private final Connection connection;

    /**
     * Creates an instance of {@code AnalysisTable}.
     * 
     * @param connection the connection to the database
     */
    public AnalysisTable(final Connection connection) {
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
    public Optional<Analysis> findByPrimaryKey(final String primaryKey) {
        final String query = "SELECT * FROM " + TABLE_NAME + " WHERE " + CODE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readAnalysesFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            Logger.getGlobal().log(Level.SEVERE, e.getMessage());
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
            final ResultSet resultSet = statement.executeQuery("SELECT * FROM " + TABLE_NAME);
            return readAnalysesFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getGlobal().log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return new ArrayList<>();
        }
    }

    public Optional<Analysis> findByExtractionCode(final String extractionCode) {
        final String query = "SELECT * FROM " + TABLE_NAME + " WHERE " + EXTRACTION_CODE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, extractionCode);
            final ResultSet resultSet = statement.executeQuery();
            return readAnalysesFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            Logger.getGlobal().log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
            statement.setString(1, value.getCode());
            statement.setString(2, value.getExtractionCode());
            statement.setString(3, value.getDescription());
            statement.setString(4, value.getLaboratoryID());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(AnalysisTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean update(final Analysis updatedValue) {
        final String query = "UPDATE " + TABLE_NAME + " SET "
                + EXTRACTION_CODE + PREPARE_FIELD + ", "
                + DESCRIPTION + PREPARE_FIELD + ", "
                + LABORATORY_ID + PREPARE_FIELD
                + " WHERE " + CODE + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, updatedValue.getExtractionCode());
            statement.setString(2, updatedValue.getDescription());
            statement.setString(3, updatedValue.getLaboratoryID());
            statement.setString(4, updatedValue.getCode());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(AnalysisTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
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
            Logger.getLogger(AnalysisTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
