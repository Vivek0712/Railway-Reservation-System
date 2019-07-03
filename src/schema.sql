CREATE DATABASE `railway` /*!40100 DEFAULT CHARACTER SET latin1 */;
CREATE TABLE `booking` (
  `pnr_no` int(11) NOT NULL,
  `email_id` varchar(45) NOT NULL,
  `no_of_tickets` int(11) NOT NULL,
  `booked_date` varchar(45) NOT NULL,
  `total_cost` float NOT NULL,
  PRIMARY KEY (`pnr_no`),
  KEY `email_id_idx` (`email_id`),
  CONSTRAINT `email_id` FOREIGN KEY (`email_id`) REFERENCES `login` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `login` (
  `email` varchar(45) NOT NULL,
  `pass` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `pnr_status` (
  `pnr_no` int(11) NOT NULL,
  `train_no` int(11) NOT NULL,
  `p_name` varchar(45) NOT NULL,
  `age` int(11) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `date_of_journey` varchar(45) NOT NULL,
  `source_code` varchar(5) NOT NULL,
  `des_code` varchar(5) NOT NULL,
  `status` varchar(10) NOT NULL,
  `seat_no` varchar(10) NOT NULL,
  `class` varchar(5) DEFAULT NULL,
  KEY `pnr_map_idx` (`pnr_no`),
  KEY `train_pnr_map_idx` (`train_no`),
  KEY `source_map_idx` (`source_code`),
  KEY `dest_map_idx` (`des_code`),
  KEY `class_idx` (`class`),
  CONSTRAINT `dest_map` FOREIGN KEY (`des_code`) REFERENCES `train_route` (`station_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `pnr_map` FOREIGN KEY (`pnr_no`) REFERENCES `booking` (`pnr_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `source_map` FOREIGN KEY (`source_code`) REFERENCES `train_route` (`station_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `train_pnr_map` FOREIGN KEY (`train_no`) REFERENCES `train_details` (`train_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `running_days` (
  `train_no` int(11) NOT NULL,
  `day` varchar(10) NOT NULL,
  KEY `train_no_idx` (`train_no`),
  CONSTRAINT `train_no` FOREIGN KEY (`train_no`) REFERENCES `train_details` (`train_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `seat_details` (
  `train_no` int(11) NOT NULL,
  `class` varchar(5) NOT NULL,
  `fare` float NOT NULL,
  `total_seats` int(11) NOT NULL,
  KEY `train_no_seat_map_idx` (`train_no`),
  CONSTRAINT `train_no_seat_map` FOREIGN KEY (`train_no`) REFERENCES `train_details` (`train_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `station` (
  `station_name` varchar(20) NOT NULL,
  `station_code` varchar(5) NOT NULL,
  PRIMARY KEY (`station_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `train_details` (
  `train_no` int(11) NOT NULL,
  `train_name` varchar(45) NOT NULL,
  PRIMARY KEY (`train_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `train_route` (
  `train_no` int(11) NOT NULL,
  `station_code` varchar(10) NOT NULL,
  `station_count` int(11) NOT NULL,
  `arrival_time` varchar(10) NOT NULL,
  `departure_time` varchar(10) NOT NULL,
  KEY `train_no_idx` (`train_no`),
  KEY `station_code_idx` (`station_code`),
  CONSTRAINT `station_code_map` FOREIGN KEY (`station_code`) REFERENCES `station` (`station_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `train_no_map` FOREIGN KEY (`train_no`) REFERENCES `train_details` (`train_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
