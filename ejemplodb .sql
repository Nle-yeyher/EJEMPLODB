-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 31-03-2025 a las 22:11:44
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ejemplodb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `coste` float NOT NULL DEFAULT 0,
  `precio` float NOT NULL DEFAULT 0,
  `descuento` decimal(5,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `coste`, `precio`, `descuento`) VALUES
(1, 'producto A', 5000, 9000.01, 999.99),
(2, 'producto B', 2, 5000, 0.00),
(3, 'producto C', 1, 1000, 0.00),
(4, 'producto D', 6, 80000, 0.00),
(5, 'producto E', 3, 12000, 0.00),
(6, 'producto F', 7, 800000, 0.00),
(7, 'producto G', 5, 50000, 0.00);

--
-- Disparadores `productos`
--
DELIMITER $$
CREATE TRIGGER `actualizarprecioproducto` BEFORE UPDATE ON `productos` FOR EACH ROW BEGIN
    IF NEW.coste <> OLD.coste THEN
        -- Aumentar el precio al doble del coste
        SET NEW.precio = NEW.coste * 2;
        SET NEW.descuento = 0; -- Inicializar el descuento en 0
        
        -- Aplicar descuentos según el precio
        IF NEW.precio <= 7000 THEN
            SET NEW.descuento = NEW.precio * 0.10;
        ELSEIF NEW.precio < 12000 THEN
            SET NEW.descuento = NEW.precio * 0.15;
        ELSEIF NEW.precio <= 25000 THEN
            SET NEW.descuento = NEW.precio * 0.50;
        END IF;
        
        -- Restar el descuento al precio final
        SET NEW.precio = NEW.precio - NEW.descuento;
    END IF;
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
