-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


DROP TABLE IF EXISTS public.fp_user CASCADE;

DROP TABLE IF EXISTS public.fp_restaurant CASCADE;


CREATE TABLE IF NOT EXISTS public.fp_user
(
    id serial NOT NULL,
    firstname character varying(45) NOT NULL,
    lastname character varying(120) NOT NULL,
    email character varying(320) NOT NULL,
    pseudo character varying(50),
    password character varying(255) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_updated time with time zone NOT NULL,
	user_role character varying(45) NOT NULL,
    identifier character varying(36) NOT NULL,
    status boolean NOT NULL,
    fp_setting_id serial NOT NULL,
    CONSTRAINT fp_user_id PRIMARY KEY (id),
    CONSTRAINT fp_user_email UNIQUE (email),
    CONSTRAINT fp_user_identifier UNIQUE (identifier)
);

DROP TABLE IF EXISTS public.fp_reservation CASCADE;

CREATE TABLE IF NOT EXISTS public.fp_reservation
(
    id serial NOT NULL,
    date date NOT NULL,
    "time" time with time zone NOT NULL,
    nb_person integer NOT NULL,
    firstname character varying(45) NOT NULL,
    lastname character varying(45) NOT NULL,
    phone character varying(15) NOT NULL,
    fp_user_id serial NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.fp_page CASCADE;

CREATE TABLE IF NOT EXISTS public.fp_page
(
    id serial NOT NULL,
    fp_user_id serial NOT NULL,
    name character varying(45),
    slug character varying(150) NOT NULL,
    active boolean NOT NULL,
    date_created time with time zone NOT NULL,
    date_updated time with time zone NOT NULL,
    parent_id integer,
    identifier character varying(36) NOT NULL,
    nb_view integer NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fp_page_slug UNIQUE (slug),
    CONSTRAINT fp_page_identifier UNIQUE (identifier)
);

DROP TABLE IF EXISTS public.fp_categorie CASCADE;

CREATE TABLE IF NOT EXISTS public.fp_categorie
(
    id serial NOT NULL,
    name character(45) NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.fp_comment CASCADE;

CREATE TABLE IF NOT EXISTS public.fp_comment
(
    id serial NOT NULL,
    text text NOT NULL,
    date_created time with time zone NOT NULL,
    date_updated time with time zone,
    fp_user_id serial NOT NULL,
    fp_recipe_id serial NOT NULL,
    PRIMARY KEY (id)
);



DROP TABLE IF EXISTS public.fp_ingredient CASCADE;

CREATE TABLE IF NOT EXISTS public.fp_ingredient
(
    id serial NOT NULL,
    name character varying(45) NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.fp_media CASCADE;

CREATE TABLE IF NOT EXISTS public.fp_media
(
    id serial NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(100) NOT NULL,
    size integer,
    description text,
    created_at time with time zone NOT NULL,
    updated_at time with time zone NOT NULL,
    identifier character varying(36) NOT NULL,
    fp_recipe_id serial NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fp_media_identifier UNIQUE (identifier)
);

DROP TABLE IF EXISTS public.fp_recipe CASCADE;

CREATE TABLE IF NOT EXISTS public.fp_recipe
(
    id serial NOT NULL,
    name character varying(64) NOT NULL,
    time_preparation character varying(45),
    difficulty character varying(20),
    preparation text,
    created_at time with time zone NOT NULL,
    updated_at time with time zone NOT NULL,
    slug character varying(150) NOT NULL,
    active boolean NOT NULL,
    identifier character varying(36) NOT NULL,
    nb_view integer NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.fp_setting CASCADE;

CREATE TABLE IF NOT EXISTS public.fp_setting
(
    id serial NOT NULL,
    color character varying(16) NOT NULL,
    font character varying(64) NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.fp_recipe_fp_categorie CASCADE;

CREATE TABLE IF NOT EXISTS public.fp_recipe_fp_categorie
(
    fp_recipe_id serial NOT NULL,
    fp_categorie_id serial NOT NULL
);

DROP TABLE IF EXISTS public.fp_recipe_fp_ingredient CASCADE;

CREATE TABLE IF NOT EXISTS public.fp_recipe_fp_ingredient
(
    fp_recipe_id serial NOT NULL,
    fp_ingredient_id serial NOT NULL
);

ALTER TABLE IF EXISTS public.fp_user
    ADD FOREIGN KEY (fp_setting_id)
    REFERENCES public.fp_setting (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.fp_reservation
    ADD CONSTRAINT fp_user_id FOREIGN KEY (fp_user_id)
    REFERENCES public.fp_user (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.fp_page
    ADD CONSTRAINT fp_user_id FOREIGN KEY (fp_user_id)
    REFERENCES public.fp_user (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;



ALTER TABLE IF EXISTS public.fp_comment
    ADD CONSTRAINT fp_user_id FOREIGN KEY (fp_user_id)
    REFERENCES public.fp_user (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.fp_comment
    ADD CONSTRAINT fp_recipe_id FOREIGN KEY (fp_recipe_id)
    REFERENCES public.fp_recipe (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.fp_media
    ADD FOREIGN KEY (fp_recipe_id)
    REFERENCES public.fp_recipe (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.fp_recipe_fp_categorie
    ADD FOREIGN KEY (fp_recipe_id)
    REFERENCES public.fp_recipe (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.fp_recipe_fp_categorie
    ADD FOREIGN KEY (fp_categorie_id)
    REFERENCES public.fp_categorie (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.fp_recipe_fp_ingredient
    ADD FOREIGN KEY (fp_recipe_id)
    REFERENCES public.fp_recipe (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.fp_recipe_fp_ingredient
    ADD FOREIGN KEY (fp_ingredient_id)
    REFERENCES public.fp_ingredient (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;