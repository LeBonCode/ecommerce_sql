DELIMITER |
DROP PROCEDURE IF EXISTS consultation_catalogue|

CREATE PROCEDURE consultation_catalogue (IN page INT, IN categories_id INT, IN nom_produit VARCHAR(100), IN prix_inf INT, IN prix_sup INT)
BEGIN
    DECLARE par_page INT DEFAULT 20;
    DECLARE offset INT DEFAULT (page-1)*par_page;

    IF !ISNULL(nom_produit) THEN
        SELECT * FROM produits p WHERE p.libelle LIKE CONCAT('%',nom_produit,'%');
    ELSE
        SELECT * FROM produits p WHERE p.categories_id = categories_id LIMIT offset,par_page;
    END IF;
END|

CALL consultation_catalogue(null,null,'bibendum',null,null)|
CALL consultation_catalogue(1,2,null,null,null)|