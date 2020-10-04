-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema programmer_job
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema programmer_job
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `programmer_job` DEFAULT CHARACTER SET utf8 ;
USE `programmer_job` ;

-- -----------------------------------------------------
-- Table `programmer_job`.`tb_admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `programmer_job`.`tb_admin` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `fullname` VARCHAR(255) NOT NULL,
  `created_account` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `programmer_job`.`tb_privilege`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `programmer_job`.`tb_privilege` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `privilege` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `programmer_job`.`tb_admin_privilege`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `programmer_job`.`tb_admin_privilege` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tb_admin_id` INT NOT NULL,
  `tb_privilege_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_admin_privilege_tb_admin_idx` (`tb_admin_id` ASC) ,
  INDEX `fk_tb_admin_privilege_tb_privilege1_idx` (`tb_privilege_id` ASC) ,
  CONSTRAINT `fk_tb_admin_privilege_tb_admin`
    FOREIGN KEY (`tb_admin_id`)
    REFERENCES `programmer_job`.`tb_admin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_admin_privilege_tb_privilege1`
    FOREIGN KEY (`tb_privilege_id`)
    REFERENCES `programmer_job`.`tb_privilege` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `programmer_job`.`tb_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `programmer_job`.`tb_address` (
  `postal_code` VARCHAR(10) NOT NULL,
  `district` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `country` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`postal_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `programmer_job`.`tb_software_programmer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `programmer_job`.`tb_software_programmer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `fullname` VARCHAR(255) NOT NULL,
  `created_account` DATETIME NOT NULL,
  `tb_admin_id` INT NOT NULL,
  `tb_address_postal_code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_software_programmer_tb_admin1_idx` (`tb_admin_id` ASC) ,
  INDEX `fk_tb_software_programmer_tb_address1_idx` (`tb_address_postal_code` ASC) ,
  CONSTRAINT `fk_tb_software_programmer_tb_admin1`
    FOREIGN KEY (`tb_admin_id`)
    REFERENCES `programmer_job`.`tb_admin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_software_programmer_tb_address1`
    FOREIGN KEY (`tb_address_postal_code`)
    REFERENCES `programmer_job`.`tb_address` (`postal_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `programmer_job`.`tb_company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `programmer_job`.`tb_company` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `companyname` VARCHAR(255) NOT NULL,
  `description` LONGTEXT NULL,
  `tb_address_postal_code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_company_tb_address1_idx` (`tb_address_postal_code` ASC) ,
  CONSTRAINT `fk_tb_company_tb_address1`
    FOREIGN KEY (`tb_address_postal_code`)
    REFERENCES `programmer_job`.`tb_address` (`postal_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `programmer_job`.`tb_company_sp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `programmer_job`.`tb_company_sp` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tb_software_programmer_id` INT NOT NULL,
  `tb_company_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_company_sp_tb_software_programmer1_idx` (`tb_software_programmer_id` ASC) ,
  INDEX `fk_tb_company_sp_tb_company1_idx` (`tb_company_id` ASC) ,
  CONSTRAINT `fk_tb_company_sp_tb_software_programmer1`
    FOREIGN KEY (`tb_software_programmer_id`)
    REFERENCES `programmer_job`.`tb_software_programmer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_company_sp_tb_company1`
    FOREIGN KEY (`tb_company_id`)
    REFERENCES `programmer_job`.`tb_company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `programmer_job`.`tb_chatroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `programmer_job`.`tb_chatroom` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `roomname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `programmer_job`.`tb_room_member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `programmer_job`.`tb_room_member` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tb_software_programmer_id` INT NOT NULL,
  `tb_chatroom_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_room_member_tb_software_programmer1_idx` (`tb_software_programmer_id` ASC) ,
  INDEX `fk_tb_room_member_tb_chatroom1_idx` (`tb_chatroom_id` ASC) ,
  CONSTRAINT `fk_tb_room_member_tb_software_programmer1`
    FOREIGN KEY (`tb_software_programmer_id`)
    REFERENCES `programmer_job`.`tb_software_programmer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_room_member_tb_chatroom1`
    FOREIGN KEY (`tb_chatroom_id`)
    REFERENCES `programmer_job`.`tb_chatroom` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `programmer_job`.`tb_message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `programmer_job`.`tb_message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `text` LONGTEXT NOT NULL,
  `created_message` DATETIME NOT NULL,
  `tb_chatroom_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_message_tb_chatroom1_idx` (`tb_chatroom_id` ASC) ,
  CONSTRAINT `fk_tb_message_tb_chatroom1`
    FOREIGN KEY (`tb_chatroom_id`)
    REFERENCES `programmer_job`.`tb_chatroom` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `programmer_job`.`tb_thread`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `programmer_job`.`tb_thread` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `text` LONGTEXT NOT NULL,
  `hastag` VARCHAR(45) NULL,
  `created_thread` DATETIME NOT NULL,
  `tb_software_programmer_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_thread_tb_software_programmer1_idx` (`tb_software_programmer_id` ASC) ,
  CONSTRAINT `fk_tb_thread_tb_software_programmer1`
    FOREIGN KEY (`tb_software_programmer_id`)
    REFERENCES `programmer_job`.`tb_software_programmer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `programmer_job`.`tb_thread_comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `programmer_job`.`tb_thread_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `text` LONGTEXT NOT NULL,
  `created_comment` DATETIME NOT NULL,
  `tb_thread_id` INT NOT NULL,
  `tb_software_programmer_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_thread_comment_tb_thread1_idx` (`tb_thread_id` ASC) ,
  INDEX `fk_tb_thread_comment_tb_software_programmer1_idx` (`tb_software_programmer_id` ASC) ,
  CONSTRAINT `fk_tb_thread_comment_tb_thread1`
    FOREIGN KEY (`tb_thread_id`)
    REFERENCES `programmer_job`.`tb_thread` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_thread_comment_tb_software_programmer1`
    FOREIGN KEY (`tb_software_programmer_id`)
    REFERENCES `programmer_job`.`tb_software_programmer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `programmer_job`.`tb_job_vacancy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `programmer_job`.`tb_job_vacancy` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` LONGTEXT NOT NULL,
  `category` VARCHAR(255) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `created_vacancy` DATETIME NOT NULL,
  `tb_software_programmer_id` INT NOT NULL,
  `tb_company_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_job_vacancy_tb_software_programmer1_idx` (`tb_software_programmer_id` ASC) ,
  INDEX `fk_tb_job_vacancy_tb_company1_idx` (`tb_company_id` ASC) ,
  CONSTRAINT `fk_tb_job_vacancy_tb_software_programmer1`
    FOREIGN KEY (`tb_software_programmer_id`)
    REFERENCES `programmer_job`.`tb_software_programmer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_job_vacancy_tb_company1`
    FOREIGN KEY (`tb_company_id`)
    REFERENCES `programmer_job`.`tb_company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `programmer_job`.`tb_job_application`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `programmer_job`.`tb_job_application` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `files` VARCHAR(255) NULL,
  `status` VARCHAR(45) NOT NULL,
  `created_application` DATETIME NOT NULL,
  `tb_job_vacancy_id` INT NOT NULL,
  `tb_software_programmer_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_job_vacancy_tb_job_vacancy1_idx` (`tb_job_vacancy_id` ASC) ,
  INDEX `fk_tb_job_vacancy_tb_software_programmer2_idx` (`tb_software_programmer_id` ASC) ,
  CONSTRAINT `fk_tb_job_vacancy_tb_job_vacancy1`
    FOREIGN KEY (`tb_job_vacancy_id`)
    REFERENCES `programmer_job`.`tb_job_vacancy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_job_vacancy_tb_software_programmer2`
    FOREIGN KEY (`tb_software_programmer_id`)
    REFERENCES `programmer_job`.`tb_software_programmer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
