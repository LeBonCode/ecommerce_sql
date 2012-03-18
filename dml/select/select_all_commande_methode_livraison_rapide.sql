SELECT * FROM commandes cde
INNER JOIN methodes_livraison ml ON cde.methodes_livraison_id = ml.id
WHERE ml.libelle = 'rapide'