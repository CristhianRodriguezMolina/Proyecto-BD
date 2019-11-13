-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 13-11-2019 a las 15:48:46
-- Versión del servidor: 10.1.41-MariaDB-0ubuntu0.18.04.1
-- Versión de PHP: 7.2.24-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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
-- Estructura de tabla para la tabla `Acomodacion`
--

CREATE TABLE `Acomodacion` (
  `habitacion` varchar(40) NOT NULL,
  `Hotel_nit` varchar(20) NOT NULL,
  `fechaLlegada` datetime NOT NULL,
  `fechaSalida` datetime NOT NULL,
  `Viaje_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Bus`
--

CREATE TABLE `Bus` (
  `placa` varchar(8) NOT NULL,
  `numAsientos` tinyint(4) NOT NULL,
  `soat` varchar(15) NOT NULL,
  `empresa` varchar(30) NOT NULL,
  `Conductor_Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Ciudad`
--

CREATE TABLE `Ciudad` (
  `codPostal` varchar(15) NOT NULL,
  `codCiudad` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Cliente`
--

CREATE TABLE `Cliente` (
  `activo` char(1) NOT NULL,
  `Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Conductor`
--

CREATE TABLE `Conductor` (
  `numLicencia` varchar(15) NOT NULL,
  `Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Grupo`
--

CREATE TABLE `Grupo` (
  `Reserva_id` smallint(6) NOT NULL,
  `Cliente_Persona_cedula` char(10) NOT NULL,
  `Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Guia`
--

CREATE TABLE `Guia` (
  `id` tinyint(4) NOT NULL,
  `Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Hotel`
--

CREATE TABLE `Hotel` (
  `nit` varchar(20) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `telefono` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Paquete`
--

CREATE TABLE `Paquete` (
  `Recorrido_id` double NOT NULL,
  `SitioTuristico_nombre` varchar(50) NOT NULL,
  `SitioTuristico_direccion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Persona`
--

CREATE TABLE `Persona` (
  `cedula` char(10) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `correo` varchar(70) NOT NULL,
  `telefono` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `Persona`
--

INSERT INTO `Persona` (`cedula`, `nombre`, `correo`, `telefono`) VALUES
('1234', 'Juan Manuel Roa Mejia', 'jumarome@gmail.com', '313 598 5016');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Recorrido`
--

CREATE TABLE `Recorrido` (
  `id` double NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Reserva`
--

CREATE TABLE `Reserva` (
  `id` smallint(6) NOT NULL,
  `fecha` datetime NOT NULL,
  `costo` decimal(9,2) NOT NULL,
  `reservante` char(10) NOT NULL,
  `Guia_Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `SitioTuristico`
--

CREATE TABLE `SitioTuristico` (
  `nombre` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `Ciudad_codCiudad` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Tiqueteria`
--

CREATE TABLE `Tiqueteria` (
  `Vuelo_referencia` varchar(30) NOT NULL,
  `asiento` varchar(50) NOT NULL,
  `Viaje_id` int(11) NOT NULL,
  `fechaSalida` datetime NOT NULL,
  `fechaLlegada` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Transporte`
--

CREATE TABLE `Transporte` (
  `Bus_placa` varchar(8) NOT NULL,
  `Viaje_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Viaje`
--

CREATE TABLE `Viaje` (
  `id` int(11) NOT NULL,
  `Recorrido_id` double NOT NULL,
  `Tiqueteria_puestos` varchar(50) NOT NULL,
  `Reserva_id` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Vuelo`
--

CREATE TABLE `Vuelo` (
  `referencia` varchar(30) NOT NULL,
  `empresa` varchar(40) NOT NULL,
  `fechaSalida` datetime NOT NULL,
  `fechaLlegada` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Acomodacion`
--
ALTER TABLE `Acomodacion`
  ADD PRIMARY KEY (`habitacion`,`Hotel_nit`,`fechaLlegada`),
  ADD KEY `Acomodacion_Hotel_FK` (`Hotel_nit`),
  ADD KEY `Acomodacion_Viaje_FK` (`Viaje_id`);

--
-- Indices de la tabla `Bus`
--
ALTER TABLE `Bus`
  ADD PRIMARY KEY (`placa`),
  ADD KEY `Bus_Conductor_FK` (`Conductor_Persona_cedula`);

--
-- Indices de la tabla `Ciudad`
--
ALTER TABLE `Ciudad`
  ADD PRIMARY KEY (`codCiudad`);

--
-- Indices de la tabla `Cliente`
--
ALTER TABLE `Cliente`
  ADD PRIMARY KEY (`Persona_cedula`);

--
-- Indices de la tabla `Conductor`
--
ALTER TABLE `Conductor`
  ADD PRIMARY KEY (`Persona_cedula`);

--
-- Indices de la tabla `Grupo`
--
ALTER TABLE `Grupo`
  ADD PRIMARY KEY (`Reserva_id`,`Cliente_Persona_cedula`),
  ADD KEY `Grupo_Persona_FK` (`Persona_cedula`);

--
-- Indices de la tabla `Guia`
--
ALTER TABLE `Guia`
  ADD PRIMARY KEY (`Persona_cedula`);

--
-- Indices de la tabla `Hotel`
--
ALTER TABLE `Hotel`
  ADD PRIMARY KEY (`nit`);

--
-- Indices de la tabla `Paquete`
--
ALTER TABLE `Paquete`
  ADD PRIMARY KEY (`Recorrido_id`,`SitioTuristico_nombre`,`SitioTuristico_direccion`),
  ADD KEY `Paquete_SitioTuristico_FK` (`SitioTuristico_nombre`,`SitioTuristico_direccion`);

--
-- Indices de la tabla `Persona`
--
ALTER TABLE `Persona`
  ADD PRIMARY KEY (`cedula`);

--
-- Indices de la tabla `Recorrido`
--
ALTER TABLE `Recorrido`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `Reserva`
--
ALTER TABLE `Reserva`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Reserva_Cliente_FK` (`reservante`),
  ADD KEY `Reserva_Guia_FK` (`Guia_Persona_cedula`);

--
-- Indices de la tabla `SitioTuristico`
--
ALTER TABLE `SitioTuristico`
  ADD PRIMARY KEY (`nombre`,`direccion`),
  ADD KEY `SitioTuristico_Ciudad_FK` (`Ciudad_codCiudad`);

--
-- Indices de la tabla `Tiqueteria`
--
ALTER TABLE `Tiqueteria`
  ADD PRIMARY KEY (`Vuelo_referencia`,`asiento`,`fechaSalida`),
  ADD KEY `Tiquetes_Viaje_FK` (`Viaje_id`);

--
-- Indices de la tabla `Transporte`
--
ALTER TABLE `Transporte`
  ADD KEY `Transporte_Bus_FK` (`Bus_placa`),
  ADD KEY `Transporte_Viaje_FK` (`Viaje_id`);

--
-- Indices de la tabla `Viaje`
--
ALTER TABLE `Viaje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Viaje_Recorrido_FK` (`Recorrido_id`),
  ADD KEY `Viaje_Reserva_FK` (`Reserva_id`);

--
-- Indices de la tabla `Vuelo`
--
ALTER TABLE `Vuelo`
  ADD PRIMARY KEY (`referencia`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Acomodacion`
--
ALTER TABLE `Acomodacion`
  ADD CONSTRAINT `Acomodacion_Hotel_FK` FOREIGN KEY (`Hotel_nit`) REFERENCES `Hotel` (`nit`) ON DELETE CASCADE,
  ADD CONSTRAINT `Acomodacion_Viaje_FK` FOREIGN KEY (`Viaje_id`) REFERENCES `Viaje` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Bus`
--
ALTER TABLE `Bus`
  ADD CONSTRAINT `Bus_Conductor_FK` FOREIGN KEY (`Conductor_Persona_cedula`) REFERENCES `Conductor` (`Persona_cedula`);

--
-- Filtros para la tabla `Cliente`
--
ALTER TABLE `Cliente`
  ADD CONSTRAINT `Cliente_Persona_FK` FOREIGN KEY (`Persona_cedula`) REFERENCES `Persona` (`cedula`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Conductor`
--
ALTER TABLE `Conductor`
  ADD CONSTRAINT `Conductor_Persona_FK` FOREIGN KEY (`Persona_cedula`) REFERENCES `Persona` (`cedula`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Grupo`
--
ALTER TABLE `Grupo`
  ADD CONSTRAINT `Grupo_Persona_FK` FOREIGN KEY (`Persona_cedula`) REFERENCES `Persona` (`cedula`),
  ADD CONSTRAINT `Grupo_Reserva_FK` FOREIGN KEY (`Reserva_id`) REFERENCES `Reserva` (`id`);

--
-- Filtros para la tabla `Guia`
--
ALTER TABLE `Guia`
  ADD CONSTRAINT `Guia_Persona_FK` FOREIGN KEY (`Persona_cedula`) REFERENCES `Persona` (`cedula`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Paquete`
--
ALTER TABLE `Paquete`
  ADD CONSTRAINT `Paquete_Recorrido_FK` FOREIGN KEY (`Recorrido_id`) REFERENCES `Recorrido` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Paquete_SitioTuristico_FK` FOREIGN KEY (`SitioTuristico_nombre`,`SitioTuristico_direccion`) REFERENCES `SitioTuristico` (`nombre`, `direccion`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Reserva`
--
ALTER TABLE `Reserva`
  ADD CONSTRAINT `Reserva_Cliente_FK` FOREIGN KEY (`reservante`) REFERENCES `Cliente` (`Persona_cedula`),
  ADD CONSTRAINT `Reserva_Guia_FK` FOREIGN KEY (`Guia_Persona_cedula`) REFERENCES `Guia` (`Persona_cedula`);

--
-- Filtros para la tabla `SitioTuristico`
--
ALTER TABLE `SitioTuristico`
  ADD CONSTRAINT `SitioTuristico_Ciudad_FK` FOREIGN KEY (`Ciudad_codCiudad`) REFERENCES `Ciudad` (`codCiudad`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Tiqueteria`
--
ALTER TABLE `Tiqueteria`
  ADD CONSTRAINT `Tiquetes_Viaje_FK` FOREIGN KEY (`Viaje_id`) REFERENCES `Viaje` (`id`),
  ADD CONSTRAINT `Tiquetes_Vuelo_FK` FOREIGN KEY (`Vuelo_referencia`) REFERENCES `Vuelo` (`referencia`);

--
-- Filtros para la tabla `Transporte`
--
ALTER TABLE `Transporte`
  ADD CONSTRAINT `Transporte_Bus_FK` FOREIGN KEY (`Bus_placa`) REFERENCES `Bus` (`placa`),
  ADD CONSTRAINT `Transporte_Viaje_FK` FOREIGN KEY (`Viaje_id`) REFERENCES `Viaje` (`id`);

--
-- Filtros para la tabla `Viaje`
--
ALTER TABLE `Viaje`
  ADD CONSTRAINT `Viaje_Recorrido_FK` FOREIGN KEY (`Recorrido_id`) REFERENCES `Recorrido` (`id`),
  ADD CONSTRAINT `Viaje_Reserva_FK` FOREIGN KEY (`Reserva_id`) REFERENCES `Reserva` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
