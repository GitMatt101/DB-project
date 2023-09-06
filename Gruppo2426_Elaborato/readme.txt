STRUMENTI NECESSARI:
MySQL Workbench, JDK 17

PREPARAZIONE DEL DATABASE:
1) Aprire MySQL Workbench ed entrare con connessione (in locale) localhost, root
2) Creare un nuovo utente andando su (Administration->Users and Privileges->Add Account) con le seguenti credenziali:
	Login Name: mattia
	Authentication Type: caching_sha2_passowrd
	Limits to Hosts Matching: localhost
	Password: mattiaDB%123
3) Conferire tutti i ruoli necessari all'interazione con il database all'utente appena creato:
	-DBManager
	-DBDesigner
	-BackupAdmin
	-(nel pannello sulla destra) REFERENCES
4) Importare il database dal file esplorazioni.sql tramite Server -> Data Import

ESECUZIONE DELL'APPLICATIVO:
Per avviare l'applicazione eseguire il file EsplorazioniAPP-all.jar tramite:
	-doppio click sul file
	-riga di comando dalla directory dove è presente il file jar -> java -jar EsplorazioniAPP-all.jar
Nell'applicazione sono già presenti le credenziali di accesso al database.