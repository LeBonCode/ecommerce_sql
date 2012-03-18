USE mydb;
INSERT INTO categories (id, libelle) VALUES (1, 'culturel');
SHOW WARNINGS;
INSERT INTO categories (id, libelle, categories_id) 
VALUES	(2, 'DVD', 1),
		(3, 'CD', 1),
		(4, 'livres', 1);
SHOW WARNINGS;