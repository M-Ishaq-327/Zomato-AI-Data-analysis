-- =====================================================================
-- Phase 2 · Step 1 — Warehouse, database, schemas, role
-- Run in Snowsight as ACCOUNTADMIN (a worksheet).
-- =====================================================================
USE ROLE ACCOUNTADMIN;

-- Compute: extra-small, auto-suspend fast so the trial credits last.
CREATE WAREHOUSE IF NOT EXISTS ZOMATO_WH
  WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND   = 60
  AUTO_RESUME    = TRUE
  INITIALLY_SUSPENDED = TRUE;

-- Database + medallion schemas.
CREATE DATABASE IF NOT EXISTS ZOMATO;
CREATE SCHEMA  IF NOT EXISTS ZOMATO.BRONZE;    -- Iceberg tables Spark wrote (dbt sources)
CREATE SCHEMA  IF NOT EXISTS ZOMATO.RAW;       -- only used by the COPY fallback path
CREATE SCHEMA  IF NOT EXISTS ZOMATO.STAGING;   -- cleaned / conformed (dbt)
CREATE SCHEMA  IF NOT EXISTS ZOMATO.MARTS;     -- Gold, Iceberg (dbt)
CREATE SCHEMA  IF NOT EXISTS ZOMATO.SNAPSHOTS; -- SCD2 history (dbt)
CREATE SCHEMA  IF NOT EXISTS ZOMATO.AI;        -- LLM-enriched tables (OpenAI jobs)
