/*
 * This file is used to test the function of ExecVecUnique(), prepare for test vec_unique
 */
----
--- Create Table and Insert Data
----
create schema vector_unique_engine;
set current_schema = vector_unique_engine;

create table vector_unique_engine.ROW_UNIQUE_TABLE_01
(
	col_int0	int4
   ,col_int1	int
   ,col_int2	int
   ,col_bint	bigint
   ,col_char	char(25)
   ,col_vchar	varchar(35)
   ,col_num		numeric(10,4)
   ,col_decimal	decimal
   ,col_float	float
   ,col_date	date
   ,col_time	time
   ,col_timetz	timetz
   ,col_interval	interval
);

create table vector_unique_engine.VECTOR_UNIQUE_TABLE_01
(
	col_int0	int4
   ,col_int1	int
   ,col_int2	int
   ,col_bint	bigint
   ,col_char	char(25)
   ,col_vchar	varchar(35)
   ,col_num		numeric(10,4)
   ,col_decimal	decimal
   ,col_float	float
   ,col_date	date
   ,col_time	time
   ,col_timetz	timetz
   ,col_interval	interval
)with(orientation=column) ;

create table vector_unique_engine.ROW_UNIQUE_TABLE_02
(
	col_int0	int4
   ,col_int1	int
   ,col_int2	int
   ,col_bint	bigint
   ,col_char	char(25)
   ,col_vchar	varchar(35)
   ,col_num		numeric(10,4)
   ,col_decimal	decimal
   ,col_float	float
   ,col_date	date
   ,col_time	time
   ,col_timetz	timetz
   ,col_interval	interval
);

create table vector_unique_engine.VECTOR_UNIQUE_TABLE_02
(
	col_int0	int4
   ,col_int1	int
   ,col_int2	int
   ,col_bint	bigint
   ,col_char	char(25)
   ,col_vchar	varchar(35)
   ,col_num		numeric(10,4)
   ,col_decimal	decimal
   ,col_float	float
   ,col_date	date
   ,col_time	time
   ,col_timetz	timetz
   ,col_interval	interval
)with(orientation=column) ;

\parallel on  18
insert into ROW_UNIQUE_TABLE_01 values(1, 10, 100, 10000, 'aa', 'aaaaaa', 0.01, 10.01, 1100.01, '2015-02-14', '16:00:38', '1996-2-6 01:00:30+8', '2 day 13:24:56');
insert into ROW_UNIQUE_TABLE_01 values(11, 20, 100, 10000, 'aa', 'gggggg', 0.01, 10.01, 1100.01, '2015-03-14', '16:02:38', '1996-2-8 01:00:30+8', '2 day 13:56:56');
insert into ROW_UNIQUE_TABLE_01 values(1, 30, 100, 30000, 'bb', 'aaaaaa', 0.01, 10.01, 100.01, '2015-04-15', '16:02:38', '1996-2-6 01:00:30+8', '2 day 13:24:56');
insert into ROW_UNIQUE_TABLE_01 values(11, 40, 100, 10000, 'bb', 'aaaaaa', 0.04, 10.01, 100.01, '2015-05-16', '16:00:38', '1996-2-8 01:00:30+8', '2 day 13:24:56');
insert into ROW_UNIQUE_TABLE_01 values(1, 50, 200, 10000, 'cc', 'aaaaaa', 0.01, 10.11, 100.01, '2015-02-18', '16:00:38', '1996-2-6 01:00:30+8', '2 day 13:56:56');
insert into ROW_UNIQUE_TABLE_01 values(11, 10, 100, 30000, 'dd', 'hhhhhh', 0.01, 10.01, 100.01, '2015-08-09', '16:00:38', '1996-2-8 01:00:30+8', '2 day 13:24:56');
insert into ROW_UNIQUE_TABLE_01 values(1, 20, 100, 10000, 'dd', 'aaaaaa', 0.01, 10.01, 100.01, '2015-10-06', '16:05:38', '1996-2-6 01:00:30+8', '8 day 13:24:56');
insert into ROW_UNIQUE_TABLE_01 values(11, 30, 100, 10000, 'ee', 'ffffff', 0.08, 10.01, 1100.01, '2015-12-02', '16:05:38', '1996-2-6 01:00:30+8', '2 day 13:24:56');
insert into ROW_UNIQUE_TABLE_01 values(1, 40, 200, 60000, 'ee', 'aaaaaa', 0.08, 10.01, 1100.01, '2015-06-16', '16:00:38', '1996-2-8 01:00:30+8', '10 day 13:24:56');
insert into ROW_UNIQUE_TABLE_01 values(11, 50, 100, 10000, 'gg', 'ffffff', 0.01, 10.11, 100.01, '2015-05-20', '16:00:38', '1996-2-6 01:00:30+8', '2 day 13:24:56');

insert into ROW_UNIQUE_TABLE_02 values(2, 10, 900, 10000, 'aa', 'bbbbbb', 0.01, 10.01, 100.01, '2015-02-14', '16:00:38', '1996-2-6 01:00:30+8', '2 day 13:24:56');
insert into ROW_UNIQUE_TABLE_02 values(1, 20, 100, 20000, 'cc', 'aaaaaa', 0.01, 10.01, 100.01, '2015-02-14', '16:00:38', '1996-2-16 01:00:30+8', '2 day 13:24:56');
insert into ROW_UNIQUE_TABLE_02 values(2, 10, 800, 10000, 'aa', 'cccccc', 0.01, 10.02, 100.22, '2015-02-14', '16:00:38', '1996-2-6 01:00:30+8', '8 day 13:24:56');
insert into ROW_UNIQUE_TABLE_02 values(7, 40, 100, 10000, 'aa', 'cccccc', 0.01, 10.01, 100.22, '2015-02-14', '16:08:38', '1996-2-16 01:00:30+8', '2 day 13:24:56');
insert into ROW_UNIQUE_TABLE_02 values(2, 10, 700, 20000, 'eee', 'aaaaaa', 0.01, 10.01, 100.22, '2015-02-14', '16:08:38', '1996-2-6 01:00:30+8', '2 day 13:24:56');
insert into ROW_UNIQUE_TABLE_02 values(1, 60, 100, 10000, 'aa', 'zzzzzz', 0.01, 10.02, 100.01, '2015-02-14', '16:00:38', '1996-2-6 01:00:30+8', '8 day 13:24:56');
insert into ROW_UNIQUE_TABLE_02 values(2, 10, 600, 10000, 'ddd', 'aaaaaa', 0.01, 10.01, 100.01, '2015-02-16', '16:00:38', '1996-2-16 01:00:30+8', '2 day 13:24:56');
insert into ROW_UNIQUE_TABLE_02 values(1, 80, 100, 20000, 'aa', 'vvvvvvv', 0.01, 10.01, 100.01, '2015-02-16', '16:00:38', '1996-2-6 01:00:30+8', '2 day 13:24:56');
\parallel off

insert into VECTOR_UNIQUE_TABLE_01 select * from ROW_UNIQUE_TABLE_01;
insert into VECTOR_UNIQUE_TABLE_02 select * from ROW_UNIQUE_TABLE_02;

analyze VECTOR_UNIQUE_TABLE_01;
analyze VECTOR_UNIQUE_TABLE_02;
