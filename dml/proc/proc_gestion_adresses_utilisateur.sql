DELIMITER |
DROP PROCEDURE IF EXISTS gestion_adresses_utilisateur|

CREATE PROCEDURE gestion_adresses_utilisateur(IN utilisateur_id INT, IN ordre VARCHAR(100), IN numero VARCHAR(45), IN voie VARCHAR(45), IN cp VARCHAR(45), IN ville VARCHAR(45), IN pays_id INT)
BEGIN
    CASE ordre
    WHEN 'add' THEN INSERT INTO adresses (numero, voie, cp, ville, utilisateurs_id, pays_id) VALUES(numero, voie, cp, ville, utilisateur_id, pays_id);
    
    WHEN 'delete' THEN SELECT 'Je suis 2';
    
    WHEN 'get' THEN SELECT adr.id, adr.numero, adr.voie, adr.cp, adr.ville, u.id FROM adresses adr 
                    INNER JOIN utilisateurs u ON u.id = adr.utilisateurs_id
                    WHERE u.id = utilisateur_id;
                            
    ELSE SELECT 'Erreur';
        END CASE;
END|

/*CALL gestion_adresses_utilisateur(3, 'get', null, null, null, null, null)|*/
CALL gestion_adresses_utilisateur(5, 'add', '13', 'Avenue plop ipsum', '33100', 'Talence', 1)|
CALL gestion_adresses_utilisateur(5, 'get', null, null, null, null, null)|
