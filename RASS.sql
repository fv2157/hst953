﻿set search_path to mimiciii;

create table rass as 
select * 
from chartevents 
where itemid=228096;