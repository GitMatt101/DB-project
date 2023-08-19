package it.unibo.controller.api;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import it.unibo.model.entities.Expedition;
import it.unibo.model.entities.GeologicalFormation;
import it.unibo.model.entities.Material;
import it.unibo.model.entities.Organism;
import it.unibo.model.entities.ROV;
import it.unibo.model.entities.Wreck;
import it.unibo.model.entities.impl.Extraction;
import it.unibo.model.entities.impl.Member;
import it.unibo.model.entities.impl.Sighting;

/**
 * This interface models a controller according to the MVC architecture pattern.
 */
public interface Controller {

    /**
     * Shows all the {@link Organism}s in the database.
     */
    void showAllOrganisms();

    /**
     * Shows all the {@link Wreck}s in the database.
     */
    void showAllWrecks();

    /**
     * Shows all the {@link GeologicalFormation}s in the database.
     */
    void showAllGeologicalFormations();

    /**
     * Shows all the {@link Sighting}s in the database.
     */
    void showAllSightings();

    /**
     * Shows all the {@code Associations} in the database.
     */
    void showAllAssociations();

    /**
     * Shows all the {@link Expedition}s in the database.
     */
    void showAllExpeditions();

    /**
     * Opens the popup for {@link Member} registration.
     */
    void openMemberRegistration();

    /**
     * Opens the popup for {@link ROV} registration.
     */
    void openROVRegistration();

    /**
     * Opens the popup for {@link Expedition} registration.
     */
    void openExpeditionRegistration();

    /**
     * Opens the popup for {@link Sighting} registration.
     */
    void openSightingRegistration();

    /**
     * Opens the popup for {@link Extraction} registration.
     */
    void openExtractionRegistration();

    /**
     * Opens the popup for the species update of a previously unidentified organism.
     */
    void openSpeciesUpdate();

    /**
     * Opens the popup for the {@link Sighting}s filter.
     */
    void openSightingsFilter();

    /**
     * Opens the popup for the {@link Extraction}s filter.
     */
    void openExtractionsFilter();

    /**
     * Opens the popup for the {@link Expedition}s filter by association.
     */
    void openExpeditionsFilterByAssociation();

    /**
     * Opens the popup for the {@link Organism}s filter by {@link Expedition}.
     */
    void openOrganismsFilterByExpedition();

    /**
     * Opens the popup for the {@link GeologicalFormation}s filter by danger level.
     */
    void openGeologicalFormationsFilterByDangerLevel();

    /**
     * Opens the popup for the {@link Wreck}s filter by name.
     */
    void openWrecksFilterByName();

    /**
     * Opens the popup for the {@link Extraction}s filter by {@link Material}.
     */
    void openAnalysesFilterByMaterial();

    /**
     * Registers a new {@link Member} in the database.
     * 
     * @param firstName       the first name of the member
     * @param lastName        the last name of the member
     * @param fiscalCode      the fiscal code of the member
     * @param associationName the name of the association the member works for
     * @param groupID         the ID of the group the member is part of
     * @param id              the ID of the member
     * @param role            the role of the member
     * @return true if the registration was successful, false otherwise
     */
    boolean registerMember(String firstName, String lastName, String fiscalCode, String associationName, String groupID,
            String id, String role);

    /**
     * Registers a new {@link ROV} in the database.
     * 
     * @param licensePlate     the ROV's license plate
     * @param manufacturerName the ROV's manufacturer name
     * @param serialNumber     the ROV's serial number given by the manufacturer
     * @param productionDate   the ROV's production date
     * @return true if the operation is successful, false otherwise
     */
    boolean registerROV(String licensePlate, String manufacturerName, String serialNumber, Date productionDate);

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
    boolean registerExpedition(String code, Date date, String locationName, String rovLicencePlate,
            String associationName, String groupID);

    /**
     * Registers a new {@link Sighting} in the database.
     * Each sighting's number is automatically generated by auto incrementing the
     * value of the previous entry.
     * 
     * @param code                  the code of the sighting
     * @param expeditionCode        the code of the expedition
     * @param depth                 the depth at which the sighting occurred (null
     *                              if not specified)
     * @param notes                 the notes of the sighting (null if not
     *                              specified)
     * @param organismID            the ID of the organism (null if not specified)
     * @param wreckID               the ID of the wreck (null if not specified)
     * @param geologicalFormationID the ID of the geological formation (null if not
     *                              specified)
     * @return true if the operation is successful, false otherwise
     */
    boolean registerSighting(String code, String expeditionCode, Integer depth, String notes, String organismID,
            String wreckID, String geologicalFormationID);

    /**
     * Registers a new {@link Extraction} in the database.
     * Each extraction's number is automatically generated by auto incrementing the
     * value of the previous entry.
     * 
     * @param code           the code of the extraction
     * @param expeditionCode the code of the expedition
     * @param materialName   the name of the material extracted
     * @param depth          the depth at which the extraction occurred (null if not
     *                       specified)
     * @param amount         the amount of material extracted
     * @param notes          the notes of the extraction (null if not specified)
     * @return true if the operation is successful, false otherwise
     */
    boolean registerExtraction(String code, String expeditionCode, String materialName, Integer depth, Float amount,
            String notes);

    /**
     * Updates the species of a previously unidentified {@link Organism}.
     * 
     * @param organismID     the ID of the organism to be updated
     * @param updatedSpecies the new species
     * @return true if the operation is successful, false otherwise
     */
    boolean updateSpecies(String organismID, String updatedSpecies);

    /**
     * Applies the given research filters to retrieve a list of {@link Sighting}s.
     * Each field of the filter is an {@link Optional} of the type of the field, or
     * an empty {@link Optional} if the field is not specified.
     * 
     * @param locationName          the name of the location
     * @param minDepth              the minimum depth
     * @param maxDepth              the maximum depth
     * @param expeditionCode        the code of the expedition
     * @param organismID            the ID of the organism
     * @param wreckID               the ID of the wreck
     * @param geologicalFormationID the ID of the geological formation
     * @return a list of {@link Sighting}s, each represented by a list of its
     *         attributes, following the order:
     *         <ul>
     *         <li>code of the sighting</li>
     *         <li>code of the expedition</li>
     *         <li>number</li>
     *         <li>depth</li>
     *         <li>notes</li>
     *         <li>ID of the organism</li>
     *         <li>ID of the wreck</li>
     *         <li>ID of the geological formation</li>
     *         </ul>
     */
    List<List<String>> filterSightings(Optional<String> locationName, Optional<Integer> minDepth,
            Optional<Integer> maxDepth, Optional<String> expeditionCode, Optional<String> organismID,
            Optional<String> wreckID, Optional<String> geologicalFormationID);

    /**
     * Applies the given research filters to retrieve a list of {@link Extraction}s.
     * Each field of the filter is an {@link Optional} of the type of the field, or
     * an empty {@link Optional} if the field is not specified.
     * 
     * @param locationName   the name of the location
     * @param minDepth       the minimum depth
     * @param maxDepth       the maximum depth
     * @param expeditionCode the code of the expedition
     * @param materialName   the name of the material
     * @return a list of {@link Extraction}s, each represented by a list of its
     *         attributes, following the order:
     *         <ul>
     *         <li>code of the extraction</li>
     *         <li>code of the expedition</li>
     *         <li>number</li>
     *         <li>name of the material</li>
     *         <li>depth</li>
     *         <li>amount</li>
     *         <li>notes</li>
     *         </ul>
     */
    List<List<String>> filterExtractions(Optional<String> locationName, Optional<Integer> minDepth,
            Optional<Integer> maxDepth, Optional<String> expeditionCode, Optional<String> materialName);

    /**
     * Retrieves all the {@link Expedition}s organized by an association.
     * 
     * @param associationName the name of the association
     * @return a list of sightings, each represented by a list of its attributes, in
     *         the following order:
     *         <ul>
     *         <li>code (String)</li>
     *         <li>date (String)</li>
     *         <li>location (String)</li>
     *         <li>association name (String)</li>
     *         <li>group ID (String)</li>
     *         <li>list of member names followed by their role (List of String)</li>
     *         </ul>
     */
    List<List<Object>> filterExpeditionsByAssociation(String associationName);

    /**
     * Retrieves all the organisms sighted during an {@link Expedition}.
     * 
     * @param expeditionCode the code of the expedition
     * @return a list of organisms, each represented by a list of its attributes, in
     *         the following order:
     *         <ul>
     *         <li>ID</li>
     *         <li>species</li>
     *         <li>temporary name</li>
     *         <li>common name</li>
     *         <li>description</li>
     *         </ul>
     */
    List<List<String>> filterOrganismsByExpedition(String expeditionCode);

    /**
     * Retrieves all the {@link GeologicalFormation}s with a specific danger level
     * and the {@link Location}s they are situated in.
     * 
     * @param dangerLevel the danger level of the geological formations
     * @return a list of geological formations, each represented by a list of its
     *         attributes, in the following order:
     *         <ul>
     *         <li>ID</li>
     *         <li>type</li>
     *         <li>size</li>
     *         <li>description</li>
     *         <li>name of the location</li>
     *         <li>name of the country</li>
     *         </ul>
     */
    List<List<String>> filterGeologicalFormationsByDangerLevel(Integer dangerLevel);

    /**
     * Retrieves all the locations where a certain {@link Wreck} was spotted.
     * 
     * @param wreckName the model of the wreck
     * @return a list of wreck IDs, location names and country names.
     */
    List<List<String>> filterLocationsByWreck(String wreckName);

    /**
     * Retrieves all the information regarding all the analyses performed on a
     * {@link Material}.
     * 
     * @param materialName the name of the material
     * @return a list of analyses, each represented by a list of its attributes, in
     *         the following order:
     *         <ul>
     *         <li>code of the analysis</li>
     *         <li>description of the analysis</li>
     *         <li>name of the laboratory</li>
     *         <li>ID of the laboratory</li>
     *         <li>address of the laboratory</li>
     *         </ul>
     * 
     */
    List<List<String>> getAnalysesInfo(String materialName);

}
