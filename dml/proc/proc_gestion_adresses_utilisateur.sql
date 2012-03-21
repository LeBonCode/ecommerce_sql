DELIMITER |
DROP PROCEDURE IF EXISTS gestion_adresses_utilisateur|

CREATE PROCEDURE gestion_adresses_utilisateur(IN ordre VARCHAR(100), IN numero VARCHAR(45), IN voie VARCHAR(45), IN cp VARCHAR(45), IN ville VARCHAR(45), IN pays_id INT, IN utilisateur_id INT, IN adresse_id INT)
BEGIN
	CASE ordre
		WHEN 'add' THEN INSERT INTO adresses (numero, voie, cp, ville, utilisateurs_id, pays_id) VALUES(numero, voie, cp, ville, utilisateur_id, pays_id);

		WHEN 'del' THEN DELETE FROM adresses WHERE id = adresse_id;

		WHEN 'edit' THEN UPDATE adresses SET numero = numero, voie = voie, cp = cp, ville = ville, pays_id = pays_id WHERE id = adresse_id;

		WHEN 'get' THEN SELECT * FROM adresses WHERE utilisateurs_id = utilisateur_id;

		ELSE SELECT 'Erreur';
	END CASE;
END|

CALL gestion_adresses_utilisateur('add', 2, "rue des chats perchés", 33000, "Bordeaux", 1, 1, null)|
CALL gestion_adresses_utilisateur('get', null, null, null, null, null, 1, null)|
CALL gestion_adresses_utilisateur('edit', 2, "rue des chats perchés", 33800, "Bordeaux", 1, 1, last_insert_id())|
CALL gestion_adresses_utilisateur('get', null, null, null, null, null, 1, null)|
CALL gestion_adresses_utilisateur('del', null, null, null, null, null, null, last_insert_id())|
CALL gestion_adresses_utilisateur('get', null, null, null, null, null, 1, null)|