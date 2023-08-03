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
import it.unibo.model.entities.Company;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@code Association} entity, represented by {@link Company}.
 */
public class CompanyTable implements Table<Company, String> {

    private static final String NAME = "Nome";
    private static final String ADDRESS = "Indirizzo";
    private static final String PREPARE_FIELD = " = ?";

    private final Connection connection;
    private final String tableName;

    /**
     * Creates an instance of {@code AssociationTable}.
     * 
     * @param connection the connection to the database
     * @param tableName  the name of the table
     */
    public CompanyTable(final Connection connection, final String tableName) {
        this.connection = connection;
        this.tableName = tableName;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String getTableName() {
        return this.tableName;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public Optional<Company> findByPrimaryKey(final String primaryKey) {
        final String query = "SELECT * FROM " + this.tableName + " WHERE " + NAME + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readManufacturersFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            Logger.getLogger(CompanyTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the associations in it and collects them in a
     * List.
     * 
     * @param resultSet a ResultSet from which the associations will be extracted
     * @return a List of all the associations in the ResultSet
     * @throws SQLException
     */
    private List<Company> readManufacturersFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<Company> manufacturers = new ArrayList<>();
        while (resultSet.next()) {
            manufacturers.add(new Company(resultSet.getString(NAME), resultSet.getString(ADDRESS)));
        }
        return manufacturers;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Company> findAll() {
        try (Statement statement = this.connection.createStatement()) {
            final ResultSet resultSet = statement.executeQuery("SELECT * FROM " + this.tableName);
            return readManufacturersFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(CompanyTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Company value) {
        final String query = "INSERT INTO " + this.tableName + " VALUES (?, ?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, value.getName());
            statement.setString(2, value.getAddress());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(CompanyTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean update(final Company updatedValue) {
        final String query = "UPDATE " + this.tableName + " SET "
                + ADDRESS + PREPARE_FIELD
                + " WHERE " + NAME + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, updatedValue.getAddress());
            statement.setString(2, updatedValue.getName());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(CompanyTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean delete(final String primaryKey) {
        final String query = "DELETE FROM " + this.tableName + " WHERE " + NAME + PREPARE_FIELD;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(CompanyTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
