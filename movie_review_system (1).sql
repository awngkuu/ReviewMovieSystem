-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 18, 2025 at 04:40 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `movie_review_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

CREATE TABLE `movies` (
  `movie_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `genre` varchar(100) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `director` varchar(100) DEFAULT NULL,
  `cast` text DEFAULT NULL,
  `synopsis` text DEFAULT NULL,
  `poster_url` varchar(255) DEFAULT NULL,
  `trailer_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies`
--

INSERT INTO `movies` (`movie_id`, `title`, `genre`, `release_date`, `director`, `cast`, `synopsis`, `poster_url`, `trailer_url`) VALUES
(1, 'Soloz: Game of Life ', 'Action, Esports, Drama', '2025-08-15', 'Ahmad Farhan Zainal', 'Khairul Azrin as Soloz\r\n\r\nPuteri Aina as Aira\r\n\r\nSyafiq Kyle as Reza\r\n\r\nRemy Ishak as Coach Zamri\r\n\r\nMira Filzah as Nisa', 'Soloz: Game of Life is a gripping drama inspired by the true story of a Malaysian esports icon, Soloz. Rising from humble beginnings in Kuala Lumpur, the film follows his journey from cyber cafes to the global Mobile Legends arena. Along the way, Soloz faces personal sacrifices, betrayal, and the mental toll of fame. It\'s a story of passion, resilience, and the unbreakable bond between a player and his game.', 'soloz.jpg', 'https://www.youtube.com/embed/eB552_r6k1s'),
(4, 'Ejen Ali 2', 'Action, Sci-Fi, Family', '2025-11-02', 'Usamah Zaid Yasin', 'adshbr', 'ashrgd', 'ejen ali.jpg', 'https://www.youtube.com/embed/5nD1LWmAeKc');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` between 1 and 5),
  `review_text` text DEFAULT NULL,
  `review_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `movie_id`, `user_id`, `rating`, `review_text`, `review_date`) VALUES
(1, 1, 1, 4, 'Good mOvie !!', '2025-06-16 18:55:31'),
(2, 1, 1, 5, 'Nice Movie !!!', '2025-06-16 18:56:12'),
(3, 1, 1, 4, 'CGI not to bad', '2025-06-16 18:56:31'),
(5, 1, 1, 3, 'Not to bad', '2025-06-16 18:57:20'),
(7, 1, 1, 3, 'biasa jer', '2025-06-17 03:54:14'),
(8, 1, 5, 3, 'boleh tahan', '2025-06-17 10:42:38'),
(10, 4, 5, 1, 'cam bodo', '2025-06-17 14:23:31');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` varchar(10) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `full_name`, `created_at`, `role`) VALUES
(1, 'awngkuu', 'wafiqaiman7@gmail.com', 'wafiq123', 'Awang Ku Wafiq', '2025-06-16 18:44:45', 'admin'),
(2, 'alip', 'alipman3@gmail.com', 'alif123', 'Alif Aiman', '2025-06-17 10:15:42', 'admin'),
(3, 'pokri', 'pokri2@gmail.com', 'pokri123', 'Hazri Halimi', '2025-06-17 10:17:24', 'admin'),
(5, 'asasa', 'asasa@gmail.com', 'asasa', 'asasa', '2025-06-17 10:28:56', 'user'),
(13, 'adada', 'adada@gmail.com', 'adada', 'adada adada', '2025-06-17 14:29:54', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`movie_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `movie_id` (`movie_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `movies`
--
ALTER TABLE `movies`
  MODIFY `movie_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
