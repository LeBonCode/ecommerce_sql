SELECT u.id, u.nom, u.prenom, cde.id FROM commandes cde 
INNER JOIN adresses adr ON adr.id = cde.adresses_facturation_id
INNER JOIN utilisateurs u ON u.id = adr.utilisateurs_id
ORDER BY u.id
