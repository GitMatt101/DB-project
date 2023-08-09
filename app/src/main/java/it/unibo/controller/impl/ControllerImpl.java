package it.unibo.controller.impl;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

import it.unibo.common.Constants;
import it.unibo.connection.ConnectionProvider;
import it.unibo.controller.api.Controller;
import it.unibo.model.entities.Expedition;
import it.unibo.model.entities.GeologicalFormation;
import it.unibo.model.entities.Location;
import it.unibo.model.entities.Organism;
import it.unibo.model.entities.ROV;
import it.unibo.model.entities.Wreck;
import it.unibo.model.entities.impl.Extraction;
import it.unibo.model.entities.impl.Operator;
import it.unibo.model.entities.impl.Sighting;
import it.unibo.model.tables.impl.CountryTable;
import it.unibo.model.tables.impl.ExpeditionTable;
import it.unibo.model.tables.impl.ExtractionTable;
import it.unibo.model.tables.impl.GeologicalFormationTable;
import it.unibo.model.tables.impl.LocationTable;
import it.unibo.model.tables.impl.OperatorTable;
import it.unibo.model.tables.impl.OrganismTable;
import it.unibo.model.tables.impl.ROVTable;
import it.unibo.model.tables.impl.SightingTable;
import it.unibo.model.tables.impl.WreckTable;

/**
 * Implementation of the {@link Controller} interface.
 */
public class ControllerImpl implements Controller {

    private final Connection connection;

    /**
     * Creates an instance of {@link ControllerImpl}.
     */
    public ControllerImpl() {
        this.connection = new ConnectionProvider(
                Constants.USERNAME,
                Constants.PASSWORD,
                Constants.DATABASE_NAME)
                .getMySQLConnection();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean registerOperator(final String firstName, final String secondName, final String fiscalCode,
            final String associationName, final String groupID, final String id) {
        return new OperatorTable(this.connection)
                .save(new Operator(firstName, secondName, fiscalCode, associationName, groupID, id));
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean registerROV(final String licensePlate, final String manufacturerName, final String serialNumber,
            final Date productionDate) {
        return new ROVTable(this.connection)
                .save(new ROV(licensePlate, manufacturerName, serialNumber, productionDate));
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean registerExpedition(final String code, Date date, final String locationName,
            final String rovLicencePlate, final String groupID, final String associationName) {
        return new ExpeditionTable(this.connection)
                .save(new Expedition(code, date, locationName, rovLicencePlate, groupID, associationName));
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean registerSighting(final String code, final String expeditionCode, final Optional<Integer> depth,
            final Blob image, final Optional<String> notes, final Optional<String> organismID,
            final Optional<String> wreckID, final Optional<String> geologicalFormationName) {
        final int number = new SightingTable(this.connection).getNextNumber(expeditionCode);
        return number != -1 ? new SightingTable(this.connection)
                .save(new Sighting(code, expeditionCode, number, depth, image, notes, organismID, wreckID,
                        geologicalFormationName))
                : false;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean registerExtraction(final String code, final String expeditionCode, final String materialName,
            final Optional<Integer> depth, final float amount, final Optional<String> notes) {
        final int number = new ExtractionTable(this.connection).getNextNumber(expeditionCode);
        return number != -1 ? new ExtractionTable(this.connection)
                .save(new Extraction(code, expeditionCode, number, materialName, depth, amount, notes))
                : false;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean updateSpecies(final String organismID, final String updatedSpecies) {
        final Optional<Organism> organism = new OrganismTable(this.connection).findByPrimaryKey(organismID);
        if (organism.isPresent()) {
            final Organism org = organism.get();
            return new OrganismTable(this.connection).update(new Organism(organismID, Optional.of(updatedSpecies),
                    Optional.empty(), org.getCommonName(), org.getDescription()));
        }
        return false;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<Object>> filterSightingsByDepth(final int minDepth, final int maxDepth) {
        final List<Sighting> sightings = new SightingTable(this.connection).filterByDepth(minDepth, maxDepth);
        final List<List<Object>> output = new LinkedList<>();
        sightings.forEach(s -> {
            List<Object> list = new ArrayList<>();
            list.add(s.getCode());
            list.add(s.getExpeditionCode());
            list.add(s.getNumber());
            list.add(s.getDepth());
            list.add(s.getImage());
            list.add(s.getNotes());
            list.add(s.getOrganismID());
            list.add(s.getWreckID());
            list.add(s.getGeologicalFormationName());
            output.add(list);
            list = new ArrayList<>();
        });
        return output;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<Object>> filterSightingsByLocation(final String locationName) {
        final List<Sighting> sightings = new SightingTable(this.connection).filterByLocation(locationName);
        final List<List<Object>> output = new LinkedList<>();
        sightings.forEach(s -> {
            List<Object> list = new ArrayList<>();
            list.add(s.getCode());
            list.add(s.getExpeditionCode());
            list.add(s.getNumber());
            list.add(s.getDepth());
            list.add(s.getImage());
            list.add(s.getNotes());
            list.add(s.getOrganismID());
            list.add(s.getWreckID());
            list.add(s.getGeologicalFormationName());
            output.add(list);
            list = new ArrayList<>();
        });
        return output;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<Object>> filterSightingsByExpedition(final String expeditionCode) {
        final List<Sighting> sightings = new SightingTable(this.connection).filterByExpedition(expeditionCode);
        final List<List<Object>> output = new LinkedList<>();
        sightings.forEach(s -> {
            List<Object> list = new ArrayList<>();
            list.add(s.getCode());
            list.add(s.getExpeditionCode());
            list.add(s.getNumber());
            list.add(s.getDepth());
            list.add(s.getImage());
            list.add(s.getNotes());
            list.add(s.getOrganismID());
            list.add(s.getWreckID());
            list.add(s.getGeologicalFormationName());
            output.add(list);
            list = new ArrayList<>();
        });
        return output;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<Object>> filterSightingsByOrganism(final String organismID) {
        final List<Sighting> sightings = new SightingTable(this.connection).filterByOrganism(organismID);
        final List<List<Object>> output = new LinkedList<>();
        sightings.forEach(s -> {
            List<Object> list = new ArrayList<>();
            list.add(s.getCode());
            list.add(s.getExpeditionCode());
            list.add(s.getNumber());
            list.add(s.getDepth());
            list.add(s.getImage());
            list.add(s.getNotes());
            list.add(s.getOrganismID());
            list.add(s.getWreckID());
            list.add(s.getGeologicalFormationName());
            output.add(list);
            list = new ArrayList<>();
        });
        return output;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<Object>> filterSightingsByWreck(final String wreckID) {
        final List<Sighting> sightings = new SightingTable(this.connection).filterByWreck(wreckID);
        final List<List<Object>> output = new LinkedList<>();
        sightings.forEach(s -> {
            final List<Object> list = new ArrayList<>();
            list.add(s.getCode());
            list.add(s.getExpeditionCode());
            list.add(s.getNumber());
            list.add(s.getDepth());
            list.add(s.getImage());
            list.add(s.getNotes());
            list.add(s.getOrganismID());
            list.add(s.getWreckID());
            list.add(s.getGeologicalFormationName());
            output.add(list);
        });
        return output;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<String>> filterExpeditionsByAssociation(final String associationName) {
        final List<Expedition> expeditions = new ExpeditionTable(this.connection).filterByAssociation(associationName);
        final List<List<String>> output = new LinkedList<>();
        expeditions.forEach(s -> {
            final List<String> list = new ArrayList<>();
            list.add(s.getCode());
            list.add(s.getDate().toString());
            list.add(s.getLocationName());
            list.add(s.getAssociationName());
            list.add(s.getGroupID());
            output.add(list);
        });
        return output;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<Object> getExpeditionDetails(final String expeditionCode) {
        final List<Object> output = new ArrayList<>();
        final Optional<Expedition> expedition = new ExpeditionTable(this.connection).findByPrimaryKey(expeditionCode);
        if (expedition.isPresent()) {
            output.add(expedition.get().getCode());
            output.add(expedition.get().getDate().toString());
            output.add(expedition.get().getLocationName());
            output.add(expedition.get().getAssociationName());
            output.add(expedition.get().getGroupID());
            output.add(new OperatorTable(this.connection)
                    .getExpeditionPartecipants(expedition.get().getAssociationName(), expedition.get().getGroupID()));
            return output;
        }
        return Collections.emptyList();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<String>> filterOrganismsByExpedition(final String expeditionCode) {
        final List<Organism> organisms = new OrganismTable(this.connection).filterByExpedition(expeditionCode);
        final List<List<String>> output = new LinkedList<>();
        organisms.forEach(o -> {
            final List<String> attributes = new ArrayList<>();
            attributes.add(o.getId());
            o.getSpecies().ifPresentOrElse(attributes::add, () -> attributes.add("null"));
            o.getTemporaryName().ifPresentOrElse(attributes::add, () -> attributes.add("null"));
            o.getCommonName().ifPresentOrElse(attributes::add, () -> attributes.add("null"));
            attributes.add(o.getDescription());
            output.add(attributes);
        });
        return output;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<String>> filterGeologicalFormationsByDangerLevel(final int dangerLevel) {
        final List<GeologicalFormation> geologicalFormations = new GeologicalFormationTable(this.connection)
                .filterByDangerLevel(dangerLevel);
        final ExpeditionTable expeditionTable = new ExpeditionTable(null);
        final SightingTable sightingTable = new SightingTable(null);
        final LocationTable locationTable = new LocationTable(null);
        final List<List<String>> output = new LinkedList<>();
        geologicalFormations.forEach(g -> {
            final String query = "SELECT " + locationTable.getName() + "," + locationTable.getCountryName()
                    + " FROM " + locationTable.getTableName() + "," + expeditionTable.getTableName() + ","
                    + sightingTable.getTableName()
                    + " WHERE " + locationTable.getTableName() + "." + locationTable.getName()
                    + "=" + expeditionTable.getTableName() + "." + expeditionTable.getLocationName()
                    + " AND " + sightingTable.getTableName() + "." + sightingTable.getExpeditionCodeName()
                    + "=" + expeditionTable.getTableName() + "." + expeditionTable.getCodeName()
                    + " AND " + sightingTable.getTableName() + "." + sightingTable.getGeologicalFormationName()
                    + "='" + g.getName() + "'";
            try (Statement statement = this.connection.createStatement()) {
                final ResultSet resultSet = statement.executeQuery(query);
                final List<String> list = new ArrayList<>();
                list.add(g.getName());
                list.add(String.valueOf(g.getSize()));
                list.add(String.valueOf(g.getDangerLevel()));
                list.add(g.getDescription());
                list.add(resultSet.getString(locationTable.getName()));
                list.add(resultSet.getString(locationTable.getCountryName()));
                output.add(list);
            } catch (final SQLException e) {
                Logger.getLogger(ControllerImpl.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR,
                        e);
            }
        });
        return output;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<String>> filterLocationsByWreck(final String wreckName) {
        final List<Wreck> wrecks = new WreckTable(this.connection).filterByName(wreckName);
        final ExpeditionTable expeditionTable = new ExpeditionTable(null);
        final SightingTable sightingTable = new SightingTable(null);
        final LocationTable locationTable = new LocationTable(null);
        final Set<List<String>> output = new HashSet<>();
        wrecks.forEach(w -> {
            final String query = "SELECT " + locationTable.getName() + "," + locationTable.getCountryName()
                    + " FROM " + locationTable.getTableName() + "," + expeditionTable.getTableName() + ","
                    + sightingTable.getTableName()
                    + " WHERE " + locationTable.getTableName() + "." + locationTable.getName()
                    + "=" + expeditionTable.getTableName() + "." + expeditionTable.getLocationName()
                    + " AND " + sightingTable.getTableName() + "." + sightingTable.getExpeditionCodeName()
                    + "=" + expeditionTable.getTableName() + "." + expeditionTable.getCodeName()
                    + " AND " + sightingTable.getTableName() + "." + sightingTable.getWreckName()
                    + "='" + w.getId() + "'";
            try (Statement statement = this.connection.createStatement()) {
                final ResultSet resultSet = statement.executeQuery(query);
                final List<String> list = new ArrayList<>();
                list.add(resultSet.getString(locationTable.getName()));
                list.add(resultSet.getString(locationTable.getCountryName()));
                output.add(list);
            } catch (final SQLException e) {
                Logger.getLogger(ControllerImpl.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR,
                        e);
            }
        });
        return new LinkedList<>(output);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<Object>> getOrganismInfo(final String organismID) {
        final List<Sighting> sightings = new SightingTable(this.connection).filterByOrganism(organismID);
        final List<List<Object>> output = new LinkedList<>();
        sightings.forEach(s -> {
            final List<Object> attributes = new ArrayList<>();
            attributes.add(s.getCode());
            attributes.add(s.getExpeditionCode());
            attributes.add(s.getNumber());
            attributes.add(s.getDepth());
            attributes.add(s.getImage());
            attributes.add(s.getNotes());
            final LocationTable locationTable = new LocationTable(null);
            final ExpeditionTable expeditionTable = new ExpeditionTable(null);
            final String locationQuery = "SELECT " + locationTable.getName() + "," + locationTable.getCountryName()
                    + " FROM " + locationTable.getTableName() + "," + expeditionTable.getTableName()
                    + " WHERE " + locationTable.getTableName() + "." + locationTable.getName()
                    + "=" + expeditionTable.getTableName() + "." + expeditionTable.getLocationName()
                    + " AND " + expeditionTable.getTableName() + "." + expeditionTable.getCodeName()
                    + "=" + s.getExpeditionCode();
            try (Statement statement = this.connection.createStatement()) {
                final ResultSet resultSet = statement.executeQuery(locationQuery);
                attributes.add(resultSet.getString(locationTable.getName()));
                attributes.add(resultSet.getString(locationTable.getCountryName()));
            } catch (final SQLException e) {
                Logger.getLogger(ControllerImpl.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR,
                        e);
            }
            output.add(attributes);
        });
        return null;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<String>> getAnalysisInfo(final String analysisCode) {
        // TODO Auto-generated method stub
        return null;
    }

}
