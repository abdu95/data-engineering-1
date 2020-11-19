## Introduction

This is the Term project that is done for Data Engineering 1 course by Malikov Abduvosid. 

This is a Brazilian ecommerce public dataset of orders made at Olist Store. The dataset has information of 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil. [Dataset link](https://www.kaggle.com/olistbr/brazilian-ecommerce?select=olist_order_items_dataset.csv)

## Analytics Plan
- Exercises that we have done. List such questions
- Answer to your questions using your DB and Analytical Layer

`E` - Extract: Joining the tables for the operational layer is an extract operation

`T` - Transform: We don't have glamorous transformations here, only a WeekOfYear covering this part. Nevertheless, please note that you call a store procedure form trigger or even use procedural language to do transformation in the trigger itself.

`L` - Load: Inserting into product_sales represents the load part of the ETL

## Reproduce 
It is recommended to use CSV files in `archive` folder (not original dataset from website). The original dataset contained quotes in some columns and therefore original dataset of CSV files were modified slightly in order to smoothly work with MySQL commands.

Order of execution of sql queries and their purpose:

1. `create_tables.sql` - creates tables and loads data from CSV files to these tables. Operational Layer
2. `stored_procedure.sql` - creates `product_sales` table for Analytical Layer
3. `data_mart.sql` - 







