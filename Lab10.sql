-- 1. Function PreReqsFor(courseNum) - returns the prereqs for the passed-in course number.

CREATE OR REPLACE FUNCTION PreReqsFor(INT, REFCURSOR) RETURNS REFCURSOR AS
$$
DECLARE
   cNum INT		:= $1;
   resultset REFCURSOR  := $2;
BEGIN
   OPEN resultset FOR
     SELECT prereqnum
     FROM Prerequisites
     WHERE coursenum = cNum;
   RETURN resultset;
END;
$$
LANGUAGE plpgsql;

SELECT PreReqsFor(499, 'results');
FETCH ALL FROM results;

SELECT PreReqsFor(221, 'results');
FETCH ALL FROM results;

-- 2. Function IsPreReqFor(courseNum) - returns the courses for which the passd-in course number
--    is an immediate pre-requisite.

CREATE OR REPLACE FUNCTION IsPreReqsFor(INT, REFCURSOR) RETURNS REFCURSOR AS
$$
DECLARE
   cNum INT		:= $1;
   resultset REFCURSOR  := $2;
BEGIN
   OPEN resultset FOR
     SELECT num, name
     FROM Courses
     WHERE num IN (SELECT coursenum
		   FROM Prerequisites
		   WHERE prereqnum = cNum);
   RETURN resultset;
END;
$$
LANGUAGE plpgsql;

SELECT IsPreReqsFor(220, 'results');
FETCH ALL FROM results;

SELECT IsPreReqsFor(308, 'results');
FETCH ALL FROM results;

SELECT IsPreReqsFor(120, 'results');
FETCH ALL FROM results;
