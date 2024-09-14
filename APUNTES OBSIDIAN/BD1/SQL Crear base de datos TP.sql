-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `G11TP1` DEFAULT CHARACTER SET utf8 ;
USE `G11TP1` ;

-- -----------------------------------------------------
-- Table `mydb`.`Fabrica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `G11TP1`.`Fabrica` (
  `idFabrica` INT NOT NULL,
  PRIMARY KEY (`idFabrica`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LineasDeMontaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `G11TP1`.`LineasDeMontaje` (
  `idProveedores` INT NOT NULL,
  `modelos` VARCHAR(45) NOT NULL,
  `capacidad` INT NOT NULL,
  `Fabrica_idFabrica` INT NOT NULL,
  PRIMARY KEY (`idProveedores`),
  INDEX `fk_LineasDeMontaje_Fabrica1_idx` (`Fabrica_idFabrica` ASC) VISIBLE,
  CONSTRAINT `fk_LineasDeMontaje_Fabrica1`
    FOREIGN KEY (`Fabrica_idFabrica`)
    REFERENCES `G11TP1`.`Fabrica` (`idFabrica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Concesionarias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `G11TP1`.`Concesionarias` (
  `idConcesionarias` INT NOT NULL,
  `reportesVentas` VARCHAR(45) NOT NULL,
  `fechaEntrega` DATETIME NOT NULL,
  PRIMARY KEY (`idConcesionarias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Automoviles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `G11TP1`.`Automoviles` (
  `nroChasis` INT NOT NULL AUTO_INCREMENT,
  `fechaIngreso` DATETIME NOT NULL,
  `fechaEgreso` DATETIME NOT NULL,
  `estadisticaEstacion` INT NOT NULL,
  `estadisticaMontaje` INT NOT NULL,
  `LineasDeMontaje_idProveedores` INT NOT NULL,
  `Concesionarias_idConcesionarias` INT NOT NULL,
  PRIMARY KEY (`nroChasis`),
  INDEX `fk_Automoviles_LineasDeMontaje_idx` (`LineasDeMontaje_idProveedores` ASC) VISIBLE,
  INDEX `fk_Automoviles_Concesionarias1_idx` (`Concesionarias_idConcesionarias` ASC) VISIBLE,
  CONSTRAINT `fk_Automoviles_LineasDeMontaje`
    FOREIGN KEY (`LineasDeMontaje_idProveedores`)
    REFERENCES `G11TP1`.`LineasDeMontaje` (`idProveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Automoviles_Concesionarias1`
    FOREIGN KEY (`Concesionarias_idConcesionarias`)
    REFERENCES `G11TP1`.`Concesionarias` (`idConcesionarias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`autopartes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `G11TP1`.`autopartes` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `motor` VARCHAR(45) NOT NULL,
  `llantas` INT NOT NULL,
  `neumaticos` VARCHAR(45) NOT NULL,
  `puertas` INT NOT NULL,
  `litrosPintura` INT NOT NULL,
  `metrosCable` INT NOT NULL,
  `lamparas` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `precio` INT NOT NULL,
  `Automoviles_nroChasis` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_autopartes_Automoviles1_idx` (`Automoviles_nroChasis` ASC) VISIBLE,
  CONSTRAINT `fk_autopartes_Automoviles1`
    FOREIGN KEY (`Automoviles_nroChasis`)
    REFERENCES `G11TP1`.`Automoviles` (`nroChasis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EstacionesDeTrabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `G11TP1`.`EstacionesDeTrabajo` (
  `idEstacionesDeTrabajo` INT NOT NULL,
  `pintura` VARCHAR(45) NOT NULL,
  `ensamblado` VARCHAR(45) NOT NULL,
  `mecanicaMotor` VARCHAR(45) NOT NULL,
  `mecanicaRodaje` VARCHAR(45) NOT NULL,
  `electricidad` VARCHAR(45) NOT NULL,
  `prueba` VARCHAR(45) NOT NULL,
  `LineasDeMontaje_idProveedores` INT NOT NULL,
  PRIMARY KEY (`idEstacionesDeTrabajo`),
  INDEX `fk_EstacionesDeTrabajo_LineasDeMontaje1_idx` (`LineasDeMontaje_idProveedores` ASC) VISIBLE,
  CONSTRAINT `fk_EstacionesDeTrabajo_LineasDeMontaje1`
    FOREIGN KEY (`LineasDeMontaje_idProveedores`)
    REFERENCES `G11TP1`.`LineasDeMontaje` (`idProveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Insumos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `G11TP1`.`Insumos` (
  `idInsumos` INT NOT NULL,
  `litrosPintura` INT NOT NULL,
  `metrosCable` INT NOT NULL,
  `cubiertas` INT NOT NULL,
  `lamparas` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idInsumos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `G11TP1`.`Pedidos` (
  `idPedios` INT NOT NULL,
  `fechaEntrega` DATETIME NOT NULL,
  `capacidadProduccion` INT NOT NULL,
  `Fabrica_idFabrica` INT NOT NULL,
  PRIMARY KEY (`idPedios`),
  INDEX `fk_Pedidos_Fabrica1_idx` (`Fabrica_idFabrica` ASC) VISIBLE,
  CONSTRAINT `fk_Pedidos_Fabrica1`
    FOREIGN KEY (`Fabrica_idFabrica`)
    REFERENCES `G11TP1`.`Fabrica` (`idFabrica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `G11TP1`.`proveedores` (
  `idproveedores` INT NOT NULL,
  `pintado` VARCHAR(45) NOT NULL,
  `armado` VARCHAR(45) NOT NULL,
  `prueba` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idproveedores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`autopartes_has_proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `G11TP1`.`autopartes_has_proveedores` (
  `autopartes_codigo` INT NOT NULL,
  `proveedores_idproveedores` INT NOT NULL,
  PRIMARY KEY (`autopartes_codigo`, `proveedores_idproveedores`),
  INDEX `fk_autopartes_has_proveedores_proveedores1_idx` (`proveedores_idproveedores` ASC) VISIBLE,
  INDEX `fk_autopartes_has_proveedores_autopartes1_idx` (`autopartes_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_autopartes_has_proveedores_autopartes1`
    FOREIGN KEY (`autopartes_codigo`)
    REFERENCES `G11TP1`.`autopartes` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_autopartes_has_proveedores_proveedores1`
    FOREIGN KEY (`proveedores_idproveedores`)
    REFERENCES `G11TP1`.`proveedores` (`idproveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;