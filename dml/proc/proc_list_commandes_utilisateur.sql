DELIMITER |
DROP PROCEDURE IF EXISTS list_commandes_utilisateur|

CREATE PROCEDURE list_commandes_utilisateur(IN utilisateur_id INT)
BEGIN
    SELECT u.id, u.nom, u.prenom, cde.id FROM commandes cde 
    INNER JOIN adresses adr ON adr.id = cde.adresses_facturation_id
    INNER JOIN utilisateurs u ON u.id = adr.utilisateurs_id
    WHERE u.id = utilisateur_id;
END|

CALL list_commandes_utilisateur(5)|
CALL list_commandes_utilisateur(7)| 