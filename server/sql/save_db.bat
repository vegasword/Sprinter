@echo off
mysqldump -u root -p --add-drop-database --skip-extended-insert --force sprinter > sprinter.sql
