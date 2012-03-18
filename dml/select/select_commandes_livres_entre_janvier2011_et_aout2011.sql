SELECT * FROM produits p
INNER JOIN livraisons_has_produits lhp ON p.id = lhp.produits_id
INNER JOIN livraisons l ON lhp.livraisons_id = l.id
WHERE l.date_expedition BETWEEN '2011-01-00 00:00:00' AND '2011-08-00 00:00:00'