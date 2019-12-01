-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 30-11-2019 a las 16:19:52
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
-- Estructura de tabla para la tabla `Grupo`
--

CREATE TABLE `Grupo` (
  `Reserva_id` smallint(6) NOT NULL,
  `Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `Grupo`
--

INSERT INTO `Grupo` (`Reserva_id`, `Persona_cedula`) VALUES
(1, '1203'),
(1, '1206'),
(1, '1207'),
(1, '1208'),
(1, '989787'),
(2, '1202'),
(2, '1203'),
(2, '1204'),
(2, '1209'),
(2, '1210'),
(2, '44'),
(3, '1217'),
(3, '1218'),
(4, '1219'),
(4, '1220');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Grupo`
--
ALTER TABLE `Grupo`
  ADD PRIMARY KEY (`Reserva_id`,`Persona_cedula`),
  ADD KEY `Grupo_Persona_FK` (`Persona_cedula`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Grupo`
--
ALTER TABLE `Grupo`
  ADD CONSTRAINT `Grupo_Persona_FK` FOREIGN KEY (`Persona_cedula`) REFERENCES `Persona` (`cedula`),
  ADD CONSTRAINT `Grupo_Reserva_FK` FOREIGN KEY (`Reserva_id`) REFERENCES `Reserva` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
