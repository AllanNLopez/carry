-- MySQL Script generated by MySQL Workbench
-- 10/30/17 01:07:54
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema carry
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema carry
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `carry` DEFAULT CHARACTER SET utf8 ;
USE `carry` ;

-- -----------------------------------------------------
-- Table `carry`.`tblRubro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblRubro` (
  `codRubro` INT NOT NULL AUTO_INCREMENT,
  `rubro` VARCHAR(45) NULL,
  PRIMARY KEY (`codRubro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblTipoUsuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblTipoUsuarios` (
  `codTipoUsuario` INT NOT NULL AUTO_INCREMENT,
  `tipoUsuario` VARCHAR(25) NULL,
  `idAcceso` VARCHAR(10) NULL,
  PRIMARY KEY (`codTipoUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblUsuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblUsuarios` (
  `codUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(25) NULL,
  `apellidos` VARCHAR(25) NULL,
  `telefono` VARCHAR(15) NULL,
  `correo` VARCHAR(25) NULL,
  `contrasena` VARCHAR(200) NULL,
  `codTipoUsuario` INT NOT NULL,
  PRIMARY KEY (`codUsuario`),
  INDEX `fk_tblUsuarios_tblTipoUsuarios_idx` (`codTipoUsuario` ASC),
  CONSTRAINT `fk_tblUsuarios_tblTipoUsuarios`
    FOREIGN KEY (`codTipoUsuario`)
    REFERENCES `carry`.`tblTipoUsuarios` (`codTipoUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblEmpresas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblEmpresas` (
  `codEmpresa` INT NOT NULL AUTO_INCREMENT,
  `rtn` VARCHAR(25) NULL,
  `nombreEmpresa` VARCHAR(45) NULL,
  `ubicacion` VARCHAR(200) NULL,
  `actividad` VARCHAR(45) NULL,
  `sitioweb` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `informacion` VARCHAR(200) NULL,
  `calificacion` INT NULL,
  `activa` INT NULL,
  `codUsuario` INT NOT NULL,
  `codRubro` INT NOT NULL,
  `mapslatitud` FLOAT NULL,
  `mapslongitud` FLOAT NULL,
  `mapsregion` VARCHAR(50) NULL,
  `mapsciudad` VARCHAR(50) NULL,
  `mapsdeparamento` VARCHAR(50) NULL,
  `mapspais` VARCHAR(50) NULL,
  PRIMARY KEY (`codEmpresa`),
  INDEX `fk_tblEmpresas_tblRubro1_idx` (`codRubro` ASC),
  INDEX `fk_tblEmpresas_tblUsuarios1_idx` (`codUsuario` ASC),
  CONSTRAINT `fk_tblEmpresas_tblRubro1`
    FOREIGN KEY (`codRubro`)
    REFERENCES `carry`.`tblRubro` (`codRubro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblEmpresas_tblUsuarios1`
    FOREIGN KEY (`codUsuario`)
    REFERENCES `carry`.`tblUsuarios` (`codUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblTipoEmpleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblTipoEmpleado` (
  `codTipoEmpleado` INT NOT NULL AUTO_INCREMENT,
  `tipoEmpleado` VARCHAR(45) NULL,
  PRIMARY KEY (`codTipoEmpleado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblTipoVehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblTipoVehiculo` (
  `codTipoVehiculo` INT NOT NULL AUTO_INCREMENT,
  `tipoVehiculo` VARCHAR(45) NULL,
  PRIMARY KEY (`codTipoVehiculo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblEmpleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblEmpleados` (
  `identificacion` VARCHAR(15) NOT NULL,
  `nacimiento` DATE NULL,
  `domicilio` VARCHAR(150) NULL,
  `telefonos` VARCHAR(45) NULL,
  `codUsuario` INT NOT NULL,
  `salario` DECIMAL(2) NULL,
  `codTipoEmpleado` INT NOT NULL,
  `codTipoVehiculo` INT NOT NULL,
  INDEX `fk_tblEmpleados_tblUsuarios1_idx` (`codUsuario` ASC),
  PRIMARY KEY (`codUsuario`),
  INDEX `fk_tblEmpleados_tblTipoEmpleado1_idx` (`codTipoEmpleado` ASC),
  INDEX `fk_tblEmpleados_tblTipoVehiculo1_idx` (`codTipoVehiculo` ASC),
  CONSTRAINT `fk_tblEmpleados_tblUsuarios1`
    FOREIGN KEY (`codUsuario`)
    REFERENCES `carry`.`tblUsuarios` (`codUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblEmpleados_tblTipoEmpleado1`
    FOREIGN KEY (`codTipoEmpleado`)
    REFERENCES `carry`.`tblTipoEmpleado` (`codTipoEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblEmpleados_tblTipoVehiculo1`
    FOREIGN KEY (`codTipoVehiculo`)
    REFERENCES `carry`.`tblTipoVehiculo` (`codTipoVehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblArticulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblArticulos` (
  `codArticulo` INT NOT NULL AUTO_INCREMENT,
  `nombreArticulo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(80) NULL,
  `precio` DECIMAL(12,2) NULL,
  `origenFabricacion` VARCHAR(45) NULL,
  `saldo` INT NULL,
  `fechaPublicacion` DATE NULL,
  `estado` VARCHAR(15) NULL,
  `codCategoria` INT NOT NULL,
  `codUsuarioPublicador` INT NOT NULL,
  PRIMARY KEY (`codArticulo`),
  INDEX `fk_tblArticulos_tblEmpresas1_idx` (`codUsuarioPublicador` ASC),
  CONSTRAINT `fk_tblArticulos_tblEmpresas1`
    FOREIGN KEY (`codUsuarioPublicador`)
    REFERENCES `carry`.`tblEmpresas` (`codEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblFormaPago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblFormaPago` (
  `codFormaPago` INT NOT NULL AUTO_INCREMENT,
  `formaPago` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codFormaPago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblOrdenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblOrdenes` (
  `codOrden` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NULL,
  `codUsuarioRepartidor` INT NOT NULL,
  `codUsuarioCliente` INT NOT NULL,
  `tiempoEstimado` INT NULL,
  `tiempoEntrega` INT NULL,
  `distanciaKms` INT NULL,
  `cantArticulos` INT NULL,
  `cantEstaciones` INT NULL,
  `costoDeCompra` DECIMAL(12,2) NULL,
  `costoDeEntrega` DECIMAL(12,2) NULL,
  `costoOrden` DECIMAL(12,2) NULL,
  `estadoOrden` VARCHAR(10) NULL,
  `observaciones` VARCHAR(300) NULL,
  `horaSalida` DATETIME NULL,
  `horaEntrega` DATETIME NULL,
  PRIMARY KEY (`codOrden`),
  INDEX `fk_tblOrdenes_tblEmpleados1_idx` (`codUsuarioRepartidor` ASC),
  INDEX `fk_tblOrdenes_tblUsuarios1_idx` (`codUsuarioCliente` ASC),
  CONSTRAINT `fk_tblOrdenes_tblEmpleados1`
    FOREIGN KEY (`codUsuarioRepartidor`)
    REFERENCES `carry`.`tblEmpleados` (`codUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblOrdenes_tblUsuarios1`
    FOREIGN KEY (`codUsuarioCliente`)
    REFERENCES `carry`.`tblUsuarios` (`codUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblFacturasCliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblFacturasCliente` (
  `codFactura` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NULL,
  `efectivo` DECIMAL(12,2) NULL,
  `cambio` DECIMAL(12,2) NULL,
  `codFormaPago` INT NOT NULL,
  `codOrden` INT NOT NULL,
  PRIMARY KEY (`codFactura`),
  INDEX `fk_tblFacturas_tblFormaPago1_idx` (`codFormaPago` ASC),
  INDEX `fk_tblFacturas_tblOrdenes1_idx` (`codOrden` ASC),
  CONSTRAINT `fk_tblFacturas_tblFormaPago1`
    FOREIGN KEY (`codFormaPago`)
    REFERENCES `carry`.`tblFormaPago` (`codFormaPago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblFacturas_tblOrdenes1`
    FOREIGN KEY (`codOrden`)
    REFERENCES `carry`.`tblOrdenes` (`codOrden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblArticulosOrdenados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblArticulosOrdenados` (
  `codOrden` INT NOT NULL,
  `codArticulo` INT NOT NULL,
  `cantidad` INT NULL,
  `precioUnitario` DECIMAL(12,2) NULL,
  `subtotal` DECIMAL(12,2) NULL,
  `mapsOrigen` VARCHAR(250) NULL,
  `ubicacionOrigen` VARCHAR(200) NULL,
  `mapsDestino` VARCHAR(250) NULL,
  `ubicacionDestino` VARCHAR(250) NULL,
  `latitudOrigen` FLOAT NULL,
  `longitudOrigen` FLOAT NULL,
  `latitudDestino` FLOAT NULL,
  `longitudDestino` FLOAT NULL,
  INDEX `fk_tblArticulosOrdenados_tblOrdenes1_idx` (`codOrden` ASC),
  INDEX `fk_tblArticulosOrdenados_tblArticulos1_idx` (`codArticulo` ASC),
  CONSTRAINT `fk_tblArticulosOrdenados_tblOrdenes1`
    FOREIGN KEY (`codOrden`)
    REFERENCES `carry`.`tblOrdenes` (`codOrden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblArticulosOrdenados_tblArticulos1`
    FOREIGN KEY (`codArticulo`)
    REFERENCES `carry`.`tblArticulos` (`codArticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblImagenesArticulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblImagenesArticulo` (
  `codImagen` INT NOT NULL AUTO_INCREMENT,
  `nombreImagen` VARCHAR(45) NULL,
  `urlUbicacion` VARCHAR(60) NULL,
  `codArticulo` INT NOT NULL,
  INDEX `fk_tblImagenes_tblArticulos1_idx` (`codArticulo` ASC),
  PRIMARY KEY (`codImagen`),
  CONSTRAINT `fk_tblImagenes_tblArticulos1`
    FOREIGN KEY (`codArticulo`)
    REFERENCES `carry`.`tblArticulos` (`codArticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblPlanesPago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblPlanesPago` (
  `codPlanPago` INT NOT NULL AUTO_INCREMENT,
  `nombrePlan` VARCHAR(45) NULL,
  `precio` DECIMAL(2) NULL,
  PRIMARY KEY (`codPlanPago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblHistorialPlanes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblHistorialPlanes` (
  `codPlanPago` INT NOT NULL AUTO_INCREMENT,
  `codUsuario` INT NOT NULL,
  `fechaAprobación` DATE NULL,
  `fechaVencimiento` DATE NULL,
  `estadoPlan` VARCHAR(45) NULL,
  INDEX `fk_tblHistorialPlanes_tblPlanesPago1_idx` (`codPlanPago` ASC),
  INDEX `fk_tblHistorialPlanes_tblEmpresas1_idx` (`codUsuario` ASC),
  CONSTRAINT `fk_tblHistorialPlanes_tblPlanesPago1`
    FOREIGN KEY (`codPlanPago`)
    REFERENCES `carry`.`tblPlanesPago` (`codPlanPago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblHistorialPlanes_tblEmpresas1`
    FOREIGN KEY (`codUsuario`)
    REFERENCES `carry`.`tblEmpresas` (`codEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblOtroCargos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblOtroCargos` (
  `codCargo` INT NOT NULL AUTO_INCREMENT,
  `concepto` VARCHAR(45) NULL,
  `valor` DECIMAL(2) NULL,
  `codFactura` INT NOT NULL,
  PRIMARY KEY (`codCargo`),
  INDEX `fk_tblOtroCargos_tblFacturas1_idx` (`codFactura` ASC),
  CONSTRAINT `fk_tblOtroCargos_tblFacturas1`
    FOREIGN KEY (`codFactura`)
    REFERENCES `carry`.`tblFacturasCliente` (`codFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblTipoEmpresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblTipoEmpresa` (
  `codTipoEmpresa` INT NOT NULL AUTO_INCREMENT,
  `tipoEmpresa` VARCHAR(45) NULL,
  PRIMARY KEY (`codTipoEmpresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblDepartamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblDepartamentos` (
  `codDepartamento` INT NOT NULL AUTO_INCREMENT,
  `codRubro` INT NOT NULL,
  PRIMARY KEY (`codDepartamento`),
  INDEX `fk_tblDepartamentos_tblRubro1_idx` (`codRubro` ASC),
  CONSTRAINT `fk_tblDepartamentos_tblRubro1`
    FOREIGN KEY (`codRubro`)
    REFERENCES `carry`.`tblRubro` (`codRubro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblCategorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblCategorias` (
  `codCategoria` INT NOT NULL AUTO_INCREMENT,
  `codDepartamento` INT NOT NULL,
  `categoria` VARCHAR(45) NULL,
  PRIMARY KEY (`codCategoria`),
  INDEX `fk_tblCategorías_tblDepartamentos1_idx` (`codDepartamento` ASC),
  CONSTRAINT `fk_tblCategorías_tblDepartamentos1`
    FOREIGN KEY (`codDepartamento`)
    REFERENCES `carry`.`tblDepartamentos` (`codDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblDetalles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblDetalles` (
  `codDetalle` INT NOT NULL AUTO_INCREMENT,
  `detalle` VARCHAR(45) NULL,
  PRIMARY KEY (`codDetalle`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblDetallesArticulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblDetallesArticulo` (
  `codArticulo` INT NOT NULL,
  `codDetalle` INT NOT NULL,
  `valor` VARCHAR(45) NULL,
  INDEX `fk_tblDetallesArticulo_tblArticulos1_idx` (`codArticulo` ASC),
  INDEX `fk_tblDetallesArticulo_tblDetalles1_idx` (`codDetalle` ASC),
  CONSTRAINT `fk_tblDetallesArticulo_tblArticulos1`
    FOREIGN KEY (`codArticulo`)
    REFERENCES `carry`.`tblArticulos` (`codArticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblDetallesArticulo_tblDetalles1`
    FOREIGN KEY (`codDetalle`)
    REFERENCES `carry`.`tblDetalles` (`codDetalle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblInfoArticulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblInfoArticulo` (
  `codArticulo` INT NOT NULL,
  `codCategoria` INT NOT NULL,
  `codDepartamento` INT NOT NULL,
  INDEX `fk_table1_tblArticulos1_idx` (`codArticulo` ASC),
  INDEX `fk_table1_tblCategorias1_idx` (`codCategoria` ASC),
  CONSTRAINT `fk_table1_tblArticulos1`
    FOREIGN KEY (`codArticulo`)
    REFERENCES `carry`.`tblArticulos` (`codArticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_tblCategorias1`
    FOREIGN KEY (`codCategoria`)
    REFERENCES `carry`.`tblCategorias` (`codCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblImagenesPerfilEmpresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblImagenesPerfilEmpresa` (
  `codImagen` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(60) NULL,
  `codEmpresa` INT NOT NULL,
  PRIMARY KEY (`codImagen`),
  INDEX `fk_tblImagenesPerfilEmpresa_tblEmpresas1_idx` (`codEmpresa` ASC),
  CONSTRAINT `fk_tblImagenesPerfilEmpresa_tblEmpresas1`
    FOREIGN KEY (`codEmpresa`)
    REFERENCES `carry`.`tblEmpresas` (`codEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblImagenesUsuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblImagenesUsuarios` (
  `codImagen` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(60) NULL,
  `codUsuario` INT NOT NULL,
  PRIMARY KEY (`codImagen`),
  INDEX `fk_tblImagenesUsuarios_tblUsuarios1_idx` (`codUsuario` ASC),
  CONSTRAINT `fk_tblImagenesUsuarios_tblUsuarios1`
    FOREIGN KEY (`codUsuario`)
    REFERENCES `carry`.`tblUsuarios` (`codUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblListaDeseos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblListaDeseos` (
  `colItem` INT NOT NULL AUTO_INCREMENT,
  `codArticulo` INT NOT NULL,
  `codUsuario` INT NOT NULL,
  `fechaRegistro` DATE NULL,
  PRIMARY KEY (`colItem`),
  INDEX `fk_tblListaDeseos_tblArticulos1_idx` (`codArticulo` ASC),
  INDEX `fk_tblListaDeseos_tblUsuarios1_idx` (`codUsuario` ASC),
  CONSTRAINT `fk_tblListaDeseos_tblArticulos1`
    FOREIGN KEY (`codArticulo`)
    REFERENCES `carry`.`tblArticulos` (`codArticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblListaDeseos_tblUsuarios1`
    FOREIGN KEY (`codUsuario`)
    REFERENCES `carry`.`tblUsuarios` (`codUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblEmpresaFavoritas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblEmpresaFavoritas` (
  `codItem` INT NOT NULL AUTO_INCREMENT,
  `codUsuario` INT NOT NULL,
  `codEmpresa` INT NOT NULL,
  PRIMARY KEY (`codItem`),
  INDEX `fk_tblEmpresaFavoritas_tblUsuarios1_idx` (`codUsuario` ASC),
  INDEX `fk_tblEmpresaFavoritas_tblEmpresas1_idx` (`codEmpresa` ASC),
  CONSTRAINT `fk_tblEmpresaFavoritas_tblUsuarios1`
    FOREIGN KEY (`codUsuario`)
    REFERENCES `carry`.`tblUsuarios` (`codUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblEmpresaFavoritas_tblEmpresas1`
    FOREIGN KEY (`codEmpresa`)
    REFERENCES `carry`.`tblEmpresas` (`codEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblTipoAspirante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblTipoAspirante` (
  `codTipoAspirante` INT NOT NULL AUTO_INCREMENT,
  `tipoAspirante` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codTipoAspirante`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carry`.`tblAspirantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carry`.`tblAspirantes` (
  `codAspirante` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NOT NULL,
  `apellido` VARCHAR(25) NOT NULL,
  `identificacion` VARCHAR(15) NOT NULL,
  `nacimiento` DATE NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `correo` VARCHAR(25) NOT NULL,
  `domicilio` VARCHAR(150) NOT NULL,
  `codTipoAspirante_fk` INT NOT NULL,
  PRIMARY KEY (`codAspirante`),
  INDEX `fk_tblAspirantes_tblTipoAspirante1_idx` (`codTipoAspirante_fk` ASC),
  CONSTRAINT `fk_tblAspirantes_tblTipoAspirante1`
    FOREIGN KEY (`codTipoAspirante_fk`)
    REFERENCES `carry`.`tblTipoAspirante` (`codTipoAspirante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO tbltipousuarios (codTipoUsuario, tipoUsuario, idAcceso) VALUES (NULL, 'Usuario comun', '1'), (NULL, 'Usuario empleado', '2'),(NULL, 'Usuario empresa','3');