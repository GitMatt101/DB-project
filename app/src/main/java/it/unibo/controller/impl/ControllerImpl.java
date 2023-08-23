package it.unibo.controller.impl;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import it.unibo.common.ConnectionProvider;
import it.unibo.common.Constants;
import it.unibo.common.Pair;
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
    public void showLocationsByMostDangerous() {
        final String query = "SELECT AVG(F.GradoPericolo) AS media, L.Nome, L.NomePaese"
                + " FROM " + Constants.GEOLOGICAL_FORMATIONS + " F"
                + Constants.JOIN + Constants.SIGHTINGS + " A ON A.IDformazionegeologica = F.ID"
                + Constants.JOIN + Constants.EXPEDITIONS + " S ON S.Codice = A.CodiceSpedizione"
                + Constants.JOIN + Constants.LOCATIONS + " L ON L.Nome = S.NomeLuogo"
                + " GROUP BY L.Nome ORDER BY media DESC";
        final List<List<String>> values = new LinkedList<>();
        try (PreparedStatement statement = this.provider.getMySQLConnection().prepareStatement(query)) {
            final ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                values.add(List.of(
                        resultSet.getString("Nome"),
                        resultSet.getString("NomePaese"),
                        String.valueOf(resultSet.getFloat("media"))));
            }
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
        }
        this.outputManager.showMostDangerousLocations(values);
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
            attributes.add(String.valueOf(o.getDiscoveryDate()));
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
            attributes.add(g.getDangerLevel() + "/5");
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
        final Optional<ROV> rov = new ROVTable(this.provider).findByPrimaryKey(rovLicencePlate);
        if (rov.isPresent() && rov.get().getProductionDate().getTime() <= date.getTime()) {
            return new ExpeditionTable(this.provider)
                .save(new Expedition(code, date, locationName, rovLicencePlate, groupID, associationName));
        } else {
            this.outputManager.showErrorMessage("Targa non valida");
            return false;
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean registerOrganism(final String id, final String temportaryName, final String description) {
        if (temportaryName.length() > 0 && id.length() > 0) {
            return new OrganismTable(this.provider).save(new Organism(
                    id,
                    Optional.empty(),
                    Optional.of(temportaryName),
                    Optional.empty(),
                    description));
        }
        return false;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean registerWreck(final String id, final Optional<String> name, final Optional<Integer> sinkDate,
            final Integer length, final String description) {
        if (id.length() > 0) {
            return new WreckTable(this.provider).save(new Wreck(id, name, sinkDate, length, description));
        }
        return false;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean registerGeologicalFormation(final String id, final String type, final Integer size,
            final Integer dangerLevel, final String description) {
        if (id.length() > 0) {
            return new GeologicalFormationTable(this.provider)
                    .save(new GeologicalFormation(id, type, size, dangerLevel, description));
        }
        return false;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean registerSighting(final String code, final String expeditionCode,
            final Integer depth, final String notes, final String organismID, final String wreckID,
            final String geologicalFormationID) {
        if (organismID != null && new OrganismTable(this.provider).findByPrimaryKey(organismID).isEmpty()) {
            this.inputManager.organismRegistration();
            return false;
        } else if (wreckID != null && new WreckTable(this.provider).findByPrimaryKey(wreckID).isEmpty()) {
            this.inputManager.wreckRegistration();
            return false;
        } else if (geologicalFormationID != null
                && new GeologicalFormationTable(this.provider).findByPrimaryKey(geologicalFormationID).isEmpty()) {
            this.inputManager.geologicalFormationRegistration();
            return false;
        } else {
            final int number = TableUtilities.getNextNumber(Constants.SIGHTINGS, expeditionCode,
                    this.provider.getMySQLConnection(), this);
            return number != -1 && new SightingTable(this.provider)
                    .save(new Sighting(code, expeditionCode, number,
                            Optional.ofNullable(depth), Optional.ofNullable(notes),
                            Optional.ofNullable(organismID), Optional.ofNullable(wreckID),
                            Optional.ofNullable(geologicalFormationID)));
        }
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
        return createOrganismList(organisms);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<String>> filterLocationsByWreck(final String wreckName) {
        final String query = "SELECT COUNT(R.ID) AS numero, L.Nome, L.NomePaese"
                + " FROM " + Constants.WRECKS + " R"
                + Constants.JOIN + Constants.SIGHTINGS + " A ON A.IDrelitto = R.ID"
                + Constants.JOIN + Constants.EXPEDITIONS + " S ON S.Codice = A.CodiceSpedizione"
                + Constants.JOIN + Constants.LOCATIONS + " L ON L.Nome = S.NomeLuogo"
                + Constants.WHERE + "R.Nome" + Constants.QUESTION_MARK
                + " GROUP BY L.Nome ORDER BY numero DESC";
        final List<List<String>> values = new LinkedList<>();
        try (PreparedStatement statement = this.provider.getMySQLConnection().prepareStatement(query)) {
            statement.setString(Constants.SINGLE_QUERY_VALUE_INDEX, wreckName);
            final ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                values.add(List.of(
                        resultSet.getString("Nome"),
                        resultSet.getString("Nomepaese"),
                        String.valueOf(resultSet.getInt("numero"))));
            }
        } catch (final SQLException e) {
            TableUtilities.logSQLException(this, e);
        }
        return new LinkedList<>(values);
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

    /**
     * {@inheritDoc}
     */
    @Override
    public List<List<String>> getScientificprogress(final Integer minYear, final Integer maxYear) {
        final List<Pair<Integer, Integer>> results = new OrganismTable(this.provider).getDiscoveries(minYear, maxYear);
        final List<List<String>> output = new LinkedList<>();
        final List<Integer> values = new LinkedList<>();
        final List<Float> percentages = new LinkedList<>();
        results.forEach(r -> {
            final int n = r.getY();
            values.add(n);
            final float avg = (float) values.stream().mapToInt(Integer::intValue).sum() / (float) values.size();
            final float perc = ((float) n) * 100 / avg - 100;
            percentages.add(perc);
        });
        Collections.reverse(results);
        Collections.reverse(percentages);
        final DecimalFormat df = new DecimalFormat("0.00");
        for (int i = 0; i < results.size(); i++) {
            final String perc = percentages.get(i) >= 0.0f ? "+" + df.format(percentages.get(i)) + "%"
                    : df.format(percentages.get(i)) + "%";
            output.add(List.of(String.valueOf(results.get(i).getX()),
                    String.valueOf(results.get(i).getY()), perc));
        }
        return output;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void openYearChoice() {
        this.inputManager.yearChoice();
    }

}
