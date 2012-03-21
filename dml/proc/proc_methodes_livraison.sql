DELIMITER |
DROP PROCEDURE IF EXISTS methodes_livraison|

CREATE PROCEDURE methodes_livraison(IN libelle VARCHAR(100))
BEGIN
	CASE libelle
		WHEN 'rapide' THEN 
            SELECT * FROM commandes cde
            INNER JOIN methodes_livraison ml ON cde.methodes_livraison_id = ml.id
            WHERE ml.libelle = 'rapide';

		WHEN 'prioritaire' THEN 
            SELECT * FROM commandes cde
            INNER JOIN methodes_livraison ml ON cde.methodes_livraison_id = ml.id
            WHERE ml.libelle = 'prioritaire';

		WHEN 'relais_kiala' THEN  
            SELECT * FROM commandes cde
            INNER JOIN methodes_livraison ml ON cde.methodes_livraison_id = ml.id
            WHERE ml.libelle = 'relais_kiala';

		ELSE SELECT 'Erreur';
	END CASE;
END|

CALL methodes_livraison('prioritaire')|

