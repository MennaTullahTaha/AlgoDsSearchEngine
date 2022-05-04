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
-- Name: algorithms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.algorithms (
    id bigint NOT NULL,
    title character varying NOT NULL,
    url character varying NOT NULL,
    time_complexity text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    searchable tsvector GENERATED ALWAYS AS ((setweight(to_tsvector('english'::regconfig, (COALESCE(title, ''::character varying))::text), 'B'::"char") || setweight(to_tsvector('english'::regconfig, COALESCE(time_complexity, ''::text)), 'A'::"char"))) STORED
);


--
-- Name: algorithms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.algorithms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: algorithms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.algorithms_id_seq OWNED BY public.algorithms.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    body text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    post_id integer
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: datastructures; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.datastructures (
    id bigint NOT NULL,
    title character varying NOT NULL,
    url character varying NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    searchable tsvector GENERATED ALWAYS AS ((setweight(to_tsvector('english'::regconfig, (COALESCE(title, ''::character varying))::text), 'B'::"char") || setweight(to_tsvector('english'::regconfig, COALESCE(content, ''::text)), 'A'::"char"))) STORED
);


--
-- Name: datastructures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.datastructures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: datastructures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.datastructures_id_seq OWNED BY public.datastructures.id;


--
-- Name: favourite_algorithms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.favourite_algorithms (
    id bigint NOT NULL,
    user_id integer,
    algorithm_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: favourite_algorithms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.favourite_algorithms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: favourite_algorithms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.favourite_algorithms_id_seq OWNED BY public.favourite_algorithms.id;


--
-- Name: favourite_datastructures; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.favourite_datastructures (
    id bigint NOT NULL,
    user_id integer,
    datastructure_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: favourite_datastructures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.favourite_datastructures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: favourite_datastructures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.favourite_datastructures_id_seq OWNED BY public.favourite_datastructures.id;


--
-- Name: favourite_posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.favourite_posts (
    id bigint NOT NULL,
    user_id integer,
    post_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: favourite_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.favourite_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: favourite_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.favourite_posts_id_seq OWNED BY public.favourite_posts.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.posts (
    id bigint NOT NULL,
    title character varying NOT NULL,
    body text NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    algorithm_id integer,
    datastructure_id integer
);


--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying NOT NULL,
    email character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    role boolean DEFAULT false,
    password_digest character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: algorithms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.algorithms ALTER COLUMN id SET DEFAULT nextval('public.algorithms_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: datastructures id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.datastructures ALTER COLUMN id SET DEFAULT nextval('public.datastructures_id_seq'::regclass);


--
-- Name: favourite_algorithms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favourite_algorithms ALTER COLUMN id SET DEFAULT nextval('public.favourite_algorithms_id_seq'::regclass);


--
-- Name: favourite_datastructures id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favourite_datastructures ALTER COLUMN id SET DEFAULT nextval('public.favourite_datastructures_id_seq'::regclass);


--
-- Name: favourite_posts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favourite_posts ALTER COLUMN id SET DEFAULT nextval('public.favourite_posts_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: algorithms algorithms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.algorithms
    ADD CONSTRAINT algorithms_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: datastructures datastructures_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.datastructures
    ADD CONSTRAINT datastructures_pkey PRIMARY KEY (id);


--
-- Name: favourite_algorithms favourite_algorithms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favourite_algorithms
    ADD CONSTRAINT favourite_algorithms_pkey PRIMARY KEY (id);


--
-- Name: favourite_datastructures favourite_datastructures_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favourite_datastructures
    ADD CONSTRAINT favourite_datastructures_pkey PRIMARY KEY (id);


--
-- Name: favourite_posts favourite_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favourite_posts
    ADD CONSTRAINT favourite_posts_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_algorithms_on_searchable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_algorithms_on_searchable ON public.algorithms USING gin (searchable);


--
-- Name: index_comments_on_body; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_comments_on_body ON public.comments USING btree (body);


--
-- Name: index_datastructures_on_searchable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_datastructures_on_searchable ON public.datastructures USING gin (searchable);


--
-- Name: index_posts_on_body; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_posts_on_body ON public.posts USING btree (body);


--
-- Name: index_posts_on_title; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_posts_on_title ON public.posts USING btree (title);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_username ON public.users USING btree (username);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20220501095041'),
('20220501103537'),
('20220502054417'),
('20220502055852'),
('20220502061212'),
('20220502104423'),
('20220502141413'),
('20220502161122'),
('20220502181512'),
('20220502194957'),
('20220502195502'),
('20220502195753'),
('20220502195804'),
('20220503051346'),
('20220503120130'),
('20220503120214');


