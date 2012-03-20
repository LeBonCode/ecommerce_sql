/* Selection de tous les produits de la commande numéro 2 */
SELECT * FROM produits p 
INNER JOIN commandes_has_produits chp ON chp.produits_id = p.id
INNER JOIN commandes cde ON cde.id = commandes_id
WHERE cde.id = 2