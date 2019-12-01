-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 29-11-2019 a las 23:30:12
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

--
-- Volcado de datos para la tabla `Acomodacion`
--

INSERT INTO `Acomodacion` (`habitacion`, `Hotel_nit`, `fechaLlegada`, `fechaSalida`, `Viaje_id`) VALUES
('3', '33004', '2019-11-13 00:00:00', '2019-11-15 21:00:00', 908),
('51', '33001', '2019-11-09 20:00:00', '2019-11-10 06:00:00', 906),
('703', '33002', '2019-11-03 00:00:00', '2019-11-22 00:00:00', 905),
('71', '33003', '2019-11-04 08:07:00', '2019-11-08 18:00:00', 907),
('71', '33003', '2019-11-04 12:00:00', '2019-11-12 12:00:00', 903),
('712', '33002', '2019-11-27 00:00:00', '2019-11-29 00:00:00', 906),
('76', '33001', '2019-11-11 00:00:00', '2019-11-12 00:00:00', 904),
('84', '33004', '2019-11-22 12:15:00', '2019-11-25 05:00:00', 905);

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

--
-- Volcado de datos para la tabla `Bus`
--

INSERT INTO `Bus` (`placa`, `numAsientos`, `soat`, `empresa`, `Conductor_Persona_cedula`) VALUES
('GAD-975', 25, '4753846784', 'Buses Armenia', '1202'),
('GEH-682', 25, '5848388703', 'Coorbuquin', '1211'),
('HIX-614', 28, '5736791023', 'TRANSTEBAIDA', '1216'),
('LOE-726', 15, '9824868353', 'Coorbuquin', '1213'),
('MBR-648', 27, '6285383984', 'Buses Armenia', '1214'),
('MSK-754', 20, '6473961023', 'Coorbuquin', '1201'),
('YTS-742', 10, '8793281765', 'Buses Armenia', '1212'),
('YTX-642', 31, '5873789285', 'TRANSTEBAIDA', '1215');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Ciudad`
--

CREATE TABLE `Ciudad` (
  `codPostal` varchar(15) NOT NULL,
  `codCiudad` varchar(3) NOT NULL,
  `nombre` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `Ciudad`
--

INSERT INTO `Ciudad` (`codPostal`, `codCiudad`, `nombre`) VALUES
('630001', '101', 'Armenia'),
('630002', '102', 'Bogotá'),
('630003', '103', 'Cali'),
('630004', '104', 'Medellin'),
('630005', '105', 'Cartagena'),
('630006', '106', 'Cúcuta'),
('630007', '107', 'Manizales'),
('630008', '108', 'Bucaramanga'),
('630009', '109', 'Barranquilla'),
('630010', '110', 'Santa Marta'),
('630011', '111', 'Pasto'),
('630012', '112', 'Pereira');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Cliente`
--

CREATE TABLE `Cliente` (
  `Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `Cliente`
--

INSERT INTO `Cliente` (`Persona_cedula`) VALUES
('1203'),
('1204'),
('1217'),
('1219');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Conductor`
--

CREATE TABLE `Conductor` (
  `numLicencia` varchar(15) NOT NULL,
  `Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `Conductor`
--

INSERT INTO `Conductor` (`numLicencia`, `Persona_cedula`) VALUES
('647383', '1201'),
('735836', '1202'),
('678396', '1211'),
('839347', '1212'),
('462728', '1213'),
('846423', '1214'),
('416361', '1215'),
('748234', '1216');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Cuenta`
--

CREATE TABLE `Cuenta` (
  `usuario` varchar(20) NOT NULL,
  `contraseña` varchar(30) DEFAULT NULL,
  `Cliente_Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `Cuenta`
--

INSERT INTO `Cuenta` (`usuario`, `contraseña`, `Cliente_Persona_cedula`) VALUES
('hola', '1234', '1203');

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
(2, '1204'),
(2, '1209'),
(2, '1210'),
(3, '1217'),
(3, '1218'),
(4, '1219'),
(4, '1220');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Guia`
--

CREATE TABLE `Guia` (
  `id` tinyint(4) NOT NULL,
  `Persona_cedula` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `Guia`
--

INSERT INTO `Guia` (`id`, `Persona_cedula`) VALUES
(1, '1205');

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

--
-- Volcado de datos para la tabla `Hotel`
--

INSERT INTO `Hotel` (`nit`, `direccion`, `empresa`, `nombre`, `telefono`) VALUES
('33001', 'CR 5#7 N', 'HotelStart', 'MIssan Hotel', '7359300'),
('33002', 'CR 5 #31 LC Norte', 'GehtKers', 'Las palmas doradas', '7463700'),
('33003', 'Cl. 5 # 2-4Z', 'Lilies', 'Hotel chicamocha', '7346224'),
('33004', 'Cl. 5 # X3 Sur', 'Hazbin Hotel', 'Santivago', '7332894');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Paquete`
--

CREATE TABLE `Paquete` (
  `Recorrido_id` smallint(6) NOT NULL,
  `SitioTuristico_nombre` varchar(50) NOT NULL,
  `SitioTuristico_codCiudad` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `Paquete`
--

INSERT INTO `Paquete` (`Recorrido_id`, `SitioTuristico_nombre`, `SitioTuristico_codCiudad`) VALUES
(5601, 'Caño Cristales', '101'),
(5601, 'Punta Gallinas', '109'),
(5602, 'Cerro Azul', '102'),
(5602, 'Minas de Nemocón', '103'),
(5602, 'Reserva Río Claro', '110'),
(5604, 'Parque Nacional Natural El Tuparro', '104');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Persona`
--

CREATE TABLE `Persona` (
  `cedula` char(10) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `correo` varchar(70) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `activo` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `Persona`
--

INSERT INTO `Persona` (`cedula`, `nombre`, `correo`, `telefono`, `activo`) VALUES
('1201', 'Juan Manuel Roa Mejia', 'jumarome@gmail.com', '313-598-8016', '0'),
('1202', 'Cristhian Camilo Rodriguez Molina', 'cristhwalker@gmail.com', '314-535-6264', '1'),
('1203', 'Daniel Bonilla Guevarra', 'bonia@gmail.com', '312-452-8354', '1'),
('1204', 'Andres llinas', 'llinas@outlook.com', '315-351-6243', '0'),
('1205', 'Wilmar Stiven Valencia Cardona', 'wilzhar@gmail.com', '312-642-6247', '1'),
('1206', 'Cristian Camilo Quiceno', 'joshua@outlook.com', '311-532-6275', '1'),
('1207', 'Jaime Antonio Nieto', 'nietoadictolol@gmail.com', '317-356-2532', '0'),
('1208', 'Luisa Cotte', 'lussolar@hotmail.com', '313-135-6246', '0'),
('1209', 'Yelsid Mami', 'yelsidmami@gmail.com', '317-646-3858', '1'),
('1210', 'Sergio Osorio Angel', 'sergiohacks@yahoo.com', '312-647-8359', '1'),
('1211', 'Maria Jose Garcia Quintero', 'mariajose@hotmail.com', '315-231-1248', '1'),
('1212', 'Miguel Angel Martinez', 'miguelangel@yahoo.com', '316-353-5465', '1'),
('1213', 'Angelica Arroyave Duque', 'angelicaduque@gmail.com', '316-367-6858', '1'),
('1214', 'Luis Osorio Gomez', 'lucho@yahoo.com', '317-548-0483', '1'),
('1215', 'John James Ospina', 'john_ospina@yahoo.com', '315-748-4395', '1'),
('1216', 'Juan Felipe Tapasco', 'tapasco@hotmail.com', '314-788-3934', '1'),
('1217', 'Luis Felipe Rincon', 'piperincon@outlook.com', '313-135-6136', '1'),
('1218', 'Maria Alejandra Caicedo Chavez', 'aleja@gmail.com', '312-638-2063', '1'),
('1219', 'Juan Diego Arias', 'juandii@yahoo.com', '316-385-3529', '1'),
('1220', 'Johan Stiven Muñoz Duque', 'duquesito@yahoo.com', '318-436-2829', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Recorrido`
--

CREATE TABLE `Recorrido` (
  `id` smallint(6) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `Recorrido`
--

INSERT INTO `Recorrido` (`id`, `descripcion`) VALUES
(5601, 'Recorrido a las montañas'),
(5602, 'Viaje por la costa'),
(5603, 'Conociendo el Amazonas'),
(5604, 'Solo recreación');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Reserva`
--

CREATE TABLE `Reserva` (
  `id` smallint(6) NOT NULL,
  `fechaSalida` datetime NOT NULL,
  `costo` decimal(9,2) NOT NULL,
  `reservante` char(10) NOT NULL,
  `Guia_Persona_cedula` char(10) NOT NULL,
  `fechaLlegada` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `Reserva`
--

INSERT INTO `Reserva` (`id`, `fechaSalida`, `costo`, `reservante`, `Guia_Persona_cedula`, `fechaLlegada`) VALUES
(1, '2019-12-14 00:00:00', '9999999.99', '1203', '1205', '2019-12-17 00:00:00'),
(2, '2019-01-14 00:00:00', '100000.00', '1204', '1205', '2019-01-23 00:00:00'),
(3, '2019-11-25 13:29:00', '2500000.00', '1217', '1205', '2019-12-01 08:43:00'),
(4, '2019-11-03 00:00:00', '800000.00', '1219', '1205', '2019-11-13 12:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `SitioTuristico`
--

CREATE TABLE `SitioTuristico` (
  `nombre` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `Ciudad_codCiudad` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `SitioTuristico`
--

INSERT INTO `SitioTuristico` (`nombre`, `direccion`, `Ciudad_codCiudad`) VALUES
('Caño Cristales', 'sierra de la Macarena', '101'),
('Cerro Azul', 'Iglesia Centro Azul Primavera', '102'),
('Minas de Nemocón', 'Cl. 2 ##0-05', '103'),
('Parque Nacional Natural El Tuparro', 'Vichada', '104'),
('Punta Gallinas', 'Península de La Guajira', '109'),
('Reserva Río Claro', 'parte alta del municipio de Sonsó', '110');

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

--
-- Volcado de datos para la tabla `Tiqueteria`
--

INSERT INTO `Tiqueteria` (`Vuelo_referencia`, `asiento`, `Viaje_id`, `fechaSalida`, `fechaLlegada`) VALUES
('MR35623Q', 'A24', 903, '2019-11-19 15:00:00', '2019-11-19 12:00:00'),
('RG47637M', 'A12', 905, '2019-11-08 22:00:00', '2019-11-09 05:00:00'),
('RG47637M', 'B23', 903, '2019-11-03 08:00:00', '2019-11-04 17:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Transporte`
--

CREATE TABLE `Transporte` (
  `Bus_placa` varchar(8) NOT NULL,
  `Viaje_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `Transporte`
--

INSERT INTO `Transporte` (`Bus_placa`, `Viaje_id`) VALUES
('GAD-975', 901),
('MSK-754', 901),
('GAD-975', 902),
('MSK-754', 902),
('GAD-975', 904),
('MSK-754', 906);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Viaje`
--

CREATE TABLE `Viaje` (
  `id` int(11) NOT NULL,
  `Recorrido_id` smallint(6) NOT NULL,
  `Reserva_id` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `Viaje`
--

INSERT INTO `Viaje` (`id`, `Recorrido_id`, `Reserva_id`) VALUES
(901, 5601, 1),
(902, 5602, 1),
(903, 5603, 1),
(904, 5604, 1),
(905, 5602, 2),
(906, 5604, 2),
(907, 5603, 3),
(908, 5604, 4);

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
-- Volcado de datos para la tabla `Vuelo`
--

INSERT INTO `Vuelo` (`referencia`, `empresa`, `fechaSalida`, `fechaLlegada`) VALUES
('BO42773T', 'Avianca', '2019-10-31 23:00:00', '2019-11-01 08:50:00'),
('KL35325R', 'Caribe Airlines', '2019-11-04 08:00:00', '2019-11-04 23:00:00'),
('MR35623Q', 'LATAM', '2019-11-24 13:00:00', '2019-11-24 19:00:00'),
('RB64701C', 'LATAM', '2019-11-03 20:45:00', '2019-11-04 12:00:00'),
('RG47637M', 'Avianca', '2019-11-15 08:00:00', '2019-11-18 15:30:00'),
('VC52674B', 'Avianca', '2019-11-26 10:00:00', '2019-11-26 20:00:00');

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
-- Indices de la tabla `Cuenta`
--
ALTER TABLE `Cuenta`
  ADD PRIMARY KEY (`Cliente_Persona_cedula`,`usuario`);

--
-- Indices de la tabla `Grupo`
--
ALTER TABLE `Grupo`
  ADD PRIMARY KEY (`Reserva_id`,`Persona_cedula`),
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
  ADD PRIMARY KEY (`Recorrido_id`,`SitioTuristico_nombre`,`SitioTuristico_codCiudad`),
  ADD KEY `Paquete_SitioTuristico_FK` (`SitioTuristico_nombre`,`SitioTuristico_codCiudad`);

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
  ADD PRIMARY KEY (`nombre`,`Ciudad_codCiudad`),
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
  ADD PRIMARY KEY (`Viaje_id`,`Bus_placa`),
  ADD KEY `Transporte_Bus_FK` (`Bus_placa`);

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
  ADD CONSTRAINT `Cliente_Persona_FK` FOREIGN KEY (`Persona_cedula`) REFERENCES `Persona` (`cedula`);

--
-- Filtros para la tabla `Conductor`
--
ALTER TABLE `Conductor`
  ADD CONSTRAINT `Conductor_Persona_FK` FOREIGN KEY (`Persona_cedula`) REFERENCES `Persona` (`cedula`);

--
-- Filtros para la tabla `Cuenta`
--
ALTER TABLE `Cuenta`
  ADD CONSTRAINT `Cuenta_Cliente_FK` FOREIGN KEY (`Cliente_Persona_cedula`) REFERENCES `Cliente` (`Persona_cedula`) ON DELETE CASCADE;

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
  ADD CONSTRAINT `Paquete_SitioTuristico_FK` FOREIGN KEY (`SitioTuristico_nombre`,`SitioTuristico_codCiudad`) REFERENCES `SitioTuristico` (`nombre`, `Ciudad_codCiudad`) ON DELETE CASCADE;

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
