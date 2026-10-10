-- Roles for the automation database. Locally a superuser runs this; on Neon
-- `automation-db provision` creates the same roles through the migrator.
--
-- automation_migrator  owns the schema and runs migrations only.
-- automation_api       the API at runtime: no superuser, no BYPASSRLS, owns nothing.
-- automation_publisher sweeps and marks the outbox across workspaces; nothing else.

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'automation_migrator') THEN
        CREATE ROLE automation_migrator LOGIN NOSUPERUSER NOCREATEROLE NOBYPASSRLS;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'automation_api') THEN
        CREATE ROLE automation_api LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE NOBYPASSRLS NOINHERIT;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'automation_publisher') THEN
        CREATE ROLE automation_publisher LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE NOBYPASSRLS NOINHERIT;
    END IF;
END
$$;
