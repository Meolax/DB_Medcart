-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
SHOW WARNINGS;
-- -----------------------------------------------------
-- Schema medcart
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema medcart
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `medcart` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `medcart` ;

-- -----------------------------------------------------
-- Table `medcart`.`backup_client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medcart`.`backup_client` (
  `IDBackupClient` INT(11) NOT NULL AUTO_INCREMENT,
  `IDClient` INT(11) NOT NULL,
  `IDUser` INT(11) NOT NULL,
  `name` CHAR(30) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  PRIMARY KEY (`IDBackupClient`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;
CREATE INDEX `part_of_name` ON `medcart`.`backup_client` (`name`(10) ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `medcart`.`backup_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medcart`.`backup_user` (
  `IDBackupUser` INT(11) NOT NULL AUTO_INCREMENT,
  `IDUser` INT(11) NOT NULL,
  `number` VARCHAR(25) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `username` VARCHAR(16) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  PRIMARY KEY (`IDBackupUser`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;
CREATE UNIQUE INDEX `username_number_UNIQUE` ON `medcart`.`backup_user` (`username` ASC, `number` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `medcart`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medcart`.`city` (
  `IDCity` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  PRIMARY KEY (`IDCity`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;
CREATE UNIQUE INDEX `name_UNIQUE` ON `medcart`.`city` (`name` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `medcart`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medcart`.`user` (
  `IDUser` INT(11) NOT NULL,
  `name` VARCHAR(16) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `number` VARCHAR(25) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `password` VARCHAR(32) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IDUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;
CREATE UNIQUE INDEX `number_UNIQUE` ON `medcart`.`user` (`number` ASC);

SHOW WARNINGS;
CREATE UNIQUE INDEX `username_UNIQUE` ON `medcart`.`user` (`name` ASC);

SHOW WARNINGS;
CREATE UNIQUE INDEX `username_number_UNIQUE` ON `medcart`.`user` (`name` ASC, `number` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `medcart`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medcart`.`client` (
  `IDClient` INT(11) NOT NULL AUTO_INCREMENT,
  `name` CHAR(30) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `IDUser` INT(11) NOT NULL,
  `dateBirthday` DATETIME NOT NULL,
  PRIMARY KEY (`IDClient`),
  CONSTRAINT `idUser`
    FOREIGN KEY (`IDUser`)
    REFERENCES `medcart`.`user` (`IDUser`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;
CREATE UNIQUE INDEX `IDClient` ON `medcart`.`client` (`IDClient` ASC);

SHOW WARNINGS;
CREATE INDEX `part_of_name` ON `medcart`.`client` (`name`(10) ASC);

SHOW WARNINGS;
CREATE INDEX `idUser_idx` ON `medcart`.`client` (`IDUser` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `medcart`.`region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medcart`.`region` (
  `IDRegion` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  PRIMARY KEY (`IDRegion`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;
CREATE UNIQUE INDEX `name_UNIQUE` ON `medcart`.`region` (`name` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `medcart`.`clinic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medcart`.`clinic` (
  `IDClinic` INT(11) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `IDCity` INT(11) NOT NULL,
  `IDRegion` INT(11) NOT NULL,
  PRIMARY KEY (`IDClinic`),
  CONSTRAINT `IDcity`
    FOREIGN KEY (`IDCity`)
    REFERENCES `medcart`.`city` (`IDCity`),
  CONSTRAINT `IDregion`
    FOREIGN KEY (`IDRegion`)
    REFERENCES `medcart`.`region` (`IDRegion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;
CREATE INDEX `IDcity_idx` ON `medcart`.`clinic` (`IDCity` ASC);

SHOW WARNINGS;
CREATE INDEX `IDregion_idx` ON `medcart`.`clinic` (`IDRegion` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `medcart`.`speciality`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medcart`.`speciality` (
  `IDSpeciality` INT(11) NOT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  PRIMARY KEY (`IDSpeciality`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;
CREATE UNIQUE INDEX `Name_UNIQUE` ON `medcart`.`speciality` (`name` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `medcart`.`doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medcart`.`doctor` (
  `IDDoctor` INT(11) NOT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `idSpeciality` INT(11) NOT NULL,
  PRIMARY KEY (`IDDoctor`),
  CONSTRAINT `doctors_Speciality`
    FOREIGN KEY (`idSpeciality`)
    REFERENCES `medcart`.`speciality` (`IDSpeciality`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;
CREATE INDEX `doctors_Speciality` ON `medcart`.`doctor` (`idSpeciality` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `medcart`.`doctype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medcart`.`doctype` (
  `IDdocType` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  PRIMARY KEY (`IDdocType`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;
CREATE UNIQUE INDEX `docTypeName_UNIQUE` ON `medcart`.`doctype` (`name` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `medcart`.`docs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medcart`.`docs` (
  `IDDoc` INT(11) NOT NULL AUTO_INCREMENT,
  `IDDoctor` INT(11) NOT NULL,
  `IDClient` INT(11) NOT NULL,
  `IDdocType` INT(11) NOT NULL,
  PRIMARY KEY (`IDDoc`),
  CONSTRAINT `idClient`
    FOREIGN KEY (`IDClient`)
    REFERENCES `medcart`.`client` (`IDClient`),
  CONSTRAINT `idDoctor`
    FOREIGN KEY (`IDDoctor`)
    REFERENCES `medcart`.`doctor` (`IDDoctor`),
  CONSTRAINT `idDoctype`
    FOREIGN KEY (`IDdocType`)
    REFERENCES `medcart`.`doctype` (`IDdocType`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;
CREATE INDEX `idClient_idx` ON `medcart`.`docs` (`IDClient` ASC);

SHOW WARNINGS;
CREATE INDEX `idDoctype_idx` ON `medcart`.`docs` (`IDdocType` ASC);

SHOW WARNINGS;
CREATE INDEX `idDoctor_idx` ON `medcart`.`docs` (`IDDoctor` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `medcart`.`doctor2clinic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medcart`.`doctor2clinic` (
  `IDdoctor2clinic` INT(11) NOT NULL AUTO_INCREMENT,
  `IDDoctor` INT(11) NOT NULL,
  `IDClinic` INT(11) NOT NULL,
  PRIMARY KEY (`IDdoctor2clinic`),
  CONSTRAINT `doctor&clinic_IDClinic`
    FOREIGN KEY (`IDClinic`)
    REFERENCES `medcart`.`clinic` (`IDClinic`),
  CONSTRAINT `doctor&clinic_IDDoctor`
    FOREIGN KEY (`IDDoctor`)
    REFERENCES `medcart`.`doctor` (`IDDoctor`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;
CREATE INDEX `idClinics_idx` ON `medcart`.`doctor2clinic` (`IDClinic` ASC);

SHOW WARNINGS;
CREATE INDEX `IDDoctor_idx` ON `medcart`.`doctor2clinic` (`IDDoctor` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `medcart`.`log_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medcart`.`log_user` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `msg` VARCHAR(25) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `IDuser` INT(11) NULL DEFAULT NULL,
  `time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;
CREATE INDEX `time_index` ON `medcart`.`log_user` (`time` ASC);

SHOW WARNINGS;
CREATE INDEX `time_msg` ON `medcart`.`log_user` (`time` ASC, `msg` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `medcart`.`spravka`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medcart`.`spravka` (
  `idSpravka` INT(11) NOT NULL AUTO_INCREMENT,
  `idDoc` INT(11) NOT NULL,
  `Diagnoz` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `EndDate` DATETIME NULL DEFAULT NULL,
  `Primechanie` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`idSpravka`),
  CONSTRAINT `idDoc`
    FOREIGN KEY (`idDoc`)
    REFERENCES `medcart`.`docs` (`IDDoc`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;
CREATE INDEX `idDoc_idx` ON `medcart`.`spravka` (`idDoc` ASC);

SHOW WARNINGS;
USE `medcart`;

DELIMITER $$
SHOW WARNINGS$$
USE `medcart`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `medcart`.`delete_user`
BEFORE DELETE ON `medcart`.`user`
FOR EACH ROW
begin
		insert into backup_user set IDuser=OLD.IDuser, number=OLD.number, username=OLD.username;
        delete from client where IDuser=OLD.IDuser;
	End$$

SHOW WARNINGS$$
SHOW WARNINGS$$
USE `medcart`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `medcart`.`update_user`
BEFORE INSERT ON `medcart`.`user`
FOR EACH ROW
begin
		insert into log_user set IDUser=new.IDUser, msg='insert' ;
    end$$

SHOW WARNINGS$$
SHOW WARNINGS$$
USE `medcart`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `medcart`.`delete_client`
BEFORE DELETE ON `medcart`.`client`
FOR EACH ROW
begin
		insert into backup_client set IDClient=OLD.IDClient, IDuser=OLD.IDuser, name=OLD.name; 
	end$$

SHOW WARNINGS$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
