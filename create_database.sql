-- Usuniecie bazy danych, jesli istnieje
USE master
IF EXISTS( SELECT * FROM sys.databases WHERE name = 'Ksiegarnia Internetowa' )
DROP DATABASE [Ksiegarnia Internetowa]
-- Stworzenie bazy danych
CREATE DATABASE [Ksiegarnia Internetowa]
USE [Ksiegarnia Internetowa]
