package it.unibo.controller;

import java.sql.Blob;
import java.sql.Connection;
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
import it.unibo.model.entities.Analysis;
import it.unibo.model.entities.Expedition;
import it.unibo.model.entities.GeologicalFormation;
import it.unibo.model.entities.Laboratory;
import it.unibo.model.entities.Material;
import it.unibo.model.entities.Organism;
import it.unibo.model.entities.ROV;
import it.unibo.model.entities.Wreck;
import it.unibo.model.entities.impl.Extraction;
import it.unibo.model.entities.impl.Operator;
import it.unibo.model.entities.impl.Sighting;
import it.unibo.model.tables.impl.AnalysisTable;
import it.unibo.model.tables.impl.ExpeditionTable;
import it.unibo.model.tables.impl.ExtractionTable;
import it.unibo.model.tables.impl.GeologicalFormationTable;
import it.unibo.model.tables.impl.LaboratoryTable;
import it.unibo.model.tables.impl.LocationTable;
import it.unibo.model.tables.impl.OperatorTable;
import it.unibo.model.tables.impl.OrganismTable;
import it.unibo.model.tables.impl.ROVTable;
import it.unibo.model.tables.impl.SightingTable;
import it.unibo.model.tables.impl.WreckTable;
import it.unibo.view.popups.RegistrationPopup;

/**
 * Implementation of the {@link Controller} interface.
 */
public class Controller {

    private static final Connection CONNECTION = new ConnectionProvider(
            Constants.USERNAME,
            Constants.PASSWORD,
            Constants.DATABASE_NAME)
            .getMySQLConnection();

    /**
     * Creates an instance of {@link Controller}.
     */
    public Controller() {
    }

    public static void openOperatorRegistrationPopup() {
        RegistrationPopup.operatorRegistration();
    }

    /**
     * Registers a new {@link Operator} in the database.
     * 
     * @param firstName       the first name of the operator
     * @param secondName      the second name of the operator
     * @param fiscalCode      the fiscal code of the operator
     * @param associationName the name of the association the operator works for
     * @param groupID         the ID of the group the operator is part of
     * @param id              the ID of the operator
     * @return true if the operation is successful, false otherwise
     */
    public static boolean registerOperator(final String firstName, final String secondName, final String fiscalCode,
            final String associationName, final String groupID, final String id) {
        return new OperatorTable(CONNECTION)
                .save(new Operator(firstName, secondName, fiscalCode, associationName, groupID, id));
    }

    /**
     * Registers a new {@link ROV} in the database.
     * 
     * @param licensePlate     the ROV's license plate
     * @param manufacturerName the ROV's manufacturer name
     * @param serialNumber     the ROV's serial number given by the manufacturer
     * @param productionDate   the ROV's production date
     * @return true if the operation is successful, false otherwise
     */
    public static boolean registerROV(final String licensePlate, final String manufacturerName, final String serialNumber,
            final Date productionDate) {
        return new ROVTable(CONNECTION)
                .save(new ROV(licensePlate, manufacturerName, serialNumber, productionDate));
    }

    /**
     * Registers a new {@link Expedition} in the database.
     * 
     * @param code            the code of the expedition
     * @param date            the date of the expedition
     * @param locationName    the name of the {@link Location} explored
     * @param rovLicencePlate the license plate of the {@link ROV} used in the
     *                        expedition
     * @param groupID         the ID of the {@link Group} that participated in the
     *                        expedition
     * @param associationName the name of the {@link Association} that organized the
     *                        expedition
     * @return true if the operation is successful, false otherwise
     */
    public static boolean registerExpedition(final String code, final Date date, final String locationName,
            final String rovLicencePlate, final String associationName, final String groupID) {
        return new ExpeditionTable(CONNECTION)
                .save(new Expedition(code, date, locationName, rovLicencePlate, groupID, associationName));
    }

    /**
     * Registers a new {@link Sighting} in the database.
     * 
     * @param code                    the code of the sighting
     * @param expeditionCode          the code of the expedition
     * @param depth                   the depth at which the sighting occurred
     * @param image                   the image of the sighted object/organism
     * @param notes                   the notes of the sighting
     * @param organismID              the ID of the organism
     * @param wreckID                 the ID of the wreck
     * @param geologicalFormationName the name of the geological formation
     * @return true if the operation is successful, false otherwise
     */
    public static boolean registerSighting(final String code, final String expeditionCode, final Optional<Integer> depth,
            final Blob image, final Optional<String> notes, final Optional<String> organismID,
            final Optional<String> wreckID, final Optional<String> geologicalFormationName) {
        final int number = new SightingTable(CONNECTION).getNextNumber(expeditionCode);
        return number != -1 ? new SightingTable(CONNECTION)
                .save(new Sighting(code, expeditionCode, number, depth, image, notes, organismID, wreckID,
                        geologicalFormationName))
                : false;
    }

    /**
     * Registers a new {@link Extraction} in the database.
     * Each extraction's number is automatically generated by auto incrementing the
     * value of the previous entry.
     * 
     * @param code           the code of the extraction
     * @param expeditionCode the code of the expedition
     * @param materialName   the name of the material extracted
     * @param depth          the depth at which the extraction occurred
     * @param amount         the amount of material extracted
     * @param notes          the notes of the extraction
     * @return true if the operation is successful, false otherwise
     */
    public static boolean registerExtraction(final String code, final String expeditionCode, final String materialName,
            final Optional<Integer> depth, final float amount, final Optional<String> notes) {
        final int number = new ExtractionTable(CONNECTION).getNextNumber(expeditionCode);
        return number != -1 ? new ExtractionTable(CONNECTION)
                .save(new Extraction(code, expeditionCode, number, materialName, depth, amount, notes))
                : false;
    }

    /**
     * Updates the species of a previously unidentified {@link Organism}.
     * 
     * @param organismID     the ID of the organism to be updated
     * @param updatedSpecies the new species
     * @return true if the operation is successful, false otherwise
     */
    public static boolean updateSpecies(final String organismID, final String updatedSpecies) {
        final Optional<Organism> organism = new OrganismTable(CONNECTION).findByPrimaryKey(organismID);
        if (organism.isPresent()) {
            final Organism org = organism.get();
            return new OrganismTable(CONNECTION).update(new Organism(organismID, Optional.of(updatedSpecies),
                    Optional.empty(), org.getCommonName(), org.getDescription()));
        }
        return false;
    }

    /**
     * Filters {@link Sighting}s by depth.
     * 
     * @param minDepth the minimum depth
     * @param maxDepth the maximum depth
     * @return a list of sightings, each represented by a list of its attributes, in
     *         the following order:
     *         <ul>
     *         <li>code of the sighting (String)</li>
     *         <li>code of the expedition (String)</li>
     *         <li>number (int)</li>
     *         <li>depth (int)</li>
     *         <li>image (Blob)</li>
     *         <li>notes (String)</li>
     *         <li>ID of the organism (String)</li>
     *         <li>ID of the wreck (String)</li>
     *         <li>name of the geological formation (String)</li>
     *         </ul>
     */
    public static List<List<Object>> filterSightingsByDepth(final int minDepth, final int maxDepth) {
        final List<Sighting> sightings = new SightingTable(CONNECTION).filterByDepth(minDepth, maxDepth);
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
     * Retrieves all the {@link Sighting}s that occurred in a specific
     * {@link Location}.
     * 
     * @param locationName the name of the location
     * @return a list of sightings, each represented by a list of its attributes, in
     *         the following order:
     *         <ul>
     *         <li>code of the sighting (String)</li>
     *         <li>code of the expedition (String)</li>
     *         <li>number (int)</li>
     *         <li>depth (int)</li>
     *         <li>image (Blob)</li>
     *         <li>notes (String)</li>
     *         <li>ID of the organism (String)</li>
     *         <li>ID of the wreck (String)</li>
     *         <li>name of the geological formation (String)</li>
     *         </ul>
     */
    public static List<List<Object>> filterSightingsByLocation(final String locationName) {
        final List<Sighting> sightings = new SightingTable(CONNECTION).filterByLocation(locationName);
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

    public static List<List<Object>> filterSightingsByExpedition(final String expeditionCode) {
        final List<Sighting> sightings = new SightingTable(CONNECTION).filterByExpedition(expeditionCode);
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
     * Retrieves all the {@link Sighting}s that occurred in an {@link Expedition}.
     * 
     * @param expeditionCode the code of the expedition
     * @return a list of sightings, each represented by a list of its attributes, in
     *         the following order:
     *         <ul>
     *         <li>code of the sighting (String)</li>
     *         <li>code of the expedition (String)</li>
     *         <li>number (int)</li>
     *         <li>depth (int)</li>
     *         <li>image (Blob)</li>
     *         <li>notes (String)</li>
     *         <li>ID of the organism (String)</li>
     *         <li>ID of the wreck (String)</li>
     *         <li>name of the geological formation (String)</li>
     *         </ul>
     */
    public static List<List<Object>> filterSightingsByOrganism(final String organismID) {
        final List<Sighting> sightings = new SightingTable(CONNECTION).filterByOrganism(organismID);
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
     * Retrieves all the {@link Sighting}s where an {@link Organism} was observated.
     * 
     * @param organismID the ID of the organism
     * @return a list of sightings, each represented by a list of its attributes, in
     *         the following order:
     *         <ul>
     *         <li>code of the sighting (String)</li>
     *         <li>code of the expedition (String)</li>
     *         <li>number (int)</li>
     *         <li>depth (int)</li>
     *         <li>image (Blob)</li>
     *         <li>notes (String)</li>
     *         <li>ID of the organism (String)</li>
     *         </ul>
     */
    public static List<List<Object>> filterSightingsByWreck(final String wreckID) {
        final List<Sighting> sightings = new SightingTable(CONNECTION).filterByWreck(wreckID);
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
     * Retrieves all the {@link Sighting}s where a {@link Wreck} was observated.
     * 
     * @param organismID the ID of the wreck
     * @return a list of sightings, each represented by a list of its attributes, in
     *         the following order:
     *         <ul>
     *         <li>code of the sighting (String)</li>
     *         <li>code of the expedition (String)</li>
     *         <li>number (int)</li>
     *         <li>depth (int)</li>
     *         <li>image (Blob)</li>
     *         <li>notes (String)</li>
     *         <li>ID of the wreck (String)</li>
     *         </ul>
     */
    public static List<List<String>> filterExpeditionsByAssociation(final String associationName) {
        final List<Expedition> expeditions = new ExpeditionTable(CONNECTION).filterByAssociation(associationName);
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
     * Retrieves all the {@link Expedition}s organized by an association.
     * 
     * @param associationName the name of the association
     * @return a list of expeditions, each represented by a list of its attributes,
     *         in the following order:
     *         <ul>
     *         <li>code (String)</li>
     *         <li>date (Date)</li>
     *         <li>name of the location (String)</li>
     *         <li>name of the association (String)</li>
     *         <li>ID of the group (String)</li>
     *         </ul>
     */
    public static List<Object> getExpeditionDetails(final String expeditionCode) {
        final List<Object> output = new ArrayList<>();
        final Optional<Expedition> expedition = new ExpeditionTable(CONNECTION).findByPrimaryKey(expeditionCode);
        if (expedition.isPresent()) {
            output.add(expedition.get().getCode());
            output.add(expedition.get().getDate().toString());
            output.add(expedition.get().getLocationName());
            output.add(expedition.get().getAssociationName());
            output.add(expedition.get().getGroupID());
            output.add(new OperatorTable(CONNECTION)
                    .getExpeditionPartecipants(expedition.get().getAssociationName(), expedition.get().getGroupID()));
            return output;
        }
        return Collections.emptyList();
    }

    /**
     * Retrieves all the details regarding an {@link Expedition}.
     * 
     * @param expeditionCode the code of the expedition
     * @return a list of the expedition's details, in the following order:
     *         <ul>
     *         <li>code (String)</li>
     *         <li>date (Date)</li>
     *         <li>name of the location (String)</li>
     *         <li>name of the association (String)</li>
     *         <li>ID of the group (String)</li>
     *         <li>operators involved (List of names and IDs)</li>
     *         <li>license plate of the ROV utilized (String)</li>
     *         </ul>
     */
    public static List<List<String>> filterOrganismsByExpedition(final String expeditionCode) {
        final List<Organism> organisms = new OrganismTable(CONNECTION).filterByExpedition(expeditionCode);
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
     * Retrieves all the {@link Organism}s that were sighted in an
     * {@link Expedition}.
     * 
     * @param expeditionCode the code of the expedition
     * @return a list of the organisms with their attributes, in the following
     *         order:
     *         <ul>
     *         <li>ID (String)</li>
     *         <li>species (String)</li>
     *         <li>temporary name (String)</li>
     *         <li>common name (String)</li>
     *         <li>description (String)</li>
     *         </ul>
     */
    public static List<List<String>> filterGeologicalFormationsByDangerLevel(final int dangerLevel) {
        final List<GeologicalFormation> geologicalFormations = new GeologicalFormationTable(CONNECTION)
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
                    + "='" + g.getID() + "'";
            try (Statement statement = CONNECTION.createStatement()) {
                final ResultSet resultSet = statement.executeQuery(query);
                final List<String> list = new ArrayList<>();
                list.add(g.getID());
                list.add(g.getType());
                list.add(String.valueOf(g.getSize()));
                list.add(String.valueOf(g.getDangerLevel()));
                list.add(g.getDescription());
                list.add(resultSet.getString(locationTable.getName()));
                list.add(resultSet.getString(locationTable.getCountryName()));
                output.add(list);
            } catch (final SQLException e) {
                Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR,
                        e);
            }
        });
        return output;
    }

    /**
     * Retrieves all the locations where a type of wreck was spotted.
     * 
     * @param wreckName
     * @return a list of locations, each represented by a list of its attributes:
     *         its name and the name of thecountry
     */
    public static List<List<String>> filterLocationsByWreck(final String wreckName) {
        final List<Wreck> wrecks = new WreckTable(CONNECTION).filterByName(wreckName);
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
            try (Statement statement = CONNECTION.createStatement()) {
                final ResultSet resultSet = statement.executeQuery(query);
                final List<String> list = new ArrayList<>();
                list.add(resultSet.getString(locationTable.getName()));
                list.add(resultSet.getString(locationTable.getCountryName()));
                output.add(list);
            } catch (final SQLException e) {
                Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR,
                        e);
            }
        });
        return new LinkedList<>(output);
    }

    /**
     * Retrieves all the informations regarding the sightings of an organism.
     * 
     * @param organismID
     * @return
     */
    public static List<List<Object>> getOrganismInfo(final String organismID) {
        final List<Sighting> sightings = new SightingTable(CONNECTION).filterByOrganism(organismID);
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
            try (Statement statement = CONNECTION.createStatement()) {
                final ResultSet resultSet = statement.executeQuery(locationQuery);
                attributes.add(resultSet.getString(locationTable.getName()));
                attributes.add(resultSet.getString(locationTable.getCountryName()));
            } catch (final SQLException e) {
                Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, Constants.STATEMENT_CREATION_ERROR,
                        e);
            }
            output.add(attributes);
        });
        return null;
    }

    /**
     * Retrieves all the information regarding all the analyses performed on a {@link Material}.
     * 
     * @param materialName the name of the {@link Material}
     * @return
     */
    public static List<List<String>> getAnalysesInfo(final String materialName) {
        final List<Extraction> extractions = new ExtractionTable(CONNECTION).filterByMaterial(materialName);
        final AnalysisTable analysisTable = new AnalysisTable(CONNECTION);
        final List<List<String>> output = new LinkedList<>();
        extractions.forEach(e -> {
            final Optional<Analysis> analysis = analysisTable.findByExtractionCode(e.getCode());
            analysis.ifPresent(a -> {
                final Optional<Laboratory> laboratory = new LaboratoryTable(CONNECTION)
                        .findByPrimaryKey(analysis.get().getLaboratoryID());
                laboratory.ifPresent(l -> {
                    final List<String> attributes = new ArrayList<>();
                    attributes.add(analysis.get().getCode());
                    attributes.add(analysis.get().getDescription());
                    attributes.add(laboratory.get().getName());
                    attributes.add(laboratory.get().getID());
                    attributes.add(laboratory.get().getAddress());
                    output.add(attributes);
                });
            });
        });
        return output;
    }

}
