CREATE TABLE parallel_sort_test AS SELECT hashint8(i) randint, md5(i::text) collate "C" padding1,
 md5(i::text || '2') collate "C" padding2 FROM generate_series(0, 200000) i;
CHECKPOINT;

--set parallel parameter
set trace_sort = on;
set client_min_messages = 'log';
set max_parallel_maintenance_workers=2;
set min_parallel_index_scan_size=0;
set min_parallel_table_scan_size=0;
set maintenance_work_mem=262144;
CREATE INDEX parallel_index ON parallel_sort_test (randint);

--clean up
reset trace_sort;
reset client_min_messages;
reset max_parallel_maintenance_workers;
reset min_parallel_index_scan_size;
reset min_parallel_table_scan_size;
reset maintenance_work_mem;
drop table parallel_sort_test cascade;