-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-11-2019 a las 17:54:35
-- Versión del servidor: 10.4.8-MariaDB
-- Versión de PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `lacatuli`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acomodacion`
--

CREATE TABLE `acomodacion` (
  `habitacion` varchar(40) NOT NULL,
  `Hotel_nit` varchar(20) NOT NULL,
  `fechaLlegada` datetime NOT NULL,
  `fechaSalida` datetime NOT NULL,
  `Viaje_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bus`
--

CREATE TABLE `bus` (
  `placa` varchar(8) NOT NULL,
  `numAsientos` tinyint(4) NOT NULL,
  `soat` varchar(15) NOT NULL,
  `empresa` varchar(30) NOT NULL,
  `Conductor_Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad`
--

CREATE TABLE `ciudad` (
  `codPostal` varchar(15) NOT NULL,
  `codCiudad` varchar(3) NOT NULL,
  `nombre` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `activo` double NOT NULL,
  `Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`activo`, `Persona_cedula`) VALUES
(1, '1'),
(1, '1007477971'),
(1, '123'),
(1, '2'),
(1, '3'),
(1, '4'),
(1, '66666666');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conductor`
--

CREATE TABLE `conductor` (
  `numLicencia` varchar(15) NOT NULL,
  `Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta`
--

CREATE TABLE `cuenta` (
  `usuario` varchar(20) NOT NULL,
  `contrasenia` varchar(30) DEFAULT NULL,
  `Cliente_Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cuenta`
--

INSERT INTO `cuenta` (`usuario`, `contrasenia`, `Cliente_Persona_cedula`) VALUES
('1', '1', '1'),
('cristh', '12345', '1007477971'),
('dsa', 'dsa', '123'),
('asd', 'asd', '2'),
('3', '3', '3'),
('4', '4', '4'),
('test', '1234', '66666666');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo`
--

CREATE TABLE `grupo` (
  `Reserva_id` smallint(6) NOT NULL,
  `Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `guia`
--

CREATE TABLE `guia` (
  `id` tinyint(4) NOT NULL,
  `Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hotel`
--

CREATE TABLE `hotel` (
  `nit` varchar(20) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `telefono` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paquete`
--

CREATE TABLE `paquete` (
  `Recorrido_id` smallint(6) NOT NULL,
  `SitioTuristico_nombre` varchar(50) NOT NULL,
  `SitioTuristico_codCiudad` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `cedula` char(10) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `correo` varchar(70) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `activo` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`cedula`, `nombre`, `correo`, `telefono`, `activo`) VALUES
('1', '1', '1', '1', NULL),
('1007477971', 'camilo', 'asca', '121432', NULL),
('123', 'dsa', 'dsa', '123123', NULL),
('12341', 'asds', 'asdas', '124', NULL),
('2', '2', '2', '2', NULL),
('3', '3', '3', '3', NULL),
('4', '4', '4', '4', NULL),
('66666666', 'ASDFS', 'FSDFSAF@GMAIL.COM', '124134', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recorrido`
--

CREATE TABLE `recorrido` (
  `id` smallint(6) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE `reserva` (
  `id` smallint(6) NOT NULL,
  `fechaSalida` datetime NOT NULL,
  `costo` decimal(9,2) NOT NULL,
  `reservante` char(10) NOT NULL,
  `Guia_Persona_cedula` char(10) NOT NULL,
  `fechaLlegada` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sitioturistico`
--

CREATE TABLE `sitioturistico` (
  `nombre` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `Ciudad_codCiudad` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiqueteria`
--

CREATE TABLE `tiqueteria` (
  `Vuelo_referencia` varchar(30) NOT NULL,
  `asiento` varchar(50) NOT NULL,
  `Viaje_id` int(11) NOT NULL,
  `fechaSalida` datetime NOT NULL,
  `fechaLlegada` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transporte`
--

CREATE TABLE `transporte` (
  `Bus_placa` varchar(8) NOT NULL,
  `Viaje_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viaje`
--

CREATE TABLE `viaje` (
  `id` int(11) NOT NULL,
  `Recorrido_id` smallint(6) NOT NULL,
  `Reserva_id` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vuelo`
--

CREATE TABLE `vuelo` (
  `referencia` varchar(30) NOT NULL,
  `empresa` varchar(40) NOT NULL,
  `fechaSalida` datetime NOT NULL,
  `fechaLlegada` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `acomodacion`
--
ALTER TABLE `acomodacion`
  ADD PRIMARY KEY (`habitacion`,`Hotel_nit`,`fechaLlegada`),
  ADD KEY `Acomodacion_Hotel_FK` (`Hotel_nit`),
  ADD KEY `Acomodacion_Viaje_FK` (`Viaje_id`);

--
-- Indices de la tabla `bus`
--
ALTER TABLE `bus`
  ADD PRIMARY KEY (`placa`),
  ADD KEY `Bus_Conductor_FK` (`Conductor_Persona_cedula`);

--
-- Indices de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  ADD PRIMARY KEY (`codCiudad`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`Persona_cedula`);

--
-- Indices de la tabla `conductor`
--
ALTER TABLE `conductor`
  ADD PRIMARY KEY (`Persona_cedula`);

--
-- Indices de la tabla `cuenta`
--
ALTER TABLE `cuenta`
  ADD PRIMARY KEY (`Cliente_Persona_cedula`,`usuario`);

--
-- Indices de la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD PRIMARY KEY (`Reserva_id`,`Persona_cedula`),
  ADD KEY `Grupo_Persona_FK` (`Persona_cedula`);

--
-- Indices de la tabla `guia`
--
ALTER TABLE `guia`
  ADD PRIMARY KEY (`Persona_cedula`);

--
-- Indices de la tabla `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`nit`);

--
-- Indices de la tabla `paquete`
--
ALTER TABLE `paquete`
  ADD PRIMARY KEY (`Recorrido_id`,`SitioTuristico_nombre`,`SitioTuristico_codCiudad`),
  ADD KEY `Paquete_SitioTuristico_FK` (`SitioTuristico_nombre`,`SitioTuristico_codCiudad`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`cedula`);

--
-- Indices de la tabla `recorrido`
--
ALTER TABLE `recorrido`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Reserva_Cliente_FK` (`reservante`),
  ADD KEY `Reserva_Guia_FK` (`Guia_Persona_cedula`);

--
-- Indices de la tabla `sitioturistico`
--
ALTER TABLE `sitioturistico`
  ADD PRIMARY KEY (`nombre`,`Ciudad_codCiudad`),
  ADD KEY `SitioTuristico_Ciudad_FK` (`Ciudad_codCiudad`);

--
-- Indices de la tabla `tiqueteria`
--
ALTER TABLE `tiqueteria`
  ADD PRIMARY KEY (`Vuelo_referencia`,`asiento`,`fechaSalida`),
  ADD KEY `Tiquetes_Viaje_FK` (`Viaje_id`);

--
-- Indices de la tabla `transporte`
--
ALTER TABLE `transporte`
  ADD PRIMARY KEY (`Viaje_id`,`Bus_placa`),
  ADD KEY `Transporte_Bus_FK` (`Bus_placa`);

--
-- Indices de la tabla `viaje`
--
ALTER TABLE `viaje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Viaje_Recorrido_FK` (`Recorrido_id`),
  ADD KEY `Viaje_Reserva_FK` (`Reserva_id`);

--
-- Indices de la tabla `vuelo`
--
ALTER TABLE `vuelo`
  ADD PRIMARY KEY (`referencia`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `acomodacion`
--
ALTER TABLE `acomodacion`
  ADD CONSTRAINT `Acomodacion_Hotel_FK` FOREIGN KEY (`Hotel_nit`) REFERENCES `hotel` (`nit`),
  ADD CONSTRAINT `Acomodacion_Viaje_FK` FOREIGN KEY (`Viaje_id`) REFERENCES `viaje` (`id`);

--
-- Filtros para la tabla `bus`
--
ALTER TABLE `bus`
  ADD CONSTRAINT `Bus_Conductor_FK` FOREIGN KEY (`Conductor_Persona_cedula`) REFERENCES `conductor` (`Persona_cedula`);

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `Cliente_Persona_FK` FOREIGN KEY (`Persona_cedula`) REFERENCES `persona` (`cedula`);

--
-- Filtros para la tabla `conductor`
--
ALTER TABLE `conductor`
  ADD CONSTRAINT `Conductor_Persona_FK` FOREIGN KEY (`Persona_cedula`) REFERENCES `persona` (`cedula`);

--
-- Filtros para la tabla `cuenta`
--
ALTER TABLE `cuenta`
  ADD CONSTRAINT `Cuenta_Cliente_FK` FOREIGN KEY (`Cliente_Persona_cedula`) REFERENCES `cliente` (`Persona_cedula`);

--
-- Filtros para la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD CONSTRAINT `Grupo_Persona_FK` FOREIGN KEY (`Persona_cedula`) REFERENCES `persona` (`cedula`),
  ADD CONSTRAINT `Grupo_Reserva_FK` FOREIGN KEY (`Reserva_id`) REFERENCES `reserva` (`id`);

--
-- Filtros para la tabla `guia`
--
ALTER TABLE `guia`
  ADD CONSTRAINT `Guia_Persona_FK` FOREIGN KEY (`Persona_cedula`) REFERENCES `persona` (`cedula`);

--
-- Filtros para la tabla `paquete`
--
ALTER TABLE `paquete`
  ADD CONSTRAINT `Paquete_Recorrido_FK` FOREIGN KEY (`Recorrido_id`) REFERENCES `recorrido` (`id`),
  ADD CONSTRAINT `Paquete_SitioTuristico_FK` FOREIGN KEY (`SitioTuristico_nombre`,`SitioTuristico_codCiudad`) REFERENCES `sitioturistico` (`nombre`, `Ciudad_codCiudad`);

--
-- Filtros para la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD CONSTRAINT `Reserva_Cliente_FK` FOREIGN KEY (`reservante`) REFERENCES `cliente` (`Persona_cedula`),
  ADD CONSTRAINT `Reserva_Guia_FK` FOREIGN KEY (`Guia_Persona_cedula`) REFERENCES `guia` (`Persona_cedula`);

--
-- Filtros para la tabla `sitioturistico`
--
ALTER TABLE `sitioturistico`
  ADD CONSTRAINT `SitioTuristico_Ciudad_FK` FOREIGN KEY (`Ciudad_codCiudad`) REFERENCES `ciudad` (`codCiudad`);

--
-- Filtros para la tabla `tiqueteria`
--
ALTER TABLE `tiqueteria`
  ADD CONSTRAINT `Tiquetes_Viaje_FK` FOREIGN KEY (`Viaje_id`) REFERENCES `viaje` (`id`),
  ADD CONSTRAINT `Tiquetes_Vuelo_FK` FOREIGN KEY (`Vuelo_referencia`) REFERENCES `vuelo` (`referencia`);

--
-- Filtros para la tabla `transporte`
--
ALTER TABLE `transporte`
  ADD CONSTRAINT `Transporte_Bus_FK` FOREIGN KEY (`Bus_placa`) REFERENCES `bus` (`placa`),
  ADD CONSTRAINT `Transporte_Viaje_FK` FOREIGN KEY (`Viaje_id`) REFERENCES `viaje` (`id`);

--
-- Filtros para la tabla `viaje`
--
ALTER TABLE `viaje`
  ADD CONSTRAINT `Viaje_Recorrido_FK` FOREIGN KEY (`Recorrido_id`) REFERENCES `recorrido` (`id`),
  ADD CONSTRAINT `Viaje_Reserva_FK` FOREIGN KEY (`Reserva_id`) REFERENCES `reserva` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
