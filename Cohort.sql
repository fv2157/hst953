set search_path to mimiciii;

-- select count(distinct subject_id)
-- from patients; -- 46,520 patients

-- select count(distinct subject_id)
-- from icustays; -- 46,476 ICU patients

-- select count(distinct icustays)
-- from icustays; -- 61,532 ICU stays


drop materialized view if exists adult_icustays;
create materialized view adult_icustays as
with temp_table as(
select i.icustay_id, i.hadm_id, i.subject_id, i.intime, p.dob, extract(days from i.intime-p.dob)/365 as age, p.gender
from icustays i
inner join patients p
on i.subject_id=p.subject_id
)
select *
from temp_table
where age>18; -- 61,532 icustays; 6,878 age=0 icustays; 54,654 age>0 icustays; 53,332 age>18 icustays

select count(icustay_id)
from adult_icustays; -- 53,332 adult icustays

select count(distinct icustay_id)
from mech_vent_final; -- 27,767 icustays with mech. vent.

drop materialized view if exists adult_icu_vent;
create materialized view adult_icu_vent as
with temp1 as (
select *,
row_number () over (partition by icustay_id order by charttime)
from mech_vent_final
)
select ai.*
from adult_icustays ai
inner join temp1 t
on ai.icustay_id=t.icustay_id
where t.row_number=1;

select count(distinct icustay_id)
from adult_icu_vent; -- 25,841 ventilated adult icustays


select count(distinct icustay_id)
from pop_dexmedetomidine; -- 1008 icustays with dexmedetomidine

drop materialized view if exists adult_icu_vent_dexmedetomidine;
create materialized view adult_icu_vent_dexmedetomidine as
with temp1 as (
select *,
row_number () over (partition by icustay_id order by starttime)
from pop_dexmedetomidine
)
select aiv.*
from adult_icu_vent aiv
inner join temp1 t
on aiv.icustay_id=t.icustay_id
where t.row_number=1;

select count(icustay_id)
from adult_icu_vent_dexmedetomidine; -- 988 ventilated adult icustays with with dexmedetomidine


select count(distinct icustay_id)
from pop_midazolam; -- 7005 icustays with midazolam

drop materialized view if exists adult_icu_vent_midazolam;
create materialized view adult_icu_vent_midazolam as
with temp1 as (
select *,
row_number () over (partition by icustay_id order by starttime)
from pop_midazolam
)
select aiv.*
from adult_icu_vent aiv
inner join temp1 t
on aiv.icustay_id=t.icustay_id
where t.row_number=1;

select count(icustay_id)
from adult_icu_vent_midazolam; -- 6256 ventilated adult icustays with with midazolam



drop materialized view if exists adult_icu_vent_dexmedetomidine_rass;
create materialized view adult_icu_vent_dexmedetomidine_rass as
with temp1 as (
select *,
row_number () over (partition by icustay_id order by charttime)
from rass
)
select aiv.*
from adult_icu_vent_dexmedetomidine aiv
inner join temp1 t
on aiv.icustay_id=t.icustay_id
where t.row_number=1;;

select count(icustay_id)
from adult_icu_vent_dexmedetomidine_rass; -- 752 ventilated adult icustays with with dexmedetomidine and RASS score


drop materialized view if exists adult_icu_vent_midazolam_rass;
create materialized view adult_icu_vent_midazolam_rass as
with temp1 as (
select *,
row_number () over (partition by icustay_id order by charttime)
from rass
)
select aiv.*
from adult_icu_vent_midazolam aiv
inner join temp1 t
on aiv.icustay_id=t.icustay_id
where t.row_number=1;;

select count(icustay_id)
from adult_icu_vent_midazolam_rass; -- 2405 ventilated adult icustays with with midazolam and RASS score