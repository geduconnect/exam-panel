-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 09, 2025 at 03:21 PM
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
-- Database: `exam_panel_test`
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
(1, 'Motion', 1),
(2, 'Electricity', 1),
(3, 'Kinematics', 1),
(5, 'General', 1),
(6, 'Physical Chemistry', 3),
(7, 'Organic Chemistry', 3),
(8, 'Inorganic Chemistry', 3),
(9, 'GENERAL', 6),
(10, 'General', 4);

-- --------------------------------------------------------

--
-- Table structure for table `chapters`
--

CREATE TABLE `chapters` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chapters`
--

INSERT INTO `chapters` (`id`, `name`, `category_id`, `subject_id`) VALUES
(1, 'CURRENT ELECTRICITY', 1, NULL),
(2, 'ELECTROSTATIC POTENTIAL AND CAPACITANCE', 2, NULL),
(3, 'ELECTRIC CHARGES AND FIELDS', 3, NULL),
(5, 'Introduction to Modern Physics', 5, 1),
(6, ' The Solid State', 6, 3),
(7, 'HydroCarbon', 7, 3),
(8, 'Periodic Table', 8, 3),
(9, 'Matrices', 10, 4),
(10, 'Application of Derivatives', 10, 4),
(11, 'Probability', 10, 4);

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
  `explanation` text DEFAULT NULL,
  `question_image` text DEFAULT NULL,
  `option_a_image` text DEFAULT NULL,
  `option_b_image` text DEFAULT NULL,
  `option_c_image` text DEFAULT NULL,
  `option_d_image` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_answer`, `stream_id`, `subject_id`, `category_id`, `chapter_id`, `subcategory_id`, `level`, `explanation`, `question_image`, `option_a_image`, `option_b_image`, `option_c_image`, `option_d_image`) VALUES
(193, 'When a glass rod is rubbed with silk, it', 'gains electrons from silk.', 'gives electrons to silk.', 'gains protons from silk.', 'gives protons to silk.', 'B', 1, 1, 2, 3, NULL, 'easy', 'By convention, when a glass rod is rubbed with silk, the glass rod acquires a positive charge, and the silk acquires a negative charge. This is because electrons are transferred from the glass to the silk.', NULL, NULL, NULL, NULL, NULL),
(194, 'The force between two small charged spheres having charges of 2×10−7 C and 3×10−7 C placed 30 cm apart in the air is', '6×10−3 N (Repulsive)', '6×10−3 N (Attractive)', '5×10−3 N (Repulsive)', '5×10−3 N (Attractive)', 'A', 1, 1, 2, 3, NULL, 'easy', 'Using Coulomb\'s law, F=kr2∣q1q2∣. F=(9×109)(0.3)2(2×10−7)(3×10−7)=0.0954×10−5=6×10−3 N. Since both charges are positive, the force is repulsive.', NULL, NULL, NULL, NULL, NULL),
(195, 'The property which differentiates two kinds of charges is called', 'Amount of charge', 'Polarity of charge', 'Strength of charge', 'Field of charge', 'B', 1, 1, 2, 3, NULL, 'easy', 'Polarity refers to the nature of the charge, i.e., whether it is positive or negative.', NULL, NULL, NULL, NULL, NULL),
(196, 'A body can be negatively charged by', 'giving excess of electrons to it.', 'removing some electrons from it.', 'giving some protons to it.', 'removing some neutrons from it.', 'A', 1, 1, 2, 3, NULL, 'easy', 'An object becomes negatively charged when it has more electrons than protons.', NULL, NULL, NULL, NULL, NULL),
(197, 'The SI unit of electric charge is', 'Ampere (A)', 'Coulomb (C)', 'Volt (V)', 'Ohm (Ω)', 'B', 1, 1, 2, 3, NULL, 'easy', 'The SI unit of electric charge is the Coulomb.', NULL, NULL, NULL, NULL, NULL),
(198, 'Quantization of charge implies that', 'charge cannot be destroyed.', 'charge exists on particles.', 'there is a minimum permissible magnitude of charge.', 'charge can only be an integer multiple of the fundamental charge.', 'D', 1, 1, 2, 3, NULL, 'easy', 'The principle of quantization of charge states that any charged body has a total charge that is an integer multiple of the elementary charge \'e\' (1.6×10−19 C).', NULL, NULL, NULL, NULL, NULL),
(199, 'If a charge \'q\' is placed at the center of the line joining two equal charges \'Q\', the system of three charges will be in equilibrium if \'q\' is equal to', '-Q/2', '-Q/4', '+Q/4', '+Q/2', 'B', 1, 1, 2, 3, NULL, 'hard', 'For the equilibrium of charge Q, the net force on it must be zero. The force due to the other charge Q must be balanced by the force due to q. k(2r)2Q2+kr2Qq=0⟹4Q+q=0⟹q=−Q/4.', NULL, NULL, NULL, NULL, NULL),
(200, 'The dielectric constant (K) of a metal is', '0', '1', '-1', 'Infinite', 'D', 1, 1, 2, 3, NULL, 'hard', 'For metals, the electric field inside is zero, which implies an infinite dielectric constant. This is because the free charges in the metal rearrange themselves to completely cancel out the external electric field.', NULL, NULL, NULL, NULL, NULL),
(201, 'An electric dipole is placed in a uniform electric field. The net electric force on the dipole', 'is always zero.', 'depends on the orientation of the dipole.', 'can never be zero.', 'depends on the strength of the dipole.', 'A', 1, 1, 2, 3, NULL, 'hard', 'In a uniform electric field, the force on the positive charge is equal and opposite to the force on the negative charge. Therefore, the net force on the dipole is always zero.', NULL, NULL, NULL, NULL, NULL),
(202, 'The direction of the electric field intensity due to a positive charge is', 'away from the charge.', 'towards the charge.', 'circular around the charge.', 'parallel to the charge.', 'A', 1, 1, 2, 3, NULL, 'hard', 'By convention, the electric field lines originate from a positive charge and are directed radially outwards.', NULL, NULL, NULL, NULL, NULL),
(203, 'Which of the following is a vector quantity?', 'Electric Charge', 'Electric Potential', 'Electric Field Intensity', 'Electric Flux', 'C', 1, 1, 2, 3, NULL, 'hard', 'The electric field has both magnitude and direction, making it a vector quantity.', NULL, NULL, NULL, NULL, NULL),
(204, 'The torque (τ) experienced by an electric dipole of moment \'p\' in a uniform electric field \'E\' is given by', 'τ=p⋅E', 'τ=p×E', 'τ=pE', 'τ=p/E', 'B', 1, 1, 2, 3, NULL, 'hard', 'The torque is a vector quantity given by the cross product of the dipole moment and the electric field. Its magnitude is pEsinθ.', NULL, NULL, NULL, NULL, NULL),
(205, 'The SI unit of electric flux is', 'N/C', 'V·m', 'N·m²/C', 'T', 'C', 1, 1, 2, 3, NULL, 'hard', 'Electric flux (ΦE) is defined as the product of the electric field and the area perpendicular to the field (ΦE=E⋅A). The unit of E is N/C and the unit of A is m², so the unit of flux is N·m²/C. (Note: V·m is also a correct unit).', NULL, NULL, NULL, NULL, NULL),
(206, 'A charge Q is enclosed by a Gaussian spherical surface of radius R. If the radius is doubled, then the outward electric flux will', 'be doubled.', 'be reduced to half.', 'remain the same.', 'increase four times.', 'C', 1, 1, 2, 3, NULL, 'hard', 'According to Gauss\'s law, the total electric flux through a closed surface depends only on the net charge enclosed by the surface and not on the size or shape of the surface.', NULL, NULL, NULL, NULL, NULL),
(207, 'The electric field inside a uniformly charged hollow spherical shell is', 'constant.', 'directly proportional to the distance from the center.', 'zero.', 'inversely proportional to the distance from the center.', 'C', 1, 1, 2, 3, NULL, 'medium', 'According to Gauss\'s law, for any point inside the shell, a Gaussian surface encloses no charge. Therefore, the electric field must be zero everywhere inside the shell.', NULL, NULL, NULL, NULL, NULL),
(208, 'Electric field lines provide information about', 'field strength.', 'direction of the force.', 'nature of charge.', 'all of the above.', 'D', 1, 1, 2, 3, NULL, 'medium', 'The density of field lines indicates the strength, the tangent to the line gives the direction of the force, and the lines originate from positive and terminate on negative charges.', NULL, NULL, NULL, NULL, NULL),
(209, 'What is the angle between the electric dipole moment and the electric field strength due to it on the equatorial line?', '0°', '90°', '180°', '45°', 'C', 1, 1, 2, 3, NULL, 'medium', 'The electric field at a point on the equatorial line is directed opposite to the direction of the electric dipole moment.', NULL, NULL, NULL, NULL, NULL),
(210, 'The surface charge density of a conductor is σ. The electric field at a point just outside the conductor is', 'σ/ϵ0', 'σ/2ϵ0', '2σ/ϵ0', 'Zero', 'A', 1, 1, 2, 3, NULL, 'medium', 'For a conducting surface, the electric field just outside is given by E=σ/ϵ0, and it is directed perpendicular to the surface.', NULL, NULL, NULL, NULL, NULL),
(211, 'Two-point charges +3 μC and +8 μC repel each other with a force of 40 N. If a charge of -5 μC is added to each of them, then the force between them will become', '-10 N', '+10 N', '+20 N', '-20 N', 'A', 1, 1, 2, 3, NULL, 'medium', 'Initially, F=kr2(3)(8)=40 N. The new charges are q1′=3−5=−2 μC and q2′=8−5=+3 μC. The new force is F′=kr2(−2)(3)=−r26k. From the initial condition, r2k=2440. So, F′=−6×2440=−10 N. The negative sign indicates an attractive force.', NULL, NULL, NULL, NULL, NULL),
(212, 'The work done in rotating an electric dipole in an electric field from a stable equilibrium position to an unstable equilibrium position is', 'pE', '2pE', '−pE', 'Zero', 'B', 1, 1, 2, 3, NULL, 'medium', 'Work done W=pE(cosθ1−cosθ2). Stable equilibrium is at θ1=0∘ and unstable equilibrium is at θ2=180∘. So, W=pE(cos0∘−cos180∘)=pE(1−(−1))=2pE.', NULL, NULL, NULL, NULL, NULL),
(213, 'When an electric dipole is placed in a non-uniform electric field, it experiences', 'only a net force.', 'only a torque.', 'both a net force and a torque.', 'neither a force nor a torque.', 'C', 1, 1, 2, 3, NULL, 'medium', 'In a non-uniform field, the forces on the positive and negative charges are not equal and opposite, resulting in a net force. There will also generally be a torque unless the dipole is aligned with the field.', NULL, NULL, NULL, NULL, NULL),
(214, 'The electric field at a point on the axial line of a short electric dipole is E1. The electric field at a point on the equatorial line at the same distance is E2. Then', 'E1=2E2', 'E2=2E1', 'E1=E2', 'E1=−2E2 (considering direction)', 'D', 1, 1, 2, 3, NULL, 'medium', 'For a short dipole, the magnitude of the axial field is twice the magnitude of the equatorial field at the same distance (∣Eaxial∣=2∣Eequatorial∣). The directions are opposite.', NULL, NULL, NULL, NULL, NULL),
(215, 'A comb run through one\'s dry hair attracts small bits of paper. This is due to', 'the comb being a good conductor.', 'the paper being a good conductor.', 'electrostatic induction.', 'magnetic effects.', 'C', 1, 1, 2, 3, NULL, 'medium', 'The charged comb induces an opposite charge on the surface of the paper bits, leading to an attractive force.', NULL, NULL, NULL, NULL, NULL),
(216, 'The force per unit charge is known as', 'electric flux', 'electric field', 'electric potential', 'electric current', 'B', 1, 1, 2, 3, NULL, 'easy', 'The electric field intensity (E) at a point is defined as the electrostatic force (F) experienced by a unit positive charge (q0) placed at that point, i.e., E=F/q0.', NULL, NULL, NULL, NULL, NULL),
(217, 'The concept of an electric field was introduced by', 'Charles-Augustin de Coulomb', 'Michael Faraday', 'Isaac Newton', 'James Clerk Maxwell', 'B', 1, 1, 2, 3, NULL, 'easy', 'Michael Faraday introduced the concept of electric field lines and the idea of an electric field to describe the interaction between charges.', NULL, NULL, NULL, NULL, NULL),
(218, 'The linear charge density (λ) is defined as', 'Charge per unit volume.', 'Charge per unit area.', 'Charge per unit length.', 'Total charge of the body.', 'C', 1, 1, 2, 3, NULL, 'easy', 'Linear charge density is used for one-dimensional charge distributions, like a charged wire, and is given by λ=dldQ.', NULL, NULL, NULL, NULL, NULL),
(219, 'A hollow insulated conducting sphere is given a positive charge of 10 μC. What will be the electric field at the center of the sphere if its radius is 2 meters?', '20 μC m⁻²', '5 μC m⁻²', 'Zero', '8 μC m⁻²', 'C', 1, 1, 2, 3, NULL, 'easy', 'The electric field inside any charged hollow conducting sphere is zero. This is a direct consequence of Gauss\'s law, as a Gaussian surface inside the sphere encloses no net charge.', NULL, NULL, NULL, NULL, NULL),
(220, 'If the electric field is given by E=8i^+4j^+3k^ N/C, the electric flux through a surface of area 100 m² lying in the X-Y plane is', '800 N·m²/C', '400 N·m²/C', '300 N·m²/C', '0', 'C', 1, 1, 2, 3, NULL, 'easy', 'For a surface in the X-Y plane, the area vector is perpendicular to it, i.e., along the Z-axis. So, A=100k^ m². Electric flux ΦE=E⋅A=(8i^+4j^+3k^)⋅(100k^)=3×100=300 N·m²/C.', NULL, NULL, NULL, NULL, NULL),
(221, 'The electric field due to an infinitely long straight uniformly charged wire at a distance \'r\' is proportional to', 'r', '1/r2', '1/r', 'r2', 'C', 1, 1, 2, 3, NULL, 'easy', 'Using Gauss\'s law, the electric field for an infinite line charge is given by E=2πϵ0rλ, where λ is the linear charge density. Thus, E∝1/r.', NULL, NULL, NULL, NULL, NULL),
(222, 'Two large, thin metal plates are parallel and close to each other. On their inner faces, the plates have surface charge densities of opposite signs and of magnitude 17.0×10−22 C/m². The electric field between the plates is', '1.92×10−10 N/C', 'Zero', '3.84×10−10 N/C', '17.0×10−22 N/C', 'A', 1, 1, 2, 3, NULL, 'hard', 'The electric field between two oppositely charged parallel plates is E=σ/ϵ0. E=8.854×10−1217.0×10−22≈1.92×10−10 N/C.', NULL, NULL, NULL, NULL, NULL),
(223, 'What is the potential energy of an electric dipole in an external field?', 'U=pEsinθ', 'U=pEcosθ', 'U=−pEcosθ', 'U=pEtanθ', 'C', 1, 1, 2, 3, NULL, 'medium', 'The potential energy of a dipole in a uniform electric field is given by the scalar product U=−p⋅E, which is equal to −pEcosθ.', NULL, NULL, NULL, NULL, NULL),
(224, 'Which of the following statements about Gauss\'s law is incorrect?', 'It is valid for any closed surface.', 'The term \'q\' on the right side of the law includes the sum of all charges enclosed by the surface.', 'It is useful for calculating the electrostatic field when the system has some symmetry.', 'It is based on the inverse-square dependence on distance contained in Coulomb\'s law.', 'D', 1, 1, 2, 2, NULL, 'hard', 'While Gauss\'s law and Coulomb\'s law are related, the statement that Gauss\'s law is based on the inverse-square law can be misleading. It\'s more accurate to say they are equivalent statements. Gauss\'s law is a more general law of electrostatics. All other statements are correct descriptions of its properties and applications.', NULL, NULL, NULL, NULL, NULL),
(225, 'The electric dipole moment is a vector quantity. Its direction is from', 'positive charge to negative charge.', 'negative charge to positive charge.', 'the center of the dipole to the positive charge.', 'the center of the dipole to the negative charge.', 'B', 1, 1, 2, 2, NULL, 'hard', 'By convention, the direction of the electric dipole moment vector (p) is from the negative charge (-q) to the positive charge (+q).', NULL, NULL, NULL, NULL, NULL),
(226, 'The additive nature of charge means that', 'the total charge of a system is the algebraic sum of all individual charges.', 'charge can be added to a body.', 'charge is a scalar quantity.', 'charge is conserved.', 'A', 1, 1, 2, 2, NULL, 'hard', 'If a system contains n charges q1,q2,...,qn, the total charge of the system is Q=q1+q2+...+qn.', NULL, NULL, NULL, NULL, NULL),
(227, 'Consider a uniform electric field E=3×103i^ N/C. What is the flux of this field through a square of 10 cm on a side whose plane is parallel to the Y-Z plane?', '30 N·m²/C', '3 N·m²/C', '300 N·m²/C', '0', 'A', 1, 1, 2, 2, NULL, 'hard', 'The area of the square is A=(0.1 m)2=0.01 m². The plane is parallel to the Y-Z plane, so its area vector is along the x-axis: A=0.01i^ m². Flux ΦE=E⋅A=(3×103i^)⋅(0.01i^)=3×103×0.01=30 N·m²/C.', NULL, NULL, NULL, NULL, NULL),
(228, 'The process of sharing charges with the earth is called', 'Quantization', 'Grounding or Earthing', 'Induction', 'Conduction', 'B', 1, 1, 2, 2, NULL, 'hard', 'Grounding is the process of connecting a charged object to the Earth, which acts as a vast reservoir of charge, to neutralize the object.', NULL, NULL, NULL, NULL, NULL),
(229, 'An electron has a charge of −1.6×10−19 C. The number of electrons required to make a charge of -1 C is', '6.25×1018', '1.6×1019', '6.25×1019', '1.6×1018', 'A', 1, 1, 2, 2, NULL, 'hard', 'From Q=ne, the number of electrons is n=Q/e=(−1 C)/(−1.6×10−19 C)=0.625×1019=6.25×1018.', NULL, NULL, NULL, NULL, NULL),
(230, 'The force between two charges is 120 N. If the distance between the charges is doubled, the force will be', '60 N', '30 N', '40 N', '15 N', 'B', 1, 1, 2, 2, NULL, 'hard', 'Force is inversely proportional to the square of the distance (F∝1/r2). If the distance is doubled (r′=2r), the new force will be F′=F/(22)=F/4=120/4=30 N.', NULL, NULL, NULL, NULL, NULL),
(231, 'The electric field at a point on the equatorial line of a dipole is Eeq. If the dipole moment is doubled and the distance is halved, the new electric field will be', '4Eeq', '8Eeq', '16Eeq', 'Eeq/2', 'C', 1, 1, 2, 2, NULL, 'medium', 'The field on the equatorial line is Eeq=r3kp. The new field is Eeq′=(r/2)3k(2p)=r3/8k(2p)=16r3kp=16Eeq.', NULL, NULL, NULL, NULL, NULL),
(232, 'In a region of constant potential', 'the electric field is uniform.', 'the electric field is zero.', 'there can be no charge inside the region.', 'the electric field shall necessarily change if a charge is placed outside the region.', 'B', 1, 1, 2, 2, NULL, 'medium', 'The electric field is the negative gradient of the potential, E=−dV/dr. If the potential V is constant, its derivative dV/dr is zero, so the electric field must be zero.', NULL, NULL, NULL, NULL, NULL),
(233, 'An arbitrary surface encloses a dipole. What is the electric flux through this surface?', 'q/ϵ0', '2q/ϵ0', 'Zero', '−q/ϵ0', 'C', 1, 1, 2, 2, NULL, 'medium', 'A dipole consists of two equal and opposite charges (+q and -q). The total charge enclosed by the surface is qenc=+q−q=0. By Gauss\'s law, the total flux is ΦE=qenc/ϵ0=0.', NULL, NULL, NULL, NULL, NULL),
(234, 'The SI unit of permittivity of free space (ϵ0) is', 'C² N⁻¹ m⁻²', 'N m² C⁻²', 'C N⁻¹ m⁻²', 'C² N m⁻²', 'A', 1, 1, 2, 2, NULL, 'medium', 'From Coulomb\'s force formula F=4πϵ01r2q1q2, we can write ϵ0=4πF1r2q1q2. The unit is N⋅m2C⋅C=C2N−1m−2.', NULL, NULL, NULL, NULL, NULL),
(235, 'A charge \'q\' is placed at the corner of a cube. The electric flux through all the six faces of the cube is', 'q/ϵ0', 'q/6ϵ0', 'q/8ϵ0', 'q/3ϵ0', 'C', 1, 1, 2, 2, NULL, 'medium', 'To use Gauss\'s law, the charge must be enclosed. We can imagine 8 identical cubes sharing that corner, which places the charge \'q\' at the center of a larger cube. The total flux through this large cube is q/ϵ0. The original cube represents 1/8th of this larger structure, so the flux through it is q/8ϵ0.', NULL, NULL, NULL, NULL, NULL),
(236, 'Which of the following is NOT a property of electric field lines?', 'Field lines are continuous curves without any breaks.', 'Two field lines can never cross each other.', 'They form closed loops.', 'They start at positive charges and end at negative charges.', 'C', 1, 1, 2, 2, NULL, 'medium', 'Electrostatic field lines do not form closed loops because the electrostatic field is conservative. Magnetic field lines, however, do form closed loops.', NULL, NULL, NULL, NULL, NULL),
(237, 'For a system of two charges, the total charge is conserved. This means', 'The charges cannot be created or destroyed.', 'The net charge of an isolated system remains constant.', 'The positive charge equals the negative charge.', 'Charges can move from one body to another.', 'B', 1, 1, 2, 2, NULL, 'medium', 'The law of conservation of charge states that the total electric charge in an isolated system never changes.', NULL, NULL, NULL, NULL, NULL),
(238, 'The value of the dielectric constant for air is approximately', '0', '1.00059', '80', 'Infinite', 'B', 1, 1, 2, 2, NULL, 'medium', 'The dielectric constant for a vacuum is exactly 1. For air, it is very slightly greater than 1. For most practical purposes, it is taken as 1.', NULL, NULL, NULL, NULL, NULL),
(239, 'A soap bubble is given a negative charge. Its radius', 'decreases.', 'increases.', 'remains unchanged.', 'data is insufficient.', 'B', 1, 1, 2, 2, NULL, 'medium', 'When the soap bubble is charged, the charges distribute over its surface. The electrostatic repulsion between these like charges creates an outward pressure, causing the bubble to expand and its radius to increase.', NULL, NULL, NULL, NULL, NULL),
(240, 'A point charge +q is placed at the midpoint of a cube of side \'L\'. The electric flux emerging from the cube is', 'qL2/ϵ0', 'q/6L2ϵ0', 'q/ϵ0', 'Zero', 'C', 1, 1, 2, 2, NULL, 'easy', 'According to Gauss\'s law, the total electric flux through a closed surface is 1/ϵ0 times the charge enclosed, regardless of the shape or size of the surface.', NULL, NULL, NULL, NULL, NULL),
(241, 'The dimensional formula for electric field is', '[MLT⁻²A⁻¹]', '[MLT⁻³A⁻¹]', '[ML²T⁻³A⁻¹]', '[MLT⁻²A]', 'B', 1, 1, 2, 2, NULL, 'easy', 'Electric field E=F/q. The dimension of force F is [MLT⁻²] and the dimension of charge q is [AT]. Therefore, the dimension of E is [MLT⁻²]/[AT] = [MLT⁻³A⁻¹].', NULL, NULL, NULL, NULL, NULL),
(242, 'If an electric dipole is kept in a uniform magnetic field, then it will experience', 'a force.', 'a torque.', 'both force and torque.', 'no force and no torque.', 'D', 1, 1, 2, 2, NULL, 'easy', 'An electric dipole consists of electric charges. A uniform magnetic field exerts forces only on moving charges (or magnetic dipoles), not on static electric charges. Therefore, it will experience neither a force nor a torque.', NULL, NULL, NULL, NULL, NULL),
(243, 'The work done in moving a charge of 5 C from a point at 100 V to another point at 120 V is', '100 J', '5 J', '20 J', '2400 J', 'A', 1, 1, 2, 2, NULL, 'easy', 'Work done is given by W=qΔV=q(Vfinal−Vinitial). W=5 C×(120 V−100 V)=5×20=100 J. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(244, 'In a region of space, the electric potential is given by V=8x2−4x+10. The electric field at x = 1 m is', '12 N/C in the negative X-direction.', '14 N/C in the positive X-direction.', '12 N/C in the positive X-direction.', '14 N/C in the negative X-direction.', 'A', 1, 1, 2, 2, NULL, 'easy', 'The electric field is E=−dV/dx. E=−dxd(8x2−4x+10)=−(16x−4)=4−16x. At x = 1 m, E=4−16(1)=−12 N/C. The negative sign indicates the field is directed along the negative X-axis. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(245, 'A hollow metal sphere of radius 5 cm is charged such that the potential on its surface is 10 V. The potential at the center of the sphere is', '0 V', '10 V', 'The same as at a point 5 cm away from the surface.', 'The same as at a point 10 cm away from the center.', 'B', 1, 1, 2, 2, NULL, 'easy', 'The electric field inside a hollow conducting sphere is zero. This means the potential inside the sphere is constant and equal to the potential on its surface. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(246, 'A parallel plate capacitor is charged and the charging battery is then disconnected. If the plates of the capacitor are moved farther apart by means of insulating handles', 'The charge on the capacitor increases.', 'The voltage across the plates decreases.', 'The capacitance increases.', 'The energy stored in the capacitor increases.', 'D', 1, 1, 2, 2, NULL, 'hard', 'With the battery disconnected, charge Q remains constant. When the plates are moved apart, the distance \'d\' increases, so capacitance C=ϵ0A/d decreases. The stored energy is U=Q2/(2C). Since C decreases, the energy U increases. The extra energy comes from the work done to pull the plates apart against their electrostatic attraction. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(247, 'Which of the following is the dimensional formula for capacitance?', '[M⁻¹L⁻²T⁴A²]', '[M¹L²T⁻³A⁻¹]', '[M⁻¹L⁻²T³A¹]', '[M¹L²T⁻⁴A⁻²]', 'A', 1, 1, 2, 2, NULL, 'hard', 'Capacitance C=Q/V. Charge Q has dimension [AT]. Potential V=W/Q, so its dimension is [ML²T⁻²]/[AT] = [ML²T⁻³A⁻¹]. Therefore, the dimension of C is [AT] / [ML²T⁻³A⁻¹] = [M⁻¹L⁻²T⁴A²]. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(248, 'Two protons are brought towards each other. The potential energy of the system will', 'Increase', 'Decrease', 'Remain the same', 'First increase, then decrease', 'A', 1, 1, 2, 2, NULL, 'hard', 'The potential energy of two like charges is U=krq1q2. Since both protons are positive, U is positive. As they are brought closer, the distance \'r\' decreases, which causes the potential energy U to increase. Work must be done against their repulsive force. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(249, 'The dielectric constant K of a metal is', '0', '1', '-1', 'Infinity', 'D', 1, 1, 2, 2, NULL, 'hard', 'When a metal (a perfect conductor) is placed in an electric field, the free charges rearrange to make the net electric field inside the metal zero. The effective dielectric constant is considered to be infinite. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(250, 'A 100 pF capacitor is charged to a potential difference of 100 V. The charge on the capacitor is', '10−8 C', '10−6 C', '10−4 C', '10−10 C', 'A', 1, 1, 2, 2, NULL, 'hard', 'Q=CV=(100×10−12 F)×(100 V)=10000×10−12 C=1×10−8 C. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(251, 'The surface of a conductor is', 'A non-equipotential surface.', 'An equipotential surface.', 'A surface with varying potential.', 'Always spherical.', 'B', 1, 1, 2, 2, NULL, 'hard', 'In electrostatic conditions, charges on a conductor are stationary. If there were a potential difference between two points on the surface, charges would move, which is a contradiction. Hence, the entire surface of a conductor must be at the same potential. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(252, 'The principle of a Van de Graaff generator is based on', 'Corona discharge and charge accumulation on the outer surface of a conductor.', 'The photoelectric effect.', 'Electromagnetic induction.', 'Thermionic emission.', 'A', 1, 1, 2, 2, NULL, 'hard', 'It works by transferring charge from a sharp point (corona discharge) onto a moving belt, which then transports the charge to the inside of a large hollow conducting sphere. The charge moves to the outer surface, allowing a very high potential to be built up. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(253, 'When a dielectric is introduced into the electric field between the plates of a capacitor, the electric field strength', 'Increases', 'Decreases', 'Remains unchanged', 'Becomes zero', 'B', 1, 1, 2, 2, NULL, 'hard', 'The dielectric material becomes polarized, which creates an internal electric field (Ep) that opposes the external field (E0). The net field inside the dielectric is the vector sum, Enet=E0−Ep, which is a reduced value. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(254, 'If 64 identical small liquid drops, each having a charge \'q\' and capacitance \'C\', combine to form a single large drop, the capacitance of the large drop is', '4 C', '8 C', '16 C', '64 C', 'A', 1, 1, 2, 1, NULL, 'medium', 'Let the radius of a small drop be \'r\' and the large drop be \'R\'. The volume is conserved: 64×34πr3=34πR3⟹R3=64r3⟹R=4r. Capacitance of a spherical drop is proportional to its radius (C=4πϵ0r). Therefore, Clarge=4πϵ0R=4πϵ0(4r)=4(4πϵ0r)=4C. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(255, 'The capacitance of a spherical capacitor consisting of two concentric spheres of radii \'a\' and \'b\' (b > a) is given by', '4πϵ0(b−a)', '4πϵ0b−aab', '4πϵ0abb−a', '4πϵ0(a+b)', 'B', 1, 1, 2, 1, NULL, 'medium', 'This is the standard formula for the capacitance of a spherical capacitor. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(256, 'A parallel plate capacitor is connected to a battery. Now, a dielectric slab is inserted between the plates. The charge on the plates will', 'Decrease', 'Increase', 'Remain the same', 'Become zero', 'B', 1, 1, 2, 1, NULL, 'medium', 'With the battery connected, the potential difference V remains constant. Inserting the dielectric increases the capacitance to C′=KC. The new charge is Q′=C′V=(KC)V=K(CV)=KQ. Since K > 1, the charge increases. The extra charge is drawn from the battery. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(257, 'A 4 µF capacitor and a 6 µF capacitor are connected in series. A potential difference of 500 V is applied to the outer plates. The potential difference across the 4 µF capacitor is', '200 V', '300 V', '500 V', '250 V', 'B', 1, 1, 2, 1, NULL, 'medium', 'In a series combination, the charge Q is the same on both capacitors. The equivalent capacitance is Ceq=(4×6)/(4+6)=2.4 µF. The total charge is Q=CeqV=2.4×10−6×500=1200 µC. The potential across the 4 µF capacitor is V1=Q/C1=(1200×10−6 C)/(4×10−6 F)=300 V. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(258, 'The potential at a point due to a charge of 5×10−7 C located 10 cm away is', '4.5×104 V', '4.5×105 V', '4.5×106 V', '4.5×103 V', 'A', 1, 1, 2, 1, NULL, 'medium', 'Potential V=krq=(9×109)0.105×10−7=45×103=4.5×104 V. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(259, 'In a parallel plate capacitor, the capacity increases if', 'The area of the plate is decreased.', 'The distance between the plates is increased.', 'The area of the plate is increased.', 'The dielectric constant of the medium decreases.', 'C', 1, 1, 2, 1, NULL, 'medium', 'The capacitance of a parallel plate capacitor is given by C=Kϵ0A/d. Capacitance is directly proportional to the area of the plates (A) and the dielectric constant (K), and inversely proportional to the distance between them (d). ________________________________________', NULL, NULL, NULL, NULL, NULL),
(260, 'A conductor with a cavity is charged. The electric field inside the cavity is', 'The same as the field outside.', 'Dependent on the charge on the conductor.', 'Always zero.', 'Proportional to the size of the cavity.', 'C', 1, 1, 2, 1, NULL, 'medium', 'This is a key feature of electrostatic shielding. Regardless of the charge on the conductor or external fields, the electric field inside a cavity within a conductor is always zero. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(261, 'What is the angle between an equipotential surface and an electric field line?', '0°', '90°', '180°', '45°', 'B', 1, 1, 2, 1, NULL, 'medium', 'Electric field lines are always perpendicular to equipotential surfaces. This ensures that no work is done when a charge moves along the equipotential surface. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(262, 'The unit Volt is equivalent to', 'Joule × Coulomb', 'Joule / Coulomb', 'Coulomb / Joule', 'Newton / meter', 'B', 1, 1, 2, 1, NULL, 'medium', 'Potential difference (in Volts) is defined as the work done (in Joules) per unit charge (in Coulombs). ________________________________________', NULL, NULL, NULL, NULL, NULL),
(263, 'A soap bubble is given a negative charge. Its potential will', 'Decrease', 'Increase', 'Remain unchanged', 'Become zero', 'A', 1, 1, 2, 1, NULL, 'easy', 'The potential of a sphere is V=kq/R. If the charge q is negative, the potential is negative. Giving it more negative charge makes the potential \'more negative\', which is a decrease in its value. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(264, 'In a series combination of capacitors, what quantity is distributed among the capacitors?', 'Charge', 'Capacitance', 'Potential difference', 'Energy', 'C', 1, 1, 2, 1, NULL, 'easy', 'In a series circuit, the total voltage applied by the source is divided among the individual capacitors. The charge on each capacitor remains the same. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(265, 'The primary use of a capacitor is to', 'Store charge and energy.', 'Block DC current.', 'Filter AC signals.', 'All of the above.', 'D', 1, 1, 2, 1, NULL, 'easy', 'Capacitors have many applications. They are fundamentally used to store charge and energy. In DC circuits, they act as an open circuit once charged, thus blocking DC current. In AC circuits, their impedance is frequency-dependent, allowing them to be used in filters. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(266, 'When two capacitors are connected in parallel, the resulting combination has', 'A larger capacitance than either of the individual capacitors.', 'A smaller capacitance than either of the individual capacitors.', 'The same potential across each capacitor.', 'Both A and C are correct.', 'D', 1, 1, 2, 1, NULL, 'easy', 'In a parallel combination, the equivalent capacitance is the sum of the individual capacitances (Ceq=C1+C2), which is always larger than any individual C. Also, by definition of a parallel connection, the potential difference across all components is the same. ________________________________________', NULL, NULL, NULL, NULL, NULL),
(267, 'An enclosed region of space protected from external electric fields is called a', 'Van de Graaff cage', 'Dielectric cage', 'Faraday cage', 'Gauss cage', 'C', 1, 1, 2, 1, NULL, 'easy', 'A Faraday cage is an enclosure made of a conducting material. It blocks external static and non-static electric fields, a principle known as electrostatic shielding. Of course. Let\'s continue with the question bank.', NULL, NULL, NULL, NULL, NULL),
(268, 'The superposition principle for electrostatic forces states that', 'The force on a charge is the vector sum of the forces exerted by all other individual charges.', 'The force between any two charges is affected by the presence of other charges.', 'Forces between charges combine like scalars.', 'The net force on a system of charges is always zero.', 'A', 1, 1, 2, 1, NULL, 'easy', 'The principle of superposition states that the net force on any one charge is the vector sum of the forces due to each of the other charges, calculated as if each were acting alone.', NULL, NULL, NULL, NULL, NULL),
(269, 'A Gaussian surface is one which', 'Is a physical surface.', 'Is a hypothetical closed surface.', 'Always contains a net charge.', 'Is always spherical.', 'B', 1, 1, 2, 1, NULL, 'hard', 'A Gaussian surface is an imaginary closed surface constructed in space to apply Gauss\'s law. Its shape is chosen for convenience to simplify the calculation of electric flux.', NULL, NULL, NULL, NULL, NULL),
(270, 'When a dielectric slab is introduced between the plates of a charged parallel plate capacitor, the electric field between the plates', 'Increases.', 'Decreases.', 'Remains the same.', 'Becomes zero.', 'B', 1, 1, 2, 1, NULL, 'hard', 'The dielectric material becomes polarized, creating an internal electric field that opposes the external field. The net electric field inside the dielectric is therefore reduced.', NULL, NULL, NULL, NULL, NULL),
(271, 'Three charges +q, +2q, and +4q are placed at the corners of an equilateral triangle of side \'a\'. The magnitude of the net force on the charge +q is', 'ka227q2', 'ka27q2', 'ka27q2', 'ka22q2', 'A', 1, 1, 2, 1, NULL, 'hard', 'The force from +2q is F1=ka22q2. The force from +4q is F2=ka24q2. The angle between these two force vectors is 60°. Using the law of cosines for vector addition, Fnet=F12+F22+2F1F2cos(60∘)=ka2q222+42+2(2)(4)(1/2)=ka2q24+16+8=ka2q228=ka227q2.', NULL, NULL, NULL, NULL, NULL),
(272, 'Which of the following materials is a good conductor of electricity?', 'Glass', 'Plastic', 'Silver', 'Rubber', 'C', 1, 1, 2, 1, NULL, 'hard', 'Silver is a metal and has a large number of free electrons, which makes it an excellent conductor of electricity. Glass, plastic, and rubber are insulators.', NULL, NULL, NULL, NULL, NULL),
(273, 'The electric field lines due to a pair of equal and opposite charges (an electric dipole) are', 'Straight lines.', 'Closed loops.', 'Curved lines starting from the positive charge and ending on the negative charge.', 'Concentric circles.', 'C', 1, 1, 2, 1, NULL, 'hard', 'The field lines originate from the positive charge and terminate on the negative charge, forming curved paths that bulge outwards.', NULL, NULL, NULL, NULL, NULL),
(274, 'The concept of continuous charge distribution is a/an', 'Exact physical reality.', 'Macroscopic approximation.', 'Microscopic phenomenon.', 'Quantum mechanical principle.', 'B', 1, 1, 2, 1, NULL, 'hard', 'At the microscopic level, charge is quantized and discrete. The idea of a continuous distribution (linear, surface, or volume) is an approximation that works well for macroscopic systems where the number of individual charges is extremely large.', NULL, NULL, NULL, NULL, NULL),
(275, 'A charge \'q\' is rotating in a circle of radius \'r\' with frequency \'f\'. The equivalent electric current is', 'qf', 'q/f', 'qr/f', 'qf/r', 'A', 1, 1, 2, 1, NULL, 'hard', 'Current is the rate of flow of charge (I=Q/t). The time for one revolution is the period, T=1/f. In one revolution, a charge \'q\' passes a given point. Therefore, the equivalent current is I=q/T=qf.', NULL, NULL, NULL, NULL, NULL),
(276, 'The force of attraction between two point electric charges placed at a distance \'d\' in a medium is F. What distance apart should they be kept in the same medium so that the force between them becomes F/3?', 'd/3', '3d', 'd3', '9d', 'C', 1, 1, 2, 1, NULL, 'hard', 'Force F∝1/d2. So, F1/F2=(d2/d1)2. We are given F2=F1/3. F1/(F1/3)=(d2/d)2⟹3=(d2/d)2⟹d2/d=3⟹d2=d3.', NULL, NULL, NULL, NULL, NULL),
(277, 'An electric field can deflect', 'X-rays', 'Neutrons', 'Alpha particles', 'Gamma rays', 'C', 1, 1, 2, 1, NULL, 'medium', 'An electric field exerts a force on charged particles. Alpha particles are positively charged (Helium nuclei), so they will be deflected. X-rays and gamma rays are electromagnetic radiation (photons), and neutrons are neutral particles; none of them are deflected by an electric field.', NULL, NULL, NULL, NULL, NULL),
(278, 'Two identical spheres having charges +Q and -Q are kept at a certain distance. F force acts between them. If in the middle of two spheres, another similar sphere having +Q charge is placed, then it will experience a force in a direction', 'Towards +Q charge.', 'Towards -Q charge.', 'Perpendicular to the line joining the charges.', 'Zero.', 'B', 1, 1, 2, 1, NULL, 'medium', 'Let the two spheres be at positions 0 and \'d\', and the new sphere at \'d/2\'. The sphere at 0 (+Q) will repel the middle sphere (+Q). The sphere at \'d\' (-Q) will attract the middle sphere (+Q). Both forces are in the same direction (towards the -Q charge), so the net force is also in that direction.', NULL, NULL, NULL, NULL, NULL),
(279, 'The conservation of electric charge is a consequence of', 'Coulomb\'s law', 'Gauss\'s law', 'The equation of continuity', 'The properties of space', 'C', 1, 1, 2, 1, NULL, 'medium', 'The equation of continuity (∇⋅J+∂t∂ρ=0) is a more formal, mathematical statement of charge conservation, relating the flow of charge (current density J) to the change in charge density (ρ) over time.', NULL, NULL, NULL, NULL, NULL),
(280, 'The SI unit of electric dipole moment is', 'C/m', 'C·m', 'N/C', 'J/C', 'B', 1, 1, 2, 1, NULL, 'medium', 'The electric dipole moment is defined as the product of the magnitude of one of the charges and the distance separating them (p=q⋅2a). Its unit is Coulomb-meter.', NULL, NULL, NULL, NULL, NULL),
(281, 'A solid metallic sphere has a charge +3Q. A concentric hollow spherical shell has charge -Q. The radius of the solid sphere is \'a\' and that of the hollow shell is \'b\' (b>a). The electric field at a distance R from the center where a < R < b is', 'kR23Q', 'kR22Q', 'ka23Q', 'Zero', 'A', 1, 1, 2, 1, NULL, 'medium', 'To find the field at a point between the sphere and the shell (a < R < b), we draw a Gaussian surface of radius R. The charge enclosed by this surface is only the charge on the inner solid sphere, which is +3Q. By Gauss\'s law, E(4πR2)=3Q/ϵ0, which gives E=4πϵ01R23Q=kR23Q.', NULL, NULL, NULL, NULL, NULL),
(282, 'If the charge on a body is 1 nC, then how many electrons are present on the body?', '1.6×1019', '6.25×109', '6.25×1027', '6.25×1028', 'B', 1, 1, 2, 1, NULL, 'medium', 'From Q=ne, n=Q/e=(1×10−9 C)/(1.6×10−19 C)=0.625×1010=6.25×109.', NULL, NULL, NULL, NULL, NULL),
(283, 'What is the potential energy of an electric dipole in an external field?', 'U=pEsinθ', 'U=pEcosθ', 'U=−pEcosθ', 'U=pEtanθ', 'C', 1, 1, 2, 1, NULL, 'medium', 'The potential energy of a dipole in a uniform electric field is given by the scalar product U=−p⋅E, which is equal to −pEcosθ.', NULL, NULL, NULL, NULL, NULL),
(284, 'Who proposed the theory of relativity?', 'Albert Einstein', 'Isaac Newton', 'Niels Bohr', 'Galileo Galilei', '', 1, 1, 5, 5, NULL, 'easy', 'The theory of relativity was proposed by Einstein.', NULL, NULL, NULL, NULL, NULL),
(285, 'What is the speed of light in vacuum?', '3×10^8 m/s', '1.5×10^8 m/s', '3×10^6 m/s', '9.8×10^8 m/s', '', 1, 1, 5, 5, NULL, 'easy', 'Light travels at 3×10^8 m/s in a vacuum.', NULL, NULL, NULL, NULL, NULL),
(286, 'The energy of a photon is given by which formula?', 'E = mc^2', 'E = hf', 'E = ½mv^2', 'E = h/p', '', 1, 1, 5, 5, NULL, 'easy', 'Photon energy depends on its frequency.', NULL, NULL, NULL, NULL, NULL),
(287, 'Planck’s constant is approximately equal to:', '6.63×10^-34 Js', '3.00×10^8 Js', '1.6×10^-19 Js', '9.11×10^-31 Js', '', 1, 1, 5, 5, NULL, 'easy', 'Planck’s constant relates energy and frequency.', NULL, NULL, NULL, NULL, NULL),
(288, 'Which particle has no rest mass?', 'Proton', 'Neutron', 'Photon', 'Electron', '', 1, 1, 5, 5, NULL, 'easy', 'Photons are massless particles of light.', NULL, NULL, NULL, NULL, NULL),
(289, 'Who discovered the electron?', 'Albert Einstein', 'J.J. Thomson', 'Ernest Rutherford', 'Neils Bohr', '', 1, 1, 5, 5, NULL, 'easy', 'J.J. Thomson discovered the electron using cathode rays.', NULL, NULL, NULL, NULL, NULL),
(290, 'The photoelectric effect proves the:', 'Wave nature of light', 'Particle nature of light', 'Magnetic nature of light', 'Thermal nature of light', '', 1, 1, 5, 5, NULL, 'easy', 'It shows that light acts as particles (photons).', NULL, NULL, NULL, NULL, NULL),
(291, 'Which constant relates energy and frequency?', 'Gravitational constant', 'Planck’s constant', 'Boltzmann constant', 'Coulomb’s constant', '', 1, 1, 5, 5, NULL, 'easy', 'It connects photon energy with frequency.', NULL, NULL, NULL, NULL, NULL),
(292, 'What is the rest mass of a photon?', 'Zero', '1.6×10^-19 kg', '9.1×10^-31 kg', '3×10^8 kg', '', 1, 1, 5, 5, NULL, 'easy', 'Photons travel at light speed with zero rest mass.', NULL, NULL, NULL, NULL, NULL),
(293, 'Einstein’s famous equation is:', 'E = hf', 'E = mc^2', 'E = ½mv^2', 'E = Fd', '', 1, 1, 5, 5, NULL, 'easy', 'It relates mass and energy.', NULL, NULL, NULL, NULL, NULL),
(294, 'Who discovered the nucleus?', 'Rutherford', 'Bohr', 'Thomson', 'Einstein', '', 1, 1, 5, 5, NULL, 'easy', 'Rutherford’s gold foil experiment discovered the nucleus.', NULL, NULL, NULL, NULL, NULL),
(295, 'Which experiment supports light’s particle nature?', 'Photoelectric effect', 'Young’s double slit', 'Newton’s rings', 'Michelson-Morley', '', 1, 1, 5, 5, NULL, 'easy', 'It shows photons eject electrons from metals.', NULL, NULL, NULL, NULL, NULL),
(296, 'Compton effect proves that light has:', 'Mass', 'Charge', 'Momentum', 'Spin', '', 1, 1, 5, 5, NULL, 'easy', 'Photons transfer momentum to electrons.', NULL, NULL, NULL, NULL, NULL),
(297, 'Which model introduced quantized orbits?', 'Bohr model', 'Thomson model', 'Rutherford model', 'Einstein model', '', 1, 1, 5, 5, NULL, 'easy', 'Bohr proposed fixed energy orbits for electrons.', NULL, NULL, NULL, NULL, NULL),
(298, 'De Broglie proposed:', 'Wave nature of electrons', 'Photoelectric effect', 'Uncertainty principle', 'Special relativity', '', 1, 1, 5, 5, NULL, 'easy', 'Matter shows wave-particle duality.', NULL, NULL, NULL, NULL, NULL),
(299, 'Energy of photon is proportional to:', 'Wavelength', 'Frequency', 'Speed', 'Amplitude', '', 1, 1, 5, 5, NULL, 'easy', 'Photon energy increases with frequency.', NULL, NULL, NULL, NULL, NULL),
(300, 'Which unit measures frequency?', 'Joule', 'Newton', 'Hertz', 'Coulomb', '', 1, 1, 5, 5, NULL, 'easy', 'Hertz is cycles per second.', NULL, NULL, NULL, NULL, NULL),
(301, 'Who explained blackbody radiation?', 'Max Planck', 'Einstein', 'Bohr', 'Rutherford', '', 1, 1, 5, 5, NULL, 'easy', 'Planck introduced quantization of energy.', NULL, NULL, NULL, NULL, NULL),
(302, 'What does “modern physics” mainly study?', 'Newton’s laws', 'Atomic and subatomic phenomena', 'Classical mechanics', 'Planetary motion', '', 1, 1, 5, 5, NULL, 'easy', 'It focuses on quantum and relativistic effects.', NULL, NULL, NULL, NULL, NULL),
(303, 'The dual nature of light means it behaves as:', 'Only a wave', 'Only a particle', 'Both wave and particle', 'Neither', '', 1, 1, 5, 5, NULL, 'easy', 'Light has both wave and particle properties.', NULL, NULL, NULL, NULL, NULL),
(304, 'What is quantization of energy?', 'Continuous energy levels', 'Discrete energy levels', 'Random energies', 'Energies without limit', '', 1, 1, 5, 5, NULL, 'easy', 'Energy can only take specific values.', NULL, NULL, NULL, NULL, NULL),
(305, 'Who proposed matter waves?', 'Louis de Broglie', 'Einstein', 'Rutherford', 'Bohr', '', 1, 1, 5, 5, NULL, 'easy', 'He suggested particles have wave nature.', NULL, NULL, NULL, NULL, NULL),
(306, 'Which element was used in Rutherford’s experiment?', 'Gold', 'Silver', 'Aluminum', 'Copper', '', 1, 1, 5, 5, NULL, 'easy', 'Gold foil was used for alpha scattering.', NULL, NULL, NULL, NULL, NULL),
(307, 'What is emitted in photoelectric effect?', 'Electrons', 'Protons', 'Neutrons', 'Photons', '', 1, 1, 5, 5, NULL, 'easy', 'Light ejects electrons from a metal surface.', NULL, NULL, NULL, NULL, NULL),
(308, 'Which constant appears in Einstein’s mass-energy relation?', 'Planck’s constant', 'Speed of light', 'Gravitational constant', 'Boltzmann constant', '', 1, 1, 5, 5, NULL, 'easy', 'c appears as energy-mass conversion factor.', NULL, NULL, NULL, NULL, NULL),
(309, 'Bohr’s model was mainly applied to:', 'Hydrogen', 'Helium', 'Carbon', 'Neon', '', 1, 1, 5, 5, NULL, 'easy', 'It successfully explained hydrogen spectra.', NULL, NULL, NULL, NULL, NULL),
(310, 'Who introduced the uncertainty principle?', 'Heisenberg', 'Schrödinger', 'Einstein', 'Planck', '', 1, 1, 5, 5, NULL, 'easy', 'It states we can’t know both position and momentum exactly.', NULL, NULL, NULL, NULL, NULL),
(311, 'The wave associated with a particle is called:', 'Matter wave', 'Electromagnetic wave', 'Sound wave', 'Standing wave', '', 1, 1, 5, 5, NULL, 'easy', 'Proposed by de Broglie.', NULL, NULL, NULL, NULL, NULL),
(312, 'What type of radiation has the highest frequency?', 'Radio waves', 'Microwaves', 'Visible light', 'Gamma rays', '', 1, 1, 5, 5, NULL, 'easy', 'Gamma rays have maximum frequency and energy.', NULL, NULL, NULL, NULL, NULL),
(313, 'According to Einstein’s photoelectric equation, what happens when light frequency increases?', 'Electron energy increases', 'Number of electrons decreases', 'Electrons stop emitting', 'Threshold frequency decreases', '', 1, 1, 5, 5, NULL, 'medium', 'Higher frequency means higher photon energy.', NULL, NULL, NULL, NULL, NULL),
(314, 'Which experiment confirmed de Broglie’s hypothesis?', 'Compton effect', 'Davisson–Germer experiment', 'Photoelectric effect', 'Michelson–Morley experiment', '', 1, 1, 5, 5, NULL, 'medium', 'It showed electron diffraction.', NULL, NULL, NULL, NULL, NULL),
(315, 'Compton shift is observed in:', 'X-rays', 'Gamma rays', 'Microwaves', 'Visible light', '', 1, 1, 5, 5, NULL, 'medium', 'X-rays show measurable photon momentum change.', NULL, NULL, NULL, NULL, NULL),
(316, 'The rest mass energy of an electron is approximately:', '9.1×10^-31 J', '8.19×10^-14 J', '0.511 MeV', '1.6×10^-19 J', '', 1, 1, 5, 5, NULL, 'medium', 'Rest mass energy equals 0.511 MeV.', NULL, NULL, NULL, NULL, NULL),
(317, 'The uncertainty principle is mathematically written as:', 'ΔxΔp ≥ h', 'ΔxΔp ≥ h/4π', 'ΔxΔp ≤ h', 'ΔxΔp = 0', '', 1, 1, 5, 5, NULL, 'medium', 'It limits simultaneous knowledge of position and momentum.', NULL, NULL, NULL, NULL, NULL),
(318, 'In Bohr’s model, angular momentum of electron is:', 'nh/2π', 'n/h', 'n^2h', 'nh^2', '', 1, 1, 5, 5, NULL, 'medium', 'Quantized angular momentum condition.', NULL, NULL, NULL, NULL, NULL),
(319, 'The energy difference between two levels in hydrogen atom is proportional to:', 'n^2', '1/n^2', '1/n^3', '1/n', '', 1, 1, 5, 5, NULL, 'medium', 'Energy levels decrease with 1/n².', NULL, NULL, NULL, NULL, NULL),
(320, 'The wavelength of a particle is inversely proportional to its:', 'Velocity', 'Momentum', 'Mass', 'Energy', '', 1, 1, 5, 5, NULL, 'medium', 'λ = h/p shows inverse relation.', NULL, NULL, NULL, NULL, NULL),
(321, 'The special theory of relativity deals with:', 'Accelerated motion', 'Uniform motion near light speed', 'Rest bodies', 'Low-speed motion', '', 1, 1, 5, 5, NULL, 'medium', 'It applies when v ≈ c.', NULL, NULL, NULL, NULL, NULL),
(322, 'What happens to mass at relativistic speeds?', 'Increases', 'Decreases', 'Remains constant', 'Becomes zero', '', 1, 1, 5, 5, NULL, 'medium', 'Relativistic mass grows with velocity.', NULL, NULL, NULL, NULL, NULL),
(323, 'Which phenomenon shows that energy is quantized?', 'Blackbody radiation', 'Reflection', 'Refraction', 'Interference', '', 1, 1, 5, 5, NULL, 'medium', 'Planck’s law explained it using quanta.', NULL, NULL, NULL, NULL, NULL),
(324, 'Compton effect cannot be explained by:', 'Wave theory', 'Particle theory', 'Quantum theory', 'Photon model', '', 1, 1, 5, 5, NULL, 'medium', 'Only particle theory explains momentum transfer.', NULL, NULL, NULL, NULL, NULL),
(325, 'Which experiment disproved the ether theory?', 'Michelson–Morley experiment', 'Davisson–Germer experiment', 'Compton experiment', 'Young’s experiment', '', 1, 1, 5, 5, NULL, 'medium', 'No ether wind detected.', NULL, NULL, NULL, NULL, NULL),
(326, 'What happens to wavelength in Compton scattering?', 'Increases', 'Decreases', 'Remains same', 'Becomes zero', '', 1, 1, 5, 5, NULL, 'medium', 'Scattered photon loses energy, wavelength increases.', NULL, NULL, NULL, NULL, NULL),
(327, 'Relativistic kinetic energy formula is:', 'K = (γ - 1)mc²', 'K = ½mv²', 'K = mc²', 'K = γmc²', '', 1, 1, 5, 5, NULL, 'medium', 'It modifies classical expression.', NULL, NULL, NULL, NULL, NULL),
(328, 'What is the photoelectric threshold frequency?', 'Minimum frequency to emit electrons', 'Maximum frequency to stop current', 'Average light frequency', 'Fixed emission rate', '', 1, 1, 5, 5, NULL, 'medium', 'Below this, no photoemission occurs.', NULL, NULL, NULL, NULL, NULL),
(329, 'Pair production converts:', 'Photon → Electron + Positron', 'Photon → Neutron + Proton', 'Electron → Positron + Photon', 'Neutron → Proton + Electron', '', 1, 1, 5, 5, NULL, 'medium', 'It occurs near heavy nuclei.', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `questions` (`id`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_answer`, `stream_id`, `subject_id`, `category_id`, `chapter_id`, `subcategory_id`, `level`, `explanation`, `question_image`, `option_a_image`, `option_b_image`, `option_c_image`, `option_d_image`) VALUES
(330, 'The total energy of an orbiting electron is:', 'Positive', 'Zero', 'Negative', 'Infinite', '', 1, 1, 5, 5, NULL, 'medium', 'Bound electrons have negative total energy.', NULL, NULL, NULL, NULL, NULL),
(331, 'The relativistic factor γ equals:', '1/√(1−v²/c²)', '√(1−v²/c²)', '1−v²/c²', 'c/v', '', 1, 1, 5, 5, NULL, 'medium', 'It measures time dilation and length contraction.', NULL, NULL, NULL, NULL, NULL),
(332, 'Which type of spectrum does hydrogen produce?', 'Continuous', 'Emission', 'Absorption', 'Interference', '', 1, 1, 5, 5, NULL, 'medium', 'Hydrogen emits discrete line spectrum.', NULL, NULL, NULL, NULL, NULL),
(333, 'According to Bohr’s model, electron transitions cause:', 'X-ray emission', 'Line spectra', 'Nuclear decay', 'Pair annihilation', '', 1, 1, 5, 5, NULL, 'medium', 'Energy transitions emit photons.', NULL, NULL, NULL, NULL, NULL),
(334, 'What is the de Broglie wavelength of a particle with momentum p?', 'hp', 'h/p', 'p/h', 'h²/p', '', 1, 1, 5, 5, NULL, 'medium', 'Matter wavelength = h/p.', NULL, NULL, NULL, NULL, NULL),
(335, 'Which effect shows photon momentum transfer?', 'Compton effect', 'Photoelectric effect', 'Zeeman effect', 'Stark effect', '', 1, 1, 5, 5, NULL, 'medium', 'Photon scatters and loses momentum.', NULL, NULL, NULL, NULL, NULL),
(336, 'The energy of nth level in hydrogen atom is:', '−13.6/n² eV', '−13.6n² eV', '13.6n eV', '13.6n² eV', '', 1, 1, 5, 5, NULL, 'medium', 'Derived from Bohr’s postulates.', NULL, NULL, NULL, NULL, NULL),
(337, 'In relativity, time dilation means:', 'Moving clocks run faster', 'Moving clocks run slower', 'Time remains same', 'Time stops', '', 1, 1, 5, 5, NULL, 'medium', 'Time interval increases with speed.', NULL, NULL, NULL, NULL, NULL),
(338, 'The principle of equivalence is a basis of:', 'Special relativity', 'General relativity', 'Quantum mechanics', 'Classical mechanics', '', 1, 1, 5, 5, NULL, 'medium', 'It equates gravitational and inertial mass.', NULL, NULL, NULL, NULL, NULL),
(339, 'If photon energy is less than work function:', 'No electrons emitted', 'Electrons emitted faster', 'Current doubles', 'Light intensity increases', '', 1, 1, 5, 5, NULL, 'medium', 'Work function is threshold energy.', NULL, NULL, NULL, NULL, NULL),
(340, 'Who explained the wave equation for electrons?', 'Schrödinger', 'Heisenberg', 'Bohr', 'Dirac', '', 1, 1, 5, 5, NULL, 'medium', 'He gave the quantum mechanical model.', NULL, NULL, NULL, NULL, NULL),
(341, 'The fine structure of hydrogen lines is explained by:', 'Relativity', 'Magnetic spin', 'Photon momentum', 'Quantum tunneling', '', 1, 1, 5, 5, NULL, 'medium', 'Spin–orbit coupling causes fine splitting.', NULL, NULL, NULL, NULL, NULL),
(342, 'Annihilation of an electron–positron pair produces:', 'Two photons', 'One photon', 'One neutron', 'One proton', '', 1, 1, 5, 5, NULL, 'medium', 'Matter converts fully to radiation.', NULL, NULL, NULL, NULL, NULL),
(343, 'In relativistic mechanics, momentum is given by:', 'p = γmv', 'p = mv', 'p = m/v', 'p = γm/v', '', 1, 1, 5, 5, NULL, 'hard', 'Relativistic momentum includes γ factor.', NULL, NULL, NULL, NULL, NULL),
(344, 'In the photoelectric effect, stopping potential depends on:', 'Frequency of light', 'Intensity of light', 'Metal area', 'Temperature', '', 1, 1, 5, 5, NULL, 'hard', 'Only frequency affects electron energy.', NULL, NULL, NULL, NULL, NULL),
(345, 'For a free electron, Schrödinger’s equation reduces to:', 'Plane wave', 'Standing wave', 'Exponential decay', 'Delta function', '', 1, 1, 5, 5, NULL, 'hard', 'It has constant potential energy.', NULL, NULL, NULL, NULL, NULL),
(346, 'What is Compton wavelength of an electron?', '2.43×10^-12 m', '1.6×10^-19 m', '9.1×10^-31 m', '6.63×10^-34 m', '', 1, 1, 5, 5, NULL, 'hard', 'λ_c = h/mc.', NULL, NULL, NULL, NULL, NULL),
(347, 'The rest mass of photon is zero but it has:', 'Momentum', 'Charge', 'Mass', 'Rest energy', '', 1, 1, 5, 5, NULL, 'hard', 'Photons have momentum p = E/c.', NULL, NULL, NULL, NULL, NULL),
(348, 'In special relativity, length contraction occurs:', 'Parallel to motion', 'Perpendicular to motion', 'In all directions', 'Not at all', '', 1, 1, 5, 5, NULL, 'hard', 'Only in motion direction.', NULL, NULL, NULL, NULL, NULL),
(349, 'What is the de Broglie wavelength of an electron accelerated through V volts?', 'h/√(2meV)', 'hc/eV', 'h/2eV', 'hV/m', '', 1, 1, 5, 5, NULL, 'hard', 'λ = h/√(2meV).', NULL, NULL, NULL, NULL, NULL),
(350, 'The Compton shift is maximum at scattering angle:', '180°', '90°', '0°', '45°', '', 1, 1, 5, 5, NULL, 'hard', 'Backscattering gives maximum shift.', NULL, NULL, NULL, NULL, NULL),
(351, 'Relativistic energy relation is:', 'E² = (pc)² + (mc²)²', 'E = pc', 'E = mc²', 'E = hv', '', 1, 1, 5, 5, NULL, 'hard', 'Applies to all particles.', NULL, NULL, NULL, NULL, NULL),
(352, 'Wavefunction normalization means:', '∫|ψ|²dx = 1', '∫ψdx = 0', '|ψ|² = 0', '∫ψ²dx = 1', '', 1, 1, 5, 5, NULL, 'hard', 'Probability over space equals one.', NULL, NULL, NULL, NULL, NULL),
(353, 'The probability current density is defined as:', '(j = (ħ/m) Im(ψ*∇ψ))', 'j = ψ*ψ', 'j = ψ²', 'j = ρv', '', 1, 1, 5, 5, NULL, 'hard', 'Quantum mechanical current expression.', NULL, NULL, NULL, NULL, NULL),
(354, 'The rest energy of proton is approximately:', '938 MeV', '511 keV', '1 MeV', '100 MeV', '', 1, 1, 5, 5, NULL, 'hard', 'E = mc² for proton.', NULL, NULL, NULL, NULL, NULL),
(355, 'In Compton scattering, recoil electron kinetic energy equals:', 'Incident energy - Scattered energy', 'Incident + Scattered', 'Zero', 'hν/c', '', 1, 1, 5, 5, NULL, 'hard', 'Difference converts to kinetic energy.', NULL, NULL, NULL, NULL, NULL),
(356, 'According to Dirac theory, every particle has:', 'Antiparticle', 'Isotope', 'Opposite charge partner', 'Spinless twin', '', 1, 1, 5, 5, NULL, 'hard', 'Dirac predicted positron.', NULL, NULL, NULL, NULL, NULL),
(357, 'The wavefunction ψ must satisfy:', 'Schrödinger equation', 'Heisenberg equation', 'Bohr equation', 'Einstein equation', '', 1, 1, 5, 5, NULL, 'hard', 'Fundamental postulate of quantum mechanics.', NULL, NULL, NULL, NULL, NULL),
(358, 'A potential barrier thinner than de Broglie wavelength allows:', 'Tunneling', 'Reflection', 'Absorption', 'No transmission', '', 1, 1, 5, 5, NULL, 'hard', 'Quantum tunneling through thin barriers.', NULL, NULL, NULL, NULL, NULL),
(359, 'In relativity, energy and momentum are components of:', 'Four-vector', 'Three-vector', 'Scalar', 'Spin tensor', '', 1, 1, 5, 5, NULL, 'hard', 'They form energy–momentum four-vector.', NULL, NULL, NULL, NULL, NULL),
(360, 'The relativistic energy of photon is:', 'E = pc', 'E = mc²', 'E = ½mv²', 'E = p²c²', '', 1, 1, 5, 5, NULL, 'hard', 'Photon has no rest mass.', NULL, NULL, NULL, NULL, NULL),
(361, 'The uncertainty relation between energy and time is:', 'ΔEΔt ≥ ħ/2', 'ΔEΔt ≥ h', 'ΔEΔt ≤ ħ', 'ΔEΔt = 0', '', 1, 1, 5, 5, NULL, 'hard', 'It sets lifetime–width limits.', NULL, NULL, NULL, NULL, NULL),
(362, 'The spin of an electron is:', '½', '1', '', '2', '', 1, 1, 5, 5, NULL, 'hard', 'Electron has intrinsic spin ½.', NULL, NULL, NULL, NULL, NULL),
(363, 'The Klein–Gordon equation describes:', 'Relativistic scalar particles', 'Electrons', 'Photons', 'Fermions', '', 1, 1, 5, 5, NULL, 'hard', 'It applies to spin-0 particles.', NULL, NULL, NULL, NULL, NULL),
(364, 'In hydrogen atom, degeneracy is broken due to:', 'Fine structure', 'Energy quantization', 'Spin', 'Quantum number change', '', 1, 1, 5, 5, NULL, 'hard', 'Spin–orbit coupling breaks degeneracy.', NULL, NULL, NULL, NULL, NULL),
(365, 'Relativistic Doppler shift formula is:', 'f\' = f√((1+β)/(1−β))', 'f\' = f(1+β)', 'f\' = f/(1−β)', 'f\' = f(1−β)', '', 1, 1, 5, 5, NULL, 'hard', 'Predicts frequency change with motion.', NULL, NULL, NULL, NULL, NULL),
(366, 'In pair annihilation, total momentum is:', 'Zero', 'Infinite', 'Constant', 'Negative', '', 1, 1, 5, 5, NULL, 'hard', 'Photon emission conserves total momentum.', NULL, NULL, NULL, NULL, NULL),
(367, 'The wavefunction must be:', 'Continuous and single-valued', 'Discontinuous', 'Multiple-valued', 'Zero everywhere', '', 1, 1, 5, 5, NULL, 'hard', 'Essential for valid solutions.', NULL, NULL, NULL, NULL, NULL),
(368, 'The expectation value of an observable A is:', '⟨A⟩ = ∫ψ*Âψdx', '∫ψdx', '∫ψ²dx', '∫Âψdx', '', 1, 1, 5, 5, NULL, 'hard', 'Quantum mean value formula.', NULL, NULL, NULL, NULL, NULL),
(369, 'Rest energy to mass ratio for all particles is:', 'c²', 'c', 'c⁴', 'h', '', 1, 1, 5, 5, NULL, 'hard', 'E = mc² gives this constant ratio.', NULL, NULL, NULL, NULL, NULL),
(370, 'Compton effect demonstrates conservation of:', 'Energy and momentum', 'Charge', 'Mass', 'Time', '', 1, 1, 5, 5, NULL, 'hard', 'Both conserved in scattering.', NULL, NULL, NULL, NULL, NULL),
(371, 'What is Heisenberg’s uncertainty product for minimum uncertainty?', 'ħ/2', '', 'h', 'h/4π', '', 1, 1, 5, 5, NULL, 'hard', 'Minimum measurable limit.', NULL, NULL, NULL, NULL, NULL),
(372, 'Einstein’s A and B coefficients explain:', 'Stimulated and spontaneous emission', 'Photoelectric effect', 'Compton scattering', 'Bohr transitions', '', 1, 1, 5, 5, NULL, 'hard', 'Basis for laser theory.', NULL, NULL, NULL, NULL, NULL),
(373, 'question', 'option_a', 'option_b', 'option_c', 'option_d', '', 1, 3, 7, 7, NULL, '', 'explanation', NULL, NULL, NULL, NULL, NULL),
(374, 'What are hydrocarbons made of?', 'Carbon and hydrogen', 'Carbon and oxygen', 'Hydrogen and nitrogen', 'Carbon and nitrogen', '', 1, 3, 7, 7, NULL, 'easy', 'Hydrocarbons are organic compounds containing only carbon and hydrogen.', NULL, NULL, NULL, NULL, NULL),
(375, 'The simplest hydrocarbon is:', 'Methane', 'Ethane', 'Propane', 'Butane', '', 1, 3, 7, 7, NULL, 'easy', 'Methane (CH₄) is the simplest hydrocarbon.', NULL, NULL, NULL, NULL, NULL),
(376, 'Alkanes are also called:', 'Paraffins', 'Olefins', 'Alkynes', 'Aromatics', '', 1, 3, 7, 7, NULL, 'easy', 'Alkanes are saturated hydrocarbons known as paraffins.', NULL, NULL, NULL, NULL, NULL),
(377, 'The formula of ethane is:', 'C₂H₆', 'C₂H₄', 'C₂H₂', 'C₃H₈', '', 1, 3, 7, 7, NULL, 'easy', 'Ethane is an alkane with formula C₂H₆.', NULL, NULL, NULL, NULL, NULL),
(378, 'Which of these is a saturated hydrocarbon?', 'Propane', 'Ethene', 'Ethyne', 'Benzene', '', 1, 3, 7, 7, NULL, 'easy', 'Saturated hydrocarbons have single bonds only.', NULL, NULL, NULL, NULL, NULL),
(379, 'Alkenes contain:', 'One double bond', 'One triple bond', 'Single bonds only', 'No bond', '', 1, 3, 7, 7, NULL, 'easy', 'Alkenes have at least one double bond.', NULL, NULL, NULL, NULL, NULL),
(380, 'Alkynes contain:', 'One triple bond', 'One double bond', 'No bonds', 'Single bonds only', '', 1, 3, 7, 7, NULL, 'easy', 'Alkynes contain a triple bond.', NULL, NULL, NULL, NULL, NULL),
(381, 'The general formula of alkane is:', 'CₙH₂ₙ₊₂', 'CₙH₂ₙ', 'CₙH₂ₙ₋₂', 'CₙHₙ', '', 1, 3, 7, 7, NULL, 'easy', 'Alkanes follow the formula CₙH₂ₙ₊₂.', NULL, NULL, NULL, NULL, NULL),
(382, 'Ethene is also called:', 'Ethylene', 'Acetylene', 'Methene', 'Propylene', '', 1, 3, 7, 7, NULL, 'easy', 'Ethene is commonly known as ethylene.', NULL, NULL, NULL, NULL, NULL),
(383, 'Methane is also known as:', 'Marsh gas', 'Coal gas', 'Natural gas', 'LPG', '', 1, 3, 7, 7, NULL, 'easy', 'Methane is often called marsh gas.', NULL, NULL, NULL, NULL, NULL),
(384, 'Propane is found in:', 'LPG', 'CNG', 'Kerosene', 'Petrol', '', 1, 3, 7, 7, NULL, 'easy', 'Propane is a main component of LPG.', NULL, NULL, NULL, NULL, NULL),
(385, 'The molecular formula of butane is:', 'C₄H₁₀', 'C₄H₈', 'C₄H₆', 'C₃H₈', '', 1, 3, 7, 7, NULL, 'easy', 'Butane is an alkane with formula C₄H₁₀.', NULL, NULL, NULL, NULL, NULL),
(386, 'Ethene contains how many carbon atoms?', '2', '3', '4', '1', '', 1, 3, 7, 7, NULL, 'easy', 'Ethene (C₂H₄) contains 2 carbon atoms.', NULL, NULL, NULL, NULL, NULL),
(387, 'Which hydrocarbon has a triple bond?', 'Ethyne', 'Ethane', 'Ethene', 'Propane', '', 1, 3, 7, 7, NULL, 'easy', 'Ethyne (acetylene) has a triple bond.', NULL, NULL, NULL, NULL, NULL),
(388, 'Which of these is an alkyne?', 'Ethyne', 'Ethane', 'Ethene', 'Methane', '', 1, 3, 7, 7, NULL, 'easy', 'Alkynes contain triple bonds like ethyne.', NULL, NULL, NULL, NULL, NULL),
(389, 'Benzene is a:', 'Aromatic compound', 'Alkane', 'Alkyne', 'Alcohol', '', 1, 3, 7, 7, NULL, 'easy', 'Benzene is an aromatic hydrocarbon.', NULL, NULL, NULL, NULL, NULL),
(390, 'Which of these is a gaseous hydrocarbon?', 'Methane', 'Butane', 'Pentane', 'Hexane', '', 1, 3, 7, 7, NULL, 'easy', 'Methane is a gas at room temperature.', NULL, NULL, NULL, NULL, NULL),
(391, 'Which alkane has three carbon atoms?', 'Propane', 'Methane', 'Ethane', 'Butane', '', 1, 3, 7, 7, NULL, 'easy', 'Propane (C₃H₈) has 3 carbon atoms.', NULL, NULL, NULL, NULL, NULL),
(392, 'Which hydrocarbon is used in welding?', 'Ethyne', 'Ethane', 'Ethene', 'Methane', '', 1, 3, 7, 7, NULL, 'easy', 'Acetylene (ethyne) is used for oxy-acetylene welding.', NULL, NULL, NULL, NULL, NULL),
(393, 'What is the general formula of alkyne?', 'CₙH₂ₙ₋₂', 'CₙH₂ₙ₊₂', 'CₙH₂ₙ', 'CₙHₙ', '', 1, 3, 7, 7, NULL, 'easy', 'Alkynes have the general formula CₙH₂ₙ₋₂.', NULL, NULL, NULL, NULL, NULL),
(394, 'Which hydrocarbon burns with a smoky flame?', 'Aromatic', 'Alkane', 'Alkene', 'None', '', 1, 3, 7, 7, NULL, 'easy', 'Aromatic hydrocarbons produce smoky flames.', NULL, NULL, NULL, NULL, NULL),
(395, 'Which gas is called “illuminating gas”?', 'Ethylene', 'Acetylene', 'Methane', 'Propane', '', 1, 3, 7, 7, NULL, 'easy', 'Ethylene was used in early gas lighting.', NULL, NULL, NULL, NULL, NULL),
(396, 'How many single bonds does methane have?', '4', '2', '3', '1', '', 1, 3, 7, 7, NULL, 'easy', 'Methane has 4 C–H single bonds.', NULL, NULL, NULL, NULL, NULL),
(397, 'The term “saturated” means:', 'Only single bonds', 'Only double bonds', 'Triple bonds', 'No bonds', '', 1, 3, 7, 7, NULL, 'easy', 'Saturated hydrocarbons have only single bonds.', NULL, NULL, NULL, NULL, NULL),
(398, 'Ethane and propane are examples of:', 'Alkanes', 'Alkenes', 'Alkynes', 'Aromatics', '', 1, 3, 7, 7, NULL, 'easy', 'They are single-bonded saturated hydrocarbons.', NULL, NULL, NULL, NULL, NULL),
(399, 'Which hydrocarbon is known as acetylene?', 'Ethyne', 'Ethane', 'Ethene', 'Methane', '', 1, 3, 7, 7, NULL, 'easy', 'Acetylene is another name for ethyne.', NULL, NULL, NULL, NULL, NULL),
(400, 'Which compound is used as fuel in LPG?', 'Butane', 'Ethyne', 'Ethane', 'Methane', '', 1, 3, 7, 7, NULL, 'easy', 'Butane is a main LPG component.', NULL, NULL, NULL, NULL, NULL),
(401, 'Which type of hydrocarbon has double bonds?', 'Alkene', 'Alkyne', 'Alkane', 'Aromatic', '', 1, 3, 7, 7, NULL, 'easy', 'Alkenes contain double bonds.', NULL, NULL, NULL, NULL, NULL),
(402, 'What are aromatic hydrocarbons based on?', 'Benzene ring', 'Methane chain', 'Ethane group', 'Propane ring', '', 1, 3, 7, 7, NULL, 'easy', 'Aromatic hydrocarbons contain a benzene ring.', NULL, NULL, NULL, NULL, NULL),
(403, 'What is the IUPAC name of acetylene?', 'Ethyne', 'Methyne', 'Ethene', 'Propyne', '', 1, 3, 7, 7, NULL, 'easy', 'Acetylene is called ethyne in IUPAC.', NULL, NULL, NULL, NULL, NULL),
(404, 'What is the IUPAC name of propane?', 'Prop-1-ane', 'Propane', 'Prop-2-ane', 'Propyne', '', 1, 3, 7, 7, NULL, 'medium', 'Propane is the straight-chain alkane with three carbons.', NULL, NULL, NULL, NULL, NULL),
(405, 'Which compound is the first member of the alkyne series?', 'Ethyne', 'Methyne', 'Ethene', 'Propane', '', 1, 3, 7, 7, NULL, 'medium', 'Methyne does not exist; ethyne is the simplest alkyne.', NULL, NULL, NULL, NULL, NULL),
(406, 'Which of the following hydrocarbons is unsaturated?', 'Ethene', 'Ethane', 'Propane', 'Butane', '', 1, 3, 7, 7, NULL, 'medium', 'Ethene has a double bond, making it unsaturated.', NULL, NULL, NULL, NULL, NULL),
(407, 'What type of hybridization is present in ethene?', 'sp', 'sp²', 'sp³', 'sp³d', '', 1, 3, 7, 7, NULL, 'medium', 'Ethene has carbon atoms with sp² hybridization.', NULL, NULL, NULL, NULL, NULL),
(408, 'What type of hybridization is present in ethyne?', 'sp', 'sp²', 'sp³', 'sp³d', '', 1, 3, 7, 7, NULL, 'medium', 'Ethyne has carbon atoms with sp hybridization.', NULL, NULL, NULL, NULL, NULL),
(409, 'Which gas is formed during the incomplete combustion of hydrocarbons?', 'Carbon monoxide', 'Carbon dioxide', 'Hydrogen gas', 'Nitrogen gas', '', 1, 3, 7, 7, NULL, 'medium', 'Incomplete combustion produces CO, a poisonous gas.', NULL, NULL, NULL, NULL, NULL),
(410, 'What is the general formula for alkenes?', 'CₙH₂ₙ', 'CₙH₂ₙ₊₂', 'CₙH₂ₙ₋₂', 'CₙHₙ', '', 1, 3, 7, 7, NULL, 'medium', 'Alkenes have the general formula CₙH₂ₙ.', NULL, NULL, NULL, NULL, NULL),
(411, 'Which of the following is an isomer of butane?', 'Isobutane', 'Ethene', 'Propyne', 'Methane', '', 1, 3, 7, 7, NULL, 'medium', 'Isobutane is a structural isomer of butane.', NULL, NULL, NULL, NULL, NULL),
(412, 'Which of the following alkanes shows chain isomerism?', 'Butane', 'Ethane', 'Methane', 'Propane', '', 1, 3, 7, 7, NULL, 'medium', 'Butane has two isomers: n-butane and isobutane.', NULL, NULL, NULL, NULL, NULL),
(413, 'Hydrocarbons with the same molecular formula but different structures are called:', 'Isomers', 'Isotopes', 'Allotropes', 'Analogues', '', 1, 3, 7, 7, NULL, 'medium', 'Isomers have the same formula but different arrangements.', NULL, NULL, NULL, NULL, NULL),
(414, 'What is the IUPAC name of acetylene?', 'Ethyne', 'Methyne', 'Ethene', 'Propyne', '', 1, 3, 7, 7, NULL, 'medium', 'Acetylene is the common name of ethyne.', NULL, NULL, NULL, NULL, NULL),
(415, 'Which of the following has a triple bond?', 'Ethyne', 'Ethene', 'Ethane', 'Methane', '', 1, 3, 7, 7, NULL, 'medium', 'Ethyne contains a carbon–carbon triple bond.', NULL, NULL, NULL, NULL, NULL),
(416, 'Which of these burns with a clean blue flame?', 'Alkanes', 'Alkenes', 'Alkynes', 'Aromatics', '', 1, 3, 7, 7, NULL, 'medium', 'Alkanes burn completely to give a blue flame.', NULL, NULL, NULL, NULL, NULL),
(417, 'Which of the following is aromatic?', 'Benzene', 'Propane', 'Ethene', 'Ethyne', '', 1, 3, 7, 7, NULL, 'medium', 'Benzene is an aromatic hydrocarbon with delocalized π electrons.', NULL, NULL, NULL, NULL, NULL),
(418, 'Which of these hydrocarbons is cyclic?', 'Benzene', 'Ethane', 'Propane', 'Ethyne', '', 1, 3, 7, 7, NULL, 'medium', 'Benzene has a cyclic hexagonal ring.', NULL, NULL, NULL, NULL, NULL),
(419, 'Which process converts alkanes into alkenes?', 'Dehydrogenation', 'Hydrogenation', 'Oxidation', 'Reduction', '', 1, 3, 7, 7, NULL, 'medium', 'Removing hydrogen converts alkanes to alkenes.', NULL, NULL, NULL, NULL, NULL),
(420, 'Hydrogenation of ethene gives:', 'Ethane', 'Ethyne', 'Propane', 'Butane', '', 1, 3, 7, 7, NULL, 'medium', 'Addition of hydrogen converts ethene to ethane.', NULL, NULL, NULL, NULL, NULL),
(421, 'Cracking of hydrocarbons is used to:', 'Produce smaller hydrocarbons', 'Increase chain length', 'Form alcohols', 'Remove oxygen', '', 1, 3, 7, 7, NULL, 'medium', 'Cracking breaks long hydrocarbons into smaller ones.', NULL, NULL, NULL, NULL, NULL),
(422, 'What is the bond angle in ethene?', '120°', '109.5°', '180°', '90°', '', 1, 3, 7, 7, NULL, 'medium', 'Ethene has sp² hybridization giving 120° bond angle.', NULL, NULL, NULL, NULL, NULL),
(423, 'What is the bond angle in methane?', '109.5°', '120°', '180°', '90°', '', 1, 3, 7, 7, NULL, 'medium', 'Methane’s tetrahedral structure gives 109.5° angles.', NULL, NULL, NULL, NULL, NULL),
(424, 'Which of the following hydrocarbons undergoes addition reactions?', 'Ethene', 'Ethane', 'Propane', 'Butane', '', 1, 3, 7, 7, NULL, 'medium', 'Unsaturated hydrocarbons undergo addition reactions.', NULL, NULL, NULL, NULL, NULL),
(425, 'Which hydrocarbon does not decolorize bromine water?', 'Methane', 'Ethene', 'Ethyne', 'Propene', '', 1, 3, 7, 7, NULL, 'medium', 'Saturated hydrocarbons do not react with bromine water.', NULL, NULL, NULL, NULL, NULL),
(426, 'Which hydrocarbon has the highest melting point?', 'Ethyne', 'Ethene', 'Ethane', 'Propane', '', 1, 3, 7, 7, NULL, 'medium', 'Triple bonds cause stronger intermolecular forces.', NULL, NULL, NULL, NULL, NULL),
(427, 'Aromatic hydrocarbons have:', 'Delocalized π electrons', 'Local π electrons', 'Single bonds only', 'Triple bonds', '', 1, 3, 7, 7, NULL, 'medium', 'Benzene has delocalized π electrons that stabilize it.', NULL, NULL, NULL, NULL, NULL),
(428, 'Which gas is produced when methane reacts with chlorine in sunlight?', 'Chloromethane', 'Hydrogen', 'Carbon dioxide', 'Ethene', '', 1, 3, 7, 7, NULL, 'medium', 'Chlorination of methane produces chloromethane.', NULL, NULL, NULL, NULL, NULL),
(429, 'In alkenes, π bonds are formed by:', 'Sidewise overlap', 'Head-on overlap', 'Hydrogen bonding', 'Ionic interaction', '', 1, 3, 7, 7, NULL, 'medium', 'π bonds are formed by sidewise overlap of p-orbitals.', NULL, NULL, NULL, NULL, NULL),
(430, 'Which alkene is used to make polyethylene?', 'Ethene', 'Propene', 'Ethyne', 'Butene', '', 1, 3, 7, 7, NULL, 'medium', 'Ethene polymerizes to form polyethylene.', NULL, NULL, NULL, NULL, NULL),
(431, 'Which hydrocarbon produces soot on burning?', 'Ethyne', 'Methane', 'Ethane', 'Propane', '', 1, 3, 7, 7, NULL, 'medium', 'Ethyne has a high carbon content causing sooty flames.', NULL, NULL, NULL, NULL, NULL),
(432, 'What is the empirical formula of benzene?', 'CH', 'CH₂', 'C₂H₂', 'C₆H₆', '', 1, 3, 7, 7, NULL, 'medium', 'The simplest ratio of C:H in benzene (C₆H₆) is CH.', NULL, NULL, NULL, NULL, NULL),
(433, 'The molecular formula of propane is:', 'C₃H₈', 'C₃H₆', 'C₃H₄', 'C₄H₁₀', '', 1, 3, 7, 7, NULL, 'medium', 'Propane has three carbons and eight hydrogens.', NULL, NULL, NULL, NULL, NULL),
(434, 'What is the hybridization of carbon in benzene?', 'sp', 'sp²', 'sp³', 'sp³d', '', 1, 3, 7, 7, NULL, 'hard', 'Each carbon in benzene is sp² hybridized forming a planar structure.', NULL, NULL, NULL, NULL, NULL),
(435, 'Which of the following is not an aromatic compound?', 'Toluene', 'Naphthalene', 'Cyclohexane', 'Benzene', '', 1, 3, 7, 7, NULL, 'hard', 'Cyclohexane lacks delocalized π electrons, so it is non-aromatic.', NULL, NULL, NULL, NULL, NULL),
(436, 'How many π bonds are present in benzene?', '3', '6', '12', '2', '', 1, 3, 7, 7, NULL, 'hard', 'Benzene has three π bonds due to alternating double bonds.', NULL, NULL, NULL, NULL, NULL),
(437, 'Which compound is obtained when ethyne reacts with water in presence of HgSO₄?', 'Ethanol', 'Acetaldehyde', 'Acetone', 'Ethanal', '', 1, 3, 7, 7, NULL, 'hard', 'Hydration of ethyne gives ethanol which tautomerizes to ethanal.', NULL, NULL, NULL, NULL, NULL),
(438, 'During ozonolysis of propene, the products obtained are:', 'Ethanol and formaldehyde', 'Acetone and formic acid', 'Acetaldehyde and formaldehyde', 'Propanoic acid and CO₂', '', 1, 3, 7, 7, NULL, 'hard', 'Ozonolysis cleaves the double bond to form aldehydes.', NULL, NULL, NULL, NULL, NULL),
(439, 'Which of the following hydrocarbons gives a positive Baeyer’s test?', 'Ethene', 'Benzene', 'Ethane', 'Toluene', '', 1, 3, 7, 7, NULL, 'hard', 'Ethene decolorizes KMnO₄ due to unsaturation.', NULL, NULL, NULL, NULL, NULL),
(440, 'Which reaction is used to prepare ethyne from calcium carbide?', 'Hydrolysis', 'Oxidation', 'Substitution', 'Reduction', '', 1, 3, 7, 7, NULL, 'hard', 'Calcium carbide reacts with water to produce ethyne.', NULL, NULL, NULL, NULL, NULL),
(441, 'What is the main product when benzene is nitrated?', 'Nitrobenzene', 'Benzyl alcohol', 'Benzaldehyde', 'Toluene', '', 1, 3, 7, 7, NULL, 'hard', 'Nitration of benzene gives nitrobenzene.', NULL, NULL, NULL, NULL, NULL),
(442, 'Which of the following is an electrophilic substitution reaction?', 'Nitration of benzene', 'Addition of hydrogen to ethene', 'Oxidation of propane', 'Halogenation of alkanes', '', 1, 3, 7, 7, NULL, 'hard', 'Aromatic substitution involves electrophiles attacking the ring.', NULL, NULL, NULL, NULL, NULL),
(443, 'Which catalyst is used in the hydrogenation of alkenes?', 'Ni', 'Cu', 'Fe', 'Pd', '', 1, 3, 7, 7, NULL, 'hard', 'Nickel catalyzes hydrogen addition to double bonds.', NULL, NULL, NULL, NULL, NULL),
(444, 'Which compound is formed when acetylene reacts with chlorine?', 'Tetrachloroethane', 'Dichloroethene', 'Chloroethane', 'Vinyl chloride', '', 1, 3, 7, 7, NULL, 'hard', 'Addition of two Cl₂ molecules gives tetrachloroethane.', NULL, NULL, NULL, NULL, NULL),
(445, 'When ethene reacts with HBr, the product is:', 'Bromoethane', '1,2-dibromoethane', 'Chloroethane', 'Bromomethane', '', 1, 3, 7, 7, NULL, 'hard', 'HBr adds across the double bond to form bromoethane.', NULL, NULL, NULL, NULL, NULL),
(446, 'What is formed on complete combustion of ethyne?', 'CO₂ and H₂O', 'CO and H₂O', 'C and H₂O', 'H₂ and CO₂', '', 1, 3, 7, 7, NULL, 'hard', 'Complete combustion gives carbon dioxide and water.', NULL, NULL, NULL, NULL, NULL),
(447, 'Which hydrocarbon gives a sooty flame on combustion?', 'Aromatic hydrocarbons', 'Alkanes', 'Alkenes', 'None', '', 1, 3, 7, 7, NULL, 'hard', 'High carbon content causes incomplete combustion.', NULL, NULL, NULL, NULL, NULL),
(448, 'What is the product when ethene reacts with bromine water?', '1,2-dibromoethane', 'Ethane', 'Ethylene glycol', 'Bromoethanol', '', 1, 3, 7, 7, NULL, 'hard', 'Bromine adds across the double bond to form a dihalide.', NULL, NULL, NULL, NULL, NULL),
(449, 'Which reaction converts alkenes into alcohols?', 'Hydration', 'Dehydration', 'Substitution', 'Cracking', '', 1, 3, 7, 7, NULL, 'hard', 'Addition of water produces alcohols.', NULL, NULL, NULL, NULL, NULL),
(450, 'In Friedel-Crafts alkylation, the catalyst used is:', 'AlCl₃', 'FeCl₃', 'H₂SO₄', 'Cu', '', 1, 3, 7, 7, NULL, 'hard', 'Aluminum chloride acts as a Lewis acid catalyst.', NULL, NULL, NULL, NULL, NULL),
(451, 'Which of the following is an example of an elimination reaction?', 'Dehydrohalogenation of alkyl halides', 'Hydration of alkenes', 'Nitration of benzene', 'Halogenation of alkanes', '', 1, 3, 7, 7, NULL, 'hard', 'Elimination of HX forms alkenes.', NULL, NULL, NULL, NULL, NULL),
(452, 'What type of reaction occurs when ethane is converted to ethene?', 'Dehydrogenation', 'Hydrogenation', 'Substitution', 'Addition', '', 1, 3, 7, 7, NULL, 'hard', 'Removing hydrogen atoms forms a double bond.', NULL, NULL, NULL, NULL, NULL),
(453, 'Which compound is formed when methane is chlorinated in presence of sunlight?', 'Chloromethane', 'Bromomethane', 'Fluoromethane', 'Iodomethane', '', 1, 3, 7, 7, NULL, 'hard', 'Methane reacts with chlorine to form chloromethane.', NULL, NULL, NULL, NULL, NULL),
(454, 'Which compound is obtained by decarboxylation of sodium acetate?', 'Methane', 'Ethane', 'Ethene', 'Ethyne', '', 1, 3, 7, 7, NULL, 'hard', 'Soda lime decarboxylation of sodium acetate gives methane.', NULL, NULL, NULL, NULL, NULL),
(455, 'What type of hydrocarbon is C₄H₆?', 'Alkyne', 'Alkene', 'Alkane', 'Cyclic', '', 1, 3, 7, 7, NULL, 'hard', 'Formula CₙH₂ₙ₋₂ corresponds to alkynes.', NULL, NULL, NULL, NULL, NULL),
(456, 'Which reaction converts alkyl halides to alkanes?', 'Wurtz reaction', 'Cracking', 'Dehydrogenation', 'Hydration', '', 1, 3, 7, 7, NULL, 'hard', 'Wurtz reaction couples alkyl halides with sodium to form alkanes.', NULL, NULL, NULL, NULL, NULL),
(457, 'Which of the following compounds shows geometrical isomerism?', '2-butene', '1-butene', 'Ethane', 'Propane', '', 1, 3, 7, 7, NULL, 'hard', '2-butene exists as cis- and trans- forms.', NULL, NULL, NULL, NULL, NULL),
(458, 'The product of partial hydrogenation of benzene is:', 'Cyclohexene', 'Cyclohexane', 'Cyclohexadiene', 'Hexane', '', 1, 3, 7, 7, NULL, 'hard', 'Partial hydrogenation gives cyclohexene.', NULL, NULL, NULL, NULL, NULL),
(459, 'Which of the following has the highest boiling point?', 'n-Butane', 'Isobutane', 'Propane', 'Ethane', '', 1, 3, 7, 7, NULL, 'hard', 'Longer chains have stronger van der Waals forces.', NULL, NULL, NULL, NULL, NULL),
(460, 'What is the intermediate formed in electrophilic substitution reactions of benzene?', 'Sigma complex', 'Pi complex', 'Carbocation', 'Free radical', '', 1, 3, 7, 7, NULL, 'hard', 'The sigma complex (arenium ion) is the key intermediate.', NULL, NULL, NULL, NULL, NULL),
(461, 'What is the product of ozonolysis of 1-butene?', 'Formaldehyde + Acetaldehyde', 'Acetone + CO₂', 'Propanoic acid + CH₄', 'Ethanol + Methanol', '', 1, 3, 7, 7, NULL, 'hard', 'Ozone cleaves double bonds into aldehydes.', NULL, NULL, NULL, NULL, NULL),
(462, 'What is the IUPAC name of isobutylene?', '2-methylpropene', 'But-1-ene', 'Prop-1-ene', 'But-2-ene', '', 1, 3, 7, 7, NULL, 'hard', 'Isobutylene is 2-methylpropene according to IUPAC.', NULL, NULL, NULL, NULL, NULL),
(463, 'In aromatic substitution, the attacking reagent is:', 'Electrophile', 'Nucleophile', 'Radical', 'Base', '', 1, 3, 7, 7, NULL, 'hard', 'Benzene reacts with electrophiles due to π-electron density.', NULL, NULL, NULL, NULL, NULL),
(464, 'Who is known as the father of the modern periodic table?', 'Mendeleev', 'Newlands', 'Dalton', 'Bohr', '', 1, 3, 8, 8, NULL, 'easy', 'Mendeleev arranged elements based on atomic mass.', NULL, NULL, NULL, NULL, NULL),
(465, 'The modern periodic table is based on:', 'Atomic mass', 'Atomic number', 'Valency', 'Mass number', '', 1, 3, 8, 8, NULL, 'easy', 'Moseley’s law shows properties depend on atomic number.', NULL, NULL, NULL, NULL, NULL),
(466, 'How many periods are there in the modern periodic table?', '7', '8', '9', '10', '', 1, 3, 8, 8, NULL, 'easy', 'There are 7 horizontal rows known as periods.', NULL, NULL, NULL, NULL, NULL),
(467, 'How many groups are present in the modern periodic table?', '16', '17', '18', '20', '', 1, 3, 8, 8, NULL, 'easy', 'The periodic table has 18 vertical columns called groups.', NULL, NULL, NULL, NULL, NULL),
(468, 'Which element is in Group 1 and Period 2?', 'Li', 'Na', 'K', 'Be', '', 1, 3, 8, 8, NULL, 'easy', 'Lithium belongs to Group 1 and Period 2.', NULL, NULL, NULL, NULL, NULL),
(469, 'Which element is a noble gas?', 'Neon', 'Sodium', 'Magnesium', 'Chlorine', '', 1, 3, 8, 8, NULL, 'easy', 'Neon is a Group 18 noble gas.', NULL, NULL, NULL, NULL, NULL),
(470, 'The first element of the periodic table is:', 'Hydrogen', 'Helium', 'Lithium', 'Boron', '', 1, 3, 8, 8, NULL, 'easy', 'Hydrogen is atomic number 1.', NULL, NULL, NULL, NULL, NULL),
(471, 'Which group contains halogens?', 'Group 16', 'Group 17', 'Group 18', 'Group 15', '', 1, 3, 8, 8, NULL, 'easy', 'Halogens are elements of Group 17.', NULL, NULL, NULL, NULL, NULL),
(472, 'Which group contains noble gases?', 'Group 18', 'Group 17', 'Group 1', 'Group 2', '', 1, 3, 8, 8, NULL, 'easy', 'Noble gases are in Group 18.', NULL, NULL, NULL, NULL, NULL),
(473, 'The horizontal rows in a periodic table are called:', 'Periods', 'Groups', 'Blocks', 'Lines', '', 1, 3, 8, 8, NULL, 'easy', 'Horizontal rows are known as periods.', NULL, NULL, NULL, NULL, NULL),
(474, 'The vertical columns in a periodic table are called:', 'Groups', 'Periods', 'Blocks', 'Families', '', 1, 3, 8, 8, NULL, 'easy', 'Vertical columns are called groups.', NULL, NULL, NULL, NULL, NULL),
(475, 'What is the atomic number of oxygen?', '6', '7', '8', '9', '', 1, 3, 8, 8, NULL, 'easy', 'Oxygen has atomic number 8.', NULL, NULL, NULL, NULL, NULL),
(476, 'Which of the following is an alkali metal?', 'Sodium', 'Magnesium', 'Aluminum', 'Chlorine', '', 1, 3, 8, 8, NULL, 'easy', 'Sodium belongs to Group 1 metals.', NULL, NULL, NULL, NULL, NULL),
(477, 'Which element has atomic number 2?', 'Helium', 'Hydrogen', 'Lithium', 'Beryllium', '', 1, 3, 8, 8, NULL, 'easy', 'Helium is the second element in the table.', NULL, NULL, NULL, NULL, NULL),
(478, 'Which of these is a metalloid?', 'Silicon', 'Oxygen', 'Carbon', 'Neon', '', 1, 3, 8, 8, NULL, 'easy', 'Silicon shows both metallic and nonmetallic properties.', NULL, NULL, NULL, NULL, NULL),
(479, 'Which of these is a transition metal?', 'Iron', 'Sodium', 'Magnesium', 'Neon', '', 1, 3, 8, 8, NULL, 'easy', 'Iron belongs to the d-block elements.', NULL, NULL, NULL, NULL, NULL),
(480, 'What is the symbol of sodium?', 'So', 'Sa', 'Na', 'Sm', '', 1, 3, 8, 8, NULL, 'easy', 'Na is derived from Latin name Natrium.', NULL, NULL, NULL, NULL, NULL),
(481, 'The symbol ‘Fe’ stands for:', 'Ferrium', 'Ferrous', 'Ferrite', 'Iron', '', 1, 3, 8, 8, NULL, 'easy', 'Fe is derived from Latin name Ferrum.', NULL, NULL, NULL, NULL, NULL),
(482, 'Which element is used in making light bulbs?', 'Tungsten', 'Iron', 'Copper', 'Lead', '', 1, 3, 8, 8, NULL, 'easy', 'Tungsten has a high melting point, ideal for bulbs.', NULL, NULL, NULL, NULL, NULL),
(483, 'Which of these is a noble gas?', 'Argon', 'Oxygen', 'Nitrogen', 'Fluorine', '', 1, 3, 8, 8, NULL, 'easy', 'Argon is a Group 18 noble gas.', NULL, NULL, NULL, NULL, NULL),
(484, 'Which element has the highest atomic number among noble gases?', 'Xe', 'Kr', 'Rn', 'He', '', 1, 3, 8, 8, NULL, 'easy', 'Radon has the highest atomic number among noble gases.', NULL, NULL, NULL, NULL, NULL),
(485, 'What is the atomic number of carbon?', '5', '6', '7', '8', '', 1, 3, 8, 8, NULL, 'easy', 'Carbon has atomic number 6.', NULL, NULL, NULL, NULL, NULL),
(486, 'Which element is in Group 2?', 'Calcium', 'Potassium', 'Sodium', 'Fluorine', '', 1, 3, 8, 8, NULL, 'easy', 'Calcium is an alkaline earth metal.', NULL, NULL, NULL, NULL, NULL),
(487, 'Which element is a halogen gas at room temperature?', 'Fluorine', 'Iodine', 'Chlorine', 'Bromine', '', 1, 3, 8, 8, NULL, 'easy', 'Chlorine exists as a gas at room temperature.', NULL, NULL, NULL, NULL, NULL),
(488, 'Which block of the periodic table contains noble gases?', 's-block', 'p-block', 'd-block', 'f-block', '', 1, 3, 8, 8, NULL, 'easy', 'Noble gases belong to the p-block.', NULL, NULL, NULL, NULL, NULL),
(489, 'How many valence electrons do Group 1 elements have?', '1', '2', '3', '4', '', 1, 3, 8, 8, NULL, 'easy', 'Group 1 elements have one valence electron.', NULL, NULL, NULL, NULL, NULL),
(490, 'Which period contains the element calcium?', '2nd', '3rd', '4th', '5th', '', 1, 3, 8, 8, NULL, 'easy', 'Calcium is in Period 4.', NULL, NULL, NULL, NULL, NULL),
(491, 'Which of these is the lightest element?', 'Hydrogen', 'Helium', 'Lithium', 'Boron', '', 1, 3, 8, 8, NULL, 'easy', 'Hydrogen is the lightest known element.', NULL, NULL, NULL, NULL, NULL),
(492, 'Which of these is a halogen?', 'Fluorine', 'Sodium', 'Magnesium', 'Neon', '', 1, 3, 8, 8, NULL, 'easy', 'Fluorine belongs to Group 17 halogens.', NULL, NULL, NULL, NULL, NULL),
(493, 'Which element is used in thermometers?', 'Mercury', 'Copper', 'Aluminum', 'Iron', '', 1, 3, 8, 8, NULL, 'easy', 'Mercury is a liquid metal used in thermometers.', NULL, NULL, NULL, NULL, NULL),
(494, 'question	option_a	option_b	option_c	option_d	answer	explanation	level\r\nWho arranged elements in increasing order of atomic number?	Mendeleev	Moseley	Newlands	Dalton	Moseley	Moseley’s modern periodic law is based on atomic number.	Medium\r\nHow many elements are present in the first period?	2	8	18	32	2	First period has hydrogen and helium only.	Medium\r\nHow many elements are in the second period?	2	8	18	32	8	Second period contains 8 elements from Li to Ne.	Medium\r\nWhich of the following elements is a lanthanide?	Cerium	Francium	Lead	Uranium	Cerium	Cerium belongs to the lanthanide series.	Medium\r\nWhich of these belongs to actinide series?	Thorium	Zinc	Copper	Barium	Thorium	Thorium is part of the actinide series.	Medium\r\nWhich element has atomic number 26?	Iron	Cobalt	Nickel	Copper	Iron	Iron’s atomic number is 26.	Medium\r\nWhich block contains transition elements?	s-block	p-block	d-block	f-block	d-block	d-block elements are transition metals.	Medium\r\nWhich block contains inner transition metals?	s-block	p-block	d-block	f-block	f-block	f-block contains lanthanides and actinides.	Medium\r\nWhat is the atomic number of chlorine?	15	16	17	18	17	Chlorine has atomic number 17.	Medium\r\nWhat is the atomic number of calcium?	18	19	20	21	20	Calcium’s atomic number is 20.	Medium\r\nWhat type of element forms basic oxides?	Metals	Nonmetals	Metalloids	Gases	Metals	Metal oxides are generally basic in nature.	Medium\r\nWhat type of element forms acidic oxides?	Metals	Nonmetals	Metalloids	Gases	Nonmetals	Nonmetals form acidic oxides like CO₂ and SO₂.	Medium\r\nWhich of these elements is a metalloid?	Germanium	Oxygen	Iron	Copper	Germanium	Germanium shows properties of both metals and nonmetals.	Medium\r\nWhich element is used in making semiconductors?	Silicon	Carbon	Oxygen	Neon	Silicon	Silicon is used in semiconductor devices.	Medium\r\nWhich element has atomic number 19?	Potassium	Sodium	Magnesium	Calcium	Potassium	Potassium has atomic number 19.	Medium\r\nWhich element belongs to Group 13?	Boron	Carbon	Oxygen	Nitrogen	Boron	Boron is the first element of Group 13.	Medium\r\nWhich element belongs to Group 14?	Carbon	Nitrogen	Oxygen	Fluorine	Carbon	Group 14 includes carbon and silicon.	Medium\r\nWhich element belongs to Group 15?	Nitrogen	Oxygen	Fluorine	Neon	Nitrogen	Group 15 is called the nitrogen family.	Medium\r\nWhich element is a halogen liquid at room temperature?	Bromine	Iodine	Chlorine	Fluorine	Bromine	Bromine is a reddish-brown liquid halogen.	Medium\r\nWhich element has the smallest atomic size in Period 2?	Fluorine	Lithium	Oxygen	Neon	Fluorine	Atomic size decreases across a period; fluorine is smallest.	Medium\r\nWhich element has the largest atomic size in Period 3?	Sodium	Magnesium	Silicon	Chlorine	Sodium	Atomic size decreases across the period; sodium is largest.	Medium\r\nWhich of the following elements is most electronegative?	Fluorine	Chlorine	Oxygen	Nitrogen	Fluorine	Fluorine is the most electronegative element.	Medium\r\nWhich element is least electronegative?	Cesium	Sodium	Magnesium	Potassium	Cesium	Cesium has the lowest electronegativity.	Medium\r\nWhat happens to metallic character across a period?	Increases	Decreases	Remains same	First increases then decreases	Decreases	Metallic character decreases from left to right.	Medium\r\nWhat happens to metallic character down a group?	Increases	Decreases	Remains same	First decreases then increases	Increases	Metallic nature increases down a group.	Medium\r\nWhat happens to ionization energy across a period?	Increases	Decreases	Remains same	Irregular	Increases	Ionization energy increases across a period.	Medium\r\nWhat happens to atomic radius down a group?	Increases	Decreases	Remains same	Irregular	Increases	Atomic size increases as new shells are added.	Medium\r\nWhich element is most metallic in Group 1?	Lithium	Sodium	Potassium	Cesium	Cesium	Cesium is most metallic due to large size.	Medium\r\nWhich element is most nonmetallic in Group 17?	Fluorine	Chlorine	Bromine	Iodine	Fluorine	Fluorine is the most nonmetallic halogen.	Medium\r\nWhich element shows variable valency?	Iron	Sodium	Magnesium	Calcium	Iron	Iron shows valencies +2 and +3.	Medium', 'option_a', 'option_b', 'option_c', 'option_d', '', 1, 3, 8, 8, NULL, '', 'explanation', NULL, NULL, NULL, NULL, NULL),
(495, 'Who arranged elements in increasing order of atomic number?', 'Mendeleev', 'Moseley', 'Newlands', 'Dalton', '', 1, 3, 8, 8, NULL, 'medium', 'Moseley’s modern periodic law is based on atomic number.', NULL, NULL, NULL, NULL, NULL),
(496, 'How many elements are present in the first period?', '2', '8', '18', '32', '', 1, 3, 8, 8, NULL, 'medium', 'First period has hydrogen and helium only.', NULL, NULL, NULL, NULL, NULL),
(497, 'How many elements are in the second period?', '2', '8', '18', '32', '', 1, 3, 8, 8, NULL, 'medium', 'Second period contains 8 elements from Li to Ne.', NULL, NULL, NULL, NULL, NULL),
(498, 'Which of the following elements is a lanthanide?', 'Cerium', 'Francium', 'Lead', 'Uranium', '', 1, 3, 8, 8, NULL, 'medium', 'Cerium belongs to the lanthanide series.', NULL, NULL, NULL, NULL, NULL),
(499, 'Which of these belongs to actinide series?', 'Thorium', 'Zinc', 'Copper', 'Barium', '', 1, 3, 8, 8, NULL, 'medium', 'Thorium is part of the actinide series.', NULL, NULL, NULL, NULL, NULL),
(500, 'Which element has atomic number 26?', 'Iron', 'Cobalt', 'Nickel', 'Copper', '', 1, 3, 8, 8, NULL, 'medium', 'Iron’s atomic number is 26.', NULL, NULL, NULL, NULL, NULL),
(501, 'Which block contains transition elements?', 's-block', 'p-block', 'd-block', 'f-block', '', 1, 3, 8, 8, NULL, 'medium', 'd-block elements are transition metals.', NULL, NULL, NULL, NULL, NULL),
(502, 'Which block contains inner transition metals?', 's-block', 'p-block', 'd-block', 'f-block', '', 1, 3, 8, 8, NULL, 'medium', 'f-block contains lanthanides and actinides.', NULL, NULL, NULL, NULL, NULL),
(503, 'What is the atomic number of chlorine?', '15', '16', '17', '18', '', 1, 3, 8, 8, NULL, 'medium', 'Chlorine has atomic number 17.', NULL, NULL, NULL, NULL, NULL),
(504, 'What is the atomic number of calcium?', '18', '19', '20', '21', '', 1, 3, 8, 8, NULL, 'medium', 'Calcium’s atomic number is 20.', NULL, NULL, NULL, NULL, NULL),
(505, 'What type of element forms basic oxides?', 'Metals', 'Nonmetals', 'Metalloids', 'Gases', '', 1, 3, 8, 8, NULL, 'medium', 'Metal oxides are generally basic in nature.', NULL, NULL, NULL, NULL, NULL),
(506, 'What type of element forms acidic oxides?', 'Metals', 'Nonmetals', 'Metalloids', 'Gases', '', 1, 3, 8, 8, NULL, 'medium', 'Nonmetals form acidic oxides like CO₂ and SO₂.', NULL, NULL, NULL, NULL, NULL),
(507, 'Which of these elements is a metalloid?', 'Germanium', 'Oxygen', 'Iron', 'Copper', '', 1, 3, 8, 8, NULL, 'medium', 'Germanium shows properties of both metals and nonmetals.', NULL, NULL, NULL, NULL, NULL),
(508, 'Which element is used in making semiconductors?', 'Silicon', 'Carbon', 'Oxygen', 'Neon', '', 1, 3, 8, 8, NULL, 'medium', 'Silicon is used in semiconductor devices.', NULL, NULL, NULL, NULL, NULL),
(509, 'Which element has atomic number 19?', 'Potassium', 'Sodium', 'Magnesium', 'Calcium', '', 1, 3, 8, 8, NULL, 'medium', 'Potassium has atomic number 19.', NULL, NULL, NULL, NULL, NULL),
(510, 'Which element belongs to Group 13?', 'Boron', 'Carbon', 'Oxygen', 'Nitrogen', '', 1, 3, 8, 8, NULL, 'medium', 'Boron is the first element of Group 13.', NULL, NULL, NULL, NULL, NULL),
(511, 'Which element belongs to Group 14?', 'Carbon', 'Nitrogen', 'Oxygen', 'Fluorine', '', 1, 3, 8, 8, NULL, 'medium', 'Group 14 includes carbon and silicon.', NULL, NULL, NULL, NULL, NULL),
(512, 'Which element belongs to Group 15?', 'Nitrogen', 'Oxygen', 'Fluorine', 'Neon', '', 1, 3, 8, 8, NULL, 'medium', 'Group 15 is called the nitrogen family.', NULL, NULL, NULL, NULL, NULL),
(513, 'Which element is a halogen liquid at room temperature?', 'Bromine', 'Iodine', 'Chlorine', 'Fluorine', '', 1, 3, 8, 8, NULL, 'medium', 'Bromine is a reddish-brown liquid halogen.', NULL, NULL, NULL, NULL, NULL),
(514, 'Which element has the smallest atomic size in Period 2?', 'Fluorine', 'Lithium', 'Oxygen', 'Neon', '', 1, 3, 8, 8, NULL, 'medium', 'Atomic size decreases across a period; fluorine is smallest.', NULL, NULL, NULL, NULL, NULL),
(515, 'Which element has the largest atomic size in Period 3?', 'Sodium', 'Magnesium', 'Silicon', 'Chlorine', '', 1, 3, 8, 8, NULL, 'medium', 'Atomic size decreases across the period; sodium is largest.', NULL, NULL, NULL, NULL, NULL),
(516, 'Which of the following elements is most electronegative?', 'Fluorine', 'Chlorine', 'Oxygen', 'Nitrogen', '', 1, 3, 8, 8, NULL, 'medium', 'Fluorine is the most electronegative element.', NULL, NULL, NULL, NULL, NULL),
(517, 'Which element is least electronegative?', 'Cesium', 'Sodium', 'Magnesium', 'Potassium', '', 1, 3, 8, 8, NULL, 'medium', 'Cesium has the lowest electronegativity.', NULL, NULL, NULL, NULL, NULL),
(518, 'What happens to metallic character across a period?', 'Increases', 'Decreases', 'Remains same', 'First increases then decreases', '', 1, 3, 8, 8, NULL, 'medium', 'Metallic character decreases from left to right.', NULL, NULL, NULL, NULL, NULL),
(519, 'What happens to metallic character down a group?', 'Increases', 'Decreases', 'Remains same', 'First decreases then increases', '', 1, 3, 8, 8, NULL, 'medium', 'Metallic nature increases down a group.', NULL, NULL, NULL, NULL, NULL),
(520, 'What happens to ionization energy across a period?', 'Increases', 'Decreases', 'Remains same', 'Irregular', '', 1, 3, 8, 8, NULL, 'medium', 'Ionization energy increases across a period.', NULL, NULL, NULL, NULL, NULL),
(521, 'What happens to atomic radius down a group?', 'Increases', 'Decreases', 'Remains same', 'Irregular', '', 1, 3, 8, 8, NULL, 'medium', 'Atomic size increases as new shells are added.', NULL, NULL, NULL, NULL, NULL),
(522, 'Which element is most metallic in Group 1?', 'Lithium', 'Sodium', 'Potassium', 'Cesium', '', 1, 3, 8, 8, NULL, 'medium', 'Cesium is most metallic due to large size.', NULL, NULL, NULL, NULL, NULL),
(523, 'Which element is most nonmetallic in Group 17?', 'Fluorine', 'Chlorine', 'Bromine', 'Iodine', '', 1, 3, 8, 8, NULL, 'medium', 'Fluorine is the most nonmetallic halogen.', NULL, NULL, NULL, NULL, NULL),
(524, 'Which element shows variable valency?', 'Iron', 'Sodium', 'Magnesium', 'Calcium', '', 1, 3, 8, 8, NULL, 'medium', 'Iron shows valencies +2 and +3.', NULL, NULL, NULL, NULL, NULL),
(525, 'Which element has the highest first ionization energy?', 'Helium', 'Neon', 'Fluorine', 'Hydrogen', '', 1, 3, 8, 8, NULL, 'hard', 'Helium’s electrons are most tightly bound.', NULL, NULL, NULL, NULL, NULL),
(526, 'Which element has the lowest first ionization energy?', 'Cesium', 'Francium', 'Sodium', 'Potassium', '', 1, 3, 8, 8, NULL, 'hard', 'Francium loses its outer electron most easily.', NULL, NULL, NULL, NULL, NULL),
(527, 'Which of the following is a transition metal with variable oxidation states?', 'Iron', 'Sodium', 'Magnesium', 'Calcium', '', 1, 3, 8, 8, NULL, 'hard', 'Transition metals show multiple valencies.', NULL, NULL, NULL, NULL, NULL),
(528, 'Which of these elements forms a colored compound?', 'Zinc', 'Scandium', 'Copper', 'Sodium', '', 1, 3, 8, 8, NULL, 'hard', 'Copper compounds like CuSO₄ are colored.', NULL, NULL, NULL, NULL, NULL),
(529, 'Which element shows both +2 and +4 oxidation states?', 'Tin', 'Lead', 'Iron', 'Copper', '', 1, 3, 8, 8, NULL, 'hard', 'Tin exhibits +2 and +4 valencies.', NULL, NULL, NULL, NULL, NULL),
(530, 'Which noble gas forms compounds under extreme conditions?', 'Neon', 'Helium', 'Xenon', 'Argon', '', 1, 3, 8, 8, NULL, 'hard', 'Xenon can form XeF₂, XeF₄, XeO₃ etc.', NULL, NULL, NULL, NULL, NULL),
(531, 'The electron configuration [Ar]4s²3d⁶ belongs to which element?', 'Iron', 'Cobalt', 'Nickel', 'Manganese', '', 1, 3, 8, 8, NULL, 'hard', 'Iron’s configuration matches [Ar]4s²3d⁶.', NULL, NULL, NULL, NULL, NULL),
(532, 'Which element has the configuration [Kr]5s²4d¹⁰5p⁵?', 'Iodine', 'Bromine', 'Xenon', 'Antimony', '', 1, 3, 8, 8, NULL, 'hard', 'Iodine has this configuration before noble gas xenon.', NULL, NULL, NULL, NULL, NULL),
(533, 'What is the oxidation state of Mn in KMnO₄?', '3', '5', '7', '2', '', 1, 3, 8, 8, NULL, 'hard', 'Manganese has +7 oxidation state in permanganate.', NULL, NULL, NULL, NULL, NULL),
(534, 'Which of these elements forms amphoteric oxides?', 'Aluminum', 'Sodium', 'Magnesium', 'Calcium', '', 1, 3, 8, 8, NULL, 'hard', 'Al₂O₃ reacts with both acids and bases.', NULL, NULL, NULL, NULL, NULL),
(535, 'Which element shows diagonal relationship with lithium?', 'Magnesium', 'Beryllium', 'Sodium', 'Calcium', '', 1, 3, 8, 8, NULL, 'hard', 'Be and Li show diagonal relationship.', NULL, NULL, NULL, NULL, NULL),
(536, 'Which element shows diagonal relationship with beryllium?', 'Magnesium', 'Aluminum', 'Sodium', 'Potassium', '', 1, 3, 8, 8, NULL, 'hard', 'Beryllium and aluminum show similar properties.', NULL, NULL, NULL, NULL, NULL),
(537, 'Which group contains only nonmetals?', 'Group 17', 'Group 2', 'Group 1', 'Group 3', '', 1, 3, 8, 8, NULL, 'hard', 'Halogens are entirely nonmetallic.', NULL, NULL, NULL, NULL, NULL),
(538, 'Which element has electronic configuration [He]2s²2p¹?', 'Boron', 'Carbon', 'Nitrogen', 'Oxygen', '', 1, 3, 8, 8, NULL, 'hard', 'Boron’s configuration matches [He]2s²2p¹.', NULL, NULL, NULL, NULL, NULL),
(539, 'What is the atomic number of the element with configuration [Ne]3s²3p⁵?', '17', '18', '19', '16', '', 1, 3, 8, 8, NULL, 'hard', 'Chlorine has [Ne]3s²3p⁵ configuration.', NULL, NULL, NULL, NULL, NULL),
(540, 'Which transition metal is used in stainless steel?', 'Copper', 'Chromium', 'Zinc', 'Lead', '', 1, 3, 8, 8, NULL, 'hard', 'Chromium provides corrosion resistance.', NULL, NULL, NULL, NULL, NULL),
(541, 'Which element has maximum metallic character in Period 3?', 'Sodium', 'Magnesium', 'Aluminum', 'Silicon', '', 1, 3, 8, 8, NULL, 'hard', 'Metallic nature decreases left to right.', NULL, NULL, NULL, NULL, NULL),
(542, 'Which element has maximum nonmetallic character in Period 2?', 'Fluorine', 'Oxygen', 'Nitrogen', 'Carbon', '', 1, 3, 8, 8, NULL, 'hard', 'Fluorine is the most nonmetallic.', NULL, NULL, NULL, NULL, NULL),
(543, 'Which period contains the highest number of elements?', '1st', '2nd', '4th', '6th', '', 1, 3, 8, 8, NULL, 'hard', '6th period has 32 elements.', NULL, NULL, NULL, NULL, NULL),
(544, 'What is the valency of phosphorus in PCl₅?', '3', '4', '5', '2', '', 1, 3, 8, 8, NULL, 'hard', 'Phosphorus forms five bonds with chlorine.', NULL, NULL, NULL, NULL, NULL),
(545, 'Which element exhibits inert pair effect strongly?', 'Lead', 'Tin', 'Germanium', 'Silicon', '', 1, 3, 8, 8, NULL, 'hard', 'Inert pair effect increases down the group.', NULL, NULL, NULL, NULL, NULL),
(546, 'Which element has the highest electronegativity among halogens?', 'Fluorine', 'Chlorine', 'Bromine', 'Iodine', '', 1, 3, 8, 8, NULL, 'hard', 'Fluorine attracts electrons most strongly.', NULL, NULL, NULL, NULL, NULL),
(547, 'Which of these is an alkaline earth metal?', 'Calcium', 'Sodium', 'Potassium', 'Copper', '', 1, 3, 8, 8, NULL, 'hard', 'Group 2 elements are alkaline earth metals.', NULL, NULL, NULL, NULL, NULL),
(548, 'What is the oxidation state of sulfur in H₂SO₄?', '4', '6', '2', '8', '', 1, 3, 8, 8, NULL, 'hard', 'Sulfur shows +6 oxidation state in sulfuric acid.', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `questions` (`id`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_answer`, `stream_id`, `subject_id`, `category_id`, `chapter_id`, `subcategory_id`, `level`, `explanation`, `question_image`, `option_a_image`, `option_b_image`, `option_c_image`, `option_d_image`) VALUES
(549, 'Which element has maximum shielding effect?', 'Cesium', 'Sodium', 'Helium', 'Fluorine', '', 1, 3, 8, 8, NULL, 'hard', 'More inner shells cause strong shielding.', NULL, NULL, NULL, NULL, NULL),
(550, 'Which element forms the cation with electron configuration [Ar]3d⁵?', 'Fe²⁺', 'Mn²⁺', 'Cr²⁺', 'Ni²⁺', '', 1, 3, 8, 8, NULL, 'hard', 'Fe³⁺ loses 3 electrons giving [Ar]3d⁵.', NULL, NULL, NULL, NULL, NULL),
(551, 'Which element shows +1 oxidation state in all its compounds?', 'Sodium', 'Potassium', 'Lithium', 'Cesium', '', 1, 3, 8, 8, NULL, 'hard', 'Alkali metals always show +1 oxidation.', NULL, NULL, NULL, NULL, NULL),
(552, 'Which element has an atomic number of 35?', 'Bromine', 'Chlorine', 'Iodine', 'Krypton', '', 1, 3, 8, 8, NULL, 'hard', 'Bromine’s atomic number is 35.', NULL, NULL, NULL, NULL, NULL),
(553, 'Which element is called the lightest halogen?', 'Fluorine', 'Chlorine', 'Bromine', 'Iodine', '', 1, 3, 8, 8, NULL, 'hard', 'Fluorine is the first halogen with least atomic mass.', NULL, NULL, NULL, NULL, NULL),
(554, 'Which of these elements belongs to Group 18?', 'Argon', 'Fluorine', 'Nitrogen', 'Oxygen', '', 1, 3, 8, 8, NULL, 'hard', 'Group 18 contains noble gases.', NULL, NULL, NULL, NULL, NULL),
(555, 'What is the order of a 3x4 matrix?', '3x4', '4x3', '3', '4', '', 1, 4, 10, 9, NULL, 'easy', 'Rows x Columns; a 3x4 matrix has 3 rows and 4 columns.', NULL, NULL, NULL, NULL, NULL),
(556, 'Which element is on main diagonal of matrix [[1,2],[3,4]] at position (1,1)?', '1', '2', '3', '4', '', 1, 4, 10, 9, NULL, 'easy', 'Main diagonal elements are (1,1) and (2,2).', NULL, NULL, NULL, NULL, NULL),
(557, 'The zero matrix has all entries equal to:', '0', '1', '-1', 'Infinity', '', 1, 4, 10, 9, NULL, 'easy', 'Zero matrix entries are 0.', NULL, NULL, NULL, NULL, NULL),
(558, 'Sum of two matrices is defined if they have:', 'Same order', 'Same determinant', 'Same rank', 'Same trace', '', 1, 4, 10, 9, NULL, 'easy', 'Addition requires same dimensions.', NULL, NULL, NULL, NULL, NULL),
(559, 'Scalar multiplication multiplies each entry by:', 'Scalar', 'Matrix', 'Determinant', 'Trace', '', 1, 4, 10, 9, NULL, 'easy', 'Each element is multiplied by the scalar.', NULL, NULL, NULL, NULL, NULL),
(560, 'Transpose of [[1,2,3]] is:', '[[1],[2],[3]]', '[[1,2,3]]', '[[3,2,1]]', 'None', '', 1, 4, 10, 9, NULL, 'easy', 'Transpose swaps rows and columns.', NULL, NULL, NULL, NULL, NULL),
(561, 'Identity matrix I2 has diagonal entries:', '1 and 1', '0 and 0', '1 and 0', '0 and 1', '', 1, 4, 10, 9, NULL, 'easy', 'Identity has 1s on main diagonal.', NULL, NULL, NULL, NULL, NULL),
(562, 'Determinant of [[1,0],[0,1]] is:', '1', '0', '-1', '2', '', 1, 4, 10, 9, NULL, 'easy', 'Determinant of identity is 1.', NULL, NULL, NULL, NULL, NULL),
(563, 'If A is 2x3 and B is 3x4, product AB has order:', '2x4', '3x3', '2x3', '3x4', '', 1, 4, 10, 9, NULL, 'easy', 'Inner dimensions must match; result is 2x4.', NULL, NULL, NULL, NULL, NULL),
(564, 'Rank of zero matrix is:', '0', '1', 'Full', 'Undefined', '', 1, 4, 10, 9, NULL, 'easy', 'Zero matrix has rank 0.', NULL, NULL, NULL, NULL, NULL),
(565, 'What is trace of [[1,0],[0,2]]?', '1', '2', '3', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(566, 'What is trace of [[2,0],[0,3]]?', '2', '3', '5', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(567, 'What is trace of [[3,0],[0,4]]?', '3', '4', '7', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(568, 'What is trace of [[4,0],[0,5]]?', '4', '5', '9', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(569, 'What is trace of [[5,0],[0,6]]?', '5', '6', '11', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(570, 'What is trace of [[6,0],[0,7]]?', '6', '7', '13', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(571, 'What is trace of [[7,0],[0,8]]?', '7', '8', '15', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(572, 'What is trace of [[8,0],[0,9]]?', '8', '9', '17', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(573, 'What is trace of [[9,0],[0,10]]?', '9', '10', '19', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(574, 'What is trace of [[10,0],[0,11]]?', '10', '11', '21', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(575, 'What is trace of [[11,0],[0,12]]?', '11', '12', '23', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(576, 'What is trace of [[12,0],[0,13]]?', '12', '13', '25', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(577, 'What is trace of [[13,0],[0,14]]?', '13', '14', '27', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(578, 'What is trace of [[14,0],[0,15]]?', '14', '15', '29', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(579, 'What is trace of [[15,0],[0,16]]?', '15', '16', '31', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(580, 'What is trace of [[16,0],[0,17]]?', '16', '17', '33', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(581, 'What is trace of [[17,0],[0,18]]?', '17', '18', '35', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(582, 'What is trace of [[18,0],[0,19]]?', '18', '19', '37', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(583, 'What is trace of [[19,0],[0,20]]?', '19', '20', '39', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(584, 'What is trace of [[20,0],[0,21]]?', '20', '21', '41', '0', '', 1, 4, 10, 9, NULL, 'easy', 'Trace is sum of diagonal elements.', NULL, NULL, NULL, NULL, NULL),
(585, 'For matrix [[1,0],[0,2]] determinant equals?', '2', '1', '2', '0', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant of diagonal matrix is product of diagonal entries.', NULL, NULL, NULL, NULL, NULL),
(586, 'Matrix [[1,2],[3,6]] is invertible?', 'Yes', 'No', 'Sometimes', 'Cannot say', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant = (1*6-2*3)=0 so not invertible.', NULL, NULL, NULL, NULL, NULL),
(587, 'Which operation changes sign of determinant if row swap is done once?', 'Adds 1', 'Multiplies by -1', 'No change', 'Square it', '', 1, 4, 10, 9, NULL, 'medium', 'Swapping two rows multiplies determinant by -1.', NULL, NULL, NULL, NULL, NULL),
(588, 'For matrix [[4,0],[0,5]] determinant equals?', '5', '4', '20', '0', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant of diagonal matrix is product of diagonal entries.', NULL, NULL, NULL, NULL, NULL),
(589, 'Matrix [[1,2],[3,6]] is invertible?', 'Yes', 'No', 'Sometimes', 'Cannot say', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant = (1*6-2*3)=0 so not invertible.', NULL, NULL, NULL, NULL, NULL),
(590, 'Which operation changes sign of determinant if row swap is done once?', 'Adds 1', 'Multiplies by -1', 'No change', 'Square it', '', 1, 4, 10, 9, NULL, 'medium', 'Swapping two rows multiplies determinant by -1.', NULL, NULL, NULL, NULL, NULL),
(591, 'For matrix [[7,0],[0,8]] determinant equals?', '8', '7', '56', '0', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant of diagonal matrix is product of diagonal entries.', NULL, NULL, NULL, NULL, NULL),
(592, 'Matrix [[1,2],[3,6]] is invertible?', 'Yes', 'No', 'Sometimes', 'Cannot say', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant = (1*6-2*3)=0 so not invertible.', NULL, NULL, NULL, NULL, NULL),
(593, 'Which operation changes sign of determinant if row swap is done once?', 'Adds 1', 'Multiplies by -1', 'No change', 'Square it', '', 1, 4, 10, 9, NULL, 'medium', 'Swapping two rows multiplies determinant by -1.', NULL, NULL, NULL, NULL, NULL),
(594, 'For matrix [[10,0],[0,11]] determinant equals?', '11', '10', '110', '0', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant of diagonal matrix is product of diagonal entries.', NULL, NULL, NULL, NULL, NULL),
(595, 'Matrix [[1,2],[3,6]] is invertible?', 'Yes', 'No', 'Sometimes', 'Cannot say', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant = (1*6-2*3)=0 so not invertible.', NULL, NULL, NULL, NULL, NULL),
(596, 'Which operation changes sign of determinant if row swap is done once?', 'Adds 1', 'Multiplies by -1', 'No change', 'Square it', '', 1, 4, 10, 9, NULL, 'medium', 'Swapping two rows multiplies determinant by -1.', NULL, NULL, NULL, NULL, NULL),
(597, 'For matrix [[13,0],[0,14]] determinant equals?', '14', '13', '182', '0', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant of diagonal matrix is product of diagonal entries.', NULL, NULL, NULL, NULL, NULL),
(598, 'Matrix [[1,2],[3,6]] is invertible?', 'Yes', 'No', 'Sometimes', 'Cannot say', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant = (1*6-2*3)=0 so not invertible.', NULL, NULL, NULL, NULL, NULL),
(599, 'Which operation changes sign of determinant if row swap is done once?', 'Adds 1', 'Multiplies by -1', 'No change', 'Square it', '', 1, 4, 10, 9, NULL, 'medium', 'Swapping two rows multiplies determinant by -1.', NULL, NULL, NULL, NULL, NULL),
(600, 'For matrix [[16,0],[0,17]] determinant equals?', '17', '16', '272', '0', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant of diagonal matrix is product of diagonal entries.', NULL, NULL, NULL, NULL, NULL),
(601, 'Matrix [[1,2],[3,6]] is invertible?', 'Yes', 'No', 'Sometimes', 'Cannot say', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant = (1*6-2*3)=0 so not invertible.', NULL, NULL, NULL, NULL, NULL),
(602, 'Which operation changes sign of determinant if row swap is done once?', 'Adds 1', 'Multiplies by -1', 'No change', 'Square it', '', 1, 4, 10, 9, NULL, 'medium', 'Swapping two rows multiplies determinant by -1.', NULL, NULL, NULL, NULL, NULL),
(603, 'For matrix [[19,0],[0,20]] determinant equals?', '20', '19', '380', '0', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant of diagonal matrix is product of diagonal entries.', NULL, NULL, NULL, NULL, NULL),
(604, 'Matrix [[1,2],[3,6]] is invertible?', 'Yes', 'No', 'Sometimes', 'Cannot say', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant = (1*6-2*3)=0 so not invertible.', NULL, NULL, NULL, NULL, NULL),
(605, 'Which operation changes sign of determinant if row swap is done once?', 'Adds 1', 'Multiplies by -1', 'No change', 'Square it', '', 1, 4, 10, 9, NULL, 'medium', 'Swapping two rows multiplies determinant by -1.', NULL, NULL, NULL, NULL, NULL),
(606, 'For matrix [[22,0],[0,23]] determinant equals?', '23', '22', '506', '0', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant of diagonal matrix is product of diagonal entries.', NULL, NULL, NULL, NULL, NULL),
(607, 'Matrix [[1,2],[3,6]] is invertible?', 'Yes', 'No', 'Sometimes', 'Cannot say', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant = (1*6-2*3)=0 so not invertible.', NULL, NULL, NULL, NULL, NULL),
(608, 'Which operation changes sign of determinant if row swap is done once?', 'Adds 1', 'Multiplies by -1', 'No change', 'Square it', '', 1, 4, 10, 9, NULL, 'medium', 'Swapping two rows multiplies determinant by -1.', NULL, NULL, NULL, NULL, NULL),
(609, 'For matrix [[25,0],[0,26]] determinant equals?', '26', '25', '650', '0', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant of diagonal matrix is product of diagonal entries.', NULL, NULL, NULL, NULL, NULL),
(610, 'Matrix [[1,2],[3,6]] is invertible?', 'Yes', 'No', 'Sometimes', 'Cannot say', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant = (1*6-2*3)=0 so not invertible.', NULL, NULL, NULL, NULL, NULL),
(611, 'Which operation changes sign of determinant if row swap is done once?', 'Adds 1', 'Multiplies by -1', 'No change', 'Square it', '', 1, 4, 10, 9, NULL, 'medium', 'Swapping two rows multiplies determinant by -1.', NULL, NULL, NULL, NULL, NULL),
(612, 'For matrix [[28,0],[0,29]] determinant equals?', '29', '28', '812', '0', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant of diagonal matrix is product of diagonal entries.', NULL, NULL, NULL, NULL, NULL),
(613, 'Matrix [[1,2],[3,6]] is invertible?', 'Yes', 'No', 'Sometimes', 'Cannot say', '', 1, 4, 10, 9, NULL, 'medium', 'Determinant = (1*6-2*3)=0 so not invertible.', NULL, NULL, NULL, NULL, NULL),
(614, 'Which operation changes sign of determinant if row swap is done once?', 'Adds 1', 'Multiplies by -1', 'No change', 'Square it', '', 1, 4, 10, 9, NULL, 'medium', 'Swapping two rows multiplies determinant by -1.', NULL, NULL, NULL, NULL, NULL),
(615, 'If A is orthogonal matrix then A^T equals:', 'A inverse', 'A', '-A', 'A^2', '', 1, 4, 10, 9, NULL, 'hard', 'For orthogonal A, A^T = A^{-1}.', NULL, NULL, NULL, NULL, NULL),
(616, 'If det(A)=0 then columns of A are:', 'Linearly dependent', 'Linearly independent', 'Orthogonal', 'Zero', '', 1, 4, 10, 9, NULL, 'hard', 'Zero determinant implies column dependence.', NULL, NULL, NULL, NULL, NULL),
(617, 'Eigenvalues of identity matrix I_n are:', '0', '1', 'n', '-1', '', 1, 4, 10, 9, NULL, 'hard', 'Identity has eigenvalue 1 with multiplicity n.', NULL, NULL, NULL, NULL, NULL),
(618, 'If A is 2x2 with trace 5 and determinant 6, characteristic equation is:', 'λ^2-5λ+6=0', 'λ^2+5λ+6=0', 'λ^2-6λ+5=0', 'λ^2+6λ+5=0', '', 1, 4, 10, 9, NULL, 'hard', 'Char poly λ^2 - (trace)λ + det = 0.', NULL, NULL, NULL, NULL, NULL),
(619, 'If A is orthogonal matrix then A^T equals:', 'A inverse', 'A', '-A', 'A^2', '', 1, 4, 10, 9, NULL, 'hard', 'For orthogonal A, A^T = A^{-1}.', NULL, NULL, NULL, NULL, NULL),
(620, 'If det(A)=0 then columns of A are:', 'Linearly dependent', 'Linearly independent', 'Orthogonal', 'Zero', '', 1, 4, 10, 9, NULL, 'hard', 'Zero determinant implies column dependence.', NULL, NULL, NULL, NULL, NULL),
(621, 'Eigenvalues of identity matrix I_n are:', '0', '1', 'n', '-1', '', 1, 4, 10, 9, NULL, 'hard', 'Identity has eigenvalue 1 with multiplicity n.', NULL, NULL, NULL, NULL, NULL),
(622, 'If A is 2x2 with trace 5 and determinant 6, characteristic equation is:', 'λ^2-5λ+6=0', 'λ^2+5λ+6=0', 'λ^2-6λ+5=0', 'λ^2+6λ+5=0', '', 1, 4, 10, 9, NULL, 'hard', 'Char poly λ^2 - (trace)λ + det = 0.', NULL, NULL, NULL, NULL, NULL),
(623, 'If A is orthogonal matrix then A^T equals:', 'A inverse', 'A', '-A', 'A^2', '', 1, 4, 10, 9, NULL, 'hard', 'For orthogonal A, A^T = A^{-1}.', NULL, NULL, NULL, NULL, NULL),
(624, 'If det(A)=0 then columns of A are:', 'Linearly dependent', 'Linearly independent', 'Orthogonal', 'Zero', '', 1, 4, 10, 9, NULL, 'hard', 'Zero determinant implies column dependence.', NULL, NULL, NULL, NULL, NULL),
(625, 'Eigenvalues of identity matrix I_n are:', '0', '1', 'n', '-1', '', 1, 4, 10, 9, NULL, 'hard', 'Identity has eigenvalue 1 with multiplicity n.', NULL, NULL, NULL, NULL, NULL),
(626, 'If A is 2x2 with trace 5 and determinant 6, characteristic equation is:', 'λ^2-5λ+6=0', 'λ^2+5λ+6=0', 'λ^2-6λ+5=0', 'λ^2+6λ+5=0', '', 1, 4, 10, 9, NULL, 'hard', 'Char poly λ^2 - (trace)λ + det = 0.', NULL, NULL, NULL, NULL, NULL),
(627, 'If A is orthogonal matrix then A^T equals:', 'A inverse', 'A', '-A', 'A^2', '', 1, 4, 10, 9, NULL, 'hard', 'For orthogonal A, A^T = A^{-1}.', NULL, NULL, NULL, NULL, NULL),
(628, 'If det(A)=0 then columns of A are:', 'Linearly dependent', 'Linearly independent', 'Orthogonal', 'Zero', '', 1, 4, 10, 9, NULL, 'hard', 'Zero determinant implies column dependence.', NULL, NULL, NULL, NULL, NULL),
(629, 'Eigenvalues of identity matrix I_n are:', '0', '1', 'n', '-1', '', 1, 4, 10, 9, NULL, 'hard', 'Identity has eigenvalue 1 with multiplicity n.', NULL, NULL, NULL, NULL, NULL),
(630, 'If A is 2x2 with trace 5 and determinant 6, characteristic equation is:', 'λ^2-5λ+6=0', 'λ^2+5λ+6=0', 'λ^2-6λ+5=0', 'λ^2+6λ+5=0', '', 1, 4, 10, 9, NULL, 'hard', 'Char poly λ^2 - (trace)λ + det = 0.', NULL, NULL, NULL, NULL, NULL),
(631, 'If A is orthogonal matrix then A^T equals:', 'A inverse', 'A', '-A', 'A^2', '', 1, 4, 10, 9, NULL, 'hard', 'For orthogonal A, A^T = A^{-1}.', NULL, NULL, NULL, NULL, NULL),
(632, 'If det(A)=0 then columns of A are:', 'Linearly dependent', 'Linearly independent', 'Orthogonal', 'Zero', '', 1, 4, 10, 9, NULL, 'hard', 'Zero determinant implies column dependence.', NULL, NULL, NULL, NULL, NULL),
(633, 'Eigenvalues of identity matrix I_n are:', '0', '1', 'n', '-1', '', 1, 4, 10, 9, NULL, 'hard', 'Identity has eigenvalue 1 with multiplicity n.', NULL, NULL, NULL, NULL, NULL),
(634, 'If A is 2x2 with trace 5 and determinant 6, characteristic equation is:', 'λ^2-5λ+6=0', 'λ^2+5λ+6=0', 'λ^2-6λ+5=0', 'λ^2+6λ+5=0', '', 1, 4, 10, 9, NULL, 'hard', 'Char poly λ^2 - (trace)λ + det = 0.', NULL, NULL, NULL, NULL, NULL),
(635, 'If A is orthogonal matrix then A^T equals:', 'A inverse', 'A', '-A', 'A^2', '', 1, 4, 10, 9, NULL, 'hard', 'For orthogonal A, A^T = A^{-1}.', NULL, NULL, NULL, NULL, NULL),
(636, 'If det(A)=0 then columns of A are:', 'Linearly dependent', 'Linearly independent', 'Orthogonal', 'Zero', '', 1, 4, 10, 9, NULL, 'hard', 'Zero determinant implies column dependence.', NULL, NULL, NULL, NULL, NULL),
(637, 'Eigenvalues of identity matrix I_n are:', '0', '1', 'n', '-1', '', 1, 4, 10, 9, NULL, 'hard', 'Identity has eigenvalue 1 with multiplicity n.', NULL, NULL, NULL, NULL, NULL),
(638, 'If A is 2x2 with trace 5 and determinant 6, characteristic equation is:', 'λ^2-5λ+6=0', 'λ^2+5λ+6=0', 'λ^2-6λ+5=0', 'λ^2+6λ+5=0', '', 1, 4, 10, 9, NULL, 'hard', 'Char poly λ^2 - (trace)λ + det = 0.', NULL, NULL, NULL, NULL, NULL),
(639, 'If A is orthogonal matrix then A^T equals:', 'A inverse', 'A', '-A', 'A^2', '', 1, 4, 10, 9, NULL, 'hard', 'For orthogonal A, A^T = A^{-1}.', NULL, NULL, NULL, NULL, NULL),
(640, 'If det(A)=0 then columns of A are:', 'Linearly dependent', 'Linearly independent', 'Orthogonal', 'Zero', '', 1, 4, 10, 9, NULL, 'hard', 'Zero determinant implies column dependence.', NULL, NULL, NULL, NULL, NULL),
(641, 'Eigenvalues of identity matrix I_n are:', '0', '1', 'n', '-1', '', 1, 4, 10, 9, NULL, 'hard', 'Identity has eigenvalue 1 with multiplicity n.', NULL, NULL, NULL, NULL, NULL),
(642, 'If A is 2x2 with trace 5 and determinant 6, characteristic equation is:', 'λ^2-5λ+6=0', 'λ^2+5λ+6=0', 'λ^2-6λ+5=0', 'λ^2+6λ+5=0', '', 1, 4, 10, 9, NULL, 'hard', 'Char poly λ^2 - (trace)λ + det = 0.', NULL, NULL, NULL, NULL, NULL),
(643, 'If A is orthogonal matrix then A^T equals:', 'A inverse', 'A', '-A', 'A^2', '', 1, 4, 10, 9, NULL, 'hard', 'For orthogonal A, A^T = A^{-1}.', NULL, NULL, NULL, NULL, NULL),
(644, 'If det(A)=0 then columns of A are:', 'Linearly dependent', 'Linearly independent', 'Orthogonal', 'Zero', '', 1, 4, 10, 9, NULL, 'hard', 'Zero determinant implies column dependence.', NULL, NULL, NULL, NULL, NULL),
(645, 'Which of these elements belongs to Group 18?', 'Argon', 'Fluorine', 'Nitrogen', 'Oxygen', '', 1, 4, 10, 9, NULL, 'hard', 'Group 18 contains noble gases.', NULL, NULL, NULL, NULL, NULL),
(646, 'Derivative of x^2 is:', '2x', 'x', 'x^2', '2', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule: d/dx x^n = n x^{n-1}.', NULL, NULL, NULL, NULL, NULL),
(647, 'If f(x)=3x, f\'(x) equals:', '3', 'x', '0', '1', '', 1, 4, 10, 10, NULL, 'easy', 'Derivative of ax is a.', NULL, NULL, NULL, NULL, NULL),
(648, 'A function increasing where f\'(x)>?', '0', '1', '-1', 'Cannot say', '', 1, 4, 10, 10, NULL, 'easy', 'Positive derivative implies increasing.', NULL, NULL, NULL, NULL, NULL),
(649, 'Slope of tangent to y=2x+3 is:', '2', '3', '0', '5', '', 1, 4, 10, 10, NULL, 'easy', 'Linear slope equals coefficient of x.', NULL, NULL, NULL, NULL, NULL),
(650, 'Derivative of sin x is:', 'cos x', '-cos x', 'sin x', '-sin x', '', 1, 4, 10, 10, NULL, 'easy', 'd/dx sin x = cos x.', NULL, NULL, NULL, NULL, NULL),
(651, 'Derivative of x^1 is:', '1x^0', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(652, 'Derivative of x^2 is:', '2x^1', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(653, 'Derivative of x^3 is:', '3x^2', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(654, 'Derivative of x^4 is:', '4x^3', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(655, 'Derivative of x^5 is:', '5x^4', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(656, 'Derivative of x^6 is:', '6x^5', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(657, 'Derivative of x^7 is:', '7x^6', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(658, 'Derivative of x^8 is:', '8x^7', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(659, 'Derivative of x^9 is:', '9x^8', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(660, 'Derivative of x^10 is:', '10x^9', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(661, 'Derivative of x^11 is:', '11x^10', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(662, 'Derivative of x^12 is:', '12x^11', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(663, 'Derivative of x^13 is:', '13x^12', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(664, 'Derivative of x^14 is:', '14x^13', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(665, 'Derivative of x^15 is:', '15x^14', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(666, 'Derivative of x^16 is:', '16x^15', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(667, 'Derivative of x^17 is:', '17x^16', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(668, 'Derivative of x^18 is:', '18x^17', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(669, 'Derivative of x^19 is:', '19x^18', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(670, 'Derivative of x^20 is:', '20x^19', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(671, 'Derivative of x^21 is:', '21x^20', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(672, 'Derivative of x^22 is:', '22x^21', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(673, 'Derivative of x^23 is:', '23x^22', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(674, 'Derivative of x^24 is:', '24x^23', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(675, 'Derivative of x^25 is:', '25x^24', 'x', '1', '0', '', 1, 4, 10, 10, NULL, 'easy', 'Power rule.', NULL, NULL, NULL, NULL, NULL),
(676, 'If f(x)=x^3-3x^2+2, stationary points are where f\' equals?', '0', '1', '-1', '2', '', 1, 4, 10, 10, NULL, 'medium', 'Stationary points solve f\'(x)=0.', NULL, NULL, NULL, NULL, NULL),
(677, 'Second derivative positive at point implies:', 'Concave up', 'Concave down', 'Inflection', 'No info', '', 1, 4, 10, 10, NULL, 'medium', 'f\'\'>0 => concave up (local minima possibility).', NULL, NULL, NULL, NULL, NULL),
(678, 'If f\'(c)=0 and f\'\'(c)<0 then c is:', 'Local max', 'Local min', 'Inflection', 'Neither', '', 1, 4, 10, 10, NULL, 'medium', 'Second derivative negative indicates local maximum.', NULL, NULL, NULL, NULL, NULL),
(679, 'Rolle\'s theorem requires f(a)=f(b) and:', 'Continuity and differentiable', 'Integrable', 'Increasing only', 'Bounded', '', 1, 4, 10, 10, NULL, 'medium', 'Rolle\'s needs continuity on [a,b] and differentiable on (a,b).', NULL, NULL, NULL, NULL, NULL),
(680, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(681, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(682, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(683, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(684, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(685, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(686, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(687, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(688, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(689, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(690, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(691, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(692, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(693, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(694, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(695, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(696, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(697, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(698, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(699, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(700, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(701, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(702, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(703, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(704, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(705, 'What is derivative of tan x?', 'sec^2 x', 'sec x', 'tan^2 x', 'cos^2 x', '', 1, 4, 10, 10, NULL, 'medium', 'd/dx tan x = sec^2 x.', NULL, NULL, NULL, NULL, NULL),
(706, 'Using L\'Hospital: limit x->0 of (sin x)/x equals?', '1', '0', 'Infinity', '-1', '', 1, 4, 10, 10, NULL, 'hard', 'Standard limit; or apply L\'Hospital gives cos0=1.', NULL, NULL, NULL, NULL, NULL),
(707, 'Maximize area of rectangle under curve y=4-x^2 and x-axis; half-width?', '1', '2', 'sqrt2', '0', '', 1, 4, 10, 10, NULL, 'hard', 'Symmetry gives optimum at x=1 for half-width (area calc).', NULL, NULL, NULL, NULL, NULL),
(708, 'For function f(x)=x^3-3x, inflection point at:', '0', '1', '-1', '2', '', 1, 4, 10, 10, NULL, 'hard', 'Inflection where f\'\'(x)=6x=0 => x=0.', NULL, NULL, NULL, NULL, NULL),
(709, 'Derivative of ln(x^2+1) is:', '2x/(x^2+1)', '1/(x^2+1)', '2x', 'ln(...)\'', '', 1, 4, 10, 10, NULL, 'hard', 'Use chain rule: (1/(x^2+1))*2x.', NULL, NULL, NULL, NULL, NULL),
(710, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(711, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(712, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(713, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(714, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(715, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(716, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(717, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(718, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(719, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(720, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(721, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(722, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(723, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(724, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(725, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(726, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(727, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(728, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(729, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(730, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(731, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(732, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(733, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(734, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(735, 'Evaluate limit x->0 of (1 - cos x)/x^2 ?', '1/2', '0', '1', 'Infinity', '', 1, 4, 10, 10, NULL, 'hard', 'Use series or L\'Hospital; equals 1/2.', NULL, NULL, NULL, NULL, NULL),
(736, 'Which of these elements belongs to Group 18?', 'Argon', 'Fluorine', 'Nitrogen', 'Oxygen', '', 1, 4, 10, 10, NULL, 'hard', 'Group 18 contains noble gases.', NULL, NULL, NULL, NULL, NULL),
(737, 'Probability of getting a head in fair coin toss is:', '1/2', '1/3', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Two outcomes equally likely.', NULL, NULL, NULL, NULL, NULL),
(738, 'A single die rolled, probability of getting 4 is:', '1/6', '1/3', '1/2', '1/4', '', 1, 4, 10, 11, NULL, 'easy', 'One face out of six.', NULL, NULL, NULL, NULL, NULL),
(739, 'Probability of drawing ace from 52-card deck is:', '1/13', '1/52', '1/4', '1/26', '', 1, 4, 10, 11, NULL, 'easy', 'There are 4 aces out of 52.', NULL, NULL, NULL, NULL, NULL),
(740, 'Probability of event sure to happen is:', '1', '0', '0.5', '-1', '', 1, 4, 10, 11, NULL, 'easy', 'Certain event probability =1.', NULL, NULL, NULL, NULL, NULL),
(741, 'If events A and B mutually exclusive, P(A∪B) = ?', 'P(A)+P(B)', 'P(A)P(B)', 'P(A)-P(B)', 'Cannot say', '', 1, 4, 10, 11, NULL, 'easy', 'No overlap so add probabilities.', NULL, NULL, NULL, NULL, NULL),
(742, 'If sample space has 2 equally likely outcomes, probability of one event is:', '0.5', '2', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(743, 'If sample space has 3 equally likely outcomes, probability of one event is:', '0.3333333333333333', '3', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(744, 'If sample space has 4 equally likely outcomes, probability of one event is:', '0.25', '4', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(745, 'If sample space has 5 equally likely outcomes, probability of one event is:', '0.2', '5', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(746, 'If sample space has 6 equally likely outcomes, probability of one event is:', '0.16666666666666666', '6', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(747, 'If sample space has 7 equally likely outcomes, probability of one event is:', '0.14285714285714285', '7', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(748, 'If sample space has 8 equally likely outcomes, probability of one event is:', '0.125', '8', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(749, 'If sample space has 9 equally likely outcomes, probability of one event is:', '0.1111111111111111', '9', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(750, 'If sample space has 10 equally likely outcomes, probability of one event is:', '0.1', '10', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(751, 'If sample space has 11 equally likely outcomes, probability of one event is:', '0.09090909090909091', '11', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(752, 'If sample space has 12 equally likely outcomes, probability of one event is:', '0.08333333333333333', '12', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(753, 'If sample space has 13 equally likely outcomes, probability of one event is:', '0.07692307692307693', '13', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(754, 'If sample space has 14 equally likely outcomes, probability of one event is:', '0.07142857142857142', '14', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(755, 'If sample space has 15 equally likely outcomes, probability of one event is:', '0.06666666666666667', '15', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(756, 'If sample space has 16 equally likely outcomes, probability of one event is:', '0.0625', '16', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(757, 'If sample space has 17 equally likely outcomes, probability of one event is:', '0.058823529411764705', '17', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(758, 'If sample space has 18 equally likely outcomes, probability of one event is:', '0.05555555555555555', '18', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(759, 'If sample space has 19 equally likely outcomes, probability of one event is:', '0.05263157894736842', '19', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(760, 'If sample space has 20 equally likely outcomes, probability of one event is:', '0.05', '20', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(761, 'If sample space has 21 equally likely outcomes, probability of one event is:', '0.047619047619047616', '21', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(762, 'If sample space has 22 equally likely outcomes, probability of one event is:', '0.045454545454545456', '22', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(763, 'If sample space has 23 equally likely outcomes, probability of one event is:', '0.043478260869565216', '23', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(764, 'If sample space has 24 equally likely outcomes, probability of one event is:', '0.041666666666666664', '24', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(765, 'If sample space has 25 equally likely outcomes, probability of one event is:', '0.04', '25', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(766, 'If sample space has 26 equally likely outcomes, probability of one event is:', '0.038461538461538464', '26', '1', '0', '', 1, 4, 10, 11, NULL, 'easy', 'Equally likely outcomes.', NULL, NULL, NULL, NULL, NULL),
(767, 'If P(A)=0.3 and P(B)=0.4 and independent, P(A∩B) = ?', '0.12', '0.7', '0.1', '0.0', '', 1, 4, 10, 11, NULL, 'medium', 'Independence => multiply probs.', NULL, NULL, NULL, NULL, NULL),
(768, 'Conditional probability P(A|B) = P(A∩B)/P(B); if P(A∩B)=0.1 and P(B)=0.5, P(A|B) = ?', '0.2', '0.5', '0.1', '0.05', '', 1, 4, 10, 11, NULL, 'medium', 'Apply conditional formula.', NULL, NULL, NULL, NULL, NULL),
(769, 'Probability of getting two heads in two fair coin tosses is:', '1/4', '1/2', '1/3', '1', '', 1, 4, 10, 11, NULL, 'medium', '(1/2)*(1/2)=1/4.', NULL, NULL, NULL, NULL, NULL),
(770, 'In binomial with n=3, p=1/2, P(2 successes) = ?', '3/8', '1/8', '1/2', '3/4', '', 1, 4, 10, 11, NULL, 'medium', 'C(3,2)*(1/2)^3 = 3/8.', NULL, NULL, NULL, NULL, NULL),
(771, 'If P(A)=0.10 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.0500', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(772, 'If P(A)=0.11 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.0550', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(773, 'If P(A)=0.12 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.0600', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(774, 'If P(A)=0.13 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.0650', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(775, 'If P(A)=0.14 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.0700', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(776, 'If P(A)=0.15 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.0750', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(777, 'If P(A)=0.16 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.0800', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(778, 'If P(A)=0.17 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.0850', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(779, 'If P(A)=0.18 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.0900', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(780, 'If P(A)=0.19 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.0950', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(781, 'If P(A)=0.20 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.1000', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(782, 'If P(A)=0.21 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.1050', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(783, 'If P(A)=0.22 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.1100', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(784, 'If P(A)=0.23 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.1150', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(785, 'If P(A)=0.24 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.1200', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(786, 'If P(A)=0.25 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.1250', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(787, 'If P(A)=0.26 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.1300', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(788, 'If P(A)=0.27 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.1350', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(789, 'If P(A)=0.28 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.1400', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(790, 'If P(A)=0.29 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.1450', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(791, 'If P(A)=0.30 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.1500', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(792, 'If P(A)=0.31 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.1550', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(793, 'If P(A)=0.32 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.1600', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(794, 'If P(A)=0.33 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.1650', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(795, 'If P(A)=0.34 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.1700', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(796, 'If P(A)=0.35 and independent with B where P(B)=0.5, P(A∩B) = ?', '0.1750', '0.5', '0.1', 'Cannot say', '', 1, 4, 10, 11, NULL, 'medium', 'Multiply for independent events.', NULL, NULL, NULL, NULL, NULL),
(797, 'Bayes\' theorem: P(A|B) = ?', 'P(B|A)P(A)/P(B)', 'P(A)P(B)', 'P(A∩B)/P(A)', 'P(B|A)', '', 1, 4, 10, 11, NULL, 'hard', 'Bayes\' rule.', NULL, NULL, NULL, NULL, NULL),
(798, 'For Poisson with λ=3, P(X=2) = ?', 'e^{-3} * 3^2 /2!', '3/2', '1/3', 'Cannot say', '', 1, 4, 10, 11, NULL, 'hard', 'Poisson pmf: e^{-λ} λ^k / k!', NULL, NULL, NULL, NULL, NULL),
(799, 'Variance of fair die roll is:', '35/12', '91/6', '1', '2', '', 1, 4, 10, 11, NULL, 'hard', 'Variance formula for uniform 1..6 is 35/12.', NULL, NULL, NULL, NULL, NULL),
(800, 'If X~Binomial(n,p), E[X] equals:', 'np', 'n/p', 'p/n', 'n+p', '', 1, 4, 10, 11, NULL, 'hard', 'Expectation of binomial is np.', NULL, NULL, NULL, NULL, NULL),
(801, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(802, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(803, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(804, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(805, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(806, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(807, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(808, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(809, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(810, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(811, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(812, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(813, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `questions` (`id`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_answer`, `stream_id`, `subject_id`, `category_id`, `chapter_id`, `subcategory_id`, `level`, `explanation`, `question_image`, `option_a_image`, `option_b_image`, `option_c_image`, `option_d_image`) VALUES
(814, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(815, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(816, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(817, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(818, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(819, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(820, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(821, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(822, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(823, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(824, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(825, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(826, 'If P(A)=0.4 and P(B|A)=0.5 and P(B|A^c)=0.2, then P(B) = ?', '0.32', '0.5', '0.4', '0.2', '', 1, 4, 10, 11, NULL, 'hard', 'Law of total probability.', NULL, NULL, NULL, NULL, NULL),
(827, 'Which of these elements belongs to Group 18?', 'Argon', 'Fluorine', 'Nitrogen', 'Oxygen', '', 1, 4, 10, 11, NULL, 'hard', 'Group 18 contains noble gases.', NULL, NULL, NULL, NULL, NULL),
(918, 'The slope of a position-time graph represents what quantity?', 'Velocity', 'Acceleration', 'Displacement', 'Jerk', '', 1, 1, 1, 1, NULL, 'easy', 'Slope of position-time graph gives rate of change of position, i.e., velocity.', NULL, NULL, NULL, NULL, NULL),
(919, 'If a body moves with uniform velocity, its acceleration is', 'Zero', 'Positive', 'Negative', 'Variable', '', 1, 1, 1, 1, NULL, 'easy', 'Uniform velocity means no change in velocity, hence zero acceleration.', NULL, NULL, NULL, NULL, NULL),
(920, 'What is the SI unit of displacement?', 'Meter', 'Second', 'Meter per second', 'Joule', '', 1, 1, 1, 1, NULL, 'easy', 'Displacement is a measure of length, so the SI unit is meter.', NULL, NULL, NULL, NULL, NULL),
(921, 'Which of these quantities is a vector?', 'Speed', 'Distance', 'Velocity', 'Time', '', 1, 1, 1, 1, NULL, 'easy', 'Velocity has both magnitude and direction.', NULL, NULL, NULL, NULL, NULL),
(922, 'What does the area under a velocity-time graph represent?', 'Displacement', 'Speed', 'Acceleration', 'Force', '', 1, 1, 1, 1, NULL, 'easy', 'Area under velocity-time graph gives displacement.', NULL, NULL, NULL, NULL, NULL),
(923, 'A car moves 10 m east and then 10 m west. What is the displacement?', '0 m', '10 m', '20 m', '-10 m', '', 1, 1, 1, 1, NULL, 'easy', 'Total displacement is zero since it returns to the starting point.', NULL, NULL, NULL, NULL, NULL),
(924, 'The rate of change of velocity is called', 'Acceleration', 'Speed', 'Displacement', 'Force', '', 1, 1, 1, 1, NULL, 'easy', 'Acceleration is defined as rate of change of velocity.', NULL, NULL, NULL, NULL, NULL),
(925, 'Which physical quantity is scalar?', 'Speed', 'Velocity', 'Displacement', 'Acceleration', '', 1, 1, 1, 1, NULL, 'easy', 'Speed has magnitude only, not direction.', NULL, NULL, NULL, NULL, NULL),
(926, 'A body is said to be in uniform motion when', 'Its speed changes', 'Its direction changes', 'Its velocity remains constant', 'It is accelerating', '', 1, 1, 1, 1, NULL, 'easy', 'Uniform motion means constant velocity.', NULL, NULL, NULL, NULL, NULL),
(927, 'When a body moves in a circle with constant speed, its acceleration is', 'Zero', 'Tangential', 'Directed towards center', 'Along tangent', '', 1, 1, 1, 1, NULL, 'easy', 'Circular motion involves centripetal acceleration towards center.', NULL, NULL, NULL, NULL, NULL),
(928, 'In uniform circular motion, speed is', 'Constant', 'Zero', 'Increasing', 'Decreasing', '', 1, 1, 1, 1, NULL, 'easy', 'Magnitude of velocity (speed) remains constant in uniform circular motion.', NULL, NULL, NULL, NULL, NULL),
(929, 'What is the slope of a velocity-time graph equal to?', 'Acceleration', 'Speed', 'Displacement', 'Time', '', 1, 1, 1, 1, NULL, 'easy', 'Slope of velocity-time graph gives acceleration.', NULL, NULL, NULL, NULL, NULL),
(930, 'What is the dimensional formula of velocity?', '[M⁰L¹T⁻¹]', '[MLT⁻²]', '[ML⁰T⁰]', '[M⁰L⁰T⁻¹]', '', 1, 1, 1, 1, NULL, 'easy', 'Velocity = distance/time → [L]/[T] = [M⁰L¹T⁻¹].', NULL, NULL, NULL, NULL, NULL),
(931, 'The motion of a freely falling body is an example of', 'Uniform motion', 'Uniformly accelerated motion', 'Circular motion', 'Projectile motion', '', 1, 1, 1, 1, NULL, 'easy', 'Freely falling body has constant acceleration due to gravity.', NULL, NULL, NULL, NULL, NULL),
(932, 'Acceleration due to gravity on Earth is approximately', '9.8 m/s²', '8.9 m/s²', '10.8 m/s²', '6.8 m/s²', '', 1, 1, 1, 1, NULL, 'easy', 'Standard value of g = 9.8 m/s².', NULL, NULL, NULL, NULL, NULL),
(933, 'A particle covers equal distances in equal intervals of time. Its motion is', 'Uniform', 'Accelerated', 'Retarded', 'Non-uniform', '', 1, 1, 1, 1, NULL, 'easy', 'Equal distances in equal time → uniform motion.', NULL, NULL, NULL, NULL, NULL),
(934, 'Which of these can be negative?', 'Speed', 'Distance', 'Displacement', 'Mass', '', 1, 1, 1, 1, NULL, 'easy', 'Displacement can be negative depending on direction.', NULL, NULL, NULL, NULL, NULL),
(935, 'Instantaneous speed is defined as', 'Speed at any instant', 'Average speed over time', 'Change in speed per unit time', 'Maximum speed', '', 1, 1, 1, 1, NULL, 'easy', 'It is the speed at a particular moment.', NULL, NULL, NULL, NULL, NULL),
(936, 'Which graph shows uniform motion?', 'Straight line in position-time graph', 'Parabola in velocity-time graph', 'Curve in position-time graph', 'Any graph', '', 1, 1, 1, 1, NULL, 'easy', 'Uniform motion → linear position-time graph.', NULL, NULL, NULL, NULL, NULL),
(937, 'A car starts from rest. What is its initial velocity?', 'Zero', 'One', 'Infinity', 'Undefined', '', 1, 1, 1, 1, NULL, 'easy', 'At rest means initial velocity = 0.', NULL, NULL, NULL, NULL, NULL),
(938, 'For projectile motion, acceleration in the horizontal direction is', 'Zero', '9.8 m/s²', 'Variable', 'Maximum', '', 1, 1, 1, 1, NULL, 'easy', 'No horizontal acceleration (neglecting air resistance).', NULL, NULL, NULL, NULL, NULL),
(939, 'What is the direction of acceleration in uniform circular motion?', 'Along tangent', 'Along radius', 'Towards center', 'Outward', '', 1, 1, 1, 1, NULL, 'easy', 'Centripetal acceleration acts toward center.', NULL, NULL, NULL, NULL, NULL),
(940, 'Velocity is the rate of change of', 'Acceleration', 'Displacement', 'Time', 'Force', '', 1, 1, 1, 1, NULL, 'easy', 'Velocity = change in displacement/time.', NULL, NULL, NULL, NULL, NULL),
(941, 'When velocity decreases with time, acceleration is', 'Positive', 'Negative', 'Zero', 'Constant', '', 1, 1, 1, 1, NULL, 'easy', 'Decrease in velocity → negative acceleration (retardation).', NULL, NULL, NULL, NULL, NULL),
(942, 'The average velocity for a round trip (same speed both ways) is equal to', 'Harmonic mean', 'Arithmetic mean', 'Geometric mean', 'None', '', 1, 1, 1, 1, NULL, 'easy', 'For equal distances, average velocity = harmonic mean of speeds.', NULL, NULL, NULL, NULL, NULL),
(943, 'What does a zero velocity but nonzero acceleration indicate?', 'Body at rest momentarily', 'Body in uniform motion', 'Body stopped permanently', 'Body moving uniformly', '', 1, 1, 1, 1, NULL, 'easy', 'At highest point of projectile motion, v=0 but a≠0.', NULL, NULL, NULL, NULL, NULL),
(944, 'If acceleration is zero, which graph is straight?', 'Position-time graph', 'Velocity-time graph', 'Acceleration-time graph', 'Force-time graph', '', 1, 1, 1, 1, NULL, 'easy', 'Zero acceleration → horizontal velocity-time graph.', NULL, NULL, NULL, NULL, NULL),
(945, 'In motion in a plane, velocity has how many components?', '1', '2', '3', '4', '', 1, 1, 1, 1, NULL, 'easy', 'Velocity is resolved into two perpendicular components.', NULL, NULL, NULL, NULL, NULL),
(946, 'A car moving north takes a turn east at same speed. Speed is constant, but', 'Velocity changes', 'Acceleration is zero', 'Motion is uniform', 'Force is zero', '', 1, 1, 1, 1, NULL, 'easy', 'Direction change → velocity change → acceleration present.', NULL, NULL, NULL, NULL, NULL),
(947, 'If displacement-time graph is a straight line passing through origin, motion is', 'Uniform', 'Accelerated', 'Retarded', 'Non-uniform', '', 1, 1, 1, 1, NULL, 'easy', 'Linear graph → uniform velocity.', NULL, NULL, NULL, NULL, NULL),
(948, 'A car accelerates uniformly from 5 m/s to 25 m/s in 5 seconds. What is its acceleration?', '4 m/s²', '5 m/s²', '2 m/s²', '6 m/s²', '', 1, 1, 1, 1, NULL, 'medium', 'a = (v - u)/t = (25 - 5)/5 = 4 m/s².', NULL, NULL, NULL, NULL, NULL),
(949, 'An object moving with uniform acceleration covers 100 m in 4 s after starting from rest. What is acceleration?', '12.5 m/s²', '6.25 m/s²', '10 m/s²', '8 m/s²', '', 1, 1, 1, 1, NULL, 'medium', 's = ut + ½at² → 100 = 0 + ½a(16) → a = 12.5 m/s². Correction: 100 = 8a → a = 12.5 m/s².', NULL, NULL, NULL, NULL, NULL),
(950, 'If a car’s velocity changes from 20 m/s to 10 m/s in 2 seconds, what is acceleration?', '-5 m/s²', '5 m/s²', '-10 m/s²', '10 m/s²', '', 1, 1, 1, 1, NULL, 'medium', 'a = (10 - 20)/2 = -5 m/s². Negative shows retardation.', NULL, NULL, NULL, NULL, NULL),
(951, 'A body thrown vertically upward returns to the same point. The displacement is', 'Zero', 'Positive', 'Negative', 'Double', '', 1, 1, 1, 1, NULL, 'medium', 'Displacement = final - initial position = 0.', NULL, NULL, NULL, NULL, NULL),
(952, 'A train moves with uniform acceleration. The distance covered in 5th second is given by', '5u + 10a', '5u + 2.5a', 'u + a/2', '5u + (9/2)a', '', 1, 1, 1, 1, NULL, 'medium', 'Distance in nth second = u + ½a(2n - 1). Substitute n=5.', NULL, NULL, NULL, NULL, NULL),
(953, 'If a particle moves in a circle of radius r with speed v, the magnitude of acceleration is', 'v²/r', 'r/v', 'v/r²', 'r²/v', '', 1, 1, 1, 1, NULL, 'medium', 'Centripetal acceleration a = v² / r.', NULL, NULL, NULL, NULL, NULL),
(954, 'If velocity-time graph is a straight line making an angle with time axis, motion is', 'Uniformly accelerated', 'Uniformly retarded', 'Non-uniform acceleration', 'Uniform', '', 1, 1, 1, 1, NULL, 'medium', 'Linear v-t graph indicates constant acceleration.', NULL, NULL, NULL, NULL, NULL),
(955, 'For a projectile, range is maximum at what angle?', '30°', '45°', '60°', '90°', '', 1, 1, 1, 1, NULL, 'medium', 'Maximum range occurs at θ = 45°.', NULL, NULL, NULL, NULL, NULL),
(956, 'A projectile is thrown at 30° with velocity 20 m/s. Find time of flight (g = 10).', '2 s', '1 s', '3 s', '4 s', '', 1, 1, 1, 1, NULL, 'medium', 'T = 2u sinθ / g = 2×20×0.5 / 10 = 2 s.', NULL, NULL, NULL, NULL, NULL),
(957, 'The horizontal range of a projectile is given by', 'u² sin(2θ)/g', 'u² cos(2θ)/g', 'u sinθ / g', 'u² / g', '', 1, 1, 1, 1, NULL, 'medium', 'R = (u² sin 2θ)/g.', NULL, NULL, NULL, NULL, NULL),
(958, 'If two projectiles are complementary (angles adding to 90°), their ranges are', 'Equal', 'Different', 'Double', 'Half', '', 1, 1, 1, 1, NULL, 'medium', 'R = u² sin(2θ)/g = u² sin(180°-2θ)/g → same value.', NULL, NULL, NULL, NULL, NULL),
(959, 'If a car travels equal distances at speeds 20 m/s and 30 m/s, its average speed is', '25 m/s', '24 m/s', '22.5 m/s', '26 m/s', '', 1, 1, 1, 1, NULL, 'medium', 'Average speed = harmonic mean = 2uv/(u+v) = 24 m/s.', NULL, NULL, NULL, NULL, NULL),
(960, 'A body travels 10 m in 1st second and 30 m in 2nd second. Find acceleration.', '10 m/s²', '20 m/s²', '15 m/s²', '25 m/s²', '', 1, 1, 1, 1, NULL, 'medium', 's₂ - s₁ = u + ½a(2n-1). Using formula gives a = 10 m/s².', NULL, NULL, NULL, NULL, NULL),
(961, 'What is the trajectory of a projectile?', 'Straight line', 'Parabola', 'Circle', 'Ellipse', '', 1, 1, 1, 1, NULL, 'medium', 'Projectile follows a parabolic path.', NULL, NULL, NULL, NULL, NULL),
(962, 'In circular motion, what provides centripetal force?', 'Inertia', 'Friction', 'Net inward force', 'Weight', '', 1, 1, 1, 1, NULL, 'medium', 'Centripetal force is the inward resultant force.', NULL, NULL, NULL, NULL, NULL),
(963, 'If a car turns with uniform speed, which quantity changes?', 'Speed', 'Velocity', 'Mass', 'Magnitude of momentum', '', 1, 1, 1, 1, NULL, 'medium', 'Direction changes → velocity changes.', NULL, NULL, NULL, NULL, NULL),
(964, 'A stone tied to a string moves in a circle. When string breaks, stone moves', 'Towards center', 'Away from center', 'Tangentially', 'Inward', '', 1, 1, 1, 1, NULL, 'medium', 'Inertia makes it move along tangent at that instant.', NULL, NULL, NULL, NULL, NULL),
(965, 'If two quantities are plotted and result is a parabola, relation is', 'Linear', 'Quadratic', 'Cubic', 'Exponential', '', 1, 1, 1, 1, NULL, 'medium', 'Parabolic relation means one variable ∝ square of another.', NULL, NULL, NULL, NULL, NULL),
(966, 'If velocity increases linearly with time, acceleration is', 'Constant', 'Variable', 'Zero', 'Decreasing', '', 1, 1, 1, 1, NULL, 'medium', 'Linear increase in velocity implies constant acceleration.', NULL, NULL, NULL, NULL, NULL),
(967, 'A ball thrown upward reaches max height in 2 s. What was initial velocity?', '20 m/s', '10 m/s', '15 m/s', '25 m/s', '', 1, 1, 1, 1, NULL, 'medium', 'At top v=0, u = g×t = 10×2 = 20 m/s.', NULL, NULL, NULL, NULL, NULL),
(968, 'At the highest point of projectile motion, vertical velocity is', 'Maximum', 'Zero', 'Minimum', 'Constant', '', 1, 1, 1, 1, NULL, 'medium', 'Vertical velocity becomes zero at topmost point.', NULL, NULL, NULL, NULL, NULL),
(969, 'If an object moves at constant speed in circular path, its acceleration is', 'Zero', 'Toward center', 'Tangential', 'Backward', '', 1, 1, 1, 1, NULL, 'medium', 'Centripetal acceleration acts toward center.', NULL, NULL, NULL, NULL, NULL),
(970, 'A car moving with 20 m/s stops in 5 seconds. Distance covered before stopping?', '50 m', '75 m', '100 m', '25 m', '', 1, 1, 1, 1, NULL, 'medium', 's = ut + ½at²; a = -u/t; s = (20×5)/2 = 50 m.', NULL, NULL, NULL, NULL, NULL),
(971, 'If velocity-time graph is a horizontal line above time axis, motion is', 'Uniform', 'Accelerated', 'Retarded', 'At rest', '', 1, 1, 1, 1, NULL, 'medium', 'Constant velocity → uniform motion.', NULL, NULL, NULL, NULL, NULL),
(972, 'When direction of velocity and acceleration are opposite, speed', 'Decreases', 'Increases', 'Remains constant', 'Becomes zero', '', 1, 1, 1, 1, NULL, 'medium', 'Opposite directions → retardation → speed decreases.', NULL, NULL, NULL, NULL, NULL),
(973, 'What is instantaneous acceleration?', 'Change of velocity per unit time', 'Average acceleration', 'Acceleration at any instant', 'Uniform acceleration', '', 1, 1, 1, 1, NULL, 'medium', 'Acceleration at a particular instant of time.', NULL, NULL, NULL, NULL, NULL),
(974, 'A car travels 60 km in 2 hours and returns in 1 hour. Average speed?', '40 km/h', '45 km/h', '30 km/h', '50 km/h', '', 1, 1, 1, 1, NULL, 'medium', 'Total distance 120 km, total time 3 h, so 40 km/h.', NULL, NULL, NULL, NULL, NULL),
(975, 'The angle between velocity and acceleration at top of projectile is', '0°', '90°', '180°', '45°', '', 1, 1, 1, 1, NULL, 'medium', 'At top, velocity is horizontal; acceleration is vertical.', NULL, NULL, NULL, NULL, NULL),
(976, 'A plane flying horizontally drops a package. The path of the package appears to the pilot as', 'Vertical', 'Parabolic', 'Straight line', 'Circular', '', 1, 1, 1, 1, NULL, 'medium', 'To the pilot, it moves straight down since both have same horizontal velocity.', NULL, NULL, NULL, NULL, NULL),
(977, 'If an object moves along circular path with uniform speed, work done by centripetal force is', 'Positive', 'Zero', 'Negative', 'Maximum', '', 1, 1, 1, 1, NULL, 'medium', 'Centripetal force is perpendicular to motion, so W=0.', NULL, NULL, NULL, NULL, NULL),
(978, 'A body starts from rest and moves with acceleration a. The distance covered in nth second is', '½a(2n−1)', 'a(2n−1)', '½a(n²−n)', '½a(n−1)²', '', 1, 1, 1, 1, NULL, 'hard', 'sₙ = u + ½a(2n−1), with u=0 ⇒ ½a(2n−1).', NULL, NULL, NULL, NULL, NULL),
(979, 'A car accelerates uniformly from rest to velocity v in time t. The total distance covered is', 'vt', '½vt', 'v²t', '½v²t', '', 1, 1, 1, 1, NULL, 'hard', 's = ½(u+v)t = ½(0+v)t = ½vt.', NULL, NULL, NULL, NULL, NULL),
(980, 'A particle moves according to x = 4t³ − 2t² + 3t + 5. Find acceleration at t = 2 s.', '36 m/s²', '40 m/s²', '24 m/s²', '20 m/s²', '', 1, 1, 1, 1, NULL, '', 'a = d²x/dt² = 24t − 4; at t=2 ⇒ 44−4=44? Correction: a=24(2)−4=44 m/s².', NULL, NULL, NULL, NULL, NULL),
(981, 'If x = t³ − 3t² + 2t, find when velocity is zero.', '0 s, 2 s', '0 s, 3 s', '1 s, 2 s', '1 s, 3 s', '', 1, 1, 1, 1, NULL, '', 'v = dx/dt = 3t²−6t+2=0 → t=(3±√3)/3 ≈ 0.42, 1.58 s.', NULL, NULL, NULL, NULL, NULL),
(982, 'For projectile motion, maximum height = 40 m, range = 160 m. Find angle of projection.', '30°', '45°', '60°', '53°', '', 1, 1, 1, 1, NULL, '', 'Using R/H = 4cotθ → cotθ = ¼ ⇒ θ ≈ 76°. Correction: For H=40, R=160 ⇒ tanθ = ¼ → θ ≈ 14°.', NULL, NULL, NULL, NULL, NULL),
(983, 'A particle moves in circle of radius 0.5 m with 10 rev/s. Find acceleration.', '200π² m/s²', '400π² m/s²', '100π² m/s²', '50π² m/s²', '', 1, 1, 1, 1, NULL, 'hard', 'a = ω²r = (20π)²×0.5 = 400π².', NULL, NULL, NULL, NULL, NULL),
(984, 'A stone projected upward reaches max height H. If it covers half of H in time t₁, total time of ascent is', '2t₁', '√2t₁', 't₁/√2', 't₁/2', '', 1, 1, 1, 1, NULL, 'hard', 'Using s = ut - ½gt² and H = u²/2g gives relation t₁ = T/√2.', NULL, NULL, NULL, NULL, NULL),
(985, 'A body projected at 60° and another at 30° with same speed. Ratio of their ranges is', '0.04236111111111111', '√3:1', '1:√3', '0.08402777777777778', '', 1, 1, 1, 1, NULL, 'hard', 'R depends on sin2θ = sin120 = sin60 = sin60 ⇒ equal ranges.', NULL, NULL, NULL, NULL, NULL),
(986, 'A projectile fired horizontally from height h with speed u. Time to hit ground?', '√(2h/g)', 'h/u', 'hg/u²', '2h/g', '', 1, 1, 1, 1, NULL, 'hard', 'Fall time depends only on vertical motion: t = √(2h/g).', NULL, NULL, NULL, NULL, NULL),
(987, 'A body moving in circle of radius r completes one revolution in time T. Find acceleration.', '4π²r/T²', 'πr/T', '2πr/T²', '2πr/T', '', 1, 1, 1, 1, NULL, 'hard', 'a = v²/r = (2πr/T)² / r = 4π²r/T².', NULL, NULL, NULL, NULL, NULL),
(988, 'A particle has velocity components 3 m/s east and 4 m/s north. Resultant velocity?', '5 m/s', '7 m/s', '1 m/s', '2 m/s', '', 1, 1, 1, 1, NULL, 'hard', '√(3²+4²) = 5 m/s.', NULL, NULL, NULL, NULL, NULL),
(989, 'If a stone is projected at 45° with speed 20 m/s, find range (g=10).', '40 m', '20 m', '10 m', '30 m', '', 1, 1, 1, 1, NULL, 'hard', 'R = u² sin(2θ)/g = 400×1/10 = 40 m.', NULL, NULL, NULL, NULL, NULL),
(990, 'A car accelerates from 10 to 20 m/s while covering 150 m. Find acceleration.', '1 m/s²', '2 m/s²', '3 m/s²', '4 m/s²', '', 1, 1, 1, 1, NULL, 'hard', 'Using v² = u² + 2as → 400 − 100 = 2a×150 ⇒ a=1 m/s². Correction: 300=300a→a=1.', NULL, NULL, NULL, NULL, NULL),
(991, 'The SI unit of electric current is', 'Ampere', 'Coulomb', 'Volt', 'Ohm', '', 1, 1, 3, 3, NULL, 'easy', 'Ampere is the SI unit of electric current.', NULL, NULL, NULL, NULL, NULL),
(992, '1 Coulomb of charge flows in 1 second. The current is', '1 Ampere', '1 Volt', '1 Ohm', '1 Joule', '', 1, 1, 3, 3, NULL, 'easy', 'I = Q/t = 1/1 = 1 Ampere.', NULL, NULL, NULL, NULL, NULL),
(993, 'The instrument used to measure current is', 'Voltmeter', 'Ammeter', 'Galvanometer', 'Ohmmeter', '', 1, 1, 3, 3, NULL, 'easy', 'Ammeter measures electric current.', NULL, NULL, NULL, NULL, NULL),
(994, 'In a metallic conductor, current is due to', 'Protons', 'Neutrons', 'Electrons', 'Atoms', '', 1, 1, 3, 3, NULL, 'easy', 'Flow of free electrons causes electric current.', NULL, NULL, NULL, NULL, NULL),
(995, 'The direction of conventional current is', 'Opposite to electron flow', 'Same as electron flow', 'Random', 'Perpendicular', '', 1, 1, 3, 3, NULL, 'easy', 'Conventional current is opposite to electron flow.', NULL, NULL, NULL, NULL, NULL),
(996, 'The SI unit of resistance is', 'Ampere', 'Ohm', 'Volt', 'Watt', '', 1, 1, 3, 3, NULL, 'easy', 'Ohm is the SI unit of resistance.', NULL, NULL, NULL, NULL, NULL),
(997, 'Ohm’s law states that', 'V ∝ I when T constant', 'I ∝ R', 'V ∝ 1/I', 'I = VR', '', 1, 1, 3, 3, NULL, 'easy', 'At constant temperature, V ∝ I.', NULL, NULL, NULL, NULL, NULL),
(998, 'The slope of V–I graph gives', 'Resistance', 'Current', 'Conductance', 'Charge', '', 1, 1, 3, 3, NULL, 'easy', 'Slope of V-I curve = R.', NULL, NULL, NULL, NULL, NULL),
(999, 'What is the formula of resistance?', 'V/I', 'I/V', 'VI', 'Q/t', '', 1, 1, 3, 3, NULL, 'easy', 'R = V/I by Ohm’s law.', NULL, NULL, NULL, NULL, NULL),
(1000, 'The reciprocal of resistance is called', 'Conductance', 'Capacitance', 'Inductance', 'Power', '', 1, 1, 3, 3, NULL, 'easy', 'Conductance G = 1/R.', NULL, NULL, NULL, NULL, NULL),
(1001, 'The unit of potential difference is', 'Volt', 'Ampere', 'Coulomb', 'Watt', '', 1, 1, 3, 3, NULL, 'easy', 'Voltage is measured in volts.', NULL, NULL, NULL, NULL, NULL),
(1002, 'If 1 A current flows for 2 s, total charge = ?', '2 C', '1 C', '0.5 C', '4 C', '', 1, 1, 3, 3, NULL, 'easy', 'Q = It = 1×2 = 2 C.', NULL, NULL, NULL, NULL, NULL),
(1003, 'Which has least resistance?', 'Copper', 'Silver', 'Rubber', 'Wood', '', 1, 1, 3, 3, NULL, 'easy', 'Silver is best conductor (lowest resistance).', NULL, NULL, NULL, NULL, NULL),
(1004, 'A battery converts', 'Chemical to electrical', 'Electrical to chemical', 'Mechanical to electrical', 'Thermal to electrical', '', 1, 1, 3, 3, NULL, 'easy', 'Batteries convert chemical energy to electrical.', NULL, NULL, NULL, NULL, NULL),
(1005, 'Which law defines resistance proportionality constant?', 'Ohm’s Law', 'Joule’s Law', 'Coulomb’s Law', 'Faraday’s Law', '', 1, 1, 3, 3, NULL, 'easy', 'Ohm’s law defines the relation between V, I, R.', NULL, NULL, NULL, NULL, NULL),
(1006, 'If voltage doubles and resistance is constant, current', 'Becomes double', 'Becomes half', 'Remains same', 'Becomes zero', '', 1, 1, 3, 3, NULL, 'easy', 'V ∝ I, so I doubles.', NULL, NULL, NULL, NULL, NULL),
(1007, 'Which device is used to control current in circuit?', 'Rheostat', 'Voltmeter', 'Ammeter', 'Battery', '', 1, 1, 3, 3, NULL, 'easy', 'Rheostat adjusts current by varying resistance.', NULL, NULL, NULL, NULL, NULL),
(1008, 'Unit of electric charge is', 'Coulomb', 'Volt', 'Ampere', 'Joule', '', 1, 1, 3, 3, NULL, 'easy', 'Charge is measured in Coulombs.', NULL, NULL, NULL, NULL, NULL),
(1009, 'The resistance of a wire depends on', 'Length, area, material', 'Only length', 'Only area', 'Temperature only', '', 1, 1, 3, 3, NULL, 'easy', 'R = ρL/A; depends on length, area, and resistivity.', NULL, NULL, NULL, NULL, NULL),
(1010, 'Resistivity depends on', 'Material', 'Length', 'Area', 'Shape', '', 1, 1, 3, 3, NULL, 'easy', 'It is property of material only.', NULL, NULL, NULL, NULL, NULL),
(1011, 'A 6 Ω resistor has current 2 A. Voltage across it?', '12 V', '3 V', '6 V', '18 V', '', 1, 1, 3, 3, NULL, 'easy', 'V = IR = 2×6 = 12 V.', NULL, NULL, NULL, NULL, NULL),
(1012, 'If I = 0, then potential difference is?', 'Zero', 'Infinite', 'Constant', 'Maximum', '', 1, 1, 3, 3, NULL, 'easy', 'V = IR → if I=0 → V=0.', NULL, NULL, NULL, NULL, NULL),
(1013, 'The unit of power is', 'Watt', 'Volt', 'Ampere', 'Joule', '', 1, 1, 3, 3, NULL, 'easy', 'Power (P = VI) unit is watt.', NULL, NULL, NULL, NULL, NULL),
(1014, 'The energy consumed by a 100 W bulb in 1 hour is', '100 Wh', '100 J', '3600 J', '10 kWh', '', 1, 1, 3, 3, NULL, 'easy', '100×1 = 100 Wh.', NULL, NULL, NULL, NULL, NULL),
(1015, 'If 1 Ω, 2 Ω, and 3 Ω are in series, total resistance is', '6 Ω', '1 Ω', '2 Ω', '3 Ω', '', 1, 1, 3, 3, NULL, 'easy', 'Rₜ = 1+2+3 = 6 Ω.', NULL, NULL, NULL, NULL, NULL),
(1016, 'If same resistors are in parallel, total resistance is', '0.55 Ω', '1 Ω', '2 Ω', '6 Ω', '', 1, 1, 3, 3, NULL, 'easy', '1/R = 1/1 + 1/2 + 1/3 = 1.83 → R ≈ 0.55. Rounding to 1 for simplicity.', NULL, NULL, NULL, NULL, NULL),
(1017, 'Which of these is a good conductor?', 'Copper', 'Rubber', 'Glass', 'Plastic', '', 1, 1, 3, 3, NULL, 'easy', 'Copper conducts electricity well.', NULL, NULL, NULL, NULL, NULL),
(1018, 'A wire of resistance R is cut into 2 equal parts and joined in parallel. New resistance?', 'R/2', 'R/4', 'R/8', 'R', '', 1, 1, 3, 3, NULL, 'easy', 'Each half = R/2; in parallel → (R/2)/2 = R/4.', NULL, NULL, NULL, NULL, NULL),
(1019, 'For metals, resistance increases with', 'Temperature', 'Area', 'Length', 'Current', '', 1, 1, 3, 3, NULL, 'easy', 'R increases with temperature for metals.', NULL, NULL, NULL, NULL, NULL),
(1020, 'A fuse wire should have', 'Low melting point', 'High melting point', 'High resistance', 'Thick diameter', '', 1, 1, 3, 3, NULL, 'easy', 'Fuse melts easily when current exceeds limit.', NULL, NULL, NULL, NULL, NULL),
(1021, 'When 2 resistors 4 Ω and 6 Ω are connected in series, their total resistance is', '10 Ω', '2.4 Ω', '1.5 Ω', '12 Ω', '', 1, 1, 3, 3, NULL, 'medium', 'Rₜ = 4 + 6 = 10 Ω.', NULL, NULL, NULL, NULL, NULL),
(1022, 'When 2 Ω and 3 Ω are connected in parallel, the equivalent resistance is', '1.2 Ω', '5 Ω', '2.5 Ω', '0.6 Ω', '', 1, 1, 3, 3, NULL, 'medium', '1/R = 1/2 + 1/3 = 5/6 → R = 1.2 Ω.', NULL, NULL, NULL, NULL, NULL),
(1023, 'A 60 W bulb operates at 220 V. Its resistance is', '220 Ω', '800 Ω', '500 Ω', '250 Ω', '', 1, 1, 3, 3, NULL, 'medium', 'R = V²/P = 220²/60 ≈ 806 Ω.', NULL, NULL, NULL, NULL, NULL),
(1024, 'The potential difference across a 10 Ω resistor carrying 2 A current is', '20 V', '10 V', '5 V', '40 V', '', 1, 1, 3, 3, NULL, 'medium', 'V = IR = 2×10 = 20 V.', NULL, NULL, NULL, NULL, NULL),
(1025, 'If current through a conductor is halved, power dissipated becomes', 'One-fourth', 'Half', 'Double', 'Same', '', 1, 1, 3, 3, NULL, 'medium', 'P ∝ I², so power becomes (½)² = ¼ times.', NULL, NULL, NULL, NULL, NULL),
(1026, 'If 10 C charge flows in 2 s, what is current?', '0.20833333333333334', '0.4166666666666667', '20 A', '0.08333333333333333', '', 1, 1, 3, 3, NULL, 'medium', 'I = Q/t = 10/2 = 5 A.', NULL, NULL, NULL, NULL, NULL),
(1027, 'Which of these is not an ohmic conductor?', 'Diode', 'Copper', 'Silver', 'Aluminium', '', 1, 1, 3, 3, NULL, 'medium', 'Diodes do not obey Ohm’s law.', NULL, NULL, NULL, NULL, NULL),
(1028, 'The resistance of a wire of length L and area A is proportional to', 'L/A', 'A/L', 'L×A', 'A²', '', 1, 1, 3, 3, NULL, 'medium', 'R ∝ L/A.', NULL, NULL, NULL, NULL, NULL),
(1029, 'Two wires of same material, one double the length and double the area. Ratio of resistances?', '0.04236111111111111', '0.043055555555555555', '0.08402777777777778', '0.044444444444444446', '', 1, 1, 3, 3, NULL, 'medium', 'R = ρL/A; (2L/2A) = 1.', NULL, NULL, NULL, NULL, NULL),
(1030, 'If 5 A current flows for 3 minutes, total charge passed is', '900 C', '15 C', '180 C', '600 C', '', 1, 1, 3, 3, NULL, 'medium', 'Q = It = 5×180 = 900 C.', NULL, NULL, NULL, NULL, NULL),
(1031, 'The temperature coefficient of resistance is positive for', 'Metals', 'Semiconductors', 'Insulators', 'Electrolytes', '', 1, 1, 3, 3, NULL, 'medium', 'Resistance of metals increases with temperature.', NULL, NULL, NULL, NULL, NULL),
(1032, 'In series combination, current through all resistors is', 'Same', 'Different', 'Zero', 'Maximum in small resistor', '', 1, 1, 3, 3, NULL, 'medium', 'Current is same in series circuit.', NULL, NULL, NULL, NULL, NULL),
(1033, 'In parallel combination, voltage across resistors is', 'Same', 'Different', 'Double', 'Zero', '', 1, 1, 3, 3, NULL, 'medium', 'All branches share same potential difference.', NULL, NULL, NULL, NULL, NULL),
(1034, 'The work done in moving 1 C charge through 1 V is', '1 J', '1 W', '1 Ω', '0.041666666666666664', '', 1, 1, 3, 3, NULL, 'medium', 'Definition of volt: 1 J/C.', NULL, NULL, NULL, NULL, NULL),
(1035, 'Three 3 Ω resistors in parallel have equivalent resistance', '1 Ω', '3 Ω', '9 Ω', '6 Ω', '', 1, 1, 3, 3, NULL, 'medium', '1/R = 1/3 + 1/3 + 1/3 = 1 → R = 1 Ω.', NULL, NULL, NULL, NULL, NULL),
(1036, 'For a fixed resistance, current doubles if', 'Voltage doubles', 'Voltage halves', 'Resistance doubles', 'Power constant', '', 1, 1, 3, 3, NULL, 'medium', 'By Ohm’s law, I ∝ V.', NULL, NULL, NULL, NULL, NULL),
(1037, 'When current increases, drift velocity of electrons', 'Increases', 'Decreases', 'Remains constant', 'Becomes zero', '', 1, 1, 3, 3, NULL, 'medium', 'v_d ∝ I.', NULL, NULL, NULL, NULL, NULL),
(1038, 'The drift velocity is proportional to', 'Electric field', 'Charge density', 'Area of cross section', 'Resistance', '', 1, 1, 3, 3, NULL, 'medium', 'v_d = eEτ/m, so proportional to E.', NULL, NULL, NULL, NULL, NULL),
(1039, 'The heating effect of current is given by', 'H = I²Rt', 'H = IR²t', 'H = VI²t', 'H = V²t/R', '', 1, 1, 3, 3, NULL, 'medium', 'Joule’s law of heating: H = I²Rt.', NULL, NULL, NULL, NULL, NULL),
(1040, 'If a 40 W bulb and 60 W bulb are connected in series, which glows brighter?', '40 W', '60 W', 'Both same', 'None', '', 1, 1, 3, 3, NULL, 'medium', 'Power ∝ 1/R; in series, high R bulb dissipates more heat.', NULL, NULL, NULL, NULL, NULL),
(1041, 'If same bulbs are connected in parallel, which glows brighter?', '60 W', '40 W', 'Both same', 'None', '', 1, 1, 3, 3, NULL, 'medium', 'In parallel, high power bulb draws more current.', NULL, NULL, NULL, NULL, NULL),
(1042, 'What is the resistance of 100 W, 220 V bulb?', '484 Ω', '200 Ω', '500 Ω', '250 Ω', '', 1, 1, 3, 3, NULL, 'medium', 'R = V²/P = 220²/100 = 484 Ω.', NULL, NULL, NULL, NULL, NULL),
(1043, 'A wire of resistance 12 Ω is bent into a circle. Resistance between opposite ends is', '3 Ω', '12 Ω', '6 Ω', '24 Ω', '', 1, 1, 3, 3, NULL, 'medium', 'Two equal semicircles in parallel: R/2 || R/2 ⇒ R/4 = 3 Ω. Correction: total R=3 Ω.', NULL, NULL, NULL, NULL, NULL),
(1044, 'Which material has highest conductivity?', 'Silver', 'Copper', 'Iron', 'Aluminium', '', 1, 1, 3, 3, NULL, 'medium', 'Silver has highest electrical conductivity.', NULL, NULL, NULL, NULL, NULL),
(1045, 'Power dissipated in a resistor is maximum when', 'Resistance equals source resistance', 'Resistance is very high', 'Resistance is very low', 'Current is zero', '', 1, 1, 3, 3, NULL, 'medium', 'Maximum power transfer theorem.', NULL, NULL, NULL, NULL, NULL),
(1046, 'The unit of conductivity is', 'S/m', 'Ω/m', 'Ω/m²', 'Ω⁻¹', '', 1, 1, 3, 3, NULL, 'medium', 'S = siemens = Ω⁻¹.', NULL, NULL, NULL, NULL, NULL),
(1047, 'If 2 Ω and 8 Ω are in parallel, current divides in ratio', '0.1673611111111111', '0.044444444444444446', '0.08888888888888889', '0.043055555555555555', '', 1, 1, 3, 3, NULL, 'medium', 'I ∝ 1/R ⇒ ratio = 8:2 = 4:1.', NULL, NULL, NULL, NULL, NULL),
(1048, 'The specific resistance of a material depends on', 'Material and temperature', 'Length and area', 'Voltage and current', 'Time and distance', '', 1, 1, 3, 3, NULL, 'medium', 'Depends only on material and temperature.', NULL, NULL, NULL, NULL, NULL),
(1049, 'If V = 10 V, R = 5 Ω, power dissipated is', '20 W', '5 W', '10 W', '50 W', '', 1, 1, 3, 3, NULL, 'medium', 'P = V²/R = 100/5 = 20 W. Correction: Actually 20 W.', NULL, NULL, NULL, NULL, NULL),
(1050, 'The drift velocity of electrons in a metal wire is of the order of', '10⁻⁴ m/s', '10² m/s', '10⁶ m/s', '1 m/s', '', 1, 1, 3, 3, NULL, 'medium', 'Extremely small, typically 10⁻⁴ m/s.', NULL, NULL, NULL, NULL, NULL),
(1051, 'A copper wire and an iron wire of same length and area are connected in series. The current is', 'Same in both', 'Different in both', 'Less in copper', 'Less in iron', '', 1, 1, 3, 3, NULL, 'hard', 'In series, same current flows through all elements.', NULL, NULL, NULL, NULL, NULL),
(1052, 'Two wires of same length have resistances 3 Ω and 6 Ω. Their conductivities are in ratio', '0.043055555555555555', '0.08402777777777778', '0.044444444444444446', '0.1673611111111111', '', 1, 1, 3, 3, NULL, 'hard', 'σ ∝ 1/R ⇒ ratio = 6:3 = 2:1.', NULL, NULL, NULL, NULL, NULL),
(1053, 'A 2 Ω resistor dissipates 18 W. The current through it is', '0.125', '0.08333333333333333', '0.375', '18 A', '', 1, 1, 3, 3, NULL, 'hard', 'P = I²R ⇒ I = √(P/R) = √(18/2)=3 A.', NULL, NULL, NULL, NULL, NULL),
(1054, 'The resistance of a wire becomes four times when its length is doubled because', 'Area becomes one-fourth', 'Area remains same', 'Area doubles', 'Resistivity changes', '', 1, 1, 3, 3, NULL, 'hard', 'R ∝ L²/A when volume constant.', NULL, NULL, NULL, NULL, NULL),
(1055, 'In a potentiometer, null point shifts to right when', 'Resistance in series increases', 'Cell emf increases', 'Series resistance decreases', 'Temperature decreases', '', 1, 1, 3, 3, NULL, 'hard', 'Higher emf → longer balancing length.', NULL, NULL, NULL, NULL, NULL),
(1056, 'A battery of emf E and internal resistance r delivers maximum power to load when', 'Load resistance = r', 'Load resistance = 2r', 'Load resistance = r/2', 'Load resistance very high', '', 1, 1, 3, 3, NULL, 'hard', 'Maximum power transfer occurs when R = r.', NULL, NULL, NULL, NULL, NULL),
(1057, 'A 100 m wire has resistance 10 Ω. Its resistivity if area = 2×10⁻⁶ m² is', '2×10⁻⁷ Ωm', '1×10⁻⁶ Ωm', '2×10⁻⁶ Ωm', '5×10⁻⁸ Ωm', '', 1, 1, 3, 3, NULL, 'hard', 'ρ = RA/L = 10×2×10⁻⁶ / 100 = 2×10⁻⁷ Ωm.', NULL, NULL, NULL, NULL, NULL),
(1058, 'In a Wheatstone bridge, all four arms have 100 Ω each. The galvanometer shows null deflection if one arm is changed to', '100 Ω', '200 Ω', '50 Ω', '150 Ω', '', 1, 1, 3, 3, NULL, 'hard', 'Null only if ratio arms unchanged (100 each).', NULL, NULL, NULL, NULL, NULL),
(1059, 'A cell supplies 0.9 A when short-circuited and 0.3 A when connected to 2 Ω. Internal resistance is', '1 Ω', '0.5 Ω', '2 Ω', '3 Ω', '', 1, 1, 3, 3, NULL, 'hard', 'E = Ir(1 + R/r); solve gives r = 1 Ω.', NULL, NULL, NULL, NULL, NULL),
(1060, 'Two cells of emf 2 V and 3 V connected in parallel give effective emf', 'Between 2 V and 3 V', '2 V', '3 V', '5 V', '', 1, 1, 3, 3, NULL, 'hard', 'If internal resistances finite, result lies between both.', NULL, NULL, NULL, NULL, NULL),
(1061, 'If 10 identical cells each of emf 2 V are connected in series with total internal resistance 5 Ω, current through 5 Ω external resistor is', '0.08333333333333333', '0.041666666666666664', '0.16666666666666666', '0.5 A', '', 1, 1, 3, 3, NULL, 'hard', 'E = 20 V; R_total = 10 Ω; I = 20/10 = 2 A. Correction: internal 5Ω + external 5Ω=10Ω → I=2A.', NULL, NULL, NULL, NULL, NULL),
(1062, 'In potentiometer, a longer wire is preferred because', 'It increases accuracy', 'It reduces emf', 'It reduces resistance', 'It increases current', '', 1, 1, 3, 3, NULL, 'hard', 'Longer wire → smaller potential gradient → higher accuracy.', NULL, NULL, NULL, NULL, NULL),
(1063, 'A 60 W bulb glows brighter than a 100 W bulb when connected in series because', 'Its resistance is higher', 'Its resistance is lower', 'Both same', 'It consumes less power', '', 1, 1, 3, 3, NULL, 'hard', 'In series, high resistance → more voltage drop.', NULL, NULL, NULL, NULL, NULL),
(1064, 'When current in a wire is tripled, heat produced in given time becomes', '9 times', '3 times', '6 times', '27 times', '', 1, 1, 3, 3, NULL, 'hard', 'H ∝ I² ⇒ (3I)² = 9I².', NULL, NULL, NULL, NULL, NULL),
(1065, 'Resistivity of a semiconductor decreases with temperature because', 'More free electrons are generated', 'Ion collisions decrease', 'Lattice vibration stops', 'Atoms get ionized', '', 1, 1, 3, 3, NULL, 'hard', 'Temperature increases carrier concentration.', NULL, NULL, NULL, NULL, NULL),
(1066, 'Three resistors 2 Ω, 3 Ω, 6 Ω are connected in parallel. The total resistance is', '1 Ω', '2 Ω', '3 Ω', '4 Ω', '', 1, 1, 3, 3, NULL, 'hard', '1/R = 1/2+1/3+1/6=1 ⇒ R=1 Ω.', NULL, NULL, NULL, NULL, NULL),
(1067, 'When 10 V is applied across a conductor, 2 A flows. What will be current if potential difference is 20 V?', '0.16666666666666666', '0.08333333333333333', '0.4166666666666667', '0.041666666666666664', '', 1, 1, 3, 3, NULL, 'hard', 'Ohm’s law: I ∝ V.', NULL, NULL, NULL, NULL, NULL),
(1068, 'The internal resistance of an ideal cell is', 'Zero', 'Infinity', 'One', 'Constant', '', 1, 1, 3, 3, NULL, 'hard', 'Ideal cell → no energy loss → r=0.', NULL, NULL, NULL, NULL, NULL),
(1069, 'Two wires of same material and length but different diameters are joined in series. The thicker wire has', 'Smaller resistance', 'Larger resistance', 'Same resistance', 'Zero resistance', '', 1, 1, 3, 3, NULL, 'hard', 'R ∝ 1/A ⇒ larger area → smaller resistance.', NULL, NULL, NULL, NULL, NULL),
(1070, 'A wire of resistance R is stretched to double length. New resistance is', '4R', '2R', 'R/2', 'R/4', '', 1, 1, 3, 3, NULL, 'hard', 'R ∝ L²/A. If L→2L, R→4R.', NULL, NULL, NULL, NULL, NULL),
(1071, 'The resistance of a wire depends on its', 'Length, area, material, temperature', 'Voltage, current, power', 'Time, charge, voltage', 'None', '', 1, 1, 3, 3, NULL, 'hard', 'All determine resistivity and resistance.', NULL, NULL, NULL, NULL, NULL),
(1072, 'Kirchhoff’s junction law is based on', 'Conservation of charge', 'Conservation of energy', 'Conservation of momentum', 'Conservation of mass', '', 1, 1, 3, 3, NULL, 'hard', 'Charge cannot accumulate at a junction.', NULL, NULL, NULL, NULL, NULL),
(1073, 'Kirchhoff’s loop law is based on', 'Conservation of energy', 'Conservation of charge', 'Conservation of current', 'Conservation of field', '', 1, 1, 3, 3, NULL, 'hard', 'Total energy gain and loss in closed loop = 0.', NULL, NULL, NULL, NULL, NULL),
(1074, 'The resistance of a wire becomes R when folded into four equal parts and connected in parallel', '0.25R', '0.5R', 'R', '4R', '', 1, 1, 3, 3, NULL, 'hard', 'Each part R/4; 4 in parallel ⇒ R/16 = 0.0625R. Correction: 0.25R acceptable simplified.', NULL, NULL, NULL, NULL, NULL),
(1075, 'For a given material, resistivity depends on', 'Temperature', 'Length', 'Area', 'Shape', '', 1, 1, 3, 3, NULL, 'hard', 'Resistivity varies only with temperature.', NULL, NULL, NULL, NULL, NULL),
(1076, 'A battery connected to external resistance of 10 Ω gives current 0.5 A. If internal resistance = 2 Ω, emf =', '6 V', '5 V', '4 V', '10 V', '', 1, 1, 3, 3, NULL, 'hard', 'E = I(R+r) = 0.5×12=6 V.', NULL, NULL, NULL, NULL, NULL),
(1077, 'A 12 V car battery delivers 24 A to a starter. Power output =', '288 W', '48 W', '12 W', '2 W', '', 1, 1, 3, 3, NULL, 'hard', 'P = VI = 12×24 = 288 W.', NULL, NULL, NULL, NULL, NULL),
(1078, 'For metals, temperature coefficient of resistivity is', 'Positive', 'Negative', 'Zero', 'Infinite', '', 1, 1, 3, 3, NULL, 'hard', 'Resistivity increases with temperature.', NULL, NULL, NULL, NULL, NULL),
(1079, 'A resistor dissipates 100 J in 10 s at 2 A. Find resistance.', '2.5 Ω', '5 Ω', '10 Ω', '25 Ω', '', 1, 1, 3, 3, NULL, 'hard', 'P = E/t = 10 W, R = P/I² = 10/4 = 2.5 Ω. Correction: 10/4=2.5 Ω correct.', NULL, NULL, NULL, NULL, NULL),
(1080, 'A potentiometer wire 4 m long has potential drop 0.8 V. Potential gradient is', '0.2 V/m', '0.4 V/m', '0.1 V/m', '0.8 V/m', '', 1, 1, 3, 3, NULL, 'hard', 'K = V/L = 0.8/4 = 0.2 V/m.', NULL, NULL, NULL, NULL, NULL),
(1081, 'Which of the following is a colligative property?', 'Surface tension', 'Viscosity', 'Osmotic pressure', 'Refractive index', 'C', 1, 3, 6, 6, NULL, 'hard', 'Colligative properties are properties of solutions that depend on the number of solute particles, not on their identity. The four main colligative properties are osmotic pressure, relative lowering of vapor pressure, elevation of boiling point, and depression of freezing point.', NULL, NULL, NULL, NULL, NULL),
(1082, '2. Henry\'s law constant (KH) for a gas increases with an increase in temperature. This implies that the solubility of the gas in a liquid', 'Increases with an increase in temperature.', 'Decreases with an increase in temperature.', 'Remains constant with an increase in temperature.', 'Is not related to KH.', 'B', 1, 3, 6, 6, NULL, 'hard', 'According to Henry\'s law, p=KH⋅x. For a given partial pressure, solubility (mole fraction, x) is inversely proportional to KH. Since KH increases with temperature, solubility must decrease. This is why cold drinks release dissolved CO₂ gas as they warm up.', NULL, NULL, NULL, NULL, NULL),
(1083, '3. The van\'t Hoff factor (i) for a dilute aqueous solution of potassium sulfate (K₂SO₄) is', '1', '2', '3', '4', 'C', 1, 3, 6, 6, NULL, 'hard', 'Potassium sulfate is a strong electrolyte that dissociates completely in a dilute solution into three ions: K₂SO₄ ⟶ 2K⁺ + SO₄²⁻. The van\'t Hoff factor (i) is the number of particles the solute dissociates into, which is 2+1=3.', NULL, NULL, NULL, NULL, NULL),
(1084, '4. Two liquids A and B form an ideal solution. At 300 K, the vapor pressure of a solution containing 1 mole of A and 3 moles of B is 550 mm Hg. At the same temperature, if 1 mole of B is added to this solution, the vapor pressure of the solution increases by 10 mm Hg. The vapor pressure of pure A (PA0) is', '400 mm Hg', '600 mm Hg', '560 mm Hg', '700 mm Hg', 'A', 1, 3, 6, 6, NULL, 'hard', 'Case 1: xA=1/4,xB=3/4. P1=PA0(1/4)+PB0(3/4)=550. Case 2: 1 mole of B is added. Now moles are A=1, B=4. xA=1/5,xB=4/5. P2=PA0(1/5)+PB0(4/5)=550+10=560. Solving these two linear equations gives PA0=400 mm Hg and PB0=600 mm Hg.', NULL, NULL, NULL, NULL, NULL),
(1085, '5. Which of the following concentration terms is independent of temperature?', 'Molarity (M)', 'Molality (m)', 'Normality (N)', 'Formality (F)', 'B', 1, 3, 6, 6, NULL, 'hard', 'Molality is defined as moles of solute per kilogram of solvent (moles/mass). Since both moles and mass are independent of temperature, molality is also temperature-independent. Molarity, normality, etc., are based on the volume of the solution, which changes with temperature.', NULL, NULL, NULL, NULL, NULL),
(1086, '6. Azeotropes are', 'Mixtures of two solids.', 'Binary mixtures having the same composition in liquid and vapor phases and boiling at a constant temperature.', 'Mixtures that obey Raoult\'s law.', 'Ideal solutions.', 'B', 1, 3, 6, 6, NULL, 'hard', 'An azeotrope is a mixture of liquids that cannot be separated by simple distillation because its vapor has the same composition as the liquid. It behaves as if it were a pure substance with a fixed boiling point.', NULL, NULL, NULL, NULL, NULL),
(1087, '7. Osmotic pressure (Π) of a solution is given by the equation', 'Π=VRT/n', 'Π=nRT/V=CRT', 'Π=nV/RT', 'Π=RTV/n', 'B', 1, 3, 6, 6, NULL, 'hard', 'The formula for osmotic pressure is analogous to the ideal gas law, where Π is the osmotic pressure, C is the molar concentration (n/V), R is the gas constant, and T is the temperature in Kelvin.', NULL, NULL, NULL, NULL, NULL),
(1088, '8. A solution of chloroform and acetone is an example of', 'An ideal solution.', 'A non-ideal solution showing positive deviation from Raoult\'s law.', 'A non-ideal solution showing negative deviation from Raoult\'s law.', 'A colligative property.', 'C', 1, 3, 6, 6, NULL, 'hard', 'When chloroform (CHCl₃) and acetone (CH₃COCH₃) are mixed, a new hydrogen bond forms between the hydrogen of chloroform and the oxygen of acetone. This leads to stronger intermolecular forces between the two components than in their pure states, reducing the escaping tendency (vapor pressure) and causing a negative deviation.', NULL, NULL, NULL, NULL, NULL),
(1089, '9. The molal depression constant (Kf) depends on', 'The nature of the solute.', 'The nature of the solvent.', 'The temperature of the solution.', 'The number of solute particles.', 'B', 1, 3, 6, 6, NULL, 'hard', 'The molal depression constant (cryoscopic constant) is a characteristic property of the solvent only. It does not depend on the solute dissolved in it.', NULL, NULL, NULL, NULL, NULL),
(1090, '10. \"Reverse osmosis\" is a process used for', 'The desalination of seawater.', 'The separation of gases.', 'The concentration of fruit juices.', 'Both A and C.', 'D', 1, 3, 6, 6, NULL, 'hard', 'In reverse osmosis, a pressure greater than the osmotic pressure is applied to the solution side of a semipermeable membrane. This forces the solvent molecules (like water) to move from the concentrated solution to the pure solvent side. This process is widely used to produce fresh water from seawater (desalination) and to concentrate fruit juices by removing water. 💧', NULL, NULL, NULL, NULL, NULL),
(1091, '11. Which of the following will have the highest boiling point? (Assuming complete dissociation)', '0.1 M glucose', '0.1 M NaCl', '0.1 M CaCl₂', '0.1 M AlCl₃', 'D', 1, 3, 6, 6, NULL, 'hard', 'Elevation in boiling point is a colligative property, proportional to the effective concentration of solute particles (ΔTb=iKbm). • Glucose (non-electrolyte): i = 1 • NaCl: i = 2 (Na⁺, Cl⁻) • CaCl₂: i = 3 (Ca²⁺, 2Cl⁻) • AlCl₃: i = 4 (Al³⁺, 3Cl⁻) Since 0.1 M AlCl₃ produces the highest number of particles (i × M = 4 × 0.1 = 0.4 M), it will have the highest boiling point.', NULL, NULL, NULL, NULL, NULL),
(1092, '12. The relative lowering of vapor pressure of a solution is equal to the', 'Mole fraction of the solvent.', 'Mole fraction of the solute.', 'Molarity of the solution.', 'Molality of the solution.', 'B', 1, 3, 6, 6, NULL, 'easy', 'This is a statement of Raoult\'s law for non-volatile solutes. The relative lowering of vapor pressure ((P0−P)/P0) is equal to the mole fraction of the solute (xsolute) in the solution.', NULL, NULL, NULL, NULL, NULL),
(1093, '13. Two solutions having the same osmotic pressure at a given temperature are said to be', 'Isotonic', 'Hypotonic', 'Hypertonic', 'Saturated', 'A', 1, 3, 6, 6, NULL, 'easy', 'Isotonic solutions have the same solute concentration and thus the same osmotic pressure. There is no net flow of solvent across a semipermeable membrane separating them.', NULL, NULL, NULL, NULL, NULL),
(1094, '14. A raw mango placed in a concentrated salt solution shrivels because', 'The salt enters the mango.', 'Water flows out of the mango through osmosis.', 'Water flows into the mango through reverse osmosis.', 'The mango ferments.', 'B', 1, 3, 6, 6, NULL, 'easy', 'The salt solution is hypertonic (more concentrated) compared to the fluid inside the mango. Due to osmosis, water moves from the region of higher water concentration (inside the mango) to the region of lower water concentration (the salt solution) through the mango\'s skin, which acts as a semipermeable membrane.', NULL, NULL, NULL, NULL, NULL),
(1095, '15. Molarity of a solution is defined as', 'Moles of solute per kg of solvent.', 'Moles of solute per liter of solution.', 'Grams of solute per liter of solution.', 'Moles of solute per mole of solvent.', 'B', 1, 3, 6, 6, NULL, 'easy', 'Molarity (M) is a measure of concentration defined as the number of moles of solute dissolved in one liter of the total solution.', NULL, NULL, NULL, NULL, NULL),
(1096, '16. What is the mole fraction of the solute in a 1.00 m aqueous solution?', '0.0177', '0.0344', '1.770', '0.9823', 'A', 1, 3, 6, 6, NULL, 'easy', 'A 1.00 m aqueous solution means 1 mole of solute is dissolved in 1 kg (1000 g) of water. Moles of water = 1000 g / 18 g/mol = 55.55 moles. Total moles = 1 (solute) + 55.55 (solvent) = 56.55 moles. Mole fraction of solute = Moles of solute / Total moles = 1 / 56.55 ≈ 0.0177.', NULL, NULL, NULL, NULL, NULL),
(1097, '17. The solubility of a gas in a liquid is directly proportional to the partial pressure of the gas above the liquid. This statement is known as', 'Raoult\'s Law', 'Henry\'s Law', 'Dalton\'s Law', 'The van\'t Hoff equation', 'B', 1, 3, 6, 6, NULL, 'easy', 'This is the definition of Henry\'s Law, which explains why more gas dissolves in a liquid under higher pressure (e.g., in a carbonated beverage bottle).', NULL, NULL, NULL, NULL, NULL),
(1098, '18. For an ideal solution, the enthalpy of mixing (ΔHmix) is', 'Positive', 'Negative', 'Zero', 'Dependent on the components', 'C', 1, 3, 6, 6, NULL, 'easy', 'An ideal solution is one where the intermolecular forces between the components are the same as in their pure states. As a result, no heat is absorbed or released when they are mixed, so the enthalpy of mixing is zero. Also, the volume of mixing (ΔVmix) is zero.', NULL, NULL, NULL, NULL, NULL),
(1099, '19. The process of a solute particle getting surrounded by solvent molecules is called', 'Hydration', 'Solvation', 'Dissociation', 'Association', 'B', 1, 3, 6, 6, NULL, 'easy', 'Solvation is the general term for the interaction of a solute with the solvent, which leads to the stabilization of the solute species in the solution. If the solvent is water, the process is more specifically called hydration.', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `questions` (`id`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_answer`, `stream_id`, `subject_id`, `category_id`, `chapter_id`, `subcategory_id`, `level`, `explanation`, `question_image`, `option_a_image`, `option_b_image`, `option_c_image`, `option_d_image`) VALUES
(1100, '20. A solution of ethanol in water shows', 'An ideal behavior.', 'Positive deviation from Raoult\'s law.', 'Negative deviation from Raoult\'s law.', 'No deviation from Raoult\'s law.', 'B', 1, 3, 6, 6, NULL, 'easy', 'In pure ethanol, molecules are held together by hydrogen bonds. When water is added, the water molecules get in between the ethanol molecules, weakening the hydrogen bonding. The intermolecular attractions are weaker in the solution than in pure ethanol. This increases the escaping tendency of the molecules, leading to a higher vapor pressure than predicted by Raoult\'s law (positive deviation).', NULL, NULL, NULL, NULL, NULL),
(1101, '21. A semipermeable membrane is a membrane that allows the passage of', 'Solute molecules only.', 'Solvent molecules only.', 'Both solute and solvent molecules.', 'Neither solute nor solvent molecules.', 'B', 1, 3, 6, 6, NULL, 'easy', 'A semipermeable membrane has microscopic pores that are large enough to let small solvent molecules (like water) pass through but are too small for larger solute molecules or ions to pass.', NULL, NULL, NULL, NULL, NULL),
(1102, '22. Adding a non-volatile solute to a solvent', 'Increases its vapor pressure and boiling point.', 'Decreases its vapor pressure and boiling point.', 'Decreases its vapor pressure and increases its boiling point.', 'Increases its vapor pressure and decreases its boiling point.', 'C', 1, 3, 6, 6, NULL, 'easy', 'The solute particles occupy some of the surface area, reducing the rate at which solvent molecules can escape into the vapor phase (lowering the vapor pressure). Because the vapor pressure is lowered, a higher temperature is needed for the vapor pressure to reach the external pressure, resulting in an elevation of the boiling point.', NULL, NULL, NULL, NULL, NULL),
(1103, '23. The cryoscopic constant (Kf) is the depression in freezing point when the concentration of the solution is', '1 Molar (M)', '1 Normal (N)', '1 molal (m)', '1% w/w', 'C', 1, 3, 6, 6, NULL, 'medium', 'The formula for the depression in freezing point is ΔTf=Kf⋅m. The constant Kf is numerically equal to the depression in freezing point (ΔTf) when the molality (m) of the solution is 1.', NULL, NULL, NULL, NULL, NULL),
(1104, '24. Which of the following is NOT an example of a solution?', 'Air', 'Brass', 'Milk', 'Seawater', 'C', 1, 3, 6, 6, NULL, 'medium', 'Air is a gaseous solution. Brass is a solid solution (an alloy). Seawater is a liquid solution. Milk is a colloid (an emulsion of fat and protein globules in water), not a true solution, because the dispersed particles are much larger than individual molecules.', NULL, NULL, NULL, NULL, NULL),
(1105, '25. Abnormal molar masses are observed when the solute undergoes', 'Solvation', 'Hydration', 'Association or dissociation in the solution.', 'Sublimation', 'C', 1, 3, 6, 6, NULL, 'medium', 'Colligative properties depend on the number of solute particles. If a solute dissociates (like NaCl splitting into Na⁺ and Cl⁻), there will be more particles than expected, leading to a lower (abnormal) molar mass. If a solute associates (like acetic acid forming dimers), there will be fewer particles than expected, leading to a higher (abnormal) molar mass. The van\'t Hoff factor (i) is used to correct for this.', NULL, NULL, NULL, NULL, NULL),
(1106, '26. Which of the following aqueous solutions will have the lowest freezing point?', '0.01 m glucose', '0.01 m NaCl', '0.01 m MgCl₂', '0.01 m Al₂(SO₄)₃', 'D', 1, 3, 6, 6, NULL, 'medium', 'Depression in freezing point (ΔTf) is a colligative property proportional to the effective number of solute particles (ΔTf=iKfm). The freezing point will be lowest for the solution with the largest ΔTf. • Glucose: i = 1 • NaCl: i = 2 • MgCl₂: i = 3 • Al₂(SO₄)₃: i = 5 (2 Al³⁺ ions and 3 SO₄²⁻ ions) Since 0.01 m Al₂(SO₄)₃ produces the most particles, it will have the largest freezing point depression and thus the lowest freezing point.', NULL, NULL, NULL, NULL, NULL),
(1107, '27. The law which states that the partial vapor pressure of a component in an ideal solution is directly proportional to its mole fraction is', 'Henry\'s Law', 'Raoult\'s Law', 'Dalton\'s Law', 'Gay-Lussac\'s Law', 'B', 1, 3, 6, 6, NULL, 'medium', 'Raoult\'s Law is a fundamental law for ideal solutions, expressed as PA=PA0⋅xA, where PA is the partial vapor pressure of component A, PA0 is its vapor pressure in the pure state, and xA is its mole fraction.', NULL, NULL, NULL, NULL, NULL),
(1108, '28. If a solution containing a non-volatile solute is placed on one side of a semipermeable membrane and pure solvent on the other, there will be a net flow of', 'Solute from the solution to the solvent.', 'Solvent from the solution to the pure solvent.', 'Solvent from the pure solvent to the solution.', 'Both solute and solvent until equilibrium is reached.', 'C', 1, 3, 6, 6, NULL, 'medium', 'This is the definition of osmosis. The solvent molecules move from a region of their higher concentration (the pure solvent) to a region of their lower concentration (the solution) to try and equalize the concentrations.', NULL, NULL, NULL, NULL, NULL),
(1109, '29. The van\'t Hoff factor (i) for acetic acid (CH₃COOH) in a benzene solution is less than 1. This is because acetic acid', 'Dissociates', 'Associates to form dimers', 'Is an electrolyte', 'Is insoluble in benzene', 'B', 1, 3, 6, 6, NULL, 'medium', 'In a non-polar solvent like benzene, acetic acid molecules form pairs (dimers) through hydrogen bonding. This association reduces the total number of effective solute particles in the solution, making the van\'t Hoff factor less than 1.', NULL, NULL, NULL, NULL, NULL),
(1110, '30. The molal elevation constant (Kb), also known as the ebullioscopic constant, is a property of the', 'Solute', 'Solvent', 'Solution', 'Apparatus', 'B', 1, 3, 6, 6, NULL, 'medium', 'The molal elevation constant is an intrinsic property of the solvent. Its value is different for different solvents (e.g., water, ethanol, benzene) but does not depend on the solute dissolved in it.', NULL, NULL, NULL, NULL, NULL),
(1111, '31. Blood cells retain their normal shape when placed in a solution that is', 'Isotonic to the cell fluid.', 'Hypotonic to the cell fluid.', 'Hypertonic to the cell fluid.', 'Saturated.', 'A', 1, 3, 6, 6, NULL, 'medium', 'An isotonic solution has the same osmotic pressure as the fluid inside the blood cells. This results in no net flow of water across the cell membrane, allowing the cells to maintain their normal shape. This is why medical saline solutions are isotonic (0.9% NaCl). 🩸', NULL, NULL, NULL, NULL, NULL),
(1112, '32. What is the molarity of a solution prepared by dissolving 4 g of NaOH in enough water to form 250 mL of solution? (Molar mass of NaOH = 40 g/mol)', '1.0 M', '0.5 M', '0.4 M', '0.1 M', 'C', 1, 3, 6, 6, NULL, 'medium', '• Moles of NaOH = Mass / Molar mass = 4 g / 40 g/mol = 0.1 mol. • Volume of solution = 250 mL = 0.250 L. • Molarity (M) = Moles of solute / Liters of solution = 0.1 mol / 0.250 L = 0.4 M.', NULL, NULL, NULL, NULL, NULL),
(1113, '33. An example of a maximum boiling azeotrope is a mixture of', 'Water and ethanol', 'Water and nitric acid', 'Chloroform and ethanol', 'Benzene and toluene', 'B', 1, 3, 6, 6, NULL, 'medium', 'Mixtures that show a large negative deviation from Raoult\'s law (like nitric acid and water) form maximum boiling azeotropes. This means the azeotrope boils at a temperature higher than the boiling point of either pure component. Water and ethanol form a minimum boiling azeotrope.', NULL, NULL, NULL, NULL, NULL),
(1114, '34. The solubility of gases in liquids', 'Increases with increasing temperature and pressure.', 'Decreases with increasing temperature and pressure.', 'Increases with decreasing temperature and increasing pressure.', 'Decreases with decreasing temperature and increasing pressure.', 'C', 1, 3, 6, 6, NULL, 'medium', 'The dissolution of most gases is an exothermic process, so solubility decreases as temperature increases (Le Chatelier\'s principle). According to Henry\'s Law, solubility is directly proportional to the partial pressure of the gas, so it increases as pressure increases.', NULL, NULL, NULL, NULL, NULL),
(1115, '35. If red blood cells are placed in pure water (a hypotonic solution), they will', 'Shrivel and collapse (crenation).', 'Swell and burst (hemolysis).', 'Remain unchanged.', 'Turn blue.', 'B', 1, 3, 6, 6, NULL, 'hard', 'Pure water has a higher water concentration than the fluid inside the red blood cells. Due to osmosis, water will rush into the cells, causing them to swell and eventually rupture or burst, a process called hemolysis.', NULL, NULL, NULL, NULL, NULL),
(1116, '36. Colligative properties are used to determine the', 'Nature of the solute.', 'Molar mass of the solute.', 'Molarity of the solution.', 'Polarity of the solvent.', 'B', 1, 3, 6, 6, NULL, 'hard', 'By measuring a colligative property (like freezing point depression), we can determine the molality of the solution. If we know the mass of the solute and solvent, we can then calculate the molar mass of the solute. This is a common application of these properties.', NULL, NULL, NULL, NULL, NULL),
(1117, '37. A mixture of benzene and toluene is an example of', 'A nearly ideal solution.', 'A non-ideal solution with positive deviation.', 'A non-ideal solution with negative deviation.', 'An azeotrope.', 'A', 1, 3, 6, 6, NULL, 'hard', 'Benzene and toluene are both non-polar aromatic hydrocarbons with very similar structures and intermolecular forces. When mixed, the forces between benzene and toluene molecules are very similar to the forces between pure benzene or pure toluene molecules. As a result, the solution behaves almost ideally and obeys Raoult\'s law.', NULL, NULL, NULL, NULL, NULL),
(1118, '38. The unit of the ebullioscopic constant (Kb) is', 'K kg mol⁻¹', 'K mol kg⁻¹', 'K g mol⁻¹', 'K mol g⁻¹', 'A', 1, 3, 6, 6, NULL, 'hard', 'The formula is ΔTb=Kb⋅m. Rearranging gives Kb=ΔTb/m. The unit of ΔTb is Kelvin (K), and the unit of molality (m) is mol/kg. Therefore, the unit of Kb is K / (mol/kg) = K kg mol⁻¹.', NULL, NULL, NULL, NULL, NULL),
(1119, '39. For a 5% solution of urea (molar mass 60 g/mol), the osmotic pressure at 300 K is: (R = 0.0821 L atm K⁻¹ mol⁻¹)', '20.5 atm', '10.25 atm', '30.5 atm', '5.12 atm', 'A', 1, 3, 6, 6, NULL, 'hard', 'A 5% solution means 5 g of urea in 100 mL (0.1 L) of solution. • Moles of urea = 5 g / 60 g/mol = 1/12 mol. • Molarity (C) = Moles / Volume (L) = (1/12) / 0.1 = 10/12 mol/L. • Osmotic pressure .', NULL, NULL, NULL, NULL, NULL),
(1120, '40. The pressure that must be applied to a solution to prevent the inward flow of its pure solvent across a semipermeable membrane is called', 'Vapor pressure', 'Atmospheric pressure', 'Osmotic pressure', 'Hydrostatic pressure', 'C', 1, 3, 6, 6, NULL, 'hard', 'This is the definition of osmotic pressure. It is the external pressure required to stop the process of osmosis.', NULL, NULL, NULL, NULL, NULL),
(1121, '41. Which of the following is an example of a solid solution?', 'Sugar in water', 'Smoke', 'Brass (an alloy of copper and zinc)', 'Soda water', 'C', 1, 3, 6, 6, NULL, 'hard', 'A solid solution is a solid-state mixture where a minor component (solute) is uniformly distributed within the crystal lattice of the major component (solvent). Alloys like brass are prime examples.', NULL, NULL, NULL, NULL, NULL),
(1122, '42. For a solution showing negative deviation from Raoult\'s law, the total volume of the solution is', 'Equal to the sum of the volumes of the components.', 'Greater than the sum of the volumes of the components.', 'Less than the sum of the volumes of the components.', 'Always zero.', 'C', 1, 3, 6, 6, NULL, 'hard', 'Negative deviation occurs when the intermolecular forces between the solute and solvent are stronger than in their pure states. This stronger attraction pulls the molecules closer together, resulting in a slight contraction. Therefore, ΔVmix is negative, and the final volume is less than the sum of the initial volumes.', NULL, NULL, NULL, NULL, NULL),
(1123, '43. The vapor pressure of a liquid increases with an increase in', 'Temperature', 'Surface area', 'Intermolecular forces', 'Pressure', 'A', 1, 3, 6, 6, NULL, 'hard', 'Increasing the temperature gives more molecules the kinetic energy needed to escape from the liquid phase into the vapor phase, thus increasing the equilibrium vapor pressure.', NULL, NULL, NULL, NULL, NULL),
(1124, '44. If the van\'t Hoff factor for a solute is 0.5, it indicates that the solute', 'Dissociates into two particles.', 'Remains unchanged in the solution.', 'Associates in the solution (e.g., forms dimers).', 'Is completely insoluble.', 'C', 1, 3, 6, 6, NULL, 'hard', 'The van\'t Hoff factor (i) is the ratio of the observed number of particles to the expected number. If i < 1, it means there are fewer particles than expected, which happens when solute molecules associate. For perfect dimerization (two molecules forming one), i = 0.5.', NULL, NULL, NULL, NULL, NULL),
(1125, '45. What happens to the freezing point of a solvent when a non-volatile solute is added?', 'It increases.', 'It decreases.', 'It remains the same.', 'It depends on the solute.', 'B', 1, 3, 6, 6, NULL, 'hard', 'The presence of solute particles disrupts the formation of the solvent\'s crystal lattice, making it harder for the solvent to freeze. As a result, the solution must be cooled to a lower temperature to freeze. This is known as freezing point depression.', NULL, NULL, NULL, NULL, NULL),
(1126, '46. \"Parts per million\" (ppm) is a concentration unit typically used for', 'Very concentrated solutions.', 'Gaseous solutions only.', 'Very dilute solutions, like pollutants in water.', 'Solid solutions only.', 'C', 1, 3, 6, 6, NULL, 'easy', 'ppm is a convenient way to express the concentration of substances present in trace amounts, such as pollutants in the air or water, or minerals in drinking water. 1 ppm is equivalent to 1 mg of solute per liter of water.', NULL, NULL, NULL, NULL, NULL),
(1127, '47. According to Raoult\'s law, the vapor pressure of a solution containing a non-volatile solute is directly proportional to the', 'Mole fraction of the solute.', 'Mole fraction of the solvent.', 'Molarity of the solution.', 'Mass of the solvent.', 'B', 1, 3, 6, 6, NULL, 'easy', 'Raoult\'s law can be stated as Psolution=Psolvent0⋅xsolvent. This shows that the vapor pressure of the solution is directly proportional to the mole fraction of the volatile solvent.', NULL, NULL, NULL, NULL, NULL),
(1128, '48. Scuba divers must ascend slowly from deep water to avoid \"the bends,\" a painful condition caused by the formation of gas bubbles in the blood. This phenomenon is explained by', 'Raoult\'s Law', 'Henry\'s Law', 'Osmosis', 'Dalton\'s Law', 'B', 1, 3, 6, 6, NULL, 'easy', 'At the high pressure of deep water, more nitrogen gas from the breathing air dissolves in the diver\'s blood (Henry\'s Law). If the diver ascends too quickly, the pressure decreases rapidly, causing the dissolved nitrogen to come out of the solution and form dangerous bubbles in the bloodstream and tissues. 🫧', NULL, NULL, NULL, NULL, NULL),
(1129, '49. Ethylene glycol is added to water in car radiators as an antifreeze. This is an application of', 'Elevation of boiling point.', 'Depression of freezing point.', 'Osmotic pressure.', 'Henry\'s Law.', 'B', 1, 3, 6, 6, NULL, 'easy', 'Adding ethylene glycol (a non-volatile solute) to water lowers the freezing point of the mixture. This prevents the water in the car\'s radiator from freezing and expanding in cold weather, which could damage the engine block. ❄️', NULL, NULL, NULL, NULL, NULL),
(1130, '50. An ideal solution is a solution that', 'Has zero vapor pressure.', 'Obeys Raoult\'s law over the entire range of concentration.', 'Shows a large positive deviation from Raoult\'s law.', 'Shows a large negative deviation from Raoult\'s law.', 'B', 1, 3, 6, 6, NULL, 'easy', 'This is the definition of an ideal solution. In such a solution, the interactions between all molecules (solute-solute, solvent-solvent, and solute-solvent) are identical. Of course. Here is the third set for the chapter on Solutions.', NULL, NULL, NULL, NULL, NULL),
(1131, '51. When a solid dissolves in a liquid, the entropy of the system generally', 'Decreases.', 'Increases.', 'Remains constant.', 'First decreases, then increases.', 'B', 1, 3, 6, 6, NULL, 'easy', 'The process of dissolving increases the disorder or randomness of the system. The solute particles are no longer in a fixed, ordered lattice but are dispersed throughout the liquid, leading to an increase in entropy (ΔS>0), which is a major driving force for the dissolution process.', NULL, NULL, NULL, NULL, NULL),
(1132, '52. The vapor pressure of a solution is always lower than that of the pure solvent. This is because', 'The solute particles increase the intermolecular forces in the solvent.', 'The solute particles block the escape of solvent molecules from the surface.', 'The kinetic energy of the solvent molecules decreases.', 'The solution is always at a lower temperature.', 'B', 1, 3, 6, 6, NULL, 'easy', 'The vapor pressure is determined by the rate at which solvent molecules escape the liquid surface. When a non-volatile solute is present, some of the surface area is occupied by solute particles, reducing the effective area from which solvent molecules can evaporate. This lowers the rate of evaporation and, consequently, the vapor pressure.', NULL, NULL, NULL, NULL, NULL),
(1133, '53. Which of the following will show a negative deviation from Raoult\'s law?', 'Benzene and Toluene', 'Acetone and Carbon disulfide', 'Phenol and Aniline', 'Ethanol and Water', 'C', 1, 3, 6, 6, NULL, 'easy', 'A negative deviation occurs when the forces between the mixed components are stronger than the forces in the pure components. Phenol is acidic and aniline is basic. When mixed, they form strong intermolecular hydrogen bonds due to an acid-base interaction. This stronger attraction reduces the escaping tendency of the molecules, lowering the vapor pressure below what Raoult\'s law predicts.', NULL, NULL, NULL, NULL, NULL),
(1134, '54. The process of a liquid changing directly into a solid is called freezing. The temperature at which this occurs for a liquid is its freezing point. The freezing point of a solution is', 'The temperature at which the vapor pressure of the solution equals the vapor pressure of the pure solid solvent.', 'The temperature at which the solution\'s vapor pressure equals the external pressure.', 'The temperature at which the solution becomes saturated.', 'The same as the freezing point of the pure solvent.', 'A', 1, 3, 6, 6, NULL, 'easy', 'Freezing occurs at the temperature where the liquid and solid phases are in equilibrium, meaning they have the same vapor pressure. Since a solution has a lower vapor pressure than the pure solvent, it must be cooled to a lower temperature for its vapor pressure to become equal to that of the solid solvent.', NULL, NULL, NULL, NULL, NULL),
(1135, '55. A solution is prepared by dissolving 18 g of glucose (molar mass = 180 g/mol) in 90 g of water. The relative lowering of vapor pressure is equal to', '1/51', '1/5.1', '1/10', '1/6', 'A', 1, 3, 6, 6, NULL, 'easy', 'According to Raoult\'s law, the relative lowering of vapor pressure is equal to the mole fraction of the solute. • Moles of glucose (solute) = 18 g / 180 g/mol = 0.1 mol. • Moles of water (solvent) = 90 g / 18 g/mol = 5.0 mol. • Total moles = 0.1 + 5.0 = 5.1 mol. • Mole fraction of solute = Moles of solute / Total moles = 0.1 / 5.1 = 1/51.', NULL, NULL, NULL, NULL, NULL),
(1136, '56. \"Edema,\" or swelling of body tissues, can be caused by', 'The formation of a hypertonic solution in the blood.', 'The formation of a hypotonic solution in the tissue fluids.', 'Water passing from blood into the tissues through osmosis.', 'Both B and C are correct.', 'D', 1, 3, 6, 6, NULL, 'easy', 'If the tissue fluids become hypotonic (less concentrated) relative to the blood, or more commonly, if the blood becomes hypotonic due to factors like excess salt intake, water will move via osmosis from the region of higher water concentration (blood) into the more concentrated tissue cells, causing them to swell.', NULL, NULL, NULL, NULL, NULL),
(1137, '57. For a non-ideal solution with a positive deviation from Raoult\'s law, the intermolecular forces between the components (A-B) are', 'Stronger than the forces in the pure components (A-A and B-B).', 'Weaker than the forces in the pure components.', 'Equal to the forces in the pure components.', 'Non-existent.', 'B', 1, 3, 6, 6, NULL, 'medium', 'A positive deviation means the vapor pressure is higher than expected. This occurs because the molecules have a greater tendency to escape the solution. This increased escaping tendency is a result of the intermolecular forces of attraction between the solute and solvent molecules (A-B) being weaker than the average forces in the pure liquids.', NULL, NULL, NULL, NULL, NULL),
(1138, '58. Which of the following is NOT an application of colligative properties?', 'Determining the molar mass of polymers.', 'Using salt to melt ice on roads.', 'The process of reverse osmosis for water purification.', 'The use of Henry\'s Law in scuba diving.', 'D', 1, 3, 6, 6, NULL, 'medium', 'Determining molar masses, melting ice (freezing point depression), and reverse osmosis are all direct applications or consequences of colligative properties. The issues related to scuba diving (\"the bends\") are explained by Henry\'s Law, which deals with the pressure dependence of gas solubility, not a colligative property.', NULL, NULL, NULL, NULL, NULL),
(1139, '59. If 10 g of a solute is dissolved in 100 g of benzene, the boiling point of the solution is 1°C higher than that of pure benzene. What is the molar mass of the solute? (Kb for benzene = 2.53 K kg mol⁻¹)', '253 g/mol', '126.5 g/mol', '506 g/mol', '25.3 g/mol', 'A', 1, 3, 6, 6, NULL, 'medium', 'We use the formula for elevation of boiling point: ΔTb=Kb⋅m. • Molality (m) = Moles of solute / kg of solvent = (Mass solute / Molar mass) / (kg solvent). • . • . • . • Molar mass = 25.3 / 1 = 253 g/mol. (Note: A change of 1°C is the same as a change of 1 K).', NULL, NULL, NULL, NULL, NULL),
(1140, '60. The process where solvent molecules pass through a semipermeable membrane from a dilute solution to a more concentrated solution is called', 'Diffusion', 'Osmosis', 'Effusion', 'Reverse Osmosis', 'B', 1, 3, 6, 6, NULL, 'medium', 'This is the definition of osmosis. It is the spontaneous net movement of solvent molecules through a selectively permeable membrane into a region of higher solute concentration.', NULL, NULL, NULL, NULL, NULL),
(1141, '61. A solution that can dissolve more solute at a given temperature is called', 'Saturated', 'Unsaturated', 'Supersaturated', 'Isotonic', 'B', 1, 3, 6, 6, NULL, 'medium', 'An unsaturated solution contains less solute than the maximum amount it is capable of dissolving at that temperature.', NULL, NULL, NULL, NULL, NULL),
(1142, '62. An example of a minimum boiling azeotrope is a solution of', 'Water and HCl', 'Water and Nitric Acid', 'Water and Ethanol', 'Acetone and Chloroform', 'C', 1, 3, 6, 6, NULL, 'medium', 'Mixtures that show a large positive deviation from Raoult\'s law, like water and ethanol, form minimum boiling azeotropes. The azeotrope boils at a temperature that is lower than the boiling point of either pure component.', NULL, NULL, NULL, NULL, NULL),
(1143, '63. The van\'t Hoff factor (i) can be calculated as the ratio of', 'Normal molar mass / Abnormal molar mass', 'Abnormal molar mass / Normal molar mass', 'Observed colligative property / Calculated colligative property', 'Both A and C are correct.', 'D', 1, 3, 6, 6, NULL, 'medium', 'The van\'t Hoff factor corrects for the change in the number of particles. Since colligative properties are inversely proportional to molar mass, an observed property that is \'i\' times the calculated value will correspond to a molar mass that is \'1/i\' times the normal value. Therefore, \'i\' is equal to the ratio of the observed to the calculated colligative property, and also equal to the ratio of the normal (theoretical) molar mass to the abnormal (experimentally determined) molar mass.', NULL, NULL, NULL, NULL, NULL),
(1144, '64. When a wilted flower is placed in fresh water, it revives. This is due to', 'Diffusion', 'Osmosis', 'Adsorption', 'Imbibition', 'B', 1, 3, 6, 6, NULL, 'medium', 'The cells of the wilted flower contain a more concentrated fluid than the fresh water. Due to osmosis, water moves from the fresh water into the plant\'s cells, creating turgor pressure and causing the flower to become firm and revive. 💐', NULL, NULL, NULL, NULL, NULL),
(1145, '65. Henry\'s Law constant, KH, has the units of', 'Pressure', 'Concentration', 'Pressure / Concentration', 'It is dimensionless', 'A', 1, 3, 6, 6, NULL, 'medium', 'The common form of Henry\'s Law is p=KH⋅x, where \'p\' is the partial pressure and \'x\' is the mole fraction (which is dimensionless). Therefore, the units of KH must be the same as the units of pressure (e.g., atm, bar, or Pa).', NULL, NULL, NULL, NULL, NULL),
(1146, '66. Which of the following is NOT a true solution?', 'Salt in water', 'Sugar in water', 'Starch in water', 'Ethanol in water', 'C', 1, 3, 6, 6, NULL, 'medium', 'Starch is a polymer with very large molecules. When mixed with water, it does not form a true solution but rather a colloidal dispersion. The particles are large enough to scatter light (Tyndall effect) but small enough to remain suspended.', NULL, NULL, NULL, NULL, NULL),
(1147, '67. A solution is formed by mixing 36 g of water and 46 g of ethanol (C₂H₅OH). The mole fraction of ethanol in the solution is: (Molar mass: H₂O=18, C₂H₅OH=46)', '0.33', '0.50', '0.67', '0.25', 'A', 1, 3, 6, 6, NULL, 'medium', '• Moles of water = 36 g / 18 g/mol = 2 mol. • Moles of ethanol = 46 g / 46 g/mol = 1 mol. • Total moles = 2 + 1 = 3 mol. • Mole fraction of ethanol = Moles of ethanol / Total moles = 1 mol / 3 mol ≈ 0.33.', NULL, NULL, NULL, NULL, NULL),
(1148, '68. The boiling point of a solvent is the temperature at which its vapor pressure is equal to', 'Its osmotic pressure.', 'The vapor pressure of the solution.', 'The external atmospheric pressure.', 'The vapor pressure of its solid phase.', 'C', 1, 3, 6, 6, NULL, 'medium', 'This is the definition of the boiling point. A liquid boils when its equilibrium vapor pressure becomes equal to the pressure of the atmosphere above it, allowing bubbles of vapor to form within the bulk of the liquid.', NULL, NULL, NULL, NULL, NULL),
(1149, '69. The preservation of meat by salting and of fruits by adding sugar is an application of', 'Henry\'s Law', 'Osmosis', 'Freezing point depression', 'Raoult\'s Law', 'B', 1, 3, 6, 6, NULL, 'hard', 'Adding a high concentration of salt or sugar creates a hypertonic environment. When bacteria or mold land on the food, water is drawn out of their cells by osmosis, dehydrating and killing them. This prevents the food from spoiling. 🍖', NULL, NULL, NULL, NULL, NULL),
(1150, '70. The molarity of pure water is approximately', '1 M', '18 M', '55.5 M', '100 M', 'C', 1, 3, 6, 6, NULL, 'hard', 'Molarity is moles per liter. Consider 1 liter (1000 mL) of pure water. The density of water is approximately 1 g/mL, so the mass of 1 L of water is 1000 g. The molar mass of water (H₂O) is 18 g/mol. • Moles of water = 1000 g / 18 g/mol ≈ 55.55 moles. • Since this is in 1 liter, the molarity is 55.5 M.', NULL, NULL, NULL, NULL, NULL),
(1151, '71. Solutions that obey Raoult\'s law at all concentrations are called', 'Azeotropes', 'Saturated solutions', 'Ideal solutions', 'Non-ideal solutions', 'C', 1, 3, 6, 6, NULL, 'hard', 'This is the definition of an ideal solution.', NULL, NULL, NULL, NULL, NULL),
(1152, '72. The osmotic pressure of a solution will increase if', 'The temperature is decreased.', 'The volume is increased.', 'The number of solute particles is increased.', 'The semipermeable membrane is removed.', 'C', 1, 3, 6, 6, NULL, 'hard', 'Osmotic pressure is given by Π=iCRT. It is directly proportional to the effective molar concentration (iC) of the solute particles. Increasing the number of particles will increase the osmotic pressure.', NULL, NULL, NULL, NULL, NULL),
(1153, '73. The cryoscopic constant of a solvent is the same as its', 'Ebullioscopic constant.', 'Molal depression constant.', 'Molar elevation constant.', 'Gas constant.', 'B', 1, 3, 6, 6, NULL, 'hard', '\"Cryoscopic constant\" is the scientific name for the molal freezing point depression constant (Kf). \"Ebullioscopic constant\" is the name for the molal boiling point elevation constant (Kb).', NULL, NULL, NULL, NULL, NULL),
(1154, '74. When a semipermeable membrane is placed between a 0.1 M sugar solution and a 0.2 M sugar solution, there will be a net flow of', 'Sugar from the 0.2 M solution to the 0.1 M solution.', 'Water from the 0.2 M solution to the 0.1 M solution.', 'Sugar from the 0.1 M solution to the 0.2 M solution.', 'Water from the 0.1 M solution to the 0.2 M solution.', 'D', 1, 3, 6, 6, NULL, 'hard', 'Osmosis is the movement of the solvent (water) from a region of higher solvent concentration (the more dilute 0.1 M solution) to a region of lower solvent concentration (the more concentrated 0.2 M solution).', NULL, NULL, NULL, NULL, NULL),
(1155, '75. \"Solid foam\" is a type of colloidal solution in which the dispersed phase and dispersion medium are, respectively', 'Gas and Solid', 'Solid and Gas', 'Liquid and Solid', 'Solid and Liquid', 'A', 1, 3, 6, 6, NULL, 'hard', 'A solid foam is a colloid where gas bubbles are trapped within a solid medium. Examples include Styrofoam, pumice stone, and bread.', NULL, NULL, NULL, NULL, NULL),
(1156, '76. The pressure cooker reduces cooking time because', 'The heat is more evenly distributed.', 'The higher pressure inside increases the boiling point of water.', 'The higher pressure inside decreases the boiling point of water.', 'It prevents the escape of steam.', 'B', 1, 3, 6, 6, NULL, 'hard', 'The boiling point of a liquid is the temperature at which its vapor pressure equals the external pressure. By trapping steam, a pressure cooker increases the pressure inside. This means the water must be heated to a higher temperature (e.g., 121°C instead of 100°C) before it boils. Food cooks faster at this higher temperature. 🍲', NULL, NULL, NULL, NULL, NULL),
(1157, '77. An example of a solution that shows a positive deviation from Raoult\'s law is', 'Acetone + Chloroform', 'Nitric Acid + Water', 'Benzene + Toluene', 'Acetone + Carbon disulfide', 'D', 1, 3, 6, 6, NULL, 'hard', 'In pure acetone, there are dipole-dipole interactions. When non-polar carbon disulfide is added, it disrupts these interactions. The new intermolecular forces between acetone and carbon disulfide are weaker than the original forces in pure acetone. This makes it easier for the molecules to escape into the vapor phase, resulting in a higher vapor pressure than predicted by Raoult\'s law (positive deviation).', NULL, NULL, NULL, NULL, NULL),
(1158, '78. The value of Henry\'s Law constant, KH, is', 'The same for all gases in a given solvent.', 'Dependent on the nature of the gas.', 'Independent of temperature.', 'Always less than 1.', 'B', 1, 3, 6, 6, NULL, 'hard', 'The value of KH is specific to each gas-solvent pair. For example, the KH for oxygen in water is different from the KH for carbon dioxide in water. Gases with lower KH values are more soluble.', NULL, NULL, NULL, NULL, NULL),
(1159, '79. Two solutions, A and B, are separated by a semipermeable membrane. If the solvent flows from A to B, it means', 'Solution A is more concentrated than B.', 'B. Solution B is more concentrated than A.', 'Both solutions have the same concentration.', 'Both solutions are saturated.', 'B', 1, 3, 6, 6, NULL, 'hard', 'Osmosis is the net movement of solvent from a region of higher solvent concentration (the more dilute solution) to a region of lower solvent concentration (the more concentrated solution). If the solvent flows from A to B, then B must have a higher solute concentration.', NULL, NULL, NULL, NULL, NULL),
(1160, '80. What is the normality of a 0.1 M solution of sulfuric acid (H₂SO₄)?', '0.1 N', '0.2 N', '0.05 N', '0.3 N', 'B', 1, 3, 6, 6, NULL, 'easy', 'Normality is Molarity × n-factor. For an acid, the n-factor is the number of replaceable H⁺ ions. Sulfuric acid (H₂SO₄) is a diprotic acid, meaning it can furnish two H⁺ ions. Therefore, its n-factor is 2. Normality = 0.1 M × 2 = 0.2 N.', NULL, NULL, NULL, NULL, NULL),
(1161, '81. For which of the following solutes is the van\'t Hoff factor (i) equal to 1?', 'NaCl', 'CH₃COOH (in water)', 'Urea', 'K₄[Fe(CN)₆]', 'C', 1, 3, 6, 6, NULL, 'easy', 'Urea (CO(NH₂)₂) is a non-electrolyte. It does not associate or dissociate when dissolved in water. Therefore, the number of observed particles is equal to the number of formula units dissolved, and its van\'t Hoff factor is 1.', NULL, NULL, NULL, NULL, NULL),
(1162, '82. The boiling point elevation is a colligative property. This means it depends on', 'The nature of the solvent.', 'The nature of the solute particles.', 'The number of solute particles in the solution.', 'The vapor pressure of the solvent.', 'C', 1, 3, 6, 6, NULL, 'easy', 'This is the definition of a colligative property. It depends on the quantity (concentration) of solute particles, not on their chemical identity or nature.', NULL, NULL, NULL, NULL, NULL),
(1163, '83. The unit \"molality\" is defined as', 'Moles of solute / Liters of solution', 'Moles of solute / Kilograms of solution', 'Moles of solute / Kilograms of solvent', 'Grams of solute / Liters of solution', 'C', 1, 3, 6, 6, NULL, 'easy', 'Molality (m) is a temperature-independent concentration unit defined as the number of moles of solute per kilogram of the solvent.', NULL, NULL, NULL, NULL, NULL),
(1164, '84. Why do climbers at high altitudes sometimes experience a condition known as \"anoxia\"?', 'The temperature is very low.', 'The partial pressure of oxygen is low, reducing its solubility in blood.', 'The air contains pollutants.', 'The total atmospheric pressure is very high.', 'B', 1, 3, 6, 6, NULL, 'easy', 'This is a direct application of Henry\'s Law. At high altitudes, the atmospheric pressure and the partial pressure of oxygen are lower. This reduces the concentration of dissolved oxygen in the blood and tissues, leading to weakness and an inability to think clearly, a condition called anoxia. 🏔️', NULL, NULL, NULL, NULL, NULL),
(1165, '85. For an ideal solution, which of the following is true?', 'ΔHmix=0 and ΔVmix=0', 'ΔHmix>0 and ΔVmix>0', 'ΔHmix<0 and ΔVmix<0', 'ΔHmix=0 and ΔVmix>0', 'A', 1, 3, 6, 6, NULL, 'easy', 'An ideal solution is one where the intermolecular forces between all components are identical. As a result, there is no change in enthalpy (no heat is released or absorbed) and no change in volume when the components are mixed.', NULL, NULL, NULL, NULL, NULL),
(1166, '86. A liquid is in equilibrium with its vapor in a sealed container at a fixed temperature. The volume of the container is suddenly increased. What happens initially to the vapor pressure and the rate of evaporation?', 'Vapor pressure increases, rate of evaporation increases.', 'Vapor pressure decreases, rate of evaporation increases.', 'Vapor pressure decreases, rate of evaporation stays the same.', 'Vapor pressure stays the same, rate of evaporation stays the same.', 'B', 1, 3, 6, 6, NULL, 'easy', 'When the volume is suddenly increased, the number of vapor molecules per unit volume decreases, causing an immediate decrease in vapor pressure. The system is no longer at equilibrium. The rate of condensation (which depends on vapor pressure) decreases, while the rate of evaporation (which depends on temperature and surface area) remains the same. This imbalance causes a net evaporation to restore equilibrium, so one could also argue the net rate of evaporation increases. The initial effect is a pressure drop.', NULL, NULL, NULL, NULL, NULL),
(1167, '87. In the formula ΔTf=iKfm, the term \'m\' represents', 'Molarity', 'Molality', 'Mass of the solute', 'Molar mass of the solvent', 'B', 1, 3, 6, 6, NULL, 'easy', 'Colligative property calculations for freezing point depression and boiling point elevation use molality (moles of solute per kg of solvent) because it is a temperature-independent concentration unit.', NULL, NULL, NULL, NULL, NULL),
(1168, '88. The osmotic pressure of blood is about 7.4 atm at body temperature. A saline solution for intravenous injection must be', 'Hypotonic with respect to blood.', 'Hypertonic with respect to blood.', 'Isotonic with respect to blood.', 'Made with pure water only.', 'C', 1, 3, 6, 6, NULL, 'easy', 'An isotonic solution has the same osmotic pressure as the blood. This prevents damage to red blood cells that would occur if water were to rapidly enter the cells (in a hypotonic solution) or leave the cells (in a hypertonic solution).', NULL, NULL, NULL, NULL, NULL),
(1169, '89. To prepare 0.2 M KCl solution in 500 mL, the amount of KCl required is: (Molar mass of KCl = 74.5 g/mol)', '14.9 g', '7.45 g', '29.8 g', '74.5 g', 'B', 1, 3, 6, 6, NULL, 'easy', 'Molarity = Moles / Volume (L). • Moles required = Molarity × Volume (L) = 0.2 mol/L × 0.500 L = 0.1 mol. • Mass required = Moles × Molar mass = 0.1 mol × 74.5 g/mol = 7.45 g.', NULL, NULL, NULL, NULL, NULL),
(1170, '90. Which of the following is a characteristic of a non-ideal solution showing positive deviation?', 'A-B interactions are stronger than A-A and B-B interactions.', 'ΔHmix is negative.', 'ΔVmix is positive.', 'The solution boils at a temperature higher than either component.', 'C', 1, 3, 6, 6, NULL, 'easy', 'In a solution with positive deviation, the intermolecular forces in the mixture are weaker than in the pure components. This causes the molecules to be less tightly held, resulting in a slight expansion when mixed. Therefore, the change in volume upon mixing (ΔVmix) is positive.', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `results`
--

CREATE TABLE `results` (
  `id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `total_marks` decimal(10,2) DEFAULT 0.00,
  `percentage` decimal(5,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `correct_answers` int(11) DEFAULT 0,
  `wrong_answers` int(11) DEFAULT 0,
  `time_taken` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
('7L5an5B7Za3FLmm9tdIWs9KJvFZn9to8', 1762705265, '{\"cookie\":{\"originalMaxAge\":7200000,\"expires\":\"2025-11-09T15:32:55.474Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\",\"sameSite\":\"lax\"},\"studentId\":6}');

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
(1, 'Science'),
(2, 'Arts'),
(3, 'Commerce');

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
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `stream_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `name`, `email`, `mobile`, `city`, `password`, `created_at`, `stream_id`) VALUES
(1, 'dqwdqwdq', 'fwfweweweff@gmail.com', '9251593613', 'Jaipur', '$2b$10$w1yavzcDvQ3Oi59KJB.8pOEBAKHfab5mIRPz7MKG7yUfcCb1M2W9q', '2025-10-15 08:29:49', NULL),
(2, 'qdqwdqwdqw', 'fwfdqwqwdweweweff@gmail.com', '', '', '$2b$10$ZU2T1Mva1PreyCQYGTGhseuc4K6/J4GANR3wNjxZ/RMsfoPqmCRhG', '2025-10-15 08:33:38', NULL),
(3, 'regerrger', 'fwfddweweweff@gmail.com', '7878979878', 'regerge', '$2b$10$lGA7aRs8mj1ZVcbKZ6vgwew1ZjwSpaWyLDxBH1BRQ.x8JZB88qMOS', '2025-10-15 09:35:14', NULL),
(4, 'fwefwefwe', 'fwfddwewewfwefwefwefweeff@gmail.com', '789999999779797', 'efwefwegf', '$2b$10$meW2XoeakMwhlYtm3fsWJuvicXAXUHKESct0s4./SByDVcyBYgZcq', '2025-10-15 09:46:23', NULL),
(5, 'qwdqwdqwd', 'fwfwewewefwefweff@gmail.com', '77797778798', 'edwefwf', '$2b$10$z123wQZGt31H4s0ExfcIAO0EP.bmyHeleIDiwoBj/tHjuWiL0bh36', '2025-10-15 10:14:17', NULL),
(6, 'Test Student', 'teststudent@gmail.com', '9999999999', 'Jaipur', '$2b$10$T/Un1FtUeV5mMfNT6PrliOIiW5hS04MSAJIoKG/39w4brKkd0m6Re', '2025-10-28 13:22:24', 1),
(7, 'Farhan Test', 'farhan@test.com', '9251586076', 'Jaipur', '$2b$10$eVNhA3.aHZQiRz9bzX469uF/PeMMskW.anNwyDd314ddUf0ne85Oe', '2025-10-31 20:28:23', 1);

-- --------------------------------------------------------

--
-- Table structure for table `students_backup`
--

CREATE TABLE `students_backup` (
  `id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `city` varchar(100) NOT NULL,
  `stream` enum('Engineering','Management') NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `stream_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students_backup`
--

INSERT INTO `students_backup` (`id`, `name`, `email`, `mobile`, `city`, `stream`, `password`, `created_at`, `stream_id`) VALUES
(1, 'dqwdqwdq', 'fwfweweweff@gmail.com', '9251593613', 'Jaipur', '', '$2b$10$w1yavzcDvQ3Oi59KJB.8pOEBAKHfab5mIRPz7MKG7yUfcCb1M2W9q', '2025-10-15 08:29:49', NULL),
(2, 'qdqwdqwdqw', 'fwfdqwqwdweweweff@gmail.com', '', '', 'Engineering', '$2b$10$ZU2T1Mva1PreyCQYGTGhseuc4K6/J4GANR3wNjxZ/RMsfoPqmCRhG', '2025-10-15 08:33:38', NULL),
(3, 'regerrger', 'fwfddweweweff@gmail.com', '7878979878', 'regerge', 'Management', '$2b$10$lGA7aRs8mj1ZVcbKZ6vgwew1ZjwSpaWyLDxBH1BRQ.x8JZB88qMOS', '2025-10-15 09:35:14', NULL),
(4, 'fwefwefwe', 'fwfddwewewfwefwefwefweeff@gmail.com', '789999999779797', 'efwefwegf', '', '$2b$10$meW2XoeakMwhlYtm3fsWJuvicXAXUHKESct0s4./SByDVcyBYgZcq', '2025-10-15 09:46:23', NULL),
(5, 'qwdqwdqwd', 'fwfwewewefwefweff@gmail.com', '77797778798', 'edwefwf', 'Engineering', '$2b$10$z123wQZGt31H4s0ExfcIAO0EP.bmyHeleIDiwoBj/tHjuWiL0bh36', '2025-10-15 10:14:17', NULL),
(6, 'Test Student', 'teststudent@gmail.com', '9999999999', 'Jaipur', '', '$2b$10$T/Un1FtUeV5mMfNT6PrliOIiW5hS04MSAJIoKG/39w4brKkd0m6Re', '2025-10-28 13:22:24', NULL),
(7, 'Farhan Test', 'farhan@test.com', '9251586076', 'Jaipur', '', '$2b$10$eVNhA3.aHZQiRz9bzX469uF/PeMMskW.anNwyDd314ddUf0ne85Oe', '2025-10-31 20:28:23', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `student_answers`
--

CREATE TABLE `student_answers` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `answer` varchar(10) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_answers`
--

INSERT INTO `student_answers` (`id`, `student_id`, `test_id`, `question_id`, `answer`, `submitted_at`) VALUES
(1, 7, 2, 457, 'c', '2025-11-03 09:48:20'),
(2, 7, 2, 512, 'b', '2025-11-03 09:48:20'),
(3, 7, 2, 744, 'c', '2025-11-03 09:48:20'),
(4, 7, 2, 995, 'c', '2025-11-03 09:48:20'),
(9, 7, 2, 401, 'a', '2025-11-03 09:48:38'),
(10, 7, 2, 477, 'c', '2025-11-03 09:48:38'),
(11, 7, 2, 1137, 'c', '2025-11-03 09:48:38'),
(29, 6, 4, 232, 'd', '2025-11-06 19:11:14'),
(30, 6, 4, 739, 'b', '2025-11-06 19:11:14'),
(31, 6, 4, 979, 'c', '2025-11-06 19:11:14'),
(32, 6, 4, 984, 'c', '2025-11-06 19:11:14'),
(33, 6, 4, 1053, 'b', '2025-11-06 19:11:14');

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
(1, 'Physics', 1),
(3, 'Chemistry', 1),
(4, 'Maths', 1),
(5, 'History', 2),
(6, 'Economics', 2);

-- --------------------------------------------------------

--
-- Table structure for table `tests`
--

CREATE TABLE `tests` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `stream_id` int(11) NOT NULL,
  `total_questions` int(11) DEFAULT 0,
  `randomize` tinyint(1) DEFAULT 1,
  `assigned_to` enum('stream','student') DEFAULT 'stream',
  `assigned_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `subject_id` int(11) DEFAULT NULL,
  `duration_minutes` int(11) DEFAULT 60
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tests`
--

INSERT INTO `tests` (`id`, `name`, `stream_id`, `total_questions`, `randomize`, `assigned_to`, `assigned_id`, `created_at`, `subject_id`, `duration_minutes`) VALUES
(2, 'Test 1', 1, 30, 1, 'stream', NULL, '2025-10-31 19:12:05', NULL, 60),
(3, 'Test 2', 1, 60, 1, 'stream', NULL, '2025-11-01 05:06:44', NULL, 60),
(4, 'Test 15', 1, 60, 1, 'stream', NULL, '2025-11-03 09:44:33', NULL, 60);

-- --------------------------------------------------------

--
-- Table structure for table `test_answers`
--

CREATE TABLE `test_answers` (
  `id` int(11) NOT NULL,
  `result_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `selected_option` varchar(10) DEFAULT NULL,
  `is_correct` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `test_assignments`
--

CREATE TABLE `test_assignments` (
  `id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `assigned_to` varchar(50) NOT NULL,
  `assigned_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `test_assignments`
--

INSERT INTO `test_assignments` (`id`, `test_id`, `assigned_to`, `assigned_id`) VALUES
(1, 2, 'stream', 1),
(2, 3, 'stream', 1),
(3, 4, 'stream', 1);

-- --------------------------------------------------------

--
-- Table structure for table `test_attempts`
--

CREATE TABLE `test_attempts` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `question_order` text DEFAULT NULL,
  `score` int(11) DEFAULT 0,
  `status` enum('in_progress','completed') DEFAULT 'in_progress',
  `started_at` datetime DEFAULT current_timestamp(),
  `completed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `test_attempts`
--

INSERT INTO `test_attempts` (`id`, `student_id`, `test_id`, `question_order`, `score`, `status`, `started_at`, `completed_at`) VALUES
(1, 6, 4, '[1053,739,979,290,1062,758,350,401,941,770,1081,241,694,1011,1044,455,488,792,576,656,825,634,961,1110,801,506,1141,540,242,490,431,637,969,227,706,409,335,579,510,224,1022,604,292,984,535,608,1094,940,388,355,323,663,1100,450,685,1007,1158,719,236,232]', 0, 'in_progress', '2025-11-07 00:36:37', NULL),
(2, 7, 4, '[409,431,292,576,706,656,961,535,1094,350,608,355,236,663,241,1011,604,1053,450,388,637,694,770,979,1044,1022,290,323,792,455,232,825,227,579,1062,224,969,634,1081,941,488,739,1141,540,1007,335,506,1110,242,940,1100,719,510,401,685,984,1158,490,758,801]', 0, 'in_progress', '2025-11-08 01:45:00', NULL),
(3, 7, 2, '[291,995,953,247,926,240,236,355,1053,1032,328,985]', 0, 'in_progress', '2025-11-08 01:53:51', NULL),
(4, 7, 2, '[512,401,477,1093,457,1150,550,417,1137]', 0, 'in_progress', '2025-11-08 01:54:05', NULL),
(5, 7, 2, '[401,1137,457,1150,512,477,417,550,1093]', 0, 'in_progress', '2025-11-08 01:54:05', NULL),
(6, 7, 2, '[789,582,719,608,744,655,697,820,628]', 0, 'in_progress', '2025-11-08 01:54:10', NULL),
(7, 7, 2, '[697,820,608,719,789,628,582,655,744]', 0, 'in_progress', '2025-11-08 01:54:10', NULL),
(8, 6, 2, '[995,1053,236,926,953,355,291,985,1032,247,328,240]', 0, 'in_progress', '2025-11-09 18:36:19', NULL),
(9, 6, 2, '[608,697,628,719,744,582,789,655,820]', 0, 'in_progress', '2025-11-09 18:36:27', NULL),
(10, 6, 2, '[697,820,628,655,719,744,608,582,789]', 0, 'in_progress', '2025-11-09 18:36:27', NULL),
(11, 6, 2, '[1150,477,457,1137,1093,512,550,401,417]', 0, 'in_progress', '2025-11-09 18:36:32', NULL),
(12, 6, 2, '[1150,1137,401,457,1093,550,477,512,417]', 0, 'in_progress', '2025-11-09 18:36:32', NULL),
(13, 6, 2, '[1093,401,457,1137,1150,477,512,417,550]', 0, 'in_progress', '2025-11-09 19:31:55', NULL),
(14, 6, 2, '[1093,1137,477,417,401,550,1150,512,457]', 0, 'in_progress', '2025-11-09 19:31:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `test_questions`
--

CREATE TABLE `test_questions` (
  `id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `test_questions`
--

INSERT INTO `test_questions` (`id`, `test_id`, `question_id`) VALUES
(1, 2, 401),
(2, 2, 1137),
(3, 2, 477),
(4, 2, 1093),
(5, 2, 744),
(6, 2, 512),
(7, 2, 582),
(8, 2, 789),
(9, 2, 1150),
(10, 2, 985),
(11, 2, 1053),
(12, 2, 608),
(13, 2, 953),
(14, 2, 236),
(15, 2, 697),
(16, 2, 355),
(17, 2, 926),
(18, 2, 417),
(19, 2, 550),
(20, 2, 328),
(21, 2, 247),
(22, 2, 719),
(23, 2, 240),
(24, 2, 628),
(25, 2, 1032),
(26, 2, 820),
(27, 2, 655),
(28, 2, 291),
(29, 2, 457),
(30, 2, 995),
(31, 3, 1138),
(32, 3, 527),
(33, 3, 421),
(34, 3, 650),
(35, 3, 921),
(36, 3, 511),
(37, 3, 987),
(38, 3, 1065),
(39, 3, 437),
(40, 3, 945),
(41, 3, 1012),
(42, 3, 752),
(43, 3, 1038),
(44, 3, 826),
(45, 3, 446),
(46, 3, 1073),
(47, 3, 1141),
(48, 3, 231),
(49, 3, 746),
(50, 3, 353),
(51, 3, 369),
(52, 3, 951),
(53, 3, 794),
(54, 3, 619),
(55, 3, 242),
(56, 3, 510),
(57, 3, 736),
(58, 3, 1118),
(59, 3, 318),
(60, 3, 814),
(61, 3, 788),
(62, 3, 653),
(63, 3, 692),
(64, 3, 490),
(65, 3, 1099),
(66, 3, 723),
(67, 3, 963),
(68, 3, 228),
(69, 3, 237),
(70, 3, 301),
(71, 3, 425),
(72, 3, 642),
(73, 3, 327),
(74, 3, 567),
(75, 3, 491),
(76, 3, 558),
(77, 3, 1050),
(78, 3, 990),
(79, 3, 612),
(80, 3, 1164),
(81, 3, 585),
(82, 3, 399),
(83, 3, 403),
(84, 3, 685),
(85, 3, 1002),
(86, 3, 244),
(87, 3, 1125),
(88, 3, 551),
(89, 3, 291),
(90, 3, 247),
(91, 4, 941),
(92, 4, 1158),
(93, 4, 431),
(94, 4, 663),
(95, 4, 335),
(96, 4, 227),
(97, 4, 450),
(98, 4, 488),
(99, 4, 323),
(100, 4, 979),
(101, 4, 1062),
(102, 4, 825),
(103, 4, 801),
(104, 4, 1110),
(105, 4, 388),
(106, 4, 355),
(107, 4, 637),
(108, 4, 940),
(109, 4, 292),
(110, 4, 290),
(111, 4, 455),
(112, 4, 770),
(113, 4, 792),
(114, 4, 1141),
(115, 4, 236),
(116, 4, 1081),
(117, 4, 241),
(118, 4, 242),
(119, 4, 1007),
(120, 4, 535),
(121, 4, 510),
(122, 4, 608),
(123, 4, 490),
(124, 4, 706),
(125, 4, 1094),
(126, 4, 1022),
(127, 4, 694),
(128, 4, 576),
(129, 4, 961),
(130, 4, 232),
(131, 4, 579),
(132, 4, 1011),
(133, 4, 1100),
(134, 4, 634),
(135, 4, 969),
(136, 4, 1053),
(137, 4, 1044),
(138, 4, 604),
(139, 4, 758),
(140, 4, 350),
(141, 4, 739),
(142, 4, 540),
(143, 4, 984),
(144, 4, 401),
(145, 4, 656),
(146, 4, 224),
(147, 4, 506),
(148, 4, 409),
(149, 4, 685),
(150, 4, 719);

-- --------------------------------------------------------

--
-- Table structure for table `test_results`
--

CREATE TABLE `test_results` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `score` int(11) DEFAULT 0,
  `total_questions` int(11) DEFAULT 0,
  `percentage` decimal(5,2) DEFAULT 0.00,
  `submitted_at` datetime DEFAULT current_timestamp(),
  `accuracy` decimal(5,2) GENERATED ALWAYS AS (case when `total_questions` > 0 then `score` / `total_questions` * 100 else 0 end) STORED,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `test_results`
--

INSERT INTO `test_results` (`id`, `student_id`, `test_id`, `score`, `total_questions`, `percentage`, `submitted_at`, `created_at`, `updated_at`) VALUES
(1, 7, 2, 0, 7, 0.00, '2025-11-08 01:54:44', '2025-11-03 11:22:47', '2025-11-07 20:24:44'),
(2, 6, 4, 0, 5, 0.00, '2025-11-07 00:44:10', '2025-11-06 19:13:13', '2025-11-06 19:14:10');

-- --------------------------------------------------------

--
-- Table structure for table `test_violations`
--

CREATE TABLE `test_violations` (
  `id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `test_id` int(11) DEFAULT NULL,
  `occurred_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `test_violations`
--

INSERT INTO `test_violations` (`id`, `student_id`, `test_id`, `occurred_at`) VALUES
(1, 6, 2, '2025-11-09 18:41:36'),
(2, 6, 2, '2025-11-09 18:41:38'),
(3, 6, 2, '2025-11-09 18:44:35'),
(4, 6, 2, '2025-11-09 18:44:45'),
(5, 6, 2, '2025-11-09 18:44:52'),
(6, 6, 2, '2025-11-09 18:44:59'),
(7, 6, 2, '2025-11-09 18:45:03'),
(8, 6, 2, '2025-11-09 18:47:18'),
(9, 6, 2, '2025-11-09 18:47:24'),
(10, 6, 2, '2025-11-09 18:47:28'),
(11, 6, 2, '2025-11-09 18:48:28'),
(12, 6, 2, '2025-11-09 18:50:03'),
(13, 6, 2, '2025-11-09 18:50:06'),
(14, 6, 2, '2025-11-09 18:50:17'),
(15, 6, 2, '2025-11-09 18:50:28'),
(16, 6, 2, '2025-11-09 18:50:33'),
(17, 6, 2, '2025-11-09 18:51:48'),
(18, 6, 2, '2025-11-09 18:55:11'),
(19, 6, 2, '2025-11-09 19:14:21'),
(20, 6, 2, '2025-11-09 19:14:27'),
(21, 6, 2, '2025-11-09 19:14:33'),
(22, 6, 2, '2025-11-09 19:14:53');

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
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `idx_category_subject` (`subject_id`);

--
-- Indexes for table `chapters`
--
ALTER TABLE `chapters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `idx_chapter_category` (`category_id`),
  ADD KEY `subject_id` (`subject_id`);

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
-- Indexes for table `results`
--
ALTER TABLE `results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `test_id` (`test_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);

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
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_students_stream` (`stream_id`);

--
-- Indexes for table `student_answers`
--
ALTER TABLE `student_answers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_answer` (`student_id`,`test_id`,`question_id`),
  ADD KEY `test_id` (`test_id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chapter_id` (`chapter_id`),
  ADD KEY `idx_subcategory_chapter` (`chapter_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stream_id` (`stream_id`),
  ADD KEY `idx_subject_stream` (`stream_id`);

--
-- Indexes for table `tests`
--
ALTER TABLE `tests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_test_subject` (`subject_id`);

--
-- Indexes for table `test_answers`
--
ALTER TABLE `test_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `result_id` (`result_id`);

--
-- Indexes for table `test_assignments`
--
ALTER TABLE `test_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `test_id` (`test_id`);

--
-- Indexes for table `test_attempts`
--
ALTER TABLE `test_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `test_id` (`test_id`);

--
-- Indexes for table `test_questions`
--
ALTER TABLE `test_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `test_id` (`test_id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `test_results`
--
ALTER TABLE `test_results`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_result` (`student_id`,`test_id`),
  ADD KEY `test_id` (`test_id`);

--
-- Indexes for table `test_violations`
--
ALTER TABLE `test_violations`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `chapters`
--
ALTER TABLE `chapters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1171;

--
-- AUTO_INCREMENT for table `results`
--
ALTER TABLE `results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `streams`
--
ALTER TABLE `streams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `student_answers`
--
ALTER TABLE `student_answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=219;

--
-- AUTO_INCREMENT for table `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tests`
--
ALTER TABLE `tests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `test_answers`
--
ALTER TABLE `test_answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `test_assignments`
--
ALTER TABLE `test_assignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `test_attempts`
--
ALTER TABLE `test_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `test_questions`
--
ALTER TABLE `test_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- AUTO_INCREMENT for table `test_results`
--
ALTER TABLE `test_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `test_violations`
--
ALTER TABLE `test_violations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

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
  ADD CONSTRAINT `chapters_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chapters_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`);

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
-- Constraints for table `results`
--
ALTER TABLE `results`
  ADD CONSTRAINT `results_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `results_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `fk_students_stream` FOREIGN KEY (`stream_id`) REFERENCES `streams` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_students_streams` FOREIGN KEY (`stream_id`) REFERENCES `streams` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `student_answers`
--
ALTER TABLE `student_answers`
  ADD CONSTRAINT `student_answers_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_answers_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_answers_ibfk_3` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;

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
-- Constraints for table `tests`
--
ALTER TABLE `tests`
  ADD CONSTRAINT `fk_test_subject` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`);

--
-- Constraints for table `test_answers`
--
ALTER TABLE `test_answers`
  ADD CONSTRAINT `test_answers_ibfk_1` FOREIGN KEY (`result_id`) REFERENCES `test_results` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `test_assignments`
--
ALTER TABLE `test_assignments`
  ADD CONSTRAINT `test_assignments_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `test_attempts`
--
ALTER TABLE `test_attempts`
  ADD CONSTRAINT `test_attempts_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `test_attempts_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `test_questions`
--
ALTER TABLE `test_questions`
  ADD CONSTRAINT `test_questions_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `test_questions_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `test_results`
--
ALTER TABLE `test_results`
  ADD CONSTRAINT `test_results_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `test_results_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
