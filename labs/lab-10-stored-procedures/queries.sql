-- Jason Wong
-- 4/25/2014

create or replace function PreReqsFor(int) returns refcursor as
$$
declare
  queriedCourseNum int := $1;
  ref refcursor := 'result';
begin
  open ref for
    select num, name, credits
    from courses
    where num in(
      select preReqNum
      from prerequisites
      where courseNum = queriedCourseNum
    );
  return ref;
end;
$$
language plpgsql;

commit;
begin;
select PreReqsFor(449);
fetch all from result;

create or replace function isPreReqFor(int) returns refcursor as
$$
declare
  queriedCourseNum int := $1;
  ref refcursor := 'result';
begin
  open ref for
    select num, name, credits
    from courses
    where num in(
      select courseNum
      from prerequisites
      where preReqNum = queriedCourseNum
    );
  return ref;
end;
$$
language plpgsql;

commit;
begin;
select isPreReqFor(120);
fetch all from result;