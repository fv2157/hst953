# hst953
Impact of sedative choice on ICU outcomes

This folder includes some of the codes used in the project "Impact of sedative choice on ICU outcomes: dexmedetomidine vs. midazolam" done as part of the requirements of the MIT course hst.953 (Fall 2016).

Other relevant pieces of code can be found at https://github.com/aforsyth/hst953

Instructtions:
 - run RASS.sql to create table rass
 - run mech_vent.sql to create table mech_vent_final
- run Cohort.sql to obtain 2 tables with all ICU stays receiving dexmed and all those receiving midazolam
- run dexmedetomidine_rass_waveforms.sql  and midazolam_rass_waveforms.sql to obtain tables with RASS waveforms (time histries) for each ICU stay
- run dexmedetomidine_rass_waveforms.m  and midazolam_rass_waveforms.m to import RASS waveforms in Matlab
- run rass_summary.m to obtain scalar indicators of RASS time histories (one RASS score per ICU stay)
