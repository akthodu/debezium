CREATE TABLE a_table
(
    web_id       bigint                                 not null
        constraint pk_a_table
            primary key,
    version      integer                  default 0     not null,
    date_updated timestamp with time zone default now() not null,
    date_created timestamp with time zone default now() not null,
    item         varchar(40)
);


ALTER TABLE public.a_table
    REPLICA IDENTITY FULL;


CREATE PUBLICATION dbz_full_publication
    FOR TABLE a_table;

SELECT * FROM pg_replication_slots;

INSERT INTO a_table (web_id, item) VALUES (1, 'item1');
UPDATE a_table set item='item1 updated' where web_id=1;
UPDATE a_table set date_updated=now() where web_id=1;
INSERT INTO a_table (web_id, item) VALUES (3, 'Delete me please');
delete from a_table where web_id=3;
