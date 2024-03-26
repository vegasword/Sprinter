@echo off
rem Remove --add-drop-database flag for production
mysqldump -u root -p --add-drop-database sprinter > sprinter.sql
