-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 15, 2025 at 12:12 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `exam_portal`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('superadmin','admin') DEFAULT 'admin',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`id`, `name`, `email`, `password`, `role`, `created_at`) VALUES
(2, 'Super Admin', 'super@admin.com', '$2b$10$n5/vkkYE6fAVdK5gM5FaTuINUZCxFUZtAwgIFW5RY2.dLSFvVOdFO', 'superadmin', '2025-10-15 07:44:27'),
(3, 'Farhan', 'farhan@admin.com', '$2b$10$Bo3sDKcnTz8iytkYjKnDwuGsZt3KtNUcZWmU2PgS4k6THUTfZyGC6', 'admin', '2025-10-15 07:45:15'),
(4, 'ewefwef', 'awefwefwefdmin@example.com', '$2b$10$D.S3jNoNYLaPwauRm2.Xy.X2uoYOmrW9kPJGhU/bO.42vyWXTfu5S', 'admin', '2025-10-15 10:09:22');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `city` varchar(100) NOT NULL,
  `stream` enum('Engineering','Management') NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `name`, `email`, `mobile`, `city`, `stream`, `password`, `created_at`) VALUES
(1, 'dqwdqwdq', 'fwfweweweff@gmail.com', '', '', 'Engineering', '$2b$10$w1yavzcDvQ3Oi59KJB.8pOEBAKHfab5mIRPz7MKG7yUfcCb1M2W9q', '2025-10-15 08:29:49'),
(2, 'qdqwdqwdqw', 'fwfdqwqwdweweweff@gmail.com', '', '', 'Engineering', '$2b$10$ZU2T1Mva1PreyCQYGTGhseuc4K6/J4GANR3wNjxZ/RMsfoPqmCRhG', '2025-10-15 08:33:38'),
(3, 'regerrger', 'fwfddweweweff@gmail.com', '7878979878', 'regerge', 'Management', '$2b$10$VQdqMwFj.izaV2Ih236AlupZjFd3A26OYvAM9tFkpM65Ti2gNVF5S', '2025-10-15 09:35:14'),
(4, 'fwefwefwe', 'fwfddwewewfwefwefwefweeff@gmail.com', '789999999779797', 'efwefwegf', 'Management', '$2b$10$meW2XoeakMwhlYtm3fsWJuvicXAXUHKESct0s4./SByDVcyBYgZcq', '2025-10-15 09:46:23');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
