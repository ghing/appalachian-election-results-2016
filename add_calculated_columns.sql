ALTER TABLE pres_election_data_2016n_appalachia
DROP COLUMN IF EXISTS clinton_pct;

ALTER TABLE pres_election_data_2016n_appalachia
ADD COLUMN clinton_pct numeric;

UPDATE pres_election_data_2016n_appalachia
SET clinton_pct = clinton / total_vote;

ALTER TABLE pres_election_data_2016n_appalachia
DROP COLUMN IF EXISTS trump_pct;

ALTER TABLE pres_election_data_2016n_appalachia
ADD COLUMN trump_pct numeric;

UPDATE pres_election_data_2016n_appalachia
SET trump_pct = trump / total_vote;

ALTER TABLE pres_election_data_2016n_appalachia
DROP COLUMN IF EXISTS trump_margin;

ALTER TABLE pres_election_data_2016n_appalachia
ADD COLUMN trump_margin numeric;

UPDATE pres_election_data_2016n_appalachia
SET trump_margin = trump - clinton;

ALTER TABLE pres_election_data_2016n_appalachia
DROP COLUMN IF EXISTS trump_margin_pct;

ALTER TABLE pres_election_data_2016n_appalachia
ADD COLUMN trump_margin_pct numeric;

UPDATE pres_election_data_2016n_appalachia
SET trump_margin_pct = trump_margin / total_vote; 

