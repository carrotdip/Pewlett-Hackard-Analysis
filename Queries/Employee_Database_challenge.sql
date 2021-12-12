--Deliverable 1
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON e.emp_no=t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

select * from retirement_titles;

--CHALLENGE STARTER CODE
-- Use Dictinct with Orderby to remove duplicate rows
-- Retrieve employee number, first and last name, and most recent job titles, ordered by employee number 
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;

select * from unique_titles;

--Select count of employees retiring by most recent job title
SELECT COUNT(ut.emp_no),
	ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.emp_no) DESC;

select * from retiring_titles;

------------------------------------------------
------------------------------------------------

--Deliverable 2
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01'
	AND e.birth_date BETWEEN '1965-01-01' and '1965-12-31'
ORDER BY e.emp_no, de.to_date DESC;

SELECT * from mentorship_eligibility;



--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9
-- Dumped by pg_dump version 12.6

-- Started on 2021-12-12 11:18:58 PST

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
-- TOC entry 209 (class 1259 OID 17707)
-- Name: current_emp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.current_emp (
    emp_no integer,
    first_name character varying,
    last_name character varying,
    to_date date
);


ALTER TABLE public.current_emp OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 17608)
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    dept_no character varying(4) NOT NULL,
    dept_name character varying(40) NOT NULL
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 17677)
-- Name: dept_emp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dept_emp (
    emp_no integer NOT NULL,
    dept_no character varying NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL
);


ALTER TABLE public.dept_emp OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 17745)
-- Name: dept_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dept_info (
    emp_no integer,
    first_name character varying,
    last_name character varying,
    dept_name character varying(40)
);


ALTER TABLE public.dept_info OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 17623)
-- Name: dept_manager; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dept_manager (
    dept_no character varying(4) NOT NULL,
    emp_no integer NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL
);


ALTER TABLE public.dept_manager OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 17730)
-- Name: emp_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emp_info (
    emp_no integer,
    first_name character varying,
    last_name character varying,
    gender character varying,
    salary integer,
    to_date date
);


ALTER TABLE public.emp_info OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 17715)
-- Name: employee_count_by_dept; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_count_by_dept (
    count bigint,
    dept_no character varying
);


ALTER TABLE public.employee_count_by_dept OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 17615)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    emp_no integer NOT NULL,
    birth_date date NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    gender character varying NOT NULL,
    hire_date date NOT NULL
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 17739)
-- Name: manager_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manager_info (
    dept_no character varying(4),
    dept_name character varying(40),
    emp_no integer,
    last_name character varying,
    first_name character varying,
    from_date date,
    to_date date
);


ALTER TABLE public.manager_info OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 17700)
-- Name: retirement_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.retirement_info (
    emp_no integer,
    first_name character varying,
    last_name character varying
);


ALTER TABLE public.retirement_info OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 17638)
-- Name: salaries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salaries (
    emp_no integer NOT NULL,
    salary integer NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL
);


ALTER TABLE public.salaries OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 17753)
-- Name: sales_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_info (
    emp_no integer,
    first_name character varying,
    last_name character varying,
    dept_name character varying(40)
);


ALTER TABLE public.sales_info OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 17666)
-- Name: titles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.titles (
    emp_no integer NOT NULL,
    title character varying NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL
);


ALTER TABLE public.titles OWNER TO postgres;

--
-- TOC entry 3061 (class 2606 OID 17614)
-- Name: departments departments_dept_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_dept_name_key UNIQUE (dept_name);


--
-- TOC entry 3063 (class 2606 OID 17612)
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (dept_no);


--
-- TOC entry 3067 (class 2606 OID 17627)
-- Name: dept_manager dept_manager_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dept_manager
    ADD CONSTRAINT dept_manager_pkey PRIMARY KEY (emp_no);


--
-- TOC entry 3065 (class 2606 OID 17622)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (emp_no);


--
-- TOC entry 3069 (class 2606 OID 17642)
-- Name: salaries salaries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT salaries_pkey PRIMARY KEY (emp_no);


--
-- TOC entry 3074 (class 2606 OID 17683)
-- Name: dept_emp dept_emp_dept_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dept_emp
    ADD CONSTRAINT dept_emp_dept_no_fkey FOREIGN KEY (dept_no) REFERENCES public.departments(dept_no);


--
-- TOC entry 3075 (class 2606 OID 17688)
-- Name: dept_emp dept_emp_emp_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dept_emp
    ADD CONSTRAINT dept_emp_emp_no_fkey FOREIGN KEY (emp_no) REFERENCES public.employees(emp_no);


--
-- TOC entry 3071 (class 2606 OID 17633)
-- Name: dept_manager dept_manager_dept_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dept_manager
    ADD CONSTRAINT dept_manager_dept_no_fkey FOREIGN KEY (dept_no) REFERENCES public.departments(dept_no);


--
-- TOC entry 3070 (class 2606 OID 17628)
-- Name: dept_manager dept_manager_emp_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dept_manager
    ADD CONSTRAINT dept_manager_emp_no_fkey FOREIGN KEY (emp_no) REFERENCES public.employees(emp_no);


--
-- TOC entry 3072 (class 2606 OID 17643)
-- Name: salaries salaries_emp_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT salaries_emp_no_fkey FOREIGN KEY (emp_no) REFERENCES public.employees(emp_no);


--
-- TOC entry 3073 (class 2606 OID 17672)
-- Name: titles titles_emp_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titles
    ADD CONSTRAINT titles_emp_no_fkey FOREIGN KEY (emp_no) REFERENCES public.employees(emp_no);


-- Completed on 2021-12-12 11:18:58 PST

--
-- PostgreSQL database dump complete
--

