DELIMITER |
DROP PROCEDURE IF EXISTS stat_produits_livrees_par_date|

CREATE PROCEDURE stat_produits_livrees_par_date(IN date_inf DATETIME, IN date_sup DATETIME)
BEGIN
	SELECT count(p.id) AS nombre_de_produits, p.id AS produit_id FROM produits p
	INNER JOIN livraisons_has_produits lhp ON p.id = lhp.produits_id
	INNER JOIN livraisons l ON lhp.livraisons_id = l.id
	WHERE l.date_expedition BETWEEN date_inf AND date_sup
	GROUP BY p.id
	ORDER BY nombre_de_produits DESC, produit_id;
END|

CALL stat_produits_livrees_par_date('2011-12-02', NOW())|
CALL stat_produits_livrees_par_date('1995-12-02', '2012-01-01')|