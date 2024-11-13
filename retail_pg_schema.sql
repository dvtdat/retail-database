--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: belongs_to; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.belongs_to (
    productid integer NOT NULL,
    brandid integer NOT NULL
);


ALTER TABLE public.belongs_to OWNER TO postgres;

--
-- Name: brand; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brand (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.brand OWNER TO postgres;

--
-- Name: checks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.checks (
    storemanagerid integer NOT NULL,
    productid integer NOT NULL
);


ALTER TABLE public.checks OWNER TO postgres;

--
-- Name: checks_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.checks_session (
    storemanagerid integer NOT NULL,
    productid integer NOT NULL,
    date date NOT NULL,
    "time" time without time zone NOT NULL,
    storewideprice integer NOT NULL
);


ALTER TABLE public.checks_session OWNER TO postgres;

--
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    id integer NOT NULL,
    ssn integer NOT NULL,
    name character varying(50) NOT NULL,
    phone character varying(50) NOT NULL,
    address character varying(50) NOT NULL
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- Name: discount_program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount_program (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text
);


ALTER TABLE public.discount_program OWNER TO postgres;

--
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    id integer NOT NULL,
    ssn integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- Name: floor_clerk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.floor_clerk (
    id integer NOT NULL
);


ALTER TABLE public.floor_clerk OWNER TO postgres;

--
-- Name: has; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.has (
    discountprogramid integer NOT NULL,
    productid integer NOT NULL,
    brandid integer NOT NULL,
    fromdate timestamp without time zone NOT NULL,
    todate timestamp without time zone NOT NULL,
    percent integer NOT NULL,
    CONSTRAINT datevalidity CHECK ((fromdate < todate)),
    CONSTRAINT discountpercent CHECK (((percent >= 0) AND (percent <= 80)))
);


ALTER TABLE public.has OWNER TO postgres;

--
-- Name: is_on; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.is_on (
    productid integer NOT NULL,
    shelfid integer NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.is_on OWNER TO postgres;

--
-- Name: payment_method; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_method (
    name character varying(100) NOT NULL,
    description text
);


ALTER TABLE public.payment_method OWNER TO postgres;

--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    mdate timestamp without time zone NOT NULL,
    edate timestamp without time zone NOT NULL,
    quantity integer NOT NULL,
    suggestedprice integer NOT NULL,
    CONSTRAINT checkvalidity CHECK (((mdate < edate) AND (quantity >= 0)))
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: purchase; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase (
    id integer NOT NULL,
    date date NOT NULL,
    "time" time without time zone NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.purchase OWNER TO postgres;

--
-- Name: restocks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.restocks (
    floorclerkid integer NOT NULL,
    shelfid integer NOT NULL
);


ALTER TABLE public.restocks OWNER TO postgres;

--
-- Name: restocks_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.restocks_session (
    floorclerkid integer NOT NULL,
    shelfid integer NOT NULL,
    date date NOT NULL,
    "time" time without time zone NOT NULL
);


ALTER TABLE public.restocks_session OWNER TO postgres;

--
-- Name: shelf; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shelf (
    id integer NOT NULL,
    location character varying(50),
    area character varying(50)
);


ALTER TABLE public.shelf OWNER TO postgres;

--
-- Name: storage_conditions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.storage_conditions (
    shelfid integer NOT NULL,
    storagecondition character varying(200)
);


ALTER TABLE public.storage_conditions OWNER TO postgres;

--
-- Name: store_manager; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_manager (
    id integer NOT NULL
);


ALTER TABLE public.store_manager OWNER TO postgres;

--
-- Name: transaction_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction_history (
    customerid integer NOT NULL,
    productid integer NOT NULL,
    purchaseid integer NOT NULL,
    brandid integer NOT NULL,
    date date NOT NULL,
    "time" time without time zone NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.transaction_history OWNER TO postgres;

--
-- Name: brand brand_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brand
    ADD CONSTRAINT brand_pkey PRIMARY KEY (id);


--
-- Name: checks_session checks_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checks_session
    ADD CONSTRAINT checks_session_pkey PRIMARY KEY (storemanagerid, productid, date, "time", storewideprice);


--
-- Name: checks checks_storemanagerid_productid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checks
    ADD CONSTRAINT checks_storemanagerid_productid_key UNIQUE (storemanagerid, productid);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);


--
-- Name: discount_program discount_program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_program
    ADD CONSTRAINT discount_program_pkey PRIMARY KEY (id);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);


--
-- Name: floor_clerk floor_clerk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.floor_clerk
    ADD CONSTRAINT floor_clerk_pkey PRIMARY KEY (id);


--
-- Name: payment_method payment_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_method
    ADD CONSTRAINT payment_method_pkey PRIMARY KEY (name);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: purchase purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_pkey PRIMARY KEY (id);


--
-- Name: restocks restocks_floorclerkid_shelfid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restocks
    ADD CONSTRAINT restocks_floorclerkid_shelfid_key UNIQUE (floorclerkid, shelfid);


--
-- Name: restocks_session restocks_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restocks_session
    ADD CONSTRAINT restocks_session_pkey PRIMARY KEY (floorclerkid, shelfid, date, "time");


--
-- Name: shelf shelf_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelf
    ADD CONSTRAINT shelf_pkey PRIMARY KEY (id);


--
-- Name: storage_conditions storage_conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.storage_conditions
    ADD CONSTRAINT storage_conditions_pkey PRIMARY KEY (shelfid);


--
-- Name: store_manager store_manager_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_manager
    ADD CONSTRAINT store_manager_pkey PRIMARY KEY (id);


--
-- Name: transaction_history transaction_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_history
    ADD CONSTRAINT transaction_history_pkey PRIMARY KEY (customerid, productid, date, "time");


--
-- Name: belongs_to belongs_to_brandid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.belongs_to
    ADD CONSTRAINT belongs_to_brandid_fkey FOREIGN KEY (brandid) REFERENCES public.brand(id);


--
-- Name: belongs_to belongs_to_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.belongs_to
    ADD CONSTRAINT belongs_to_productid_fkey FOREIGN KEY (productid) REFERENCES public.product(id);


--
-- Name: checks checks_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checks
    ADD CONSTRAINT checks_productid_fkey FOREIGN KEY (productid) REFERENCES public.product(id);


--
-- Name: checks_session checks_session_storemanagerid_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checks_session
    ADD CONSTRAINT checks_session_storemanagerid_productid_fkey FOREIGN KEY (storemanagerid, productid) REFERENCES public.checks(storemanagerid, productid);


--
-- Name: checks checks_storemanagerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checks
    ADD CONSTRAINT checks_storemanagerid_fkey FOREIGN KEY (storemanagerid) REFERENCES public.store_manager(id);


--
-- Name: floor_clerk floor_clerk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.floor_clerk
    ADD CONSTRAINT floor_clerk_id_fkey FOREIGN KEY (id) REFERENCES public.employee(id);


--
-- Name: has has_brandid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.has
    ADD CONSTRAINT has_brandid_fkey FOREIGN KEY (brandid) REFERENCES public.brand(id);


--
-- Name: has has_discountprogramid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.has
    ADD CONSTRAINT has_discountprogramid_fkey FOREIGN KEY (discountprogramid) REFERENCES public.discount_program(id);


--
-- Name: has has_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.has
    ADD CONSTRAINT has_productid_fkey FOREIGN KEY (productid) REFERENCES public.product(id);


--
-- Name: is_on is_on_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.is_on
    ADD CONSTRAINT is_on_productid_fkey FOREIGN KEY (productid) REFERENCES public.product(id);


--
-- Name: is_on is_on_shelfid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.is_on
    ADD CONSTRAINT is_on_shelfid_fkey FOREIGN KEY (shelfid) REFERENCES public.shelf(id);


--
-- Name: purchase purchase_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_name_fkey FOREIGN KEY (name) REFERENCES public.payment_method(name);


--
-- Name: restocks restocks_floorclerkid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restocks
    ADD CONSTRAINT restocks_floorclerkid_fkey FOREIGN KEY (floorclerkid) REFERENCES public.floor_clerk(id);


--
-- Name: restocks_session restocks_session_floorclerkid_shelfid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restocks_session
    ADD CONSTRAINT restocks_session_floorclerkid_shelfid_fkey FOREIGN KEY (floorclerkid, shelfid) REFERENCES public.restocks(floorclerkid, shelfid);


--
-- Name: restocks restocks_shelfid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restocks
    ADD CONSTRAINT restocks_shelfid_fkey FOREIGN KEY (shelfid) REFERENCES public.shelf(id);


--
-- Name: storage_conditions storage_conditions_shelfid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.storage_conditions
    ADD CONSTRAINT storage_conditions_shelfid_fkey FOREIGN KEY (shelfid) REFERENCES public.shelf(id);


--
-- Name: store_manager store_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_manager
    ADD CONSTRAINT store_manager_id_fkey FOREIGN KEY (id) REFERENCES public.employee(id);


--
-- Name: transaction_history transaction_history_brandid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_history
    ADD CONSTRAINT transaction_history_brandid_fkey FOREIGN KEY (brandid) REFERENCES public.brand(id);


--
-- Name: transaction_history transaction_history_customerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_history
    ADD CONSTRAINT transaction_history_customerid_fkey FOREIGN KEY (customerid) REFERENCES public.customer(id);


--
-- Name: transaction_history transaction_history_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_history
    ADD CONSTRAINT transaction_history_productid_fkey FOREIGN KEY (productid) REFERENCES public.product(id);


--
-- Name: transaction_history transaction_history_purchaseid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_history
    ADD CONSTRAINT transaction_history_purchaseid_fkey FOREIGN KEY (purchaseid) REFERENCES public.purchase(id);


--
-- PostgreSQL database dump complete
--

