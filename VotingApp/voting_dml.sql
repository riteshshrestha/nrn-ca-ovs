SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema NRN_CA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `NRN_CA` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `NRN_CA` ;

-- -----------------------------------------------------
-- Table `NRN_CA`.`CONTACT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NRN_CA`.`CONTACT` (
  `CONTACT_ID` INT NOT NULL,
  `FIRST_NAME` VARCHAR(45) NULL,
  `MIDDLE_NAME` VARCHAR(45) NULL,
  `LAST_NAME` VARCHAR(45) NULL,
  `EMAIL` VARCHAR(45) NULL,
  `PHONE` INT NULL,
  `POSTAL_CODE` VARCHAR(45) NULL,
  `CREATE_DT` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`CONTACT_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NRN_CA`.`CANDIDATE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NRN_CA`.`CANDIDATE` (
  `CANDIDATE_ID` INT NOT NULL AUTO_INCREMENT,
  `CONTACT_ID` INT NOT NULL,
  `ZONE` VARCHAR(45) NULL,
  PRIMARY KEY (`CANDIDATE_ID`),
  INDEX `CONTACT_ID_idx` (`CONTACT_ID` ASC),
  CONSTRAINT `CONTACT_ID_CANDIDATE`
    FOREIGN KEY (`CONTACT_ID`)
    REFERENCES `NRN_CA`.`CONTACT` (`CONTACT_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NRN_CA`.`VOTER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NRN_CA`.`VOTER` (
  `VOTER_ID` INT NOT NULL AUTO_INCREMENT,
  `CONTACT_ID` INT NULL,
  PRIMARY KEY (`VOTER_ID`),
  INDEX `CONTACT_ID_idx` (`CONTACT_ID` ASC),
  CONSTRAINT `CONTACT_ID_VOTER`
    FOREIGN KEY (`CONTACT_ID`)
    REFERENCES `NRN_CA`.`CONTACT` (`CONTACT_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NRN_CA`.`ROLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NRN_CA`.`ROLE` (
  `ROLE_ID` INT NOT NULL AUTO_INCREMENT,
  `ROLE_NAME` VARCHAR(45) NULL,
  PRIMARY KEY (`ROLE_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NRN_CA`.`APP_USER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NRN_CA`.`APP_USER` (
  `APP_USER_ID` INT NOT NULL AUTO_INCREMENT,
  `CONTACT_ID` INT NULL,
  `USERNAME` VARCHAR(45) NULL,
  `PASSWORD` VARCHAR(45) NULL,
  `STATUS` VARCHAR(45) NULL,
  `ROLE_ID` INT NULL,
  PRIMARY KEY (`APP_USER_ID`),
  INDEX `CONTACT_ID_idx` (`CONTACT_ID` ASC),
  INDEX `ROLE_ID_idx` (`ROLE_ID` ASC),
  CONSTRAINT `CONTACT_ID_APP_USER`
    FOREIGN KEY (`CONTACT_ID`)
    REFERENCES `NRN_CA`.`CONTACT` (`CONTACT_ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `ROLE_ID`
    FOREIGN KEY (`ROLE_ID`)
    REFERENCES `NRN_CA`.`ROLE` (`ROLE_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;