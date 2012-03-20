DELIMITER |
DROP PROCEDURE IF EXISTS gestion_adresses_utilisateur|

CREATE PROCEDURE gestion_adresses_utilisateur(IN utilisateur_id INT, IN ordre VARCHAR(100))
BEGIN
    CASE ordre
    WHEN 'add' THEN SELECT 'Je suis 1';
    
    WHEN 'delete' THEN SELECT 'Je suis 2';
    
    WHEN 'get' THEN SELECT adr.id, adr.numero, adr.voie, adr.cp, adr.ville, u.id FROM adresses adr 
                    INNER JOIN utilisateurs u ON u.id = adr.utilisateurs_id
                    WHERE u.id = utilisateur_id;
                            
    ELSE SELECT 'Je suis autre chose que 1 et 2';
        END CASE;
END|

CALL gestion_adresses_utilisateur(3, 'get')|
CALL gestion_adresses_utilisateur(5, 'get')|

