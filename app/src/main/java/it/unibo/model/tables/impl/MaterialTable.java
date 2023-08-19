package it.unibo.model.tables.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

import it.unibo.common.Constants;
import it.unibo.connection.ConnectionProvider;
import it.unibo.model.entities.Material;
import it.unibo.model.tables.api.Table;

/**
 * MySQL table for {@link Material} entity.
 */
public class MaterialTable implements Table<Material, String> {

    private static final String TABLE_NAME = "materiali";
    private static final String NAME = "Nome";

    private final Connection connection;

    /**
     * Creates an instance of {@code MaterialTable}.
     * 
     * @param provider the provider of the connection to the database
     */
    public MaterialTable(final ConnectionProvider provider) {
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
    public Optional<Material> findByPrimaryKey(final String primaryKey) {
        final String query = "SELECT * FROM " + TABLE_NAME + Constants.WHERE + NAME + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            final ResultSet resultSet = statement.executeQuery();
            return readMaterialsFromResultSet(resultSet).stream().findFirst();
        } catch (final SQLException e) {
            Logger.getLogger(MaterialTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Optional.empty();
        }
    }

    /**
     * Given a ResultSet read all the materials in it and collects them in a List.
     * 
     * @param resultSet a ResultSet from which the Material(s) will be extracted
     * @return a List of all the materials in the ResultSet
     */
    private List<Material> readMaterialsFromResultSet(final ResultSet resultSet) throws SQLException {
        final List<Material> materials = new ArrayList<>();
        while (resultSet.next()) {
            final Material material = new Material(resultSet.getString(NAME));
            materials.add(material);
        }
        return materials;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Material> findAll() {
        final String query = "SELECT * FROM " + TABLE_NAME;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            final ResultSet resultSet = statement.executeQuery();
            return readMaterialsFromResultSet(resultSet);
        } catch (final SQLException e) {
            Logger.getLogger(MaterialTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return Collections.emptyList();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean save(final Material value) {
        final String query = "INSERT INTO " + TABLE_NAME + " VALUES (?)";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, value.getName());
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(MaterialTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean update(final Material updatedValue) {
        // Cannot update a table if its only attribute is its primary key
        return false;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean delete(final String primaryKey) {
        final String query = "DELETE FROM " + TABLE_NAME + Constants.WHERE + NAME + Constants.QUESTION_MARK;
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, primaryKey);
            return statement.executeUpdate() > 0;
        } catch (final SQLException e) {
            Logger.getLogger(MaterialTable.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR, e);
            return false;
        }
    }

}
