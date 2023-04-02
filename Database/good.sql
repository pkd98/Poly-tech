set pagesize 0   -- No header rows
set trimspool on -- remove trailing blanks
set headsep off  -- this may or may not be useful...depends on your headings.
set feedback off
set linesize 2000   -- X should be the sum of the column widths
set numw 2000       -- X should be the length you want for numbers (avoid scientific notation on IDs)
spool emp_list.csv;
SELECT EMPNO || ',' || ENAME || ',' || JOB || ',' || SAL || ',' || DEPTNO FROM EMP;
spool off;