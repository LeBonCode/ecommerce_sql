DELIMITER |
DROP PROCEDURE IF EXISTS calcul_montant_commande|

CREATE PROCEDURE calcul_montant_commande(IN commande_id INT)
BEGIN
	DECLARE user_id INT;
	
	SELECT SUM(prix) + fdp.tarif AS montant_commande_avec_fdp, SUM(prix) AS montant_commande 
	FROM produits p 
	INNER JOIN commandes_has_produits chp ON p.id = chp.produits_id
	INNER JOIN commandes c ON chp.commandes_id = c.id
	INNER JOIN adresses a ON a.id = c.adresses_livraison_id
	INNER JOIN frais_de_port fdp ON (fdp.methodes_livraison_id = c.methodes_livraison_id AND fdp.pays_id = a.pays_id)
	WHERE c.id = commande_id;
END|

CALL calcul_montant_commande(1)|
CALL calcul_montant_commande(3)|