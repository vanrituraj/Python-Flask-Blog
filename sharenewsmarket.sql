-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 27, 2021 at 06:13 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sharenewsmarket`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `email` varchar(32) NOT NULL,
  `phone_num` varchar(12) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_num`, `msg`, `date`) VALUES
(1, 'rituraj vankhede', 'van.ritu.333@gmail.com', '09584509798', 'msg is sent', '2021-11-25 14:41:58'),
(2, 'rituraj vankhede', 'van.ritu.333@gmail.com', '09584509798', 'rituraj hu', '2021-11-25 15:58:13'),
(3, 'rituraj vankhede', 'van.ritu.333@gmail.com', '09584509798', 'rituraj hu', '2021-11-25 15:58:40'),
(4, 'rituraj vankhede', 'van.ritu.333@gmail.com', '09584509798', 'rituraj hu', '2021-11-25 15:59:12'),
(5, 'rituraj vankhede', 'van.ritu.333@gmail.com', '09584509798', 'rituraj hu', '2021-11-25 16:34:00'),
(6, 'rituraj vankhede', 'van.ritu.333@gmail.com', '09584509798', 'rituraj hu', '2021-11-25 16:35:51');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` varchar(35) NOT NULL,
  `tagline` varchar(50) NOT NULL,
  `slug` varchar(35) NOT NULL,
  `content` varchar(300) NOT NULL,
  `img_file` varchar(32) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'this is first', 'क्या छोटी NAV नेट एसेट वैल्यू (Net Asset Value) अच', 'first post', 'जब आप म्यूच्यूअल फण्ड में निवेश करने की सुरुआत करते है तब आप शुरु में ही NAV को देखना है की आपकी NAV नेट एसेट वैल्यू (Net Asset Value) कितनी है और जब आप म्यूच्यूअल फंड्स को बेचने जाते है तब आपको देखना है की उस समय आपको NAV नेट एसेट वैल्यू (Net Asset Value) कितनी है |\r\nऔर आखरी में जो भी अंतर (differe', '1-bg.jpg', '2021-11-25 10:08:00'),
(2, 'Asset Value) अच्छी होती है या बड़ी ', ' अगर infosis का शेयर आपको ', 'second post', 'लेकिन इसमें लोगो को बहुत confusion होता है की क्या छोटी NAV नेट एसेट वैल्यू (Net Asset Value) अच्छी होती है या बड़ी NAV नेट एसेट वैल्यू (Net Asset Value) अच्छी होती है|\r\nजैसे :- अगर आप शेयर मार्केट में नये है तो आपको confusion होता है की 10रु या 20रु वाले शेयर अच्छे होते है या 200 रु या 1000 रुपये वा', '2-bg.jpg', '2021-11-25 10:13:31'),
(3, 'आपका फण्ड अच्छा परफॉर्म (perform) क', 'फण्ड का ऑब्जेक्टिव (Objective) देखना चाहिए ?', 'third post', 'जब कोई फण्ड आपनी स्कीम में ये बोलता है की मेरा बेचमार्क ये चीजे है जैसे :-\r\nकोई डायवर्सिफाय (diversify) फण्ड है और बोलता है की मेरा बेंचमार्क निफ्टी है तो हमे ये देखना है की निफ्टी के मुकाबले में क्या इस फण्ड ने अच्छा परफॉर्म किया है |\r\nअगर जवाब मिलता है हा तो ये फण्ड अच्छा है\r\nऔर अगर जवाब मिलता है ', '', '2021-11-25 10:16:39'),
(4, 'बेंचमार्क से तुलना करना आसान हो जात', '', 'fourth', 'अगर आपको कोई बोले की किसी फण्ड ने आपको 15 % का रिटर्न दिया है तो आपको पता नही चलेगा की ये एक अच्छा रिटर्न है की नही है |\r\nऐसे में ये बेंचमार्क से पता करना आसान होता है ये के अच्छा रिटर्न है ख़राब है |\r\nबेंचमार्क एक आधार होता है जिससे आप जान सकते है की किसी फण्ड का परफॉर्म कैसा रहा है', '', '2021-11-25 10:17:44'),
(5, 'NFO:- NFO मतलब की न्यू फण्ड ऑफर (Ne', '', 'fifth post', 'मानलो 2 फण्ड है और दोनों का पोर्टफोलियो भी एक सामान है |\r\nऔर इसमें से किसी एक की NAV 10 रु है\r\nऔर दुसरे की NAV 200 रु है |\r\nतो एसा हो सकता है क्यकी कोई फण्ड 12 साल पहले शुरु किया हो और कोई फण्ड 6 महीने पहले ही शुरु हुआ हो | तो ऐसे में दोनों फण्ड की NAV अलग हो सकती है |\r\nऔर अगर दोनों का पोर्टफोलियो 1', '', '2021-11-25 10:18:16'),
(6, 'आपका फण्ड अच्छा परफॉर्म (perform) क', '', 'sixth post', 'जब भी आप किसी फण्ड में पैसा लगाते है तो उस फण्ड की परफॉरमेंस देखने के लिए की वो अच्छा कर रहा है की नही, आपको कुछ चीजे देखनी होगी जैसे :-\r\n\r\nफण्ड का ऑब्जेक्टिव (Objective) देखना चाहिए ?', '', '2021-11-25 10:19:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
