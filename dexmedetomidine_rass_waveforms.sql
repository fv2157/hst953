set search_path to mimiciii;


drop materialized view if exists dexmedetomidine_rass_waveforms;
create materialized view dexmedetomidine_rass_waveforms as (
with temp as (
select d.icustay_id, r.subject_id, r.hadm_id, r.charttime, r.valuenum
from adult_icu_vent_dexmedetomidine_rass d
left join rass r
on d.hadm_id=r.hadm_id)
SELECT ROW_NUMBER() 
        OVER (ORDER BY icustay_id, charttime) AS Row, 
    subject_id, hadm_id, icustay_id, charttime, valuenum 
FROM temp);

select *
from dexmedetomidine_rass_waveforms;

-- select count(icustay_id)
-- from dexmedetomidine_rass_waveforms;