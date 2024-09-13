--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-1.pgdg22.04+1)
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.acorn_finance_receipts DROP CONSTRAINT IF EXISTS purchase_id;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_payments DROP CONSTRAINT IF EXISTS invoice_id;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_receipts DROP CONSTRAINT IF EXISTS currency_id;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_purchases DROP CONSTRAINT IF EXISTS currency_id;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_payments DROP CONSTRAINT IF EXISTS currency_id;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_invoices DROP CONSTRAINT IF EXISTS currency_id;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_receipts DROP CONSTRAINT IF EXISTS backend_user_id;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_payments DROP CONSTRAINT IF EXISTS backend_user_id;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_invoices DROP CONSTRAINT IF EXISTS backend_user_id;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_purchases DROP CONSTRAINT IF EXISTS backend_user_id;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_receipts DROP CONSTRAINT IF EXISTS backend_user_group_id;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_payments DROP CONSTRAINT IF EXISTS backend_user_group_id;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_invoices DROP CONSTRAINT IF EXISTS backend_user_group_id;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_purchases DROP CONSTRAINT IF EXISTS backend_user_group_id;
DROP INDEX IF EXISTS public.fki_currency_id;
DROP INDEX IF EXISTS public.fki_backend_user_id;
DROP INDEX IF EXISTS public.fki_backend_user_group_id;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_receipts DROP CONSTRAINT IF EXISTS acorn_finance_receipts_pkey;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_purchases DROP CONSTRAINT IF EXISTS acorn_finance_purchases_pkey;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_payments DROP CONSTRAINT IF EXISTS acorn_finance_payments_pkey;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_invoices DROP CONSTRAINT IF EXISTS acorn_finance_invoices_pkey;
ALTER TABLE IF EXISTS ONLY public.acorn_finance_currencies DROP CONSTRAINT IF EXISTS acorn_finance_currency_pkey;
DROP TABLE IF EXISTS public.acorn_finance_receipts;
DROP TABLE IF EXISTS public.acorn_finance_purchases;
DROP TABLE IF EXISTS public.acorn_finance_payments;
DROP TABLE IF EXISTS public.acorn_finance_invoices;
DROP TABLE IF EXISTS public.acorn_finance_currencies;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: acorn_finance_currencies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.acorn_finance_currencies (
    id uuid NOT NULL,
    name character varying(1024) NOT NULL,
    shortname character(3) NOT NULL,
    symbol character varying(16) NOT NULL
);


--
-- Name: acorn_finance_invoices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.acorn_finance_invoices (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    number integer NOT NULL,
    currency_id uuid NOT NULL,
    mark_paid boolean DEFAULT false NOT NULL,
    amount integer NOT NULL,
    name character varying(1024) GENERATED ALWAYS AS ((((('#'::text || (number)::text) || ' ('::text) || (amount)::text) || ')'::text)) STORED NOT NULL,
    backend_user_id integer,
    backend_user_group_id integer,
    CONSTRAINT either_or CHECK (((NOT (backend_user_id IS NULL)) OR (NOT (backend_user_group_id IS NULL))))
);


--
-- Name: COLUMN acorn_finance_invoices.backend_user_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.acorn_finance_invoices.backend_user_id IS 'translation: Client';


--
-- Name: COLUMN acorn_finance_invoices.backend_user_group_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.acorn_finance_invoices.backend_user_group_id IS 'translation: Client Organisation';


--
-- Name: acorn_finance_payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.acorn_finance_payments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    invoice_id uuid NOT NULL,
    currency_id uuid NOT NULL,
    amount integer NOT NULL,
    number integer,
    name character varying(1024) GENERATED ALWAYS AS ((((('#'::text || (number)::text) || ' ('::text) || (amount)::text) || ')'::text)) STORED NOT NULL,
    backend_user_id integer,
    backend_user_group_id integer,
    CONSTRAINT either_or CHECK (((NOT (backend_user_id IS NULL)) OR (NOT (backend_user_group_id IS NULL))))
);


--
-- Name: COLUMN acorn_finance_payments.invoice_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.acorn_finance_payments.invoice_id IS 'Test comment';


--
-- Name: COLUMN acorn_finance_payments.backend_user_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.acorn_finance_payments.backend_user_id IS 'translation: Client';


--
-- Name: COLUMN acorn_finance_payments.backend_user_group_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.acorn_finance_payments.backend_user_group_id IS 'translation: Client Organisation';


--
-- Name: acorn_finance_purchases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.acorn_finance_purchases (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    number integer NOT NULL,
    mark_paid boolean DEFAULT false NOT NULL,
    currency_id uuid NOT NULL,
    amount integer NOT NULL,
    name character varying(1024) GENERATED ALWAYS AS ((((('#'::text || (number)::text) || ' ('::text) || (amount)::text) || ')'::text)) STORED NOT NULL,
    backend_user_id integer,
    backend_user_group_id integer,
    CONSTRAINT either_or CHECK (((NOT (backend_user_id IS NULL)) OR (NOT (backend_user_group_id IS NULL))))
);


--
-- Name: COLUMN acorn_finance_purchases.backend_user_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.acorn_finance_purchases.backend_user_id IS 'translation: Client';


--
-- Name: COLUMN acorn_finance_purchases.backend_user_group_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.acorn_finance_purchases.backend_user_group_id IS 'translation: Client Organisation';


--
-- Name: acorn_finance_receipts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.acorn_finance_receipts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    purchase_id uuid NOT NULL,
    number integer NOT NULL,
    currency_id uuid NOT NULL,
    amount integer NOT NULL,
    name character varying(1024) GENERATED ALWAYS AS ((((('#'::text || (number)::text) || ' ('::text) || (amount)::text) || ')'::text)) STORED NOT NULL,
    backend_user_id integer,
    backend_user_group_id integer,
    CONSTRAINT either_or CHECK (((NOT (backend_user_id IS NULL)) OR (NOT (backend_user_group_id IS NULL))))
);


--
-- Name: COLUMN acorn_finance_receipts.backend_user_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.acorn_finance_receipts.backend_user_id IS 'translation: Client';


--
-- Name: COLUMN acorn_finance_receipts.backend_user_group_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.acorn_finance_receipts.backend_user_group_id IS 'translation: Client Organisation';


--
-- Name: acorn_finance_currencies acorn_finance_currency_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_currencies
    ADD CONSTRAINT acorn_finance_currency_pkey PRIMARY KEY (id);


--
-- Name: acorn_finance_invoices acorn_finance_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_invoices
    ADD CONSTRAINT acorn_finance_invoices_pkey PRIMARY KEY (id);


--
-- Name: acorn_finance_payments acorn_finance_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_payments
    ADD CONSTRAINT acorn_finance_payments_pkey PRIMARY KEY (id);


--
-- Name: acorn_finance_purchases acorn_finance_purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_purchases
    ADD CONSTRAINT acorn_finance_purchases_pkey PRIMARY KEY (id);


--
-- Name: acorn_finance_receipts acorn_finance_receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_receipts
    ADD CONSTRAINT acorn_finance_receipts_pkey PRIMARY KEY (id);


--
-- Name: fki_backend_user_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_backend_user_group_id ON public.acorn_finance_purchases USING btree (backend_user_group_id);


--
-- Name: fki_backend_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_backend_user_id ON public.acorn_finance_purchases USING btree (backend_user_id);


--
-- Name: fki_currency_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_currency_id ON public.acorn_finance_invoices USING btree (currency_id);


--
-- Name: acorn_finance_purchases backend_user_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_purchases
    ADD CONSTRAINT backend_user_group_id FOREIGN KEY (backend_user_group_id) REFERENCES public.backend_user_groups(id) NOT VALID;


--
-- Name: acorn_finance_invoices backend_user_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_invoices
    ADD CONSTRAINT backend_user_group_id FOREIGN KEY (backend_user_group_id) REFERENCES public.backend_user_groups(id) NOT VALID;


--
-- Name: acorn_finance_payments backend_user_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_payments
    ADD CONSTRAINT backend_user_group_id FOREIGN KEY (backend_user_group_id) REFERENCES public.backend_user_groups(id) NOT VALID;


--
-- Name: acorn_finance_receipts backend_user_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_receipts
    ADD CONSTRAINT backend_user_group_id FOREIGN KEY (backend_user_group_id) REFERENCES public.backend_user_groups(id) NOT VALID;


--
-- Name: acorn_finance_purchases backend_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_purchases
    ADD CONSTRAINT backend_user_id FOREIGN KEY (backend_user_id) REFERENCES public.backend_users(id) NOT VALID;


--
-- Name: acorn_finance_invoices backend_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_invoices
    ADD CONSTRAINT backend_user_id FOREIGN KEY (backend_user_id) REFERENCES public.backend_users(id) NOT VALID;


--
-- Name: acorn_finance_payments backend_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_payments
    ADD CONSTRAINT backend_user_id FOREIGN KEY (backend_user_id) REFERENCES public.backend_users(id) NOT VALID;


--
-- Name: acorn_finance_receipts backend_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_receipts
    ADD CONSTRAINT backend_user_id FOREIGN KEY (backend_user_id) REFERENCES public.backend_users(id) NOT VALID;


--
-- Name: acorn_finance_invoices currency_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_invoices
    ADD CONSTRAINT currency_id FOREIGN KEY (currency_id) REFERENCES public.acorn_finance_currencies(id) NOT VALID;


--
-- Name: acorn_finance_payments currency_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_payments
    ADD CONSTRAINT currency_id FOREIGN KEY (currency_id) REFERENCES public.acorn_finance_currencies(id) NOT VALID;


--
-- Name: acorn_finance_purchases currency_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_purchases
    ADD CONSTRAINT currency_id FOREIGN KEY (currency_id) REFERENCES public.acorn_finance_currencies(id) NOT VALID;


--
-- Name: acorn_finance_receipts currency_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_receipts
    ADD CONSTRAINT currency_id FOREIGN KEY (currency_id) REFERENCES public.acorn_finance_currencies(id) NOT VALID;


--
-- Name: acorn_finance_payments invoice_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_payments
    ADD CONSTRAINT invoice_id FOREIGN KEY (invoice_id) REFERENCES public.acorn_finance_invoices(id) NOT VALID;


--
-- Name: acorn_finance_receipts purchase_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acorn_finance_receipts
    ADD CONSTRAINT purchase_id FOREIGN KEY (purchase_id) REFERENCES public.acorn_finance_purchases(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

SET search_path TO public;
