-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 16, 2025 at 02:07 PM
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
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `subject_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `subject_id`) VALUES
(1, 'eeffwef', 1),
(2, 'dwfwewef', 1),
(3, 'dwfeweffwfw', 1),
(4, 'wefewfwfeewf', 2);

-- --------------------------------------------------------

--
-- Table structure for table `chapters`
--

CREATE TABLE `chapters` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chapters`
--

INSERT INTO `chapters` (`id`, `name`, `category_id`) VALUES
(1, 'wefwfwfwef', 1),
(2, 'wfewwf3t54t', 2),
(3, 'qweqeqqe', 3),
(4, '457788', 4);

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `option_a` varchar(255) DEFAULT NULL,
  `option_b` varchar(255) DEFAULT NULL,
  `option_c` varchar(255) DEFAULT NULL,
  `option_d` varchar(255) DEFAULT NULL,
  `correct_answer` varchar(255) DEFAULT NULL,
  `stream_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `subcategory_id` int(11) DEFAULT NULL,
  `level` enum('easy','medium','hard') DEFAULT 'medium',
  `explanation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_answer`, `stream_id`, `subject_id`, `category_id`, `chapter_id`, `subcategory_id`, `level`, `explanation`) VALUES
(1, 'ewffffffffffffffffffffffffffffffffffffffffffffffffffffffff', 'fff45', '65465', '76787', '98797', '76787', 1, 1, 2, 3, 1, 'medium', NULL),
(2, 'wefwe', 'f', 'dj', 'd', 'o', 'o', 2, 2, NULL, 1, NULL, 'easy', 'hwewgfu');

-- --------------------------------------------------------

--
-- Table structure for table `streams`
--

CREATE TABLE `streams` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `streams`
--

INSERT INTO `streams` (`id`, `name`) VALUES
(1, 'EFWFEWF'),
(2, 'dfewfwe');

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
(3, 'regerrger', 'fwfddweweweff@gmail.com', '7878979878', 'regerge', 'Management', '$2b$10$lGA7aRs8mj1ZVcbKZ6vgwew1ZjwSpaWyLDxBH1BRQ.x8JZB88qMOS', '2025-10-15 09:35:14'),
(4, 'fwefwefwe', 'fwfddwewewfwefwefwefweeff@gmail.com', '789999999779797', 'efwefwegf', 'Management', '$2b$10$meW2XoeakMwhlYtm3fsWJuvicXAXUHKESct0s4./SByDVcyBYgZcq', '2025-10-15 09:46:23'),
(5, 'qwdqwdqwd', 'fwfwewewefwefweff@gmail.com', '77797778798', 'edwefwf', 'Engineering', '$2b$10$z123wQZGt31H4s0ExfcIAO0EP.bmyHeleIDiwoBj/tHjuWiL0bh36', '2025-10-15 10:14:17');

-- --------------------------------------------------------

--
-- Table structure for table `subcategories`
--

CREATE TABLE `subcategories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `chapter_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subcategories`
--

INSERT INTO `subcategories` (`id`, `name`, `chapter_id`) VALUES
(1, 'edwfwefw', 2);

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `stream_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `name`, `stream_id`) VALUES
(1, 'weffewef', 1),
(2, 'ewfwef', 2);

-- --------------------------------------------------------

--
-- Table structure for table `tests`
--

CREATE TABLE `tests` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `stream_id` int(11) DEFAULT NULL,
  `total_duration` int(11) DEFAULT 90,
  `per_subject_duration` int(11) DEFAULT 30,
  `time_per_question` int(11) DEFAULT 20,
  `randomize` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tests`
--

INSERT INTO `tests` (`id`, `name`, `stream_id`, `total_duration`, `per_subject_duration`, `time_per_question`, `randomize`, `created_at`) VALUES
(12, 'qeewfw', 1, 90, 30, 20, 0, '2025-10-16 10:49:17');

-- --------------------------------------------------------

--
-- Table structure for table `test_sets`
--

CREATE TABLE `test_sets` (
  `id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `set_name` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `test_sets`
--

INSERT INTO `test_sets` (`id`, `test_id`, `set_name`, `created_at`) VALUES
(12, 12, 'A', '2025-10-16 10:49:17');

-- --------------------------------------------------------

--
-- Table structure for table `test_set_questions`
--

CREATE TABLE `test_set_questions` (
  `id` int(11) NOT NULL,
  `test_set_id` int(11) NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `question_id` int(11) NOT NULL,
  `difficulty` enum('easy','medium','hard') DEFAULT NULL,
  `chapter_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `test_set_questions`
--

INSERT INTO `test_set_questions` (`id`, `test_set_id`, `subject_id`, `question_id`, `difficulty`, `chapter_id`) VALUES
(1, 12, 1, 1, 'medium', 3);

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
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `chapters`
--
ALTER TABLE `chapters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stream_id` (`stream_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `chapter_id` (`chapter_id`),
  ADD KEY `subcategory_id` (`subcategory_id`);

--
-- Indexes for table `streams`
--
ALTER TABLE `streams`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chapter_id` (`chapter_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stream_id` (`stream_id`);

--
-- Indexes for table `tests`
--
ALTER TABLE `tests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `test_sets`
--
ALTER TABLE `test_sets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `test_id` (`test_id`);

--
-- Indexes for table `test_set_questions`
--
ALTER TABLE `test_set_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `test_set_id` (`test_set_id`),
  ADD KEY `question_id` (`question_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `chapters`
--
ALTER TABLE `chapters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `streams`
--
ALTER TABLE `streams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tests`
--
ALTER TABLE `tests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `test_sets`
--
ALTER TABLE `test_sets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `test_set_questions`
--
ALTER TABLE `test_set_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chapters`
--
ALTER TABLE `chapters`
  ADD CONSTRAINT `chapters_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`stream_id`) REFERENCES `streams` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `questions_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `questions_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `questions_ibfk_4` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `questions_ibfk_5` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD CONSTRAINT `subcategories_ibfk_1` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subjects`
--
ALTER TABLE `subjects`
  ADD CONSTRAINT `subjects_ibfk_1` FOREIGN KEY (`stream_id`) REFERENCES `streams` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `test_sets`
--
ALTER TABLE `test_sets`
  ADD CONSTRAINT `test_sets_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `test_set_questions`
--
ALTER TABLE `test_set_questions`
  ADD CONSTRAINT `test_set_questions_ibfk_1` FOREIGN KEY (`test_set_id`) REFERENCES `test_sets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `test_set_questions_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
