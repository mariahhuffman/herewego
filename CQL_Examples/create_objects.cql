CREATE KEYSPACE CQL_Clustering_Example
  WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

USE CQL_Clustering_Example;

CREATE TABLE Projects_by_Account (
	Account text,
	Project text,
	Office text,
	Revenue float,
	Consultant_Count int,
	Project_lead text,
	Roles map<text, text>,
	PRIMARY KEY ((Account, Office)));

CREATE TABLE Projects_by_Account_Cluster (
	Account text,
	Project text,
	Office text,
	Revenue float,
	Consultant_Count int,
	Project_lead text,
	Roles map<text, text>,
	PRIMARY KEY ((Account), Office)
	);

--Run these scripts to query the tables
select * from projects_by_account; 
select * from projects_by_account_cluster;

--Run these scripts to import the 7 rows of data. Note, 'Example_Data.csv' must either be in the CQL Shell bin folder, or be reference explicitly
copy projects_by_account  (account, project, office, revenue, consultant_count, project_lead, roles) from 'Example_Data.csv';
copy projects_by_account_cluster  (account, project, office, revenue, consultant_count, project_lead, roles) from 'Example_Data.csv';

--Run these scripts in Cassandra-CLI to see examples of clustering, and how it impacts how Cassandra stores data
use CQL_Clustering_Example;
list projects_by_account;
get projects_by_account_cluster['BigRetailBank'];
