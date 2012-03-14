SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`roles` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `libelle` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`utilisateurs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`utilisateurs` ;

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


-- -----------------------------------------------------
-- Table `mydb`.`pays`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`pays` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`pays` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `libelle` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`adresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`adresses` ;

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


-- -----------------------------------------------------
-- Table `mydb`.`methodes_livraison`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`methodes_livraison` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`methodes_livraison` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `libelle` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`commandes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`commandes` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`commandes` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `date` DATETIME NULL ,
  `methodes_livraison_id` INT NOT NULL ,
  `adresses_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_commandes_methodes_livraison1` (`methodes_livraison_id` ASC) ,
  INDEX `fk_commandes_adresses1` (`adresses_id` ASC) ,
  CONSTRAINT `fk_commandes_methodes_livraison1`
    FOREIGN KEY (`methodes_livraison_id` )
    REFERENCES `mydb`.`methodes_livraison` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commandes_adresses1`
    FOREIGN KEY (`adresses_id` )
    REFERENCES `mydb`.`adresses` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`livraisons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`livraisons` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`livraisons` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `date_expedition` DATETIME NULL ,
  `date_reception` DATETIME NULL ,
  `commandes_id` INT NOT NULL ,
  `adresses_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_livraisons_commandes1` (`commandes_id` ASC) ,
  INDEX `fk_livraisons_adresses1` (`adresses_id` ASC) ,
  CONSTRAINT `fk_livraisons_commandes1`
    FOREIGN KEY (`commandes_id` )
    REFERENCES `mydb`.`commandes` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_livraisons_adresses1`
    FOREIGN KEY (`adresses_id` )
    REFERENCES `mydb`.`adresses` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`etapes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`etapes` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`etapes` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `libelle` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cartes_credit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`cartes_credit` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`cartes_credit` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `numero` VARCHAR(45) NOT NULL ,
  `date_expiration` DATETIME NOT NULL ,
  `code_securite` VARCHAR(45) NOT NULL ,
  `utilisateurs_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cartes_credit_utilisateurs1` (`utilisateurs_id` ASC) ,
  CONSTRAINT `fk_cartes_credit_utilisateurs1`
    FOREIGN KEY (`utilisateurs_id` )
    REFERENCES `mydb`.`utilisateurs` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`paiements`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`paiements` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`paiements` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `date` DATETIME NULL ,
  `commandes_id` INT NOT NULL ,
  `methodes_paiement_id` INT NOT NULL ,
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


-- -----------------------------------------------------
-- Table `mydb`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`categories` ;

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


-- -----------------------------------------------------
-- Table `mydb`.`produits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`produits` ;

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


-- -----------------------------------------------------
-- Table `mydb`.`frais_de_port`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`frais_de_port` ;

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


-- -----------------------------------------------------
-- Table `mydb`.`commandes_has_produits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`commandes_has_produits` ;

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


-- -----------------------------------------------------
-- Table `mydb`.`livraisons_has_produits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`livraisons_has_produits` ;

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


-- -----------------------------------------------------
-- Table `mydb`.`livraisons_has_etapes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`livraisons_has_etapes` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`livraisons_has_etapes` (
  `livraisons_id` INT NOT NULL ,
  `etapes_id` INT NOT NULL ,
  `date` DATETIME NULL ,
  INDEX `fk_livraisons_has_etapes_etapes1` (`etapes_id` ASC) ,
  INDEX `fk_livraisons_has_etapes_livraisons1` (`livraisons_id` ASC) ,
  CONSTRAINT `fk_livraisons_has_etapes_livraisons1`
    FOREIGN KEY (`livraisons_id` )
    REFERENCES `mydb`.`livraisons` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_livraisons_has_etapes_etapes1`
    FOREIGN KEY (`etapes_id` )
    REFERENCES `mydb`.`etapes` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
