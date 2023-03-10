-- MySQL Script generated by MySQL Workbench
-- Tue Mar  7 12:57:26 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema nilaik
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema nilaik
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nilaik` DEFAULT CHARACTER SET utf8 ;
USE `nilaik` ;

-- -----------------------------------------------------
-- Table `nilaik`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nilaik`.`producto` (
  `idproducto` INT NOT NULL AUTO_INCREMENT,
  `articulo` VARCHAR(50) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `talla` INT NOT NULL,
  `codigo` VARCHAR(45) NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `PrecioMayoreo` INT NOT NULL,
  `preciomenudeo` INT NOT NULL,
  `existencias` INT NOT NULL,
  `imgproducto_idimgproducto` INT NOT NULL,
  PRIMARY KEY (`idproducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nilaik`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nilaik`.`pedido` (
  `idpedido` INT NOT NULL AUTO_INCREMENT,
  `fechapedido` DATE NOT NULL,
  `cliente_idcliente` INT NOT NULL,
  PRIMARY KEY (`idpedido`),
  INDEX `fk_pedido_cliente1_idx` (`cliente_idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `nilaik`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nilaik`.`carrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nilaik`.`carrito` (
  `idcarrito` INT NOT NULL AUTO_INCREMENT,
  `pedido_idpedido` INT NULL,
  PRIMARY KEY (`idcarrito`),
  INDEX `fk_carrito_pedido1_idx` (`pedido_idpedido` ASC) VISIBLE,
  CONSTRAINT `fk_carrito_pedido1`
    FOREIGN KEY (`pedido_idpedido`)
    REFERENCES `nilaik`.`pedido` (`idpedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nilaik`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nilaik`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(150) NOT NULL,
  `contrasena` VARCHAR(45) NOT NULL,
  `nacimiento` DATE NOT NULL,
  `direccion` VARCHAR(150) NOT NULL,
  `carrito_idcarrito` INT NULL,
  PRIMARY KEY (`idcliente`),
  INDEX `fk_cliente_carrito1_idx` (`carrito_idcarrito` ASC) VISIBLE,
  UNIQUE INDEX `correo_UNIQUE` (`correo` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_carrito1`
    FOREIGN KEY (`carrito_idcarrito`)
    REFERENCES `nilaik`.`carrito` (`idcarrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nilaik`.`mensaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nilaik`.`mensaje` (
  `idmensaje` INT NOT NULL AUTO_INCREMENT,
  `mensaje` VARCHAR(45) NOT NULL,
  `mailmensaje` VARCHAR(45) NOT NULL,
  `visto` INT NOT NULL,
  `cliente_idcliente` INT NOT NULL,
  PRIMARY KEY (`idmensaje`),
  INDEX `fk_mensaje_cliente1_idx` (`cliente_idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_mensaje_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `nilaik`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nilaik`.`relacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nilaik`.`relacion` (
  `producto_idproducto` INT NOT NULL,
  `pedido_idpedido` INT NOT NULL,
  INDEX `fk_pedido_has_producto_producto1_idx` (`producto_idproducto` ASC) VISIBLE,
  INDEX `fk_pedido_has_producto_pedido1_idx` (`pedido_idpedido` ASC) VISIBLE,
  PRIMARY KEY (`producto_idproducto`, `pedido_idpedido`),
  CONSTRAINT `fk_pedido_has_producto_pedido1`
    FOREIGN KEY (`pedido_idpedido`)
    REFERENCES `nilaik`.`pedido` (`idpedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_has_producto_producto1`
    FOREIGN KEY (`producto_idproducto`)
    REFERENCES `nilaik`.`producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
