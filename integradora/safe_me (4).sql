-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-11-2022 a las 08:20:25
-- Versión del servidor: 10.4.25-MariaDB
-- Versión de PHP: 8.0.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `safe_me`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `bitacora` (IN `iduser` INT, IN `idemocion` INT(11), IN `segunda_emocion` INT, OUT `nombremocion` VARCHAR(15) CHARSET utf8mb4)   BEGIN START TRANSACTION;
   
	SELECT nombre INTO nombremocion FROM emociones WHERE id_emocion=idemocion;
   
    IF iduser !=0 THEN INSERT INTO log_feels(id,id_emocion,nombre_emocion,id_emc_desagrado,id_emc_felicidad,id_emc_ira,id_emc_miedo,id_emc_sorpresa,id_emc_tristeza,descripcion,created_at)
    VALUES(iduser,idemocion,nombremocion,0,0,0,0,0,0," ",now()); COMMIT;
    ELSE ROLLBACK;
    END IF;
    
    IF segunda_emocion=1 THEN update log_feels set id_emc_felicidad=1 WHERE id=iduser; COMMIT; ELSE ROLLBACK; END IF;
   

     
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `new_register` (IN `new_username` VARCHAR(60), IN `new_email` VARCHAR(70), IN `new_fullname` VARCHAR(70), IN `passwordd` VARCHAR(70), OUT `user_` VARCHAR(70))   BEGIN START TRANSACTION;
    SELECT username into user_ FROM users WHERE fullname=new_fullname;
    INSERT INTO users(fullname,username,email,password_,created_at) 
	VALUES(new_fullname,new_username,new_email,AES_ENCRYPT(passwordd,'CR7'),now());
    IF new_username = user_ THEN ROLLBACK;
    ELSE COMMIT;
    END IF;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `new_username` (IN `iduser` INT(50), IN `new_username` VARCHAR(70), OUT `comparacion_user` VARCHAR(70), OUT `idd` INT(50))   BEGIN
  START TRANSACTION;
  SELECT id INTO idd FROM users WHERE id=iduser;
  Select username into comparacion_user from users where iduser=id;
   
  IF comparacion_user != new_username THEN
    UPDATE users SET username=new_username WHERE iduser = id ;
    COMMIT;
  ELSE
    ROLLBACK;
   END IF;
   END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `segunda_emocion` (IN `iduser` INT, IN `primera_emocion` INT, IN `segunda_emocion` INT, IN `descripcionn` TEXT, OUT `nombre_emocionn` VARCHAR(100))   BEGIN START TRANSACTION;
SELECT nombre into nombre_emocionn from emociones WHERE primera_emocion=id_emocion;
IF primera_emocion=1 THEN
insert into log_feels(id,id_emocion,nombre_emocion,id_emc_desagrado,id_emc_felicidad,id_emc_ira,
id_emc_miedo,id_emc_sorpresa,id_emc_tristeza,descripcion,created_at) values(iduser,primera_emocion,nombre_emocionn,0,segunda_emocion,0,0,0,0,descripcionn,now());COMMIT; else ROLLBACK; END IF;
IF primera_emocion=2 THEN insert into log_feels(id,id_emocion,nombre_emocion,id_emc_desagrado,id_emc_felicidad,id_emc_ira,
id_emc_miedo,id_emc_sorpresa,id_emc_tristeza,descripcion,created_at) values(iduser,primera_emocion,nombre_emocionn,0,0,0,0,segunda_emocion,0,descripcionn,now());COMMIT; else ROLLBACK;  END IF;
IF primera_emocion=3 THEN insert into log_feels(id,id_emocion,nombre_emocion,id_emc_desagrado,id_emc_felicidad,id_emc_ira,
id_emc_miedo,id_emc_sorpresa,id_emc_tristeza,descripcion,created_at) values(iduser,primera_emocion,nombre_emocionn,0,0,0,segunda_emocion,0,0,descripcionn,now());COMMIT; else ROLLBACK;  END IF;
IF primera_emocion=4 THEN insert into log_feels(id,id_emocion,nombre_emocion,id_emc_desagrado,id_emc_felicidad,id_emc_ira,
id_emc_miedo,id_emc_sorpresa,id_emc_tristeza,descripcion,created_at) values(iduser,primera_emocion,nombre_emocionn,0,0,segunda_emocion,0,0,0,descripcionn,now());COMMIT; else ROLLBACK;  END IF;
IF primera_emocion=5 THEN insert into log_feels(id,id_emocion,nombre_emocion,id_emc_desagrado,id_emc_felicidad,id_emc_ira,
id_emc_miedo,id_emc_sorpresa,id_emc_tristeza,descripcion,created_at) values(iduser,primera_emocion,nombre_emocionn,segunda_emocion,0,0,0,0,0,descripcionn,now());COMMIT; else ROLLBACK;  END IF;
IF primera_emocion=6 THEN insert into log_feels(id,id_emocion,nombre_emocion,id_emc_desagrado,id_emc_felicidad,id_emc_ira,
id_emc_miedo,id_emc_sorpresa,id_emc_tristeza,descripcion,created_at) values(iduser,primera_emocion,nombre_emocionn,0,0,0,0,0,segunda_emocion,descripcionn,now());COMMIT; else ROLLBACK;  END IF;




END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_imagenes`
--

CREATE TABLE `cat_imagenes` (
  `id_cat_img` int(11) NOT NULL,
  `id_emocion` int(11) NOT NULL,
  `imagen` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emociones`
--

CREATE TABLE `emociones` (
  `id_emocion` int(11) NOT NULL,
  `nombre` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `emociones`
--

INSERT INTO `emociones` (`id_emocion`, `nombre`) VALUES
(5, 'desagrado'),
(1, 'felicidad'),
(4, 'ira'),
(3, 'miedo'),
(2, 'sorpresa'),
(6, 'tristeza');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emocion_desagrado`
--

CREATE TABLE `emocion_desagrado` (
  `id_emc_desagrado` int(11) NOT NULL,
  `id_emocion` int(11) NOT NULL,
  `nombre` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `emocion_desagrado`
--

INSERT INTO `emocion_desagrado` (`id_emc_desagrado`, `id_emocion`, `nombre`) VALUES
(1, 5, 'disconforme'),
(2, 5, 'decepcionado'),
(3, 5, 'horrible'),
(4, 5, 'abstinencia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emocion_felicidad`
--

CREATE TABLE `emocion_felicidad` (
  `id_emc_felicidad` int(11) NOT NULL,
  `id_emocion` int(11) NOT NULL,
  `nombre` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `emocion_felicidad`
--

INSERT INTO `emocion_felicidad` (`id_emc_felicidad`, `id_emocion`, `nombre`) VALUES
(1, 1, 'alegre'),
(2, 1, 'interesado'),
(3, 1, 'orgulloso'),
(4, 1, 'aceptado'),
(5, 1, 'poderoso'),
(6, 1, 'pacifico'),
(7, 1, 'intimo'),
(8, 1, 'optimista');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emocion_ira`
--

CREATE TABLE `emocion_ira` (
  `id_emc_ira` int(11) NOT NULL,
  `id_emocion` int(11) NOT NULL,
  `nombre` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `emocion_ira`
--

INSERT INTO `emocion_ira` (`id_emc_ira`, `id_emocion`, `nombre`) VALUES
(1, 4, 'critico'),
(2, 4, 'distante'),
(3, 4, 'frustrado'),
(4, 4, 'agresivo'),
(5, 4, 'loco'),
(6, 4, 'lleno de odio'),
(7, 4, 'amenazado'),
(8, 4, 'herido');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emocion_miedo`
--

CREATE TABLE `emocion_miedo` (
  `id_emc_miedo` int(11) NOT NULL,
  `id_emocion` int(11) NOT NULL,
  `nombre` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `emocion_miedo`
--

INSERT INTO `emocion_miedo` (`id_emc_miedo`, `id_emocion`, `nombre`) VALUES
(1, 3, 'humillado'),
(2, 3, 'rechazado'),
(3, 3, 'sumiso'),
(4, 3, 'inseguro'),
(5, 3, 'ansioso'),
(6, 3, 'asustado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emocion_sorpresa`
--

CREATE TABLE `emocion_sorpresa` (
  `id_emc_sorpresa` int(11) NOT NULL,
  `id_emocion` int(11) NOT NULL,
  `nombre` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `emocion_sorpresa`
--

INSERT INTO `emocion_sorpresa` (`id_emc_sorpresa`, `id_emocion`, `nombre`) VALUES
(1, 2, 'sorprendido'),
(2, 2, 'confundido '),
(3, 2, 'asombrado'),
(4, 2, 'entusiasmado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emocion_tristeza`
--

CREATE TABLE `emocion_tristeza` (
  `id_emc_tristeza` int(11) NOT NULL,
  `id_emocion` int(11) NOT NULL,
  `nombre` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `emocion_tristeza`
--

INSERT INTO `emocion_tristeza` (`id_emc_tristeza`, `id_emocion`, `nombre`) VALUES
(1, 6, 'culpable'),
(2, 6, 'abandonado'),
(3, 6, 'desesperado'),
(4, 6, 'deprimido'),
(5, 6, 'solo'),
(6, 6, 'aburrido');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_feels`
--

CREATE TABLE `log_feels` (
  `id_log` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `id_emocion` int(11) NOT NULL,
  `nombre_emocion` varchar(15) NOT NULL,
  `id_emc_desagrado` int(11) DEFAULT NULL,
  `id_emc_felicidad` int(11) DEFAULT NULL,
  `id_emc_ira` int(11) DEFAULT NULL,
  `id_emc_miedo` int(11) DEFAULT NULL,
  `id_emc_sorpresa` int(11) DEFAULT NULL,
  `id_emc_tristeza` int(11) DEFAULT NULL,
  `descripcion` text NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `log_feels`
--

INSERT INTO `log_feels` (`id_log`, `id`, `id_emocion`, `nombre_emocion`, `id_emc_desagrado`, `id_emc_felicidad`, `id_emc_ira`, `id_emc_miedo`, `id_emc_sorpresa`, `id_emc_tristeza`, `descripcion`, `created_at`) VALUES
(12, 2, 5, 'desagrado', 0, 0, 0, 0, 0, 0, '', '2022-10-28 20:15:11'),
(13, 2, 5, 'desagrado', 0, 0, 0, 0, 0, 0, ' ', '2022-11-03 11:25:58'),
(18, 2, 1, 'felicidad', 0, 3, 0, 0, 0, 0, 'toymalito', '0000-00-00 00:00:00'),
(20, 2, 4, 'ira', 0, 0, 1, 0, 0, 0, 'toymalito porque', '2022-11-16 00:17:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(500) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `fullname`, `username`, `email`, `password_`, `created_at`) VALUES
(1, 'bebé', 'babychulo', 'elbebe@bebe.com', 'bb', '2025-11-25 00:00:00'),
(2, 'Dafnis Cain V', 'Cain', 'cain@hotmail.com', '123', '2022-10-24 22:12:58'),
(6, 'D', 'tony montana', 'alan@gmail.com', '123', '2022-10-28 19:23:03'),
(8, 'iram putin', 'madafaking', 'iram@gmail.com', 'elmasvergas', '2022-10-28 12:03:05'),
(17, 'iram fuyi', 'iramccalvarez', 'irawmmmm@gmail.com', '12345', '2022-10-28 19:29:14'),
(19, 'loco chon', 'CR7', 'Messi@gmail.com', 'perrodelmal', '2022-11-03 11:33:50'),
(20, 'Cesar Duarte', 'perre vergue', 'prrovrgo@gmail.com', '??z9??g??}??Ŏ', '2022-11-11 00:08:46'),
(22, 'Dayana Cruz', 'Messi', 'bbbonito@gmail.com', '??5#?J?$5?x*2?', '2022-11-11 00:48:28');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cat_imagenes`
--
ALTER TABLE `cat_imagenes`
  ADD PRIMARY KEY (`id_cat_img`),
  ADD KEY `id_emocion` (`id_emocion`);

--
-- Indices de la tabla `emociones`
--
ALTER TABLE `emociones`
  ADD PRIMARY KEY (`id_emocion`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `emocion_desagrado`
--
ALTER TABLE `emocion_desagrado`
  ADD PRIMARY KEY (`id_emc_desagrado`),
  ADD KEY `id_emocion` (`id_emocion`);

--
-- Indices de la tabla `emocion_felicidad`
--
ALTER TABLE `emocion_felicidad`
  ADD PRIMARY KEY (`id_emc_felicidad`),
  ADD KEY `id_emocion` (`id_emocion`);

--
-- Indices de la tabla `emocion_ira`
--
ALTER TABLE `emocion_ira`
  ADD PRIMARY KEY (`id_emc_ira`),
  ADD KEY `id_emocion` (`id_emocion`);

--
-- Indices de la tabla `emocion_miedo`
--
ALTER TABLE `emocion_miedo`
  ADD PRIMARY KEY (`id_emc_miedo`),
  ADD KEY `id_emocion` (`id_emocion`);

--
-- Indices de la tabla `emocion_sorpresa`
--
ALTER TABLE `emocion_sorpresa`
  ADD PRIMARY KEY (`id_emc_sorpresa`),
  ADD KEY `id_emocion` (`id_emocion`);

--
-- Indices de la tabla `emocion_tristeza`
--
ALTER TABLE `emocion_tristeza`
  ADD PRIMARY KEY (`id_emc_tristeza`),
  ADD KEY `id_emocion` (`id_emocion`);

--
-- Indices de la tabla `log_feels`
--
ALTER TABLE `log_feels`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `id` (`id`),
  ADD KEY `id_emocion` (`id_emocion`),
  ADD KEY `id_emc_desagrado` (`id_emc_desagrado`,`id_emc_felicidad`,`id_emc_ira`,`id_emc_miedo`,`id_emc_sorpresa`,`id_emc_tristeza`),
  ADD KEY `nombre_emocion` (`nombre_emocion`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `fullname` (`fullname`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cat_imagenes`
--
ALTER TABLE `cat_imagenes`
  MODIFY `id_cat_img` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `emocion_desagrado`
--
ALTER TABLE `emocion_desagrado`
  MODIFY `id_emc_desagrado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `emocion_felicidad`
--
ALTER TABLE `emocion_felicidad`
  MODIFY `id_emc_felicidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `emocion_ira`
--
ALTER TABLE `emocion_ira`
  MODIFY `id_emc_ira` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `emocion_miedo`
--
ALTER TABLE `emocion_miedo`
  MODIFY `id_emc_miedo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `emocion_sorpresa`
--
ALTER TABLE `emocion_sorpresa`
  MODIFY `id_emc_sorpresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `emocion_tristeza`
--
ALTER TABLE `emocion_tristeza`
  MODIFY `id_emc_tristeza` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `log_feels`
--
ALTER TABLE `log_feels`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cat_imagenes`
--
ALTER TABLE `cat_imagenes`
  ADD CONSTRAINT `cat_imagenes_ibfk_1` FOREIGN KEY (`id_emocion`) REFERENCES `emociones` (`id_emocion`);

--
-- Filtros para la tabla `emocion_desagrado`
--
ALTER TABLE `emocion_desagrado`
  ADD CONSTRAINT `emocion_desagrado_ibfk_1` FOREIGN KEY (`id_emocion`) REFERENCES `emociones` (`id_emocion`);

--
-- Filtros para la tabla `emocion_felicidad`
--
ALTER TABLE `emocion_felicidad`
  ADD CONSTRAINT `emocion_felicidad_ibfk_1` FOREIGN KEY (`id_emocion`) REFERENCES `emociones` (`id_emocion`);

--
-- Filtros para la tabla `emocion_ira`
--
ALTER TABLE `emocion_ira`
  ADD CONSTRAINT `emocion_ira_ibfk_1` FOREIGN KEY (`id_emocion`) REFERENCES `emociones` (`id_emocion`);

--
-- Filtros para la tabla `emocion_miedo`
--
ALTER TABLE `emocion_miedo`
  ADD CONSTRAINT `emocion_miedo_ibfk_1` FOREIGN KEY (`id_emocion`) REFERENCES `emociones` (`id_emocion`);

--
-- Filtros para la tabla `emocion_sorpresa`
--
ALTER TABLE `emocion_sorpresa`
  ADD CONSTRAINT `emocion_sorpresa_ibfk_1` FOREIGN KEY (`id_emocion`) REFERENCES `emociones` (`id_emocion`);

--
-- Filtros para la tabla `emocion_tristeza`
--
ALTER TABLE `emocion_tristeza`
  ADD CONSTRAINT `emocion_tristeza_ibfk_1` FOREIGN KEY (`id_emocion`) REFERENCES `emociones` (`id_emocion`);

--
-- Filtros para la tabla `log_feels`
--
ALTER TABLE `log_feels`
  ADD CONSTRAINT `log_feels_ibfk_1` FOREIGN KEY (`id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `log_feels_ibfk_2` FOREIGN KEY (`id_emocion`) REFERENCES `emociones` (`id_emocion`),
  ADD CONSTRAINT `log_feels_ibfk_3` FOREIGN KEY (`nombre_emocion`) REFERENCES `emociones` (`nombre`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
