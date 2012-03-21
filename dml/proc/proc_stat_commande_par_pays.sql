DELIMITER |
DROP PROCEDURE IF EXISTS stat_commande_par_pays|

CREATE PROCEDURE stat_commande_par_pays(IN date_inf DATETIME, IN date_sup DATETIME)
BEGIN
	DECLARE curseur CURSOR FOR SELECT * FROM pays;
	OPEN curseur1; # ouverture du curseur1

    # première ligne du résultat
    FETCH curseur1 INTO var_identifiant, var_mot_passe;
    SELECT var_identifiant, var_mot_passe;

    CLOSE curseur1; # fermeture du curseur1
END|

CALL stat_produits_livrees_par_date('2011-12-02', NOW())|
CALL stat_produits_livrees_par_date('1995-12-02', '2012-01-01')|