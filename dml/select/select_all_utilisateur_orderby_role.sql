SELECT * FROM utilisateurs u 
INNER JOIN roles r ON r.id = u.roles_id
ORDER BY r.libelle