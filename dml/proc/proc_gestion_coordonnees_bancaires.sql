DELIMITER |
DROP PROCEDURE IF EXISTS gestion_coordonnees_bancaires|

CREATE PROCEDURE gestion_coordonnees_bancaires(IN ordre VARCHAR(4), IN numero VARCHAR(16), IN date_expiration DATETIME, IN code_securite INT, IN utilisateur_id INT, IN nom_titulaire VARCHAR(45), IN carte_credit_id INT)
BEGIN
	CASE ordre
		WHEN 'add' THEN INSERT INTO cartes_credit (numero, date_expiration, code_securite, utilisateurs_id, nom_titulaire) VALUES(numero, date_expiration, code_securite, utilisateur_id, nom_titulaire);

		WHEN 'del' THEN DELETE FROM cartes_credit WHERE id = carte_credit_id;

		WHEN 'edit' THEN UPDATE cartes_credit SET numero = numero, date_expiration = date_expiration, code_securite = code_securite, utilisateurs_id = utilisateur_id, nom_titulaire = nom_titulaire WHERE id = carte_credit_id;

		WHEN 'get' THEN SELECT * FROM cartes_credit WHERE utilisateurs_id = utilisateur_id;

		ELSE SELECT 'Erreur';
	END CASE;
END|

CALL gestion_coordonnees_bancaires("add", 1234567891011121, '2012-12-12', 911, 1, "Lorem Ipsum", null)|
CALL gestion_coordonnees_bancaires("get", null, null, null, 1, null, null)|
CALL gestion_coordonnees_bancaires("edit", 1234567891011121, '2012-12-12', 923, 1, "Lorem Ipsum", last_insert_id())|
CALL gestion_coordonnees_bancaires("get", null, null, null, 1, null, null)|
CALL gestion_coordonnees_bancaires("del", null, null, null, null, null, last_insert_id())|
CALL gestion_coordonnees_bancaires("get", null, null, null, 1, null, null)|