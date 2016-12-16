set search_path to mimiciii;


drop materialized view if exists midazolam_rass_waveforms;
create materialized view midazolam_rass_waveforms as (
with temp as (
select m.icustay_id, r.subject_id, r.hadm_id, r.charttime, r.valuenum
from adult_icu_vent_midazolam_rass m
left join rass r
on m.hadm_id=r.hadm_id)
SELECT ROW_NUMBER() 
        OVER (ORDER BY icustay_id, charttime) AS Row, 
    subject_id, hadm_id, icustay_id, charttime, valuenum 
FROM temp);

select *
from midazolam_rass_waveforms;

-- select count(icustay_id)
-- from midazolam_rass_waveforms;