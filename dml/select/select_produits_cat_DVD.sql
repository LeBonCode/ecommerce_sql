/*Selection des produits dans la catégorie DVD */
SELECT * FROM produits p INNER JOIN categories c ON p.categories_id = c.id WHERE c.libelle = 'DVD'



