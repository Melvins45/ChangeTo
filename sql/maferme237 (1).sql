-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 28 nov. 2025 à 09:21
-- Version du serveur : 10.4.24-MariaDB
-- Version de PHP : 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `maferme237`
--

-- --------------------------------------------------------

--
-- Structure de la table `administrateurs`
--

CREATE TABLE `administrateurs` (
  `idAdministrateur` int(11) NOT NULL,
  `niveauAccesAdministrateur` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `caracteristiques`
--

CREATE TABLE `caracteristiques` (
  `idCaracteristique` int(11) NOT NULL,
  `nomCaracteristique` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

CREATE TABLE `clients` (
  `idClient` int(11) NOT NULL,
  `adresseClient` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `entreprises`
--

CREATE TABLE `entreprises` (
  `idEntreprise` int(11) NOT NULL,
  `secteurActiviteEntreprise` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `etapeproductions`
--

CREATE TABLE `etapeproductions` (
  `idEtapeProduction` int(11) NOT NULL,
  `descriptionEtapeProduction` text DEFAULT NULL,
  `dateEtapeProduction` datetime DEFAULT NULL,
  `idProduit` int(11) NOT NULL,
  `idFournisseur` int(11) DEFAULT NULL,
  `idProducteur` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `fournisseurs`
--

CREATE TABLE `fournisseurs` (
  `idFournisseur` int(11) NOT NULL,
  `noteClientFournisseur` float DEFAULT NULL,
  `noteEntrepriseFournisseur` float DEFAULT NULL,
  `verifieFournisseur` tinyint(1) DEFAULT NULL,
  `historiqueProduits` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `gestionnaires`
--

CREATE TABLE `gestionnaires` (
  `idGestionnaire` int(11) NOT NULL,
  `roleGestionnaire` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `ligneprecommandes`
--

CREATE TABLE `ligneprecommandes` (
  `quantite` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `PrecommandeIdPrecommande` int(11) NOT NULL,
  `ProduitIdProduit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `livraisons`
--

CREATE TABLE `livraisons` (
  `idLivraison` int(11) NOT NULL,
  `lieuLivraison` varchar(255) DEFAULT NULL,
  `dateDebutLivraison` datetime DEFAULT NULL,
  `dateFinLivraison` datetime DEFAULT NULL,
  `idPrecommande` int(11) NOT NULL,
  `idClient` int(11) DEFAULT NULL,
  `idGestionnaire` int(11) DEFAULT NULL,
  `idLivreur` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `livreurs`
--

CREATE TABLE `livreurs` (
  `idLivreur` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `paiements`
--

CREATE TABLE `paiements` (
  `idPaiement` int(11) NOT NULL,
  `idTransaction` varchar(255) NOT NULL,
  `modePaiement` varchar(255) NOT NULL,
  `datePaiement` datetime DEFAULT NULL,
  `idPrecommande` int(11) NOT NULL,
  `idLivraison` int(11) NOT NULL,
  `idLivreur` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `idGestionnaire` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `personnes`
--

CREATE TABLE `personnes` (
  `idPersonne` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `prenomPersonne` varchar(255) NOT NULL,
  `emailPersonne` varchar(255) NOT NULL,
  `motDePassePersonne` varchar(255) NOT NULL,
  `telephonePersonne` varchar(255) DEFAULT NULL,
  `dateCreationCompte` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `pointlivraisons`
--

CREATE TABLE `pointlivraisons` (
  `idPointLivraison` int(11) NOT NULL,
  `adressePointLivraison` varchar(255) DEFAULT NULL,
  `idEntreprise` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `idGestionnaire` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `precommandes`
--

CREATE TABLE `precommandes` (
  `idPrecommande` int(11) NOT NULL,
  `datePrecommande` datetime DEFAULT NULL,
  `statutPrecommande` varchar(255) DEFAULT NULL,
  `idClient` int(11) DEFAULT NULL,
  `idEntreprise` int(11) DEFAULT NULL,
  `idGestionnaire` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `producteurs`
--

CREATE TABLE `producteurs` (
  `idProducteur` int(11) NOT NULL,
  `specialiteProducteur` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `produitcaracteristiques`
--

CREATE TABLE `produitcaracteristiques` (
  `valeurCaracteristique` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `ProduitIdProduit` int(11) NOT NULL,
  `CaracteristiqueIdCaracteristique` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

CREATE TABLE `produits` (
  `idProduit` int(11) NOT NULL,
  `nomProduit` varchar(255) DEFAULT NULL,
  `descriptionProduit` text DEFAULT NULL,
  `prixClientProduit` float DEFAULT NULL,
  `prixEntrepriseProduit` float DEFAULT NULL,
  `prixFournisseurProduit` float DEFAULT NULL,
  `stockProduit` int(11) DEFAULT NULL,
  `stockFournisseurProduit` int(11) DEFAULT NULL,
  `quantiteMinProduitEntreprise` int(11) DEFAULT NULL,
  `quantiteMinProduitClient` int(11) DEFAULT NULL,
  `photosProduit` varchar(255) DEFAULT NULL,
  `statutVerificationProduit` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `idFournisseur` int(11) DEFAULT NULL,
  `idGestionnaire` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `souhaitproduits`
--

CREATE TABLE `souhaitproduits` (
  `idSouhaitProduit` int(11) NOT NULL,
  `descriptionSouhaitProduit` text DEFAULT NULL,
  `dateSouhaitProduit` datetime DEFAULT NULL,
  `idClient` int(11) DEFAULT NULL,
  `idEntreprise` int(11) DEFAULT NULL,
  `idFournisseur` int(11) DEFAULT NULL,
  `idGestionnaire` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `objetSouhaitProduit` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `administrateurs`
--
ALTER TABLE `administrateurs`
  ADD PRIMARY KEY (`idAdministrateur`);

--
-- Index pour la table `caracteristiques`
--
ALTER TABLE `caracteristiques`
  ADD PRIMARY KEY (`idCaracteristique`);

--
-- Index pour la table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`idClient`);

--
-- Index pour la table `entreprises`
--
ALTER TABLE `entreprises`
  ADD PRIMARY KEY (`idEntreprise`);

--
-- Index pour la table `etapeproductions`
--
ALTER TABLE `etapeproductions`
  ADD PRIMARY KEY (`idEtapeProduction`),
  ADD KEY `idProduit` (`idProduit`),
  ADD KEY `idFournisseur` (`idFournisseur`),
  ADD KEY `idProducteur` (`idProducteur`);

--
-- Index pour la table `fournisseurs`
--
ALTER TABLE `fournisseurs`
  ADD PRIMARY KEY (`idFournisseur`);

--
-- Index pour la table `gestionnaires`
--
ALTER TABLE `gestionnaires`
  ADD PRIMARY KEY (`idGestionnaire`);

--
-- Index pour la table `ligneprecommandes`
--
ALTER TABLE `ligneprecommandes`
  ADD PRIMARY KEY (`PrecommandeIdPrecommande`,`ProduitIdProduit`),
  ADD KEY `ProduitIdProduit` (`ProduitIdProduit`);

--
-- Index pour la table `livraisons`
--
ALTER TABLE `livraisons`
  ADD PRIMARY KEY (`idLivraison`),
  ADD KEY `idPrecommande` (`idPrecommande`),
  ADD KEY `idClient` (`idClient`),
  ADD KEY `idGestionnaire` (`idGestionnaire`),
  ADD KEY `idLivreur` (`idLivreur`);

--
-- Index pour la table `livreurs`
--
ALTER TABLE `livreurs`
  ADD PRIMARY KEY (`idLivreur`);

--
-- Index pour la table `paiements`
--
ALTER TABLE `paiements`
  ADD PRIMARY KEY (`idPaiement`),
  ADD KEY `idPrecommande` (`idPrecommande`),
  ADD KEY `idLivraison` (`idLivraison`),
  ADD KEY `idLivreur` (`idLivreur`),
  ADD KEY `idGestionnaire` (`idGestionnaire`);

--
-- Index pour la table `personnes`
--
ALTER TABLE `personnes`
  ADD PRIMARY KEY (`idPersonne`),
  ADD UNIQUE KEY `emailPersonne` (`emailPersonne`);

--
-- Index pour la table `pointlivraisons`
--
ALTER TABLE `pointlivraisons`
  ADD PRIMARY KEY (`idPointLivraison`),
  ADD KEY `idGestionnaire` (`idGestionnaire`),
  ADD KEY `idEntreprise` (`idEntreprise`);

--
-- Index pour la table `precommandes`
--
ALTER TABLE `precommandes`
  ADD PRIMARY KEY (`idPrecommande`),
  ADD KEY `idClient` (`idClient`),
  ADD KEY `idEntreprise` (`idEntreprise`),
  ADD KEY `idGestionnaire` (`idGestionnaire`);

--
-- Index pour la table `producteurs`
--
ALTER TABLE `producteurs`
  ADD PRIMARY KEY (`idProducteur`);

--
-- Index pour la table `produitcaracteristiques`
--
ALTER TABLE `produitcaracteristiques`
  ADD PRIMARY KEY (`ProduitIdProduit`,`CaracteristiqueIdCaracteristique`),
  ADD KEY `CaracteristiqueIdCaracteristique` (`CaracteristiqueIdCaracteristique`);

--
-- Index pour la table `produits`
--
ALTER TABLE `produits`
  ADD PRIMARY KEY (`idProduit`),
  ADD KEY `idFournisseur` (`idFournisseur`),
  ADD KEY `idGestionnaire` (`idGestionnaire`);

--
-- Index pour la table `souhaitproduits`
--
ALTER TABLE `souhaitproduits`
  ADD PRIMARY KEY (`idSouhaitProduit`),
  ADD KEY `idClient` (`idClient`),
  ADD KEY `idEntreprise` (`idEntreprise`),
  ADD KEY `idFournisseur` (`idFournisseur`),
  ADD KEY `idGestionnaire` (`idGestionnaire`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `caracteristiques`
--
ALTER TABLE `caracteristiques`
  MODIFY `idCaracteristique` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `etapeproductions`
--
ALTER TABLE `etapeproductions`
  MODIFY `idEtapeProduction` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `livraisons`
--
ALTER TABLE `livraisons`
  MODIFY `idLivraison` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `paiements`
--
ALTER TABLE `paiements`
  MODIFY `idPaiement` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `personnes`
--
ALTER TABLE `personnes`
  MODIFY `idPersonne` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `pointlivraisons`
--
ALTER TABLE `pointlivraisons`
  MODIFY `idPointLivraison` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `precommandes`
--
ALTER TABLE `precommandes`
  MODIFY `idPrecommande` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `produits`
--
ALTER TABLE `produits`
  MODIFY `idProduit` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `souhaitproduits`
--
ALTER TABLE `souhaitproduits`
  MODIFY `idSouhaitProduit` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `administrateurs`
--
ALTER TABLE `administrateurs`
  ADD CONSTRAINT `administrateurs_ibfk_1` FOREIGN KEY (`idAdministrateur`) REFERENCES `personnes` (`idPersonne`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`idClient`) REFERENCES `personnes` (`idPersonne`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `entreprises`
--
ALTER TABLE `entreprises`
  ADD CONSTRAINT `entreprises_ibfk_1` FOREIGN KEY (`idEntreprise`) REFERENCES `personnes` (`idPersonne`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `etapeproductions`
--
ALTER TABLE `etapeproductions`
  ADD CONSTRAINT `etapeproductions_ibfk_1` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_10` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_11` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_12` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_13` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_14` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_15` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_16` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_17` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_18` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_19` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_2` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_20` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_21` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_22` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_23` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_24` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_25` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_26` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_27` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_28` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_29` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_3` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_30` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_31` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_32` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_33` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_34` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_35` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_36` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_37` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_38` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_39` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_4` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_40` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_41` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_42` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_43` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_44` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_45` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_46` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_47` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_48` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_49` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_5` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_50` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_51` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_52` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_53` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_54` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_55` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_56` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_57` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_58` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_59` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_6` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_60` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_61` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_62` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_63` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_64` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_65` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_66` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_67` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_68` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_69` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_7` FOREIGN KEY (`idProduit`) REFERENCES `produits` (`idProduit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_8` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `etapeproductions_ibfk_9` FOREIGN KEY (`idProducteur`) REFERENCES `producteurs` (`idProducteur`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `fournisseurs`
--
ALTER TABLE `fournisseurs`
  ADD CONSTRAINT `fournisseurs_ibfk_1` FOREIGN KEY (`idFournisseur`) REFERENCES `personnes` (`idPersonne`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `gestionnaires`
--
ALTER TABLE `gestionnaires`
  ADD CONSTRAINT `gestionnaires_ibfk_1` FOREIGN KEY (`idGestionnaire`) REFERENCES `personnes` (`idPersonne`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `ligneprecommandes`
--
ALTER TABLE `ligneprecommandes`
  ADD CONSTRAINT `ligneprecommandes_ibfk_1` FOREIGN KEY (`PrecommandeIdPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ligneprecommandes_ibfk_2` FOREIGN KEY (`ProduitIdProduit`) REFERENCES `produits` (`idProduit`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `livraisons`
--
ALTER TABLE `livraisons`
  ADD CONSTRAINT `livraisons_ibfk_1` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_10` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_100` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_101` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_102` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_103` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_104` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_11` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_12` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_13` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_14` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_15` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_16` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_17` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_18` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_19` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_2` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_20` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_21` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_22` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_23` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_24` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_25` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_26` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_27` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_28` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_29` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_3` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_30` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_31` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_32` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_33` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_34` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_35` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_36` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_37` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_38` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_39` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_4` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_40` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_41` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_42` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_43` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_44` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_45` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_46` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_47` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_48` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_49` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_5` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_50` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_51` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_52` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_53` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_54` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_55` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_56` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_57` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_58` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_59` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_6` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_60` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_61` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_62` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_63` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_64` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_65` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_66` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_67` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_68` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_69` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_7` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_70` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_71` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_72` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_73` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_74` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_75` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_76` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_77` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_78` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_79` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_8` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_80` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_81` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_82` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_83` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_84` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_85` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_86` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_87` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_88` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_89` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_9` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_90` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_91` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_92` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_93` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_94` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_95` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_96` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_97` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_98` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `livraisons_ibfk_99` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `livreurs`
--
ALTER TABLE `livreurs`
  ADD CONSTRAINT `livreurs_ibfk_1` FOREIGN KEY (`idLivreur`) REFERENCES `personnes` (`idPersonne`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `paiements`
--
ALTER TABLE `paiements`
  ADD CONSTRAINT `paiements_ibfk_1` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_10` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_11` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_12` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_13` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_14` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_15` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_16` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_17` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_18` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_19` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_2` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_20` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_21` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_22` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_23` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_24` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_25` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_26` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_27` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_28` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_29` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_3` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_30` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_31` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_32` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_33` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_34` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_35` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_36` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_37` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_38` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_39` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_4` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_40` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_41` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_42` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_43` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_44` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_45` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_46` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_47` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_48` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_49` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_5` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_50` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_51` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_52` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_53` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_54` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_55` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_56` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_57` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_58` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_59` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_6` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_60` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_61` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_62` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_63` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_64` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_65` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_66` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_67` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_68` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_69` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_7` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_70` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_71` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_72` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_73` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_74` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_75` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_76` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_77` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_78` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_79` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_8` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_80` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_81` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_82` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_83` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_84` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_85` FOREIGN KEY (`idLivraison`) REFERENCES `livraisons` (`idLivraison`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_86` FOREIGN KEY (`idLivreur`) REFERENCES `livreurs` (`idLivreur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_87` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paiements_ibfk_9` FOREIGN KEY (`idPrecommande`) REFERENCES `precommandes` (`idPrecommande`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `pointlivraisons`
--
ALTER TABLE `pointlivraisons`
  ADD CONSTRAINT `pointlivraisons_ibfk_10` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_11` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_12` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_13` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_14` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_15` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_16` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_17` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_18` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_19` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_20` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_21` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_22` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_23` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_24` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_25` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_26` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_27` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_28` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_29` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_3` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_30` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_31` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_32` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_33` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_34` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_35` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_36` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_37` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_38` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_39` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_40` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_41` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_42` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_43` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_44` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_45` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_46` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_47` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_5` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_7` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pointlivraisons_ibfk_9` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `precommandes`
--
ALTER TABLE `precommandes`
  ADD CONSTRAINT `precommandes_ibfk_1` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_10` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_100` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_101` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_102` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_11` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_12` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_13` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_14` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_15` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_16` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_17` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_18` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_19` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_2` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_20` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_21` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_22` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_23` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_24` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_25` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_26` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_27` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_28` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_29` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_3` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_30` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_31` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_32` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_33` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_34` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_35` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_36` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_37` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_38` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_39` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_4` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_40` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_41` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_42` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_43` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_44` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_45` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_46` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_47` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_48` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_49` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_5` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_50` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_51` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_52` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_53` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_54` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_55` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_56` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_57` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_58` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_59` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_6` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_60` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_61` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_62` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_63` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_64` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_65` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_66` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_67` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_68` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_69` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_7` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_70` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_71` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_72` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_73` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_74` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_75` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_76` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_77` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_78` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_79` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_8` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_80` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_81` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_82` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_83` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_84` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_85` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_86` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_87` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_88` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_89` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_9` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_90` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_91` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_92` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_93` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_94` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_95` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_96` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_97` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_98` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `precommandes_ibfk_99` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `producteurs`
--
ALTER TABLE `producteurs`
  ADD CONSTRAINT `producteurs_ibfk_1` FOREIGN KEY (`idProducteur`) REFERENCES `personnes` (`idPersonne`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `produitcaracteristiques`
--
ALTER TABLE `produitcaracteristiques`
  ADD CONSTRAINT `produitcaracteristiques_ibfk_1` FOREIGN KEY (`ProduitIdProduit`) REFERENCES `produits` (`idProduit`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `produitcaracteristiques_ibfk_2` FOREIGN KEY (`CaracteristiqueIdCaracteristique`) REFERENCES `caracteristiques` (`idCaracteristique`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `produits`
--
ALTER TABLE `produits`
  ADD CONSTRAINT `produits_ibfk_1` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_10` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_11` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_12` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_13` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_14` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_15` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_16` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_17` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_18` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_19` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_2` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_20` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_21` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_22` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_23` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_24` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_25` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_26` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_27` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_28` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_29` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_3` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_30` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_31` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_32` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_33` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_34` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_35` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_36` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_37` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_38` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_39` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_4` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_40` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_41` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_42` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_43` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_44` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_45` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_46` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_47` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_48` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_49` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_5` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_50` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_51` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_52` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_53` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_54` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_55` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_56` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_57` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_58` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_59` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_6` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_60` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_61` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_62` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_63` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_64` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_65` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_66` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_67` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_68` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_69` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_7` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_70` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_71` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_72` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_73` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_74` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_75` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_76` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_77` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_8` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `produits_ibfk_9` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `souhaitproduits`
--
ALTER TABLE `souhaitproduits`
  ADD CONSTRAINT `souhaitproduits_ibfk_1` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_10` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_100` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_101` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_102` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_103` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_104` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_105` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_106` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_107` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_108` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_109` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_11` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_110` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_111` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_112` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_113` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_114` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_115` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_12` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_13` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_14` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_15` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_16` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_17` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_18` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_19` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_2` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_20` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_21` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_22` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_23` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_24` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_25` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_26` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_27` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_28` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_29` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_3` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_30` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_31` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_32` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_33` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_34` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_35` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_36` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_37` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_38` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_39` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_4` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_40` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_41` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_42` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_43` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_44` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_45` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_46` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_47` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_48` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_49` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_5` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_50` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_51` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_52` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_53` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_54` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_55` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_56` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_57` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_58` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_59` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_6` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_60` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_61` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_62` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_63` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_64` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_65` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_66` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_67` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_68` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_69` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_7` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_70` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_71` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_72` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_73` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_74` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_75` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_76` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_77` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_78` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_79` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_8` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_80` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_81` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_82` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_83` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_84` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_85` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_86` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_87` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_88` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_89` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_9` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_90` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_91` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_92` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_93` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_94` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_95` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_96` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_97` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_98` FOREIGN KEY (`idFournisseur`) REFERENCES `fournisseurs` (`idFournisseur`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `souhaitproduits_ibfk_99` FOREIGN KEY (`idGestionnaire`) REFERENCES `gestionnaires` (`idGestionnaire`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
