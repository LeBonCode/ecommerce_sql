DELIMITER |
DROP PROCEDURE IF EXISTS consultation_catalogue|

CREATE PROCEDURE consultation_catalogue (IN page INT, IN categories_id INT, IN nom_produit VARCHAR(100), IN prix_inf INT, IN prix_sup INT)
BEGIN
	DECLARE par_page INT DEFAULT 20;
	DECLARE offset INT;
	DECLARE cond VARCHAR(8000) DEFAULT "";
	DECLARE cond_prix_inf VARCHAR(8000) DEFAULT "";
	DECLARE cond_prix_sup VARCHAR(8000) DEFAULT "";
	
	SET @query = "SELECT * FROM produits p";
	
    IF !ISNULL(nom_produit) THEN
		SET cond = CONCAT("p.libelle LIKE '%",nom_produit,"%'");
    ELSEIF !ISNULL(page) THEN
		SET offset := (page-1)*par_page;
		SET cond = CONCAT("p.categories_id = categories_id LIMIT ", offset, ",", par_page);
    END IF;

	IF !ISNULL(prix_inf) THEN
		SET cond_prix_inf = CONCAT(cond_prix_inf, " prix >= ", prix_inf);
	END IF;
	
	IF !ISNULL(prix_sup) THEN
		SET cond_prix_sup = CONCAT(cond_prix_sup, " prix <= ", prix_sup);
	END IF;
	
	IF cond != "" AND cond_prix_inf != "" THEN
		SET cond_prix_inf = CONCAT(" AND ", cond_prix_inf);
	END IF;
    
	IF (cond != "" OR cond_prix_inf != "") AND cond_prix_sup != "" THEN
		SET cond_prix_sup = CONCAT(" AND ", cond_prix_sup);
	END IF;
	SET @query = CONCAT(@query, " WHERE ", cond, cond_prix_inf, cond_prix_sup);

	PREPARE stmt FROM @query;
	EXECUTE stmt;
END|

CALL consultation_catalogue(null,null,'bibendum',null,null)|
CALL consultation_catalogue(1,2,null,null,null)|
CALL consultation_catalogue(null,null,null,10,100)|
