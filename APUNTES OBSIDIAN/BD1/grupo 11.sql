-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


CREATE SCHEMA IF NOT EXISTS `g11tp1` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Schema automotriz
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `automotriz` DEFAULT CHARACTER SET utf8mb3 ;
USE `automotriz` ;




-- -----------------------------------------------------
-- Table `automotriz`.`automoviles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`automoviles` (
  `nroChasis` INT NOT NULL AUTO_INCREMENT,
  `modelo` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`nroChasis`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `automotriz`.`autopartes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`autopartes` (
  `idAutoparte` INT NOT NULL,
  `descripcion` VARCHAR(90) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAutoparte`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `automotriz`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`proveedores` (
  `idProveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(35) NOT NULL,
  PRIMARY KEY (`idProveedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `automotriz`.`autopartes_proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`autopartes_proveedores` (
  `idAutoparte` INT NOT NULL,
  `idProveedor` INT NOT NULL,
  `precio` DECIMAL NOT NULL,
  PRIMARY KEY (`idAutoparte`, `idProveedor`),
  INDEX `Proveedores_idProveedor` (`idProveedor` ASC) VISIBLE,
  CONSTRAINT `autopartes_proveedores_ibfk_1`
    FOREIGN KEY (`idAutoparte`)
    REFERENCES `automotriz`.`autopartes` (`idAutoparte`),
  CONSTRAINT `autopartes_proveedores_ibfk_2`
    FOREIGN KEY (`idProveedor`)
    REFERENCES `automotriz`.`proveedores` (`idProveedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `automotriz`.`concesionarias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`concesionarias` (
  `idConcesionaria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`idConcesionaria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `automotriz`.`modelos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`modelos` (
  `idModelos` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idModelos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `automotriz`.`lineasdemontaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`lineasdemontaje` (
  `idLineaMontaje` INT NOT NULL AUTO_INCREMENT,
  `modeloVehiculo` VARCHAR(90) NOT NULL,
  `capacidadProduccion` INT NOT NULL,
  `modelos_idModelos` INT NOT NULL,
  PRIMARY KEY (`idLineaMontaje`, `modelos_idModelos`),
  INDEX `fk_lineasdemontaje_modelos1_idx` (`modelos_idModelos` ASC) VISIBLE,
  CONSTRAINT `fk_lineasdemontaje_modelos1`
    FOREIGN KEY (`modelos_idModelos`)
    REFERENCES `automotriz`.`modelos` (`idModelos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `automotriz`.`estacionesdetrabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`estacionesdetrabajo` (
  `idEstacion` INT NOT NULL AUTO_INCREMENT,
  `nombreTarea` VARCHAR(45) NOT NULL,
  `lineasdemontaje_idLineaMontaje` INT NOT NULL,
  `orden` INT NOT NULL,
  PRIMARY KEY (`idEstacion`, `lineasdemontaje_idLineaMontaje`),
  INDEX `fk_estacionesdetrabajo_lineasdemontaje1_idx` (`lineasdemontaje_idLineaMontaje` ASC) VISIBLE,
  CONSTRAINT `fk_estacionesdetrabajo_lineasdemontaje1`
    FOREIGN KEY (`lineasdemontaje_idLineaMontaje`)
    REFERENCES `automotriz`.`lineasdemontaje` (`idLineaMontaje`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `automotriz`.`consumo_autopartes_estacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`consumo_autopartes_estacion` (
  `idConsumo` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `estacionesdetrabajo_idEstacion` INT NOT NULL,
  `autopartes_idAutoparte` INT NOT NULL,
  PRIMARY KEY (`idConsumo`, `estacionesdetrabajo_idEstacion`, `autopartes_idAutoparte`),
  INDEX `fk_consumo_autopartes_estacion_estacionesdetrabajo1_idx` (`estacionesdetrabajo_idEstacion` ASC) VISIBLE,
  INDEX `fk_consumo_autopartes_estacion_autopartes1_idx` (`autopartes_idAutoparte` ASC) VISIBLE,
  CONSTRAINT `fk_consumo_autopartes_estacion_autopartes1`
    FOREIGN KEY (`autopartes_idAutoparte`)
    REFERENCES `automotriz`.`autopartes` (`idAutoparte`),
  CONSTRAINT `fk_consumo_autopartes_estacion_estacionesdetrabajo1`
    FOREIGN KEY (`estacionesdetrabajo_idEstacion`)
    REFERENCES `automotriz`.`estacionesdetrabajo` (`idEstacion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `automotriz`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`pedidos` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `fechaEntrega` DATETIME NOT NULL,
  `cantidad` INT NOT NULL,
  `idConcesionaria` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `idConcesionaria`),
  INDEX `fk_pedidos_concesionarias1_idx` (`idConcesionaria` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_concesionarias1`
    FOREIGN KEY (`idConcesionaria`)
    REFERENCES `automotriz`.`concesionarias` (`idConcesionaria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `automotriz`.`modelos_has_pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`modelos_has_pedidos` (
  `idmodelos` INT NOT NULL,
  `idPedido` INT NOT NULL,
  `automoviles_nroChasis` INT NOT NULL,
  PRIMARY KEY (`idmodelos`, `idPedido`, `automoviles_nroChasis`),
  INDEX `fk_modelos_has_pedidos_pedidos1_idx` (`idPedido` ASC) VISIBLE,
  INDEX `fk_modelos_has_pedidos_modelos1_idx` (`idmodelos` ASC) VISIBLE,
  INDEX `fk_modelos_has_pedidos_automoviles1_idx` (`automoviles_nroChasis` ASC) VISIBLE,
  CONSTRAINT `fk_modelos_has_pedidos_modelos1`
    FOREIGN KEY (`idmodelos`)
    REFERENCES `automotriz`.`modelos` (`idModelos`),
  CONSTRAINT `fk_modelos_has_pedidos_pedidos1`
    FOREIGN KEY (`idPedido`)
    REFERENCES `automotriz`.`pedidos` (`idPedido`),
  CONSTRAINT `fk_modelos_has_pedidos_automoviles1`
    FOREIGN KEY (`automoviles_nroChasis`)
    REFERENCES `automotriz`.`automoviles` (`nroChasis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `automotriz`.`registro_estaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`registro_estaciones` (
  `idRegistro` INT NOT NULL AUTO_INCREMENT,
  `fechaIngreso` DATETIME NOT NULL,
  `fechaEgreso` DATETIME NOT NULL,
  `automoviles_nroChasis` INT NOT NULL,
  `estacionesdetrabajo_idEstacion` INT NOT NULL,
  PRIMARY KEY (`idRegistro`, `automoviles_nroChasis`, `estacionesdetrabajo_idEstacion`),
  INDEX `fk_registro_estaciones_automoviles1_idx` (`automoviles_nroChasis` ASC) VISIBLE,
  INDEX `fk_registro_estaciones_estacionesdetrabajo1_idx` (`estacionesdetrabajo_idEstacion` ASC) VISIBLE,
  CONSTRAINT `fk_registro_estaciones_automoviles1`
    FOREIGN KEY (`automoviles_nroChasis`)
    REFERENCES `automotriz`.`automoviles` (`nroChasis`),
  CONSTRAINT `fk_registro_estaciones_estacionesdetrabajo1`
    FOREIGN KEY (`estacionesdetrabajo_idEstacion`)
    REFERENCES `automotriz`.`estacionesdetrabajo` (`idEstacion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
