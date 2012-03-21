/* ATTENTION genere un fichier csv par pays dans le dossier mydb(repertoire de la base de données) qui est dans mysql */
/* Il faut penser à les supprimer après tests */
DELIMITER |
DROP PROCEDURE IF EXISTS stat_commande_par_pays|

CREATE PROCEDURE stat_commande_par_pays(IN date_inf DATETIME, IN date_sup DATETIME)
BEGIN
	DECLARE done INT DEFAULT 0;
	DECLARE pays_id INT;
	DECLARE nom_pays VARCHAR(45);
	DECLARE curseur CURSOR FOR SELECT * FROM pays;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

	OPEN curseur;
	REPEAT
	FETCH curseur INTO pays_id, nom_pays;
	SET @sql_text = 
	CONCAT (
		"SELECT * 
		FROM commandes c
		INNER JOIN adresses a ON a.id = c.adresses_facturation_id
		WHERE a.pays_id = pays_id
		INTO OUTFILE 'commandes_",
		nom_pays,
		date_format(now(),'%Y%m%d%H%i'),
		".csv' ",
		"FIELDS TERMINATED BY ','
		ENCLOSED BY '\"'
		LINES TERMINATED BY '\n'"
	);
	PREPARE s1 FROM @sql_text;
	EXECUTE s1;
	UNTIL done END REPEAT;
END|

CALL stat_commande_par_pays('2011-12-02', NOW())|
/*CALL stat_commande_par_pays('1995-12-02', '2012-01-01')|*/