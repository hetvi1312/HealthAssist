-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 27, 2024 at 01:16 PM
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
-- Database: `healthassist`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `appointment_type` enum('Google Meet','In Person') DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `appointment_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointment_id`, `user_id`, `doctor_id`, `name`, `appointment_type`, `appointment_date`, `appointment_time`) VALUES
(1, 1, 1, 'aisha', 'In Person', '2024-09-22', '06:15:00'),
(2, 1, 1, 'hetvipatel', 'Google Meet', '2024-09-15', '09:19:00'),
(3, 1, 2, 'komal', 'Google Meet', '2024-09-21', '12:20:00'),
(4, 1, 1, 'divya', 'In Person', '2024-09-28', '08:28:00'),
(5, 1, 1, 'komal', 'In Person', '2024-09-20', '11:46:00'),
(6, 1, 1, 'Connplex smart Theatre - Shila', 'Google Meet', '2024-09-28', '11:47:00'),
(7, 1, 1, 'divyaaaa', 'Google Meet', '2024-09-29', '11:51:00'),
(8, 1, 2, 'aesha patel', 'Google Meet', '2024-09-22', '13:09:00'),
(9, 1, 2, 'patel aesha ', 'Google Meet', '2024-09-25', '14:24:00'),
(10, 1, 2, 'aisha', 'Google Meet', '2024-09-17', '22:47:00'),
(11, 1, 1, 'divya', 'Google Meet', '2024-09-18', '01:00:00'),
(12, 2, 2, 'Diya', 'Google Meet', '2024-10-01', '11:01:00'),
(13, 2, 2, 'aisha', 'In Person', '2024-09-29', '15:34:00');

-- --------------------------------------------------------

--
-- Table structure for table `chat_history`
--

CREATE TABLE `chat_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_message` text NOT NULL,
  `assistant_response` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `doctor_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `specialty` varchar(100) DEFAULT NULL,
  `experience` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`doctor_id`, `name`, `email`, `phone`, `specialty`, `experience`, `image_url`) VALUES
(1, 'aesha patel', 'aesha@gmali.com', '8765432190', 'Neurologist', 1, 'doc7.jpg'),
(2, 'divya ', 'divya@gmail.com', '8765432166', 'Gynecologist', 4, 'doc5.jpg'),
(3, 'hetvi patel', 'hetvi@gmail.com', '9739405053', 'Dermatologist', 3, 'doc8.jpg'),
(4, 'vrushali ', 'vrushali@gmail.cim', '8765432190', ' Cardiologist', 11, 'doc6.jpg'),
(5, 'abhishek kumar', 'abhi@gmail.com', '8765432166', 'Physician', 6, 'doc1.jpg'),
(6, 'ayush', 'abck@gmail.com', '8765432166', 'Physician', 11, 'doc2.jpg'),
(7, 'jay patel', 'abcd@gmail.com', '8765432166', 'Physician', 10, 'doc3.jpg'),
(8, 'krishna', 'abce@gmail.com', '8765432166', 'Physician', 4, 'doc4.jpg'),
(9, 'akshay', 'abcf@gmail.com', '8765432166', 'Physician', 2, 'doc9.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `exercises`
--

CREATE TABLE `exercises` (
  `exercise_id` int(11) NOT NULL,
  `exercise_name` varchar(100) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `exercise_details` text DEFAULT NULL,
  `exercise_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exercises`
--

INSERT INTO `exercises` (`exercise_id`, `exercise_name`, `category_id`, `exercise_details`, `exercise_image`) VALUES
(1, ' Mindfulness Meditation\r\n', 1, 'Sit in a quiet place with your eyes closed and focus on your breath or sensations in your body. If your mind starts to wander, gently bring your attention back to your breath without judgment. This practice helps you stay present and develop greater awareness of your thoughts and feelings.', 'medi1.jpg'),
(2, 'Loving-Kindness Meditation (Metta)', 1, 'Sit comfortably and silently repeat phrases like “May I be happy, may I be healthy,” while focusing on feelings of love and kindness. Gradually extend these wishes to others, starting with loved ones, then extending to acquaintances and even those with whom you have conflicts, fostering compassion.', 'medi2.jpg'),
(3, 'Body Scan Meditation', 1, 'Lie down or sit comfortably, and slowly focus on each part of your body, starting from your toes and moving upward. Notice any sensations or tension in each area and consciously release it. This practice enhances body awareness and promotes relaxation.', 'medi3.jpg'),
(4, 'Breath Awareness Meditation', 1, 'Sit quietly and focus entirely on your breath—observe the inhales and exhales without trying to control it. When your mind wanders, gently bring your attention back to your breath, helping you develop concentration and calmness.', 'medi4.jpg'),
(5, 'Zen Meditation (Zazen)', 1, 'Sit in a comfortable position with a straight spine. Focus on your breath and keep your mind clear by allowing thoughts to pass by without engaging with them. The emphasis is on posture and stillness to cultivate awareness and mental clarity.', 'medi5.jpg'),
(6, 'Chakra Meditation', 1, 'Sit comfortably and focus on each of the seven energy centers (chakras) in the body. Visualize each chakra as a spinning wheel of energy, starting from the base of your spine to the crown of your head, balancing and aligning them to promote overall energy flow.', 'medi6.jpg'),
(9, 'Triangle Pose (Trikonasana)', 2, 'Triangle Pose (Trikonasana) begins by standing with your feet wide apart, turning your right foot out 90 degrees and your left foot slightly inward. Extend your right arm forward and lower it to your right shin or the floor while reaching your left arm up toward the ceiling. Engage your core and keep your body in a straight line, gazing up at your left hand or forward. This pose stretches the legs and hips, enhances balance, and supports digestion.', 'yoga.gif'),
(10, 'Ustrasana ', 2, 'Camel Pose (Ustrasana) involves kneeling with your knees hip-width apart and your thighs perpendicular to the floor. Place your hands on your lower back for support, then lean back and reach for your heels with your hands. Lift your chest and push your hips forward, arching your back. Keep your neck relaxed and gaze upward or slightly forward. Hold the pose while breathing deeply, then come back to the starting position by bringing your hands to your lower back and rising slowly. Camel Pose stretches the front of the body, including the chest, abdomen, and thighs, while also improving flexibility and opening the heart.', 'yoga2.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `exercise_categories`
--

CREATE TABLE `exercise_categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `image_url` varchar(600) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exercise_categories`
--

INSERT INTO `exercise_categories` (`category_id`, `category_name`, `image_url`) VALUES
(1, 'Meditation', 'med.gif'),
(2, 'Yoga', 'yoga.gif'),
(3, 'Pranayama', 'pra.jpg'),
(4, ' Cardiovascular (Aerobic)', 'card.gif'),
(5, 'Stretch', 'srt.gif'),
(6, 'Warm Up', 'warm.gif'),
(7, 'Fast Workout', 'fast.gif'),
(8, 'pain relief', 'pain.gif'),
(9, 'correction', 'corr.gif');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `phone`) VALUES
(1, 'hetvi', 'hetvi13patel@gmail.com', '$2b$12$0z79dlRXBDY9shsNzrguLewn8IXjXjoUSiLnNEKaUu3p2E91PSVy.', '9879055193'),
(2, 'Divya', 'divya@gmail.com', '$2b$12$RI1yC7r3jnGULYXd/ugCCuKi5xLndrc43o8OzpomBcBDYijvE.kRy', '9999999999');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `chat_history`
--
ALTER TABLE `chat_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`doctor_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `exercises`
--
ALTER TABLE `exercises`
  ADD PRIMARY KEY (`exercise_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `exercise_categories`
--
ALTER TABLE `exercise_categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `chat_history`
--
ALTER TABLE `chat_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `exercises`
--
ALTER TABLE `exercises`
  MODIFY `exercise_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `exercise_categories`
--
ALTER TABLE `exercise_categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`);

--
-- Constraints for table `chat_history`
--
ALTER TABLE `chat_history`
  ADD CONSTRAINT `chat_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `exercises`
--
ALTER TABLE `exercises`
  ADD CONSTRAINT `exercises_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `exercise_categories` (`category_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
