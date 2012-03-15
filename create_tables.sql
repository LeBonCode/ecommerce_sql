SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
SHOW WARNINGS;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`roles` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `mydb`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `libelle` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`utilisateurs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`utilisateurs` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `mydb`.`utilisateurs` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `email` VARCHAR(45) NULL ,
  `password` VARCHAR(45) NULL ,
  `nom` VARCHAR(45) NULL ,
  `prenom` VARCHAR(45) NULL ,
  `roles_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_utilisateurs_roles` (`roles_id` ASC) ,
  CONSTRAINT `fk_utilisateurs_roles`
    FOREIGN KEY (`roles_id` )
    REFERENCES `mydb`.`roles` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`pays`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`pays` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `mydb`.`pays` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `libelle` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`adresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`adresses` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `mydb`.`adresses` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `numero` VARCHAR(45) NULL ,
  `voie` VARCHAR(45) NULL ,
  `cp` VARCHAR(45) NULL ,
  `ville` VARCHAR(45) NULL ,
  `utilisateurs_id` INT NOT NULL ,
  `pays_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_adresses_utilisateurs1` (`utilisateurs_id` ASC) ,
  INDEX `fk_adresses_pays1` (`pays_id` ASC) ,
  CONSTRAINT `fk_adresses_utilisateurs1`
    FOREIGN KEY (`utilisateurs_id` )
    REFERENCES `mydb`.`utilisateurs` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_adresses_pays1`
    FOREIGN KEY (`pays_id` )
    REFERENCES `mydb`.`pays` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`methodes_livraison`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`methodes_livraison` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `mydb`.`methodes_livraison` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `libelle` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`commandes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`commandes` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `mydb`.`commandes` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `date` DATETIME NULL ,
  `methodes_livraison_id` INT NOT NULL ,
  `adresses_livraison_id` INT NOT NULL ,
  `adresses_facturation_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_commandes_methodes_livraison1` (`methodes_livraison_id` ASC) ,
  INDEX `fk_commandes_adresses1` (`adresses_livraison_id` ASC) ,
  INDEX `fk_commandes_adresses2` (`adresses_facturation_id` ASC) ,
  CONSTRAINT `fk_commandes_methodes_livraison1`
    FOREIGN KEY (`methodes_livraison_id` )
    REFERENCES `mydb`.`methodes_livraison` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commandes_adresses1`
    FOREIGN KEY (`adresses_livraison_id` )
    REFERENCES `mydb`.`adresses` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commandes_adresses2`
    FOREIGN KEY (`adresses_facturation_id` )
    REFERENCES `mydb`.`adresses` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`livraisons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`livraisons` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `mydb`.`livraisons` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `date_expedition` DATETIME NULL ,
  `commandes_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_livraisons_commandes1` (`commandes_id` ASC) ,
  CONSTRAINT `fk_livraisons_commandes1`
    FOREIGN KEY (`commandes_id` )
    REFERENCES `mydb`.`commandes` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`cartes_credit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`cartes_credit` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `mydb`.`cartes_credit` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `numero` VARCHAR(45) NOT NULL ,
  `date_expiration` DATETIME NOT NULL ,
  `code_securite` VARCHAR(45) NOT NULL ,
  `utilisateurs_id` INT NOT NULL ,
  `nom_titulaire` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cartes_credit_utilisateurs1` (`utilisateurs_id` ASC) ,
  CONSTRAINT `fk_cartes_credit_utilisateurs1`
    FOREIGN KEY (`utilisateurs_id` )
    REFERENCES `mydb`.`utilisateurs` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`paiements`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`paiements` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `mydb`.`paiements` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `date` DATETIME NULL ,
  `commandes_id` INT NOT NULL ,
  `cartes_credit_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_paiements_commandes1` (`commandes_id` ASC) ,
  INDEX `fk_paiements_cartes_credit1` (`cartes_credit_id` ASC) ,
  CONSTRAINT `fk_paiements_commandes1`
    FOREIGN KEY (`commandes_id` )
    REFERENCES `mydb`.`commandes` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paiements_cartes_credit1`
    FOREIGN KEY (`cartes_credit_id` )
    REFERENCES `mydb`.`cartes_credit` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`categories` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `mydb`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `libelle` VARCHAR(45) NULL ,
  `categories_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_categories_categories1` (`categories_id` ASC) ,
  CONSTRAINT `fk_categories_categories1`
    FOREIGN KEY (`categories_id` )
    REFERENCES `mydb`.`categories` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`produits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`produits` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `mydb`.`produits` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `libelle` VARCHAR(45) NULL ,
  `description` VARCHAR(45) NULL ,
  `prix` DECIMAL(10,2) NULL ,
  `categories_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_produits_categories1` (`categories_id` ASC) ,
  CONSTRAINT `fk_produits_categories1`
    FOREIGN KEY (`categories_id` )
    REFERENCES `mydb`.`categories` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`frais_de_port`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`frais_de_port` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `mydb`.`frais_de_port` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `tarif` DECIMAL(10,2) NULL ,
  `methodes_livraison_id` INT NOT NULL ,
  `pays_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_frais_de_port_methodes_livraison1` (`methodes_livraison_id` ASC) ,
  INDEX `fk_frais_de_port_pays1` (`pays_id` ASC) ,
  CONSTRAINT `fk_frais_de_port_methodes_livraison1`
    FOREIGN KEY (`methodes_livraison_id` )
    REFERENCES `mydb`.`methodes_livraison` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_frais_de_port_pays1`
    FOREIGN KEY (`pays_id` )
    REFERENCES `mydb`.`pays` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`commandes_has_produits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`commandes_has_produits` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `mydb`.`commandes_has_produits` (
  `commandes_id` INT NOT NULL ,
  `produits_id` INT NOT NULL ,
  `quantite` VARCHAR(45) NULL ,
  INDEX `fk_commandes_has_produits_produits1` (`produits_id` ASC) ,
  INDEX `fk_commandes_has_produits_commandes1` (`commandes_id` ASC) ,
  CONSTRAINT `fk_commandes_has_produits_commandes1`
    FOREIGN KEY (`commandes_id` )
    REFERENCES `mydb`.`commandes` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commandes_has_produits_produits1`
    FOREIGN KEY (`produits_id` )
    REFERENCES `mydb`.`produits` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`livraisons_has_produits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`livraisons_has_produits` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `mydb`.`livraisons_has_produits` (
  `livraisons_id` INT NOT NULL ,
  `produits_id` INT NOT NULL ,
  `quantite` VARCHAR(45) NULL ,
  INDEX `fk_livraisons_has_produits_produits1` (`produits_id` ASC) ,
  INDEX `fk_livraisons_has_produits_livraisons1` (`livraisons_id` ASC) ,
  CONSTRAINT `fk_livraisons_has_produits_livraisons1`
    FOREIGN KEY (`livraisons_id` )
    REFERENCES `mydb`.`livraisons` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_livraisons_has_produits_produits1`
    FOREIGN KEY (`produits_id` )
    REFERENCES `mydb`.`produits` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
