SELECT SUM(prix) AS montant_commande FROM produits p 
INNER JOIN commandes_has_produits chp ON p.id = chp.produits_id
INNER JOIN commandes c ON chp.commandes_id = c.id
WHERE c.id = 5