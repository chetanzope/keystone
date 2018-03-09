-- MySQL dump 10.13  Distrib 5.7.21, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: keystone
-- ------------------------------------------------------
-- Server version	5.7.21-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `access_token`
--

DROP TABLE IF EXISTS `access_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_token` (
  `id` varchar(64) NOT NULL,
  `access_secret` varchar(64) NOT NULL,
  `authorizing_user_id` varchar(64) NOT NULL,
  `project_id` varchar(64) NOT NULL,
  `role_ids` text NOT NULL,
  `consumer_id` varchar(64) NOT NULL,
  `expires_at` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_access_token_authorizing_user_id` (`authorizing_user_id`),
  KEY `ix_access_token_consumer_id` (`consumer_id`),
  CONSTRAINT `access_token_ibfk_1` FOREIGN KEY (`consumer_id`) REFERENCES `consumer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_token`
--

LOCK TABLES `access_token` WRITE;
/*!40000 ALTER TABLE `access_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `access_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_credential`
--

DROP TABLE IF EXISTS `application_credential`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_credential` (
  `internal_id` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  `secret_hash` varchar(255) NOT NULL,
  `description` text,
  `user_id` varchar(64) NOT NULL,
  `project_id` varchar(64) DEFAULT NULL,
  `expires_at` bigint(20) DEFAULT NULL,
  `system` varchar(64) DEFAULT NULL,
  `unrestricted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`internal_id`),
  UNIQUE KEY `duplicate_app_cred_constraint` (`user_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_credential`
--

LOCK TABLES `application_credential` WRITE;
/*!40000 ALTER TABLE `application_credential` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_credential` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_credential_role`
--

DROP TABLE IF EXISTS `application_credential_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_credential_role` (
  `application_credential_id` int(11) NOT NULL,
  `role_id` varchar(64) NOT NULL,
  PRIMARY KEY (`application_credential_id`,`role_id`),
  CONSTRAINT `application_credential_role_ibfk_1` FOREIGN KEY (`application_credential_id`) REFERENCES `application_credential` (`internal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_credential_role`
--

LOCK TABLES `application_credential_role` WRITE;
/*!40000 ALTER TABLE `application_credential_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_credential_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignment`
--

DROP TABLE IF EXISTS `assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignment` (
  `type` enum('UserProject','GroupProject','UserDomain','GroupDomain') NOT NULL,
  `actor_id` varchar(64) NOT NULL,
  `target_id` varchar(64) NOT NULL,
  `role_id` varchar(64) NOT NULL,
  `inherited` tinyint(1) NOT NULL,
  PRIMARY KEY (`type`,`actor_id`,`target_id`,`role_id`,`inherited`),
  KEY `ix_actor_id` (`actor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment`
--

LOCK TABLES `assignment` WRITE;
/*!40000 ALTER TABLE `assignment` DISABLE KEYS */;
INSERT INTO `assignment` VALUES ('UserProject','2718bb0d526c49bbaf7be3dd56c22042','6b2aa83e68244bf7800c6dcf64c5b47f','25c4415582624d0eb2446f72868166f5',0),('UserProject','2718bb0d526c49bbaf7be3dd56c22042','c4903924727740d68dd34db8587405d5','25c4415582624d0eb2446f72868166f5',0),('UserProject','2718bb0d526c49bbaf7be3dd56c22042','c4903924727740d68dd34db8587405d5','9fed7da458134864acac6cdccf8a2086',0),('UserProject','42ad352dfd9a43fcae01d6ece24cbf32','40ca160ee23f4568aebc25cb805e0ca5','70fa0f25ac3f4f3ba8f1c5d863afe109',0),('UserProject','42ad352dfd9a43fcae01d6ece24cbf32','6008b47a437e47f684fc8a31feb3ca6f','70fa0f25ac3f4f3ba8f1c5d863afe109',0),('UserProject','42ad352dfd9a43fcae01d6ece24cbf32','c4903924727740d68dd34db8587405d5','70fa0f25ac3f4f3ba8f1c5d863afe109',0),('UserDomain','42ad352dfd9a43fcae01d6ece24cbf32','default','70fa0f25ac3f4f3ba8f1c5d863afe109',0),('GroupProject','4960f5eb26d4418c9e1a38241a217f45','40ca160ee23f4568aebc25cb805e0ca5','25c4415582624d0eb2446f72868166f5',0),('GroupProject','4960f5eb26d4418c9e1a38241a217f45','40ca160ee23f4568aebc25cb805e0ca5','9fed7da458134864acac6cdccf8a2086',0),('GroupProject','4960f5eb26d4418c9e1a38241a217f45','c4903924727740d68dd34db8587405d5','25c4415582624d0eb2446f72868166f5',0),('GroupProject','4960f5eb26d4418c9e1a38241a217f45','c4903924727740d68dd34db8587405d5','9fed7da458134864acac6cdccf8a2086',0),('UserProject','5380c22a34cc43f8831a88230f033d58','ebceb557ab7a46b38c2d0bd41966a09c','cb2597a3d81149459ee8218555a45cc3',0),('UserProject','609cd7757572457e98db3855a755922f','ebceb557ab7a46b38c2d0bd41966a09c','cb2597a3d81149459ee8218555a45cc3',0),('GroupProject','6273f43e06ac4718bef8bb1fd88f2426','6008b47a437e47f684fc8a31feb3ca6f','70fa0f25ac3f4f3ba8f1c5d863afe109',0),('UserProject','b5be4ddfbb114d5f84843e88ca2b77ac','ebceb557ab7a46b38c2d0bd41966a09c','cb2597a3d81149459ee8218555a45cc3',0),('UserProject','c560beda00614430a326be2544970441','40ca160ee23f4568aebc25cb805e0ca5','25c4415582624d0eb2446f72868166f5',0),('UserProject','c560beda00614430a326be2544970441','40ca160ee23f4568aebc25cb805e0ca5','9fed7da458134864acac6cdccf8a2086',0),('UserProject','d56c4cf8dfa94d4bbf037ae64499f075','ebceb557ab7a46b38c2d0bd41966a09c','70fa0f25ac3f4f3ba8f1c5d863afe109',0),('UserProject','d56c4cf8dfa94d4bbf037ae64499f075','ebceb557ab7a46b38c2d0bd41966a09c','cb2597a3d81149459ee8218555a45cc3',0),('UserProject','f8c5fb118f6a4759b249a5c51a06167b','ebceb557ab7a46b38c2d0bd41966a09c','70fa0f25ac3f4f3ba8f1c5d863afe109',0),('UserProject','f8c5fb118f6a4759b249a5c51a06167b','ebceb557ab7a46b38c2d0bd41966a09c','cb2597a3d81149459ee8218555a45cc3',0);
/*!40000 ALTER TABLE `assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_register`
--

DROP TABLE IF EXISTS `config_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config_register` (
  `type` varchar(64) NOT NULL,
  `domain_id` varchar(64) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_register`
--

LOCK TABLES `config_register` WRITE;
/*!40000 ALTER TABLE `config_register` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_register` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumer`
--

DROP TABLE IF EXISTS `consumer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consumer` (
  `id` varchar(64) NOT NULL,
  `description` varchar(64) DEFAULT NULL,
  `secret` varchar(64) NOT NULL,
  `extra` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumer`
--

LOCK TABLES `consumer` WRITE;
/*!40000 ALTER TABLE `consumer` DISABLE KEYS */;
/*!40000 ALTER TABLE `consumer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credential`
--

DROP TABLE IF EXISTS `credential`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credential` (
  `id` varchar(64) NOT NULL,
  `user_id` varchar(64) NOT NULL,
  `project_id` varchar(64) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `extra` text,
  `key_hash` varchar(64) NOT NULL,
  `encrypted_blob` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credential`
--

LOCK TABLES `credential` WRITE;
/*!40000 ALTER TABLE `credential` DISABLE KEYS */;
/*!40000 ALTER TABLE `credential` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endpoint`
--

DROP TABLE IF EXISTS `endpoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endpoint` (
  `id` varchar(64) NOT NULL,
  `legacy_endpoint_id` varchar(64) DEFAULT NULL,
  `interface` varchar(8) NOT NULL,
  `service_id` varchar(64) NOT NULL,
  `url` text NOT NULL,
  `extra` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `region_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `service_id` (`service_id`),
  KEY `fk_endpoint_region_id` (`region_id`),
  CONSTRAINT `endpoint_service_id_fkey` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`),
  CONSTRAINT `fk_endpoint_region_id` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endpoint`
--

LOCK TABLES `endpoint` WRITE;
/*!40000 ALTER TABLE `endpoint` DISABLE KEYS */;
INSERT INTO `endpoint` VALUES ('1c1ddd3bd4194cedbc85b4b3ab829c3c',NULL,'public','f368f582c96241e1954687c751980a26','http://20.20.4.105/volume/','{}',1,'RegionOne'),('4be3a92687e8426ca21e568897730d4f',NULL,'public','b8aaed7db36e499fa0ec6a14eb1f5679','http://20.20.4.105/volume/v1/$(project_id)s','{}',1,'RegionOne'),('6c0a208d1cdf4bbba3bc74f74bdc8f16',NULL,'public','1387dec1913448b4afcafbf6ccb8d8db','http://20.20.4.105/image','{}',1,'RegionOne'),('78b8191595124aa38592e1e837b59a95',NULL,'public','f6595a51863e4ab3ad091f1fb9d2b850','http://20.20.4.105/volume/v2/$(project_id)s','{}',1,'RegionOne'),('8df71ff00b7c43e79b8b8e9fb54729e3',NULL,'admin','0ec5dd202e8e4733b91afb5ed0541a78','http://20.20.4.105/identity','{}',1,'RegionOne'),('975db838e92b406b9428ae78be215b20',NULL,'public','b2d0dd2c815b41239cf945817dd78655','http://20.20.4.105:9696/','{}',1,'RegionOne'),('9960b7ce94c343a0aacd4cecd5381b66',NULL,'public','499fe696d2dc4d5baf6027aa26d70d0c','http://20.20.4.105/placement','{}',1,'RegionOne'),('a766d06d6e0143c3b8db0b38280bf074',NULL,'public','88520acc6e41474da9206ac9f4a5227c','http://20.20.4.105/compute/v2/$(project_id)s','{}',1,'RegionOne'),('b605b09e80f748d29a08bc76a254c32d',NULL,'public','717e51fe8a9b476ab4c75a825373455d','http://20.20.4.105/compute/v2.1','{}',1,'RegionOne'),('df3de34807274bbba54cd20d54362bee',NULL,'public','0ec5dd202e8e4733b91afb5ed0541a78','http://20.20.4.105/identity','{}',1,'RegionOne'),('dfc726c3e8ae4ff59c0698293997a516',NULL,'public','6802bc6ef7f14f4f990cce0913a3b241','http://20.20.4.105/volume/v3/$(project_id)s','{}',1,'RegionOne');
/*!40000 ALTER TABLE `endpoint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endpoint_group`
--

DROP TABLE IF EXISTS `endpoint_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endpoint_group` (
  `id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `filters` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endpoint_group`
--

LOCK TABLES `endpoint_group` WRITE;
/*!40000 ALTER TABLE `endpoint_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `endpoint_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `federated_user`
--

DROP TABLE IF EXISTS `federated_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `federated_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `idp_id` varchar(64) NOT NULL,
  `protocol_id` varchar(64) NOT NULL,
  `unique_id` varchar(255) NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idp_id` (`idp_id`,`protocol_id`,`unique_id`),
  KEY `user_id` (`user_id`),
  KEY `federated_user_protocol_id_fkey` (`protocol_id`,`idp_id`),
  CONSTRAINT `federated_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `federated_user_ibfk_2` FOREIGN KEY (`idp_id`) REFERENCES `identity_provider` (`id`) ON DELETE CASCADE,
  CONSTRAINT `federated_user_protocol_id_fkey` FOREIGN KEY (`protocol_id`, `idp_id`) REFERENCES `federation_protocol` (`id`, `idp_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `federated_user`
--

LOCK TABLES `federated_user` WRITE;
/*!40000 ALTER TABLE `federated_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `federated_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `federation_protocol`
--

DROP TABLE IF EXISTS `federation_protocol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `federation_protocol` (
  `id` varchar(64) NOT NULL,
  `idp_id` varchar(64) NOT NULL,
  `mapping_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`,`idp_id`),
  KEY `idp_id` (`idp_id`),
  CONSTRAINT `federation_protocol_ibfk_1` FOREIGN KEY (`idp_id`) REFERENCES `identity_provider` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `federation_protocol`
--

LOCK TABLES `federation_protocol` WRITE;
/*!40000 ALTER TABLE `federation_protocol` DISABLE KEYS */;
/*!40000 ALTER TABLE `federation_protocol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group` (
  `id` varchar(64) NOT NULL,
  `domain_id` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` text,
  `extra` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ixu_group_name_domain_id` (`domain_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT INTO `group` VALUES ('4960f5eb26d4418c9e1a38241a217f45','default','nonadmins','non-admin group','{}'),('6273f43e06ac4718bef8bb1fd88f2426','default','admins','openstack admin group','{}');
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `id_mapping`
--

DROP TABLE IF EXISTS `id_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `id_mapping` (
  `public_id` varchar(64) NOT NULL,
  `domain_id` varchar(64) NOT NULL,
  `local_id` varchar(64) NOT NULL,
  `entity_type` enum('user','group') NOT NULL,
  PRIMARY KEY (`public_id`),
  UNIQUE KEY `domain_id` (`domain_id`,`local_id`,`entity_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `id_mapping`
--

LOCK TABLES `id_mapping` WRITE;
/*!40000 ALTER TABLE `id_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `id_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `identity_provider`
--

DROP TABLE IF EXISTS `identity_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `identity_provider` (
  `id` varchar(64) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `description` text,
  `domain_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`),
  CONSTRAINT `identity_provider_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_provider`
--

LOCK TABLES `identity_provider` WRITE;
/*!40000 ALTER TABLE `identity_provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `identity_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idp_remote_ids`
--

DROP TABLE IF EXISTS `idp_remote_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idp_remote_ids` (
  `idp_id` varchar(64) DEFAULT NULL,
  `remote_id` varchar(255) NOT NULL,
  PRIMARY KEY (`remote_id`),
  KEY `idp_id` (`idp_id`),
  CONSTRAINT `idp_remote_ids_ibfk_1` FOREIGN KEY (`idp_id`) REFERENCES `identity_provider` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idp_remote_ids`
--

LOCK TABLES `idp_remote_ids` WRITE;
/*!40000 ALTER TABLE `idp_remote_ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `idp_remote_ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `implied_role`
--

DROP TABLE IF EXISTS `implied_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `implied_role` (
  `prior_role_id` varchar(64) NOT NULL,
  `implied_role_id` varchar(64) NOT NULL,
  PRIMARY KEY (`prior_role_id`,`implied_role_id`),
  KEY `implied_role_implied_role_id_fkey` (`implied_role_id`),
  CONSTRAINT `implied_role_implied_role_id_fkey` FOREIGN KEY (`implied_role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE,
  CONSTRAINT `implied_role_prior_role_id_fkey` FOREIGN KEY (`prior_role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `implied_role`
--

LOCK TABLES `implied_role` WRITE;
/*!40000 ALTER TABLE `implied_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `implied_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `limit`
--

DROP TABLE IF EXISTS `limit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `limit` (
  `id` varchar(64) NOT NULL,
  `project_id` varchar(64) DEFAULT NULL,
  `service_id` varchar(255) DEFAULT NULL,
  `region_id` varchar(64) DEFAULT NULL,
  `resource_name` varchar(255) DEFAULT NULL,
  `resource_limit` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`,`service_id`,`region_id`,`resource_name`),
  KEY `limit_service_id_fkey` (`service_id`,`region_id`,`resource_name`),
  CONSTRAINT `limit_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `limit_service_id_fkey` FOREIGN KEY (`service_id`, `region_id`, `resource_name`) REFERENCES `registered_limit` (`service_id`, `region_id`, `resource_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `limit`
--

LOCK TABLES `limit` WRITE;
/*!40000 ALTER TABLE `limit` DISABLE KEYS */;
/*!40000 ALTER TABLE `limit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `local_user`
--

DROP TABLE IF EXISTS `local_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `local_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `domain_id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  `failed_auth_count` int(11) DEFAULT NULL,
  `failed_auth_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain_id` (`domain_id`,`name`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `local_user_user_id_fkey` (`user_id`,`domain_id`),
  CONSTRAINT `local_user_user_id_fkey` FOREIGN KEY (`user_id`, `domain_id`) REFERENCES `user` (`id`, `domain_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `local_user`
--

LOCK TABLES `local_user` WRITE;
/*!40000 ALTER TABLE `local_user` DISABLE KEYS */;
INSERT INTO `local_user` VALUES (1,'42ad352dfd9a43fcae01d6ece24cbf32','default','admin',0,NULL),(2,'2718bb0d526c49bbaf7be3dd56c22042','default','demo',0,NULL),(3,'c560beda00614430a326be2544970441','default','alt_demo',0,NULL),(4,'f8c5fb118f6a4759b249a5c51a06167b','default','nova',0,NULL),(5,'609cd7757572457e98db3855a755922f','default','glance',0,NULL),(6,'b5be4ddfbb114d5f84843e88ca2b77ac','default','cinder',0,NULL),(8,'5380c22a34cc43f8831a88230f033d58','default','neutron',0,NULL),(9,'d56c4cf8dfa94d4bbf037ae64499f075','default','placement',0,NULL);
/*!40000 ALTER TABLE `local_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mapping`
--

DROP TABLE IF EXISTS `mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mapping` (
  `id` varchar(64) NOT NULL,
  `rules` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mapping`
--

LOCK TABLES `mapping` WRITE;
/*!40000 ALTER TABLE `mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrate_version`
--

DROP TABLE IF EXISTS `migrate_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrate_version` (
  `repository_id` varchar(250) NOT NULL,
  `repository_path` text,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`repository_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrate_version`
--

LOCK TABLES `migrate_version` WRITE;
/*!40000 ALTER TABLE `migrate_version` DISABLE KEYS */;
INSERT INTO `migrate_version` VALUES ('keystone','/opt/stack/keystone/keystone/common/sql/migrate_repo',109),('keystone_contract','/opt/stack/keystone/keystone/common/sql/contract_repo',44),('keystone_data_migrate','/opt/stack/keystone/keystone/common/sql/data_migration_repo',44),('keystone_expand','/opt/stack/keystone/keystone/common/sql/expand_repo',44);
/*!40000 ALTER TABLE `migrate_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nonlocal_user`
--

DROP TABLE IF EXISTS `nonlocal_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nonlocal_user` (
  `domain_id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_id` varchar(64) NOT NULL,
  PRIMARY KEY (`domain_id`,`name`),
  UNIQUE KEY `ixu_nonlocal_user_user_id` (`user_id`),
  KEY `nonlocal_user_user_id_fkey` (`user_id`,`domain_id`),
  CONSTRAINT `nonlocal_user_user_id_fkey` FOREIGN KEY (`user_id`, `domain_id`) REFERENCES `user` (`id`, `domain_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nonlocal_user`
--

LOCK TABLES `nonlocal_user` WRITE;
/*!40000 ALTER TABLE `nonlocal_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `nonlocal_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password`
--

DROP TABLE IF EXISTS `password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `local_user_id` int(11) NOT NULL,
  `password` varchar(128) DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `self_service` tinyint(1) NOT NULL DEFAULT '0',
  `password_hash` varchar(255) DEFAULT NULL,
  `created_at_int` bigint(20) NOT NULL DEFAULT '0',
  `expires_at_int` bigint(20) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `local_user_id` (`local_user_id`),
  CONSTRAINT `password_ibfk_1` FOREIGN KEY (`local_user_id`) REFERENCES `local_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password`
--

LOCK TABLES `password` WRITE;
/*!40000 ALTER TABLE `password` DISABLE KEYS */;
INSERT INTO `password` VALUES (1,1,NULL,NULL,0,'$2b$04$09LNUs158/AqSb/b2oSm5e2hk4Lv/Enab9vdYG5M8F6bgOhHmu.Uq',1520311957033218,NULL,'2018-03-06 04:52:37'),(2,2,NULL,NULL,0,'$2b$04$NdEnaFRXQtO7eWK50SCzfeVaRTUkJMJnq6fNkDF1uedDKf0qx05Hq',1520311987523676,NULL,'2018-03-06 04:53:08'),(3,3,NULL,NULL,0,'$2b$04$DZtv6c6NV1kffGr1Qe3tV.pekDODNvfuGdlGzKNiYOGd.nlGwl9DK',1520312015666944,NULL,'2018-03-06 04:53:36'),(4,4,NULL,NULL,0,'$2b$04$l4L3rju4E3zCteHg7f6K8.Domum4LVPm5XtcpMzM7btLXcSB4OeHK',1520312070444981,NULL,'2018-03-06 04:54:30'),(5,5,NULL,NULL,0,'$2b$04$4BAxaU65G6n380mHC8nNfucXUIgLxXrbqAAyd68b2elNNgsJSePmK',1520312101428873,NULL,'2018-03-06 04:55:01'),(6,6,NULL,NULL,0,'$2b$04$QGsAmDAvLxdTxq7ZCu5G7.hrLVzbkAP.OVs29bMRvgyMeqV7l0PeS',1520312120559726,NULL,'2018-03-06 04:55:21'),(7,8,NULL,NULL,0,'$2b$04$Twxwrr1.X4TkvojlhhhyueqdTGLb9EiF2bh3ETgGG4Y89nymeP8u6',1520312164120248,NULL,'2018-03-06 04:56:04'),(8,9,NULL,NULL,0,'$2b$04$bt3rZ07e2QoK8yE3cwN9eecpBV52uRb5aj.wpDSypGGG.3Yj3t6ia',1520312468110345,NULL,'2018-03-06 05:01:08');
/*!40000 ALTER TABLE `password` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `policy`
--

DROP TABLE IF EXISTS `policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy` (
  `id` varchar(64) NOT NULL,
  `type` varchar(255) NOT NULL,
  `blob` text NOT NULL,
  `extra` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policy`
--

LOCK TABLES `policy` WRITE;
/*!40000 ALTER TABLE `policy` DISABLE KEYS */;
/*!40000 ALTER TABLE `policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `policy_association`
--

DROP TABLE IF EXISTS `policy_association`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_association` (
  `id` varchar(64) NOT NULL,
  `policy_id` varchar(64) NOT NULL,
  `endpoint_id` varchar(64) DEFAULT NULL,
  `service_id` varchar(64) DEFAULT NULL,
  `region_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `endpoint_id` (`endpoint_id`,`service_id`,`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policy_association`
--

LOCK TABLES `policy_association` WRITE;
/*!40000 ALTER TABLE `policy_association` DISABLE KEYS */;
/*!40000 ALTER TABLE `policy_association` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `id` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `extra` text,
  `description` text,
  `enabled` tinyint(1) DEFAULT NULL,
  `domain_id` varchar(64) NOT NULL,
  `parent_id` varchar(64) DEFAULT NULL,
  `is_domain` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ixu_project_name_domain_id` (`domain_id`,`name`),
  KEY `project_parent_id_fkey` (`parent_id`),
  CONSTRAINT `project_domain_id_fkey` FOREIGN KEY (`domain_id`) REFERENCES `project` (`id`),
  CONSTRAINT `project_parent_id_fkey` FOREIGN KEY (`parent_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES ('40ca160ee23f4568aebc25cb805e0ca5','alt_demo','{}','',1,'default','default',0),('6008b47a437e47f684fc8a31feb3ca6f','admin','{}','Bootstrap project for initializing the cloud.',1,'default','default',0),('6b2aa83e68244bf7800c6dcf64c5b47f','invisible_to_admin','{}','',1,'default','default',0),('<<keystone.domain.root>>','<<keystone.domain.root>>','{}','',0,'<<keystone.domain.root>>',NULL,1),('c4903924727740d68dd34db8587405d5','demo','{}','',1,'default','default',0),('default','Default','{}','The default domain',1,'<<keystone.domain.root>>',NULL,1),('ebceb557ab7a46b38c2d0bd41966a09c','service','{}','',1,'default','default',0);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_endpoint`
--

DROP TABLE IF EXISTS `project_endpoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_endpoint` (
  `endpoint_id` varchar(64) NOT NULL,
  `project_id` varchar(64) NOT NULL,
  PRIMARY KEY (`endpoint_id`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_endpoint`
--

LOCK TABLES `project_endpoint` WRITE;
/*!40000 ALTER TABLE `project_endpoint` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_endpoint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_endpoint_group`
--

DROP TABLE IF EXISTS `project_endpoint_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_endpoint_group` (
  `endpoint_group_id` varchar(64) NOT NULL,
  `project_id` varchar(64) NOT NULL,
  PRIMARY KEY (`endpoint_group_id`,`project_id`),
  CONSTRAINT `project_endpoint_group_ibfk_1` FOREIGN KEY (`endpoint_group_id`) REFERENCES `endpoint_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_endpoint_group`
--

LOCK TABLES `project_endpoint_group` WRITE;
/*!40000 ALTER TABLE `project_endpoint_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_endpoint_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_tag`
--

DROP TABLE IF EXISTS `project_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_tag` (
  `project_id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`project_id`,`name`),
  UNIQUE KEY `project_id` (`project_id`,`name`),
  CONSTRAINT `project_tag_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_tag`
--

LOCK TABLES `project_tag` WRITE;
/*!40000 ALTER TABLE `project_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `region` (
  `id` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `parent_region_id` varchar(255) DEFAULT NULL,
  `extra` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES ('RegionOne','',NULL,'{}');
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registered_limit`
--

DROP TABLE IF EXISTS `registered_limit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registered_limit` (
  `id` varchar(64) NOT NULL,
  `service_id` varchar(255) DEFAULT NULL,
  `region_id` varchar(64) DEFAULT NULL,
  `resource_name` varchar(255) DEFAULT NULL,
  `default_limit` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `service_id` (`service_id`,`region_id`,`resource_name`),
  KEY `region_id` (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registered_limit`
--

LOCK TABLES `registered_limit` WRITE;
/*!40000 ALTER TABLE `registered_limit` DISABLE KEYS */;
/*!40000 ALTER TABLE `registered_limit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request_token`
--

DROP TABLE IF EXISTS `request_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `request_token` (
  `id` varchar(64) NOT NULL,
  `request_secret` varchar(64) NOT NULL,
  `verifier` varchar(64) DEFAULT NULL,
  `authorizing_user_id` varchar(64) DEFAULT NULL,
  `requested_project_id` varchar(64) NOT NULL,
  `role_ids` text,
  `consumer_id` varchar(64) NOT NULL,
  `expires_at` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_request_token_consumer_id` (`consumer_id`),
  CONSTRAINT `request_token_ibfk_1` FOREIGN KEY (`consumer_id`) REFERENCES `consumer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request_token`
--

LOCK TABLES `request_token` WRITE;
/*!40000 ALTER TABLE `request_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `request_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revocation_event`
--

DROP TABLE IF EXISTS `revocation_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revocation_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` varchar(64) DEFAULT NULL,
  `project_id` varchar(64) DEFAULT NULL,
  `user_id` varchar(64) DEFAULT NULL,
  `role_id` varchar(64) DEFAULT NULL,
  `trust_id` varchar(64) DEFAULT NULL,
  `consumer_id` varchar(64) DEFAULT NULL,
  `access_token_id` varchar(64) DEFAULT NULL,
  `issued_before` datetime NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `revoked_at` datetime NOT NULL,
  `audit_id` varchar(32) DEFAULT NULL,
  `audit_chain_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_revocation_event_new_revoked_at` (`revoked_at`),
  KEY `ix_revocation_event_issued_before` (`issued_before`),
  KEY `ix_revocation_event_project_id_issued_before` (`project_id`,`issued_before`),
  KEY `ix_revocation_event_user_id_issued_before` (`user_id`,`issued_before`),
  KEY `ix_revocation_event_audit_id_issued_before` (`audit_id`,`issued_before`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revocation_event`
--

LOCK TABLES `revocation_event` WRITE;
/*!40000 ALTER TABLE `revocation_event` DISABLE KEYS */;
INSERT INTO `revocation_event` VALUES (1,NULL,NULL,'b4326f572ab5434ead43ad5b08549a96',NULL,NULL,NULL,NULL,'2018-03-06 05:13:47',NULL,'2018-03-06 05:13:47',NULL,NULL),(2,NULL,'9ddffd1af96547f1998a2e165101bd23',NULL,NULL,NULL,NULL,NULL,'2018-03-06 05:13:48',NULL,'2018-03-06 05:13:48',NULL,NULL);
/*!40000 ALTER TABLE `revocation_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  `extra` text,
  `domain_id` varchar(64) NOT NULL DEFAULT '<<null>>',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ixu_role_name_domain_id` (`name`,`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES ('25c4415582624d0eb2446f72868166f5','Member','{}','<<null>>'),('70fa0f25ac3f4f3ba8f1c5d863afe109','admin','{}','<<null>>'),('9454c58f4e14469994e55aa70a5b8eaa','ResellerAdmin','{}','<<null>>'),('9fed7da458134864acac6cdccf8a2086','anotherrole','{}','<<null>>'),('cb2597a3d81149459ee8218555a45cc3','service','{}','<<null>>');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensitive_config`
--

DROP TABLE IF EXISTS `sensitive_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensitive_config` (
  `domain_id` varchar(64) NOT NULL,
  `group` varchar(255) NOT NULL,
  `option` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`domain_id`,`group`,`option`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensitive_config`
--

LOCK TABLES `sensitive_config` WRITE;
/*!40000 ALTER TABLE `sensitive_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `sensitive_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service` (
  `id` varchar(64) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `extra` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES ('0ec5dd202e8e4733b91afb5ed0541a78','identity',1,'{\"name\": \"keystone\"}'),('1387dec1913448b4afcafbf6ccb8d8db','image',1,'{\"description\": \"Glance Image Service\", \"name\": \"glance\"}'),('499fe696d2dc4d5baf6027aa26d70d0c','placement',1,'{\"description\": \"Placement Service\", \"name\": \"placement\"}'),('6802bc6ef7f14f4f990cce0913a3b241','volumev3',1,'{\"description\": \"Cinder Volume Service V3\", \"name\": \"cinderv3\"}'),('717e51fe8a9b476ab4c75a825373455d','compute',1,'{\"description\": \"Nova Compute Service\", \"name\": \"nova\"}'),('88520acc6e41474da9206ac9f4a5227c','compute_legacy',1,'{\"description\": \"Nova Compute Service (Legacy 2.0)\", \"name\": \"nova_legacy\"}'),('b2d0dd2c815b41239cf945817dd78655','network',1,'{\"description\": \"Neutron Service\", \"name\": \"neutron\"}'),('b8aaed7db36e499fa0ec6a14eb1f5679','volume',1,'{\"description\": \"Cinder Volume Service\", \"name\": \"cinder\"}'),('f368f582c96241e1954687c751980a26','block-storage',1,'{\"description\": \"Cinder Volume Service\", \"name\": \"cinder\"}'),('f6595a51863e4ab3ad091f1fb9d2b850','volumev2',1,'{\"description\": \"Cinder Volume Service V2\", \"name\": \"cinderv2\"}');
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_provider`
--

DROP TABLE IF EXISTS `service_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_provider` (
  `auth_url` varchar(256) NOT NULL,
  `id` varchar(64) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `description` text,
  `sp_url` varchar(256) NOT NULL,
  `relay_state_prefix` varchar(256) NOT NULL DEFAULT 'ss:mem:',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_provider`
--

LOCK TABLES `service_provider` WRITE;
/*!40000 ALTER TABLE `service_provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_assignment`
--

DROP TABLE IF EXISTS `system_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_assignment` (
  `type` varchar(64) NOT NULL,
  `actor_id` varchar(64) NOT NULL,
  `target_id` varchar(64) NOT NULL,
  `role_id` varchar(64) NOT NULL,
  `inherited` tinyint(1) NOT NULL,
  PRIMARY KEY (`type`,`actor_id`,`target_id`,`role_id`,`inherited`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_assignment`
--

LOCK TABLES `system_assignment` WRITE;
/*!40000 ALTER TABLE `system_assignment` DISABLE KEYS */;
INSERT INTO `system_assignment` VALUES ('UserSystem','42ad352dfd9a43fcae01d6ece24cbf32','system','70fa0f25ac3f4f3ba8f1c5d863afe109',0);
/*!40000 ALTER TABLE `system_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `id` varchar(64) NOT NULL,
  `expires` datetime DEFAULT NULL,
  `extra` text,
  `valid` tinyint(1) NOT NULL,
  `trust_id` varchar(64) DEFAULT NULL,
  `user_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_token_expires` (`expires`),
  KEY `ix_token_expires_valid` (`expires`,`valid`),
  KEY `ix_token_user_id` (`user_id`),
  KEY `ix_token_trust_id` (`trust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trust`
--

DROP TABLE IF EXISTS `trust`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trust` (
  `id` varchar(64) NOT NULL,
  `trustor_user_id` varchar(64) NOT NULL,
  `trustee_user_id` varchar(64) NOT NULL,
  `project_id` varchar(64) DEFAULT NULL,
  `impersonation` tinyint(1) NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `remaining_uses` int(11) DEFAULT NULL,
  `extra` text,
  `expires_at_int` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `duplicate_trust_constraint_expanded` (`trustor_user_id`,`trustee_user_id`,`project_id`,`impersonation`,`expires_at`,`expires_at_int`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trust`
--

LOCK TABLES `trust` WRITE;
/*!40000 ALTER TABLE `trust` DISABLE KEYS */;
/*!40000 ALTER TABLE `trust` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trust_role`
--

DROP TABLE IF EXISTS `trust_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trust_role` (
  `trust_id` varchar(64) NOT NULL,
  `role_id` varchar(64) NOT NULL,
  PRIMARY KEY (`trust_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trust_role`
--

LOCK TABLES `trust_role` WRITE;
/*!40000 ALTER TABLE `trust_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `trust_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` varchar(64) NOT NULL,
  `extra` text,
  `enabled` tinyint(1) DEFAULT NULL,
  `default_project_id` varchar(64) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `last_active_at` date DEFAULT NULL,
  `domain_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ixu_user_id_domain_id` (`id`,`domain_id`),
  KEY `domain_id` (`domain_id`),
  KEY `ix_default_project_id` (`default_project_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('2718bb0d526c49bbaf7be3dd56c22042','{\"email\": \"demo@example.com\"}',1,NULL,'2018-03-06 04:53:08',NULL,'default'),('42ad352dfd9a43fcae01d6ece24cbf32','{}',1,NULL,'2018-03-06 04:52:37',NULL,'default'),('5380c22a34cc43f8831a88230f033d58','{}',1,NULL,'2018-03-06 04:56:04',NULL,'default'),('609cd7757572457e98db3855a755922f','{}',1,NULL,'2018-03-06 04:55:01',NULL,'default'),('b5be4ddfbb114d5f84843e88ca2b77ac','{}',1,NULL,'2018-03-06 04:55:21',NULL,'default'),('c560beda00614430a326be2544970441','{\"email\": \"alt_demo@example.com\"}',1,NULL,'2018-03-06 04:53:36',NULL,'default'),('d56c4cf8dfa94d4bbf037ae64499f075','{}',1,NULL,'2018-03-06 05:01:08',NULL,'default'),('f8c5fb118f6a4759b249a5c51a06167b','{}',1,NULL,'2018-03-06 04:54:30',NULL,'default');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group_membership`
--

DROP TABLE IF EXISTS `user_group_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group_membership` (
  `user_id` varchar(64) NOT NULL,
  `group_id` varchar(64) NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `fk_user_group_membership_group_id` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`),
  CONSTRAINT `fk_user_group_membership_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group_membership`
--

LOCK TABLES `user_group_membership` WRITE;
/*!40000 ALTER TABLE `user_group_membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_group_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_option`
--

DROP TABLE IF EXISTS `user_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_option` (
  `user_id` varchar(64) NOT NULL,
  `option_id` varchar(4) NOT NULL,
  `option_value` text,
  PRIMARY KEY (`user_id`,`option_id`),
  CONSTRAINT `user_option_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_option`
--

LOCK TABLES `user_option` WRITE;
/*!40000 ALTER TABLE `user_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `whitelisted_config`
--

DROP TABLE IF EXISTS `whitelisted_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `whitelisted_config` (
  `domain_id` varchar(64) NOT NULL,
  `group` varchar(255) NOT NULL,
  `option` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`domain_id`,`group`,`option`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `whitelisted_config`
--

LOCK TABLES `whitelisted_config` WRITE;
/*!40000 ALTER TABLE `whitelisted_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `whitelisted_config` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-07 17:35:56
