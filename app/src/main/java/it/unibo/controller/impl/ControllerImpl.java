package it.unibo.controller.impl;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import it.unibo.common.Constants;
import it.unibo.connection.ConnectionProvider;
import it.unibo.controller.api.Controller;
import it.unibo.model.entities.Analysis;
import it.unibo.model.entities.Company;
import it.unibo.model.entities.Expedition;
import it.unibo.model.entities.Laboratory;
import it.unibo.model.entities.ROV;
import it.unibo.model.entities.impl.Extraction;
import it.unibo.model.entities.impl.GeologicalFormation;
import it.unibo.model.entities.impl.Member;
import it.unibo.model.entities.impl.Organism;
import it.unibo.model.entities.impl.Sighting;
import it.unibo.model.entities.impl.Wreck;
import it.unibo.model.tables.TableUtilities;
import it.unibo.model.tables.impl.AnalysisTable;
import it.unibo.model.tables.impl.CompanyTable;
import it.unibo.model.tables.impl.ExpeditionTable;
import it.unibo.model.tables.impl.ExtractionTable;
import it.unibo.model.tables.impl.GeologicalFormationTable;
import it.unibo.model.tables.impl.LaboratoryTable;
import it.unibo.model.tables.impl.MemberTable;
import it.unibo.model.tables.impl.OrganismTable;
import it.unibo.model.tables.impl.ROVTable;
import it.unibo.model.tables.impl.SightingTable;
import it.unibo.model.tables.impl.WreckTable;
import it.unibo.view.popups.api.InputManager;
import it.unibo.view.popups.api.OutputManager;
import it.unibo.view.popups.impl.InputManagerImpl;
import it.unibo.view.popups.impl.OutputManagerImpl;

/**
 * This class is used as an intermediary between view and model.
 */
public class ControllerImpl implements Controller {

    private final ConnectionProvider provider;
    private final InputManager inputManager;
    private final OutputManager outputManager;

    /**
     * Creates an instance of {@code ControllerImpl}, setting up the connection to
     * the database and the input/output managers.
     */
    public ControllerImpl() {
        this.provider = new ConnectionProvider(Constants.USERNAME, Constants.PASSWORD, Constants.DATABASE_NAME);
        this.inputManager = new InputManagerImpl(this);
        this.outputManager = new OutputManagerImpl();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void openMemberRegistration() {
        this.inputManager.memberRegistration();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void openROVRegistration() {
        this.inputManager.rovRegistration();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void openExpeditionRegistration() {
        this.inputManager.expeditionRegistration();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void openSightingRegistration() {
        this.inputManager.sightingRegistration();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void openExtractionRegistration() {
        this.inputManager.extractionRegistration();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void openSpeciesUpdate() {
        this.inputManager.speciesUpdate();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void openSightingsFilter() {
        this.inputManager.sightingsFilter();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void openExtractionsFilter() {
        this.inputManager.extractionsFilter();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void openExpeditionsFilterByAssociation() {
        this.inputManager.expeditionsFilterByAssociation();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void openOrganismsFilterByExpedition() {
        this.inputManager.organismsFilterByExpedition();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void openGeologicalFormationsFilterByDangerLevel() {
        this.inputManager.geologicalFormationFilterByDangerLevel();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void openWrecksFilterByName() {
        this.inputManager.wrecksFitlerByName();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void openAnalysesFilterByMaterial() {
        this.inputManager.analysesFilterByMaterial();
    }

    private List<List<String>> createOrganismList(final List<Organism> organisms) {
        final List<List<String>> output = new LinkedList<>();
        organisms.forEach(o -> {
            final List<String> attributes = new ArrayList<>();
            attributes.add(o.getID());
            o.getSpecies().ifPresentOrElse(attributes::add, () -> attributes.add("[NON IDENTIFICATO]"));
            o.getTemporaryName().ifPresentOrElse(attributes::add, () -> attributes.add(""));
            o.getCommonName().ifPresentOrElse(attributes::add, () -> attributes.add(""));
            attributes.add(o.getDescription());
            output.add(attributes);
        });
        return output;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void showAllOrganisms() {
        final List<Organism> organisms = new OrganismTable(this.provider).findAll();
        this.outputManager.showOrganisms(createOrganismList(organisms));
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void showAllWrecks() {
        final List<Wreck> wrecks = new WreckTable(this.provider).findAll();
        final List<List<String>> output = new LinkedList<>();
        wrecks.forEach(w -> {
            final List<String> attributes = new ArrayList<>();
            attributes.add(w.getID());
            w.getName().ifPresentOrElse(n -> attributes.add(n), () -> attributes.add(""));
            w.getWreckageDate().ifPresentOrElse(d -> attributes.add(d.toString()), () -> attributes.add("Sconosciuta"));
            attributes.add(w.getLength() + "m");
            attributes.add(w.getDescription());
            output.add(attributes);
        });
        this.outputManager.showWrecks(output);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void showAllGeologicalFormations() {
        final List<GeologicalFormation> geologicalFormations = new GeologicalFormationTable(this.provider).findAll();
        final List<List<String>> output = new LinkedList<>();
        geologicalFormations.forEach(g -> {
            final List<String> attributes = new ArrayList<>();
            attributes.add(g.getID());
            attributes.add(g.getType());
            attributes.add(g.getSize() + "m2");
            attributes.add(g.getDescription());
            output.add(attributes);
        });
        this.outputManager.showGeologicalFormations(output);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void showAllSightings() {
        final List<Sighting> sightings = new SightingTable(this.provider).findAll();
        final List<List<String>> output = new LinkedList<>();
        sightings.forEach(s -> {
            final List<String> attributes = new ArrayList<>();
            attributes.add(s.getCode());
            attributes.add(s.getExpeditionCode());
            attributes.add(String.valueOf(s.getNumber()));
            s.getDepth().ifPresentOrElse(d -> {
                if (d > 0) {
                    attributes.add(d + "m");
                } else {
                    attributes.add(Constants.DEPTH_NOT_SPECIFIED);
                }
            }, () -> attributes.add(Constants.DEPTH_NOT_SPECIFIED));
            s.getNotes().ifPresentOrElse(attributes::add, () -> attributes.add(""));
            s.getOrganismID().ifPresentOrElse(attributes::add, () -> attributes.add(""));
            s.getWreckID().ifPresentOrElse(attributes::add, () -> attributes.add(""));
            s.getGeologicalFormationID().ifPresentOrElse(attributes::add, () -> attributes.add(""));
            output.add(attributes);
        });
        this.outputManager.showSightings(output);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void showAllAssociations() {
        final List<Company> associations = new CompanyTable(this.provider, "associazioni").findAll();
        final List<List<String>> output = new LinkedList<>();
        associations.forEach(a -> {
            final List<String> attributes = new ArrayList<>();
            attributes.add(a.getName());
            attributes.add(a.getAddress());
            output.add(attributes);
        });
        this.outputManager.showAssociations(output);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void showAllExpeditions() {
        final List<Expedition> expeditions = new ExpeditionTable(this.provider).findAll();
        final List<List<Object>> output = new LinkedList<>();
        expeditions.forEach(e -> {
            final List<Object> attributes = new ArrayList<>();
            attributes.add(e.getCode());
            attributes.add(e.getDate().toString());
            attributes.add(e.getLocationName());
            attributes.add(e.getAssociationName());
            attributes.add(e.getGroupID());
            final List<Object> names = new ArrayList<>();
            new MemberTable(this.provider).getExpeditionPartecipants(e.getAssociationName(), e.getGroupID())
                    .forEach(o -> {
                        names.add(o.getFirstName() + " " + o.getLastName() + "-" + o.getRole());
                    });
            attributes.add(names);
            output.add(attributes);
        });
        this.outputManager.showExpeditions(output);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean registerMember(final String firstName, final String lastName, final String fiscalCode,
            final String associationName, final String groupID, final String id, final String role) {
        return new MemberTable(this.provider)
                .save(new Member(firstName, lastName, fiscalCode, associationName, groupID, id, role));
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean registerROV(final String licensePlate, final String manufacturerName,
            final String serialNumber, final Date productionDate) {
        return new ROVTable(this.provider)
                .save(new ROV(licensePlate, manufacturerName, serialNumber, productionDate));
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean registerExpedition(final String code, final Date date, final String locationName,
            final String rovLicencePlate, final String associationName, final String groupID) {
        return new ExpeditionTable(this.provider)
                .save(new Expedition(code, date, locationName, rovLicencePlate, groupID, associationName));
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean registerSighting(final String code, final String expeditionCode,
            final Integer depth, final String notes, final String organismID, final String wreckID,
            final String geologicalFormationID) {
        final int number = TableUtilities.getNextNumber(Constants.SIGHTINGS, expeditionCode,
                this.provider.getMySQLConnection(), this);
        return number != -1 && new SightingTable(this.provider)
                .save(new Sighting(code, expeditionCode, number,
                        Optional.ofNullable(depth), Optional.ofNullable(notes),
                        Optional.ofNullable(organismID), Optional.ofNullable(wreckID),
                        Optional.ofNullable(geologicalFormationID)));
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean registerExtraction(final String code, final String expeditionCode, final String materialName,
            final Integer depth, final Float amount, final String notes) {
        final int number = TableUtilities.getNextNumber(Constants.EXTRACTIONS, expeditionCode,
                this.provider.getMySQLConnection(), this);
        return number != -1 && new ExtractionTable(this.provider)
                .save(new Extraction(code, expeditionCode, number, materialName, Optional.ofNullable(depth), amount,
                        Optional.ofNullable(notes)));
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean updateSpecies(final String organismID, final String updatedSpecies) {
        final Optional<Organism> organism = new OrganismTable(this.provider).findByPrimaryKey(organismID);
        if (organism.isPresent()) {
            final Organism org = organism.get();
            return new OrganismTable(this.provider).update(new Organism(organismID, Optional.of(updatedSpecies),
                    Optional.empty(), org.getCommonName(), org.getDescription()));
        }
        return false;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<String>> filterSightings(final Optional<String> locationName,
            final Optional<Integer> minDepth, final Optional<Integer> maxDepth,
            final Optional<String> expeditionCode, final Optional<String> organismID, final Optional<String> wreckID,
            final Optional<String> geologicalFormationID) {
        final List<Sighting> sightings = new SightingTable(this.provider)
                .filter(locationName, minDepth, maxDepth, expeditionCode, organismID, wreckID, geologicalFormationID);
        final List<List<String>> output = new LinkedList<>();
        sightings.forEach(s -> {
            final List<String> list = new ArrayList<>();
            list.add(s.getCode());
            list.add(s.getExpeditionCode());
            list.add(String.valueOf(s.getNumber()));
            s.getDepth().ifPresentOrElse(d -> {
                if (d > 0) {
                    list.add(d + "m");
                } else {
                    list.add(Constants.DEPTH_NOT_SPECIFIED);
                }
            }, () -> list.add(Constants.DEPTH_NOT_SPECIFIED));
            s.getNotes().ifPresentOrElse(list::add, () -> list.add(""));
            s.getOrganismID().ifPresentOrElse(list::add, () -> list.add(""));
            s.getWreckID().ifPresentOrElse(list::add, () -> list.add(""));
            s.getGeologicalFormationID().ifPresentOrElse(list::add, () -> list.add(""));
            output.add(list);
        });
        return new LinkedList<>(new HashSet<>(output));
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<String>> filterExtractions(final Optional<String> locationName,
            final Optional<Integer> minDepth, final Optional<Integer> maxDepth,
            final Optional<String> expeditionCode, final Optional<String> materialName) {
        final List<Extraction> extractions = new ExtractionTable(this.provider)
                .filter(locationName, minDepth, maxDepth, expeditionCode, materialName);
        final List<List<String>> output = new LinkedList<>();
        extractions.forEach(s -> {
            final List<String> list = new ArrayList<>();
            list.add(s.getCode());
            list.add(s.getExpeditionCode());
            list.add(String.valueOf(s.getNumber()));
            list.add(s.getMaterialName());
            s.getDepth().ifPresentOrElse(d -> {
                if (d > 0) {
                    list.add(d + "m");
                } else {
                    list.add(Constants.DEPTH_NOT_SPECIFIED);
                }
            }, () -> list.add(Constants.DEPTH_NOT_SPECIFIED));
            list.add(String.valueOf(s.getAmount()));
            s.getNotes().ifPresentOrElse(n -> list.add(n), () -> list.add(""));
            output.add(list);
        });
        return new LinkedList<>(new HashSet<>(output));
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<Object>> filterExpeditionsByAssociation(final String associationName) {
        final List<Expedition> expeditions = new ExpeditionTable(this.provider).filterByAssociation(associationName);
        final List<List<Object>> output = new LinkedList<>();
        expeditions.forEach(s -> {
            final List<Object> list = new ArrayList<>();
            list.add(s.getCode());
            list.add(s.getDate().toString());
            list.add(s.getLocationName());
            list.add(s.getAssociationName());
            list.add(s.getGroupID());
            final List<Object> names = new ArrayList<>();
            new MemberTable(this.provider).getExpeditionPartecipants(s.getAssociationName(), s.getGroupID())
                    .forEach(o -> {
                        names.add(o.getFirstName() + " " + o.getLastName() + "-" + o.getRole());
                    });
            list.add(names);
            output.add(list);
        });
        return output;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<String>> filterOrganismsByExpedition(final String expeditionCode) {
        final List<Organism> organisms = new OrganismTable(this.provider).filterByExpedition(expeditionCode);
        return new LinkedList<>(new HashSet<>(createOrganismList(organisms)));
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<String>> filterGeologicalFormationsByDangerLevel(final Integer dangerLevel) {
        final List<GeologicalFormation> geologicalFormations = new GeologicalFormationTable(this.provider)
                .filterByDangerLevel(dangerLevel);
        final List<List<String>> output = new LinkedList<>();
        geologicalFormations.forEach(g -> {
            final String query = "SELECT Nome, NomePaese FROM "
                    + Constants.LOCATIONS + "," + Constants.EXPEDITIONS + "," + Constants.SIGHTINGS
                    + Constants.WHERE + Constants.LOCATIONS + ".Nome"
                    + Constants.EQUALS + Constants.EXPEDITIONS + ".NomeLuogo"
                    + Constants.AND + Constants.SIGHTINGS + ".CodiceSpedizione"
                    + Constants.EQUALS + Constants.EXPEDITIONS + ".Codice"
                    + Constants.AND + Constants.SIGHTINGS + ".IDformazionegeologica" + Constants.QUESTION_MARK;
            try (PreparedStatement statement = this.provider.getMySQLConnection().prepareStatement(query)) {
                statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, g.getID());
                final ResultSet resultSet = statement.executeQuery();
                final List<String> list = new ArrayList<>();
                list.add(g.getID());
                list.add(g.getType());
                list.add(String.valueOf(g.getSize()));
                list.add(g.getDescription());
                list.add(resultSet.getString("Nome"));
                list.add(resultSet.getString("NomePaese"));
                output.add(list);
            } catch (final SQLException e) {
                TableUtilities.logSQLException(this, e);
            }
        });
        return output;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<String>> filterLocationsByWreck(final String wreckName) {
        final List<Wreck> wrecks = new WreckTable(this.provider).filterByName(wreckName);
        final Set<List<String>> output = new HashSet<>();
        wrecks.forEach(w -> {
            final List<String> list = new ArrayList<>();
            final String query = "SELECT Nome, NomePaese " + " FROM "
                    + Constants.LOCATIONS + "," + Constants.EXPEDITIONS + "," + Constants.SIGHTINGS
                    + Constants.WHERE + Constants.LOCATIONS + ".Nome"
                    + Constants.EQUALS + Constants.EXPEDITIONS + ".NomeLuogo"
                    + Constants.AND + Constants.SIGHTINGS + ".CodiceSpedizione"
                    + Constants.EQUALS + Constants.EXPEDITIONS + ".Codice"
                    + Constants.AND + Constants.SIGHTINGS + ".IDrelitto" + Constants.QUESTION_MARK;
            try (PreparedStatement statement = this.provider.getMySQLConnection().prepareStatement(query)) {
                statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, w.getID());
                final ResultSet resultSet = statement.executeQuery();
                list.add(w.getID());
                list.add(resultSet.getString("Nome"));
                list.add(resultSet.getString("NomePaese"));
                output.add(list);
            } catch (final SQLException e) {
                TableUtilities.logSQLException(this, e);
            }
        });
        return new LinkedList<>(output);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<String>> getAnalysesInfo(final String materialName) {
        final List<Extraction> extractions = new ExtractionTable(this.provider).filterByMaterial(materialName);
        final AnalysisTable analysisTable = new AnalysisTable(this.provider);
        final List<List<String>> output = new LinkedList<>();
        extractions.forEach(e -> {
            final Optional<Analysis> analysis = analysisTable.findByExtractionCode(e.getCode());
            analysis.ifPresent(a -> {
                final Optional<Laboratory> laboratory = new LaboratoryTable(this.provider)
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
