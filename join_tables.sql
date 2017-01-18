SELECT
  counties.county,
  counties.state,
  counties.geoid,
  counties.subregion,
  counties.the_geom,
  data.total_vote,
  data.clinton,
  data.clinton_pct,
  data.trump,
  data.trump_pct,
  data.trump_margin,
  data.trump_margin_pct
FROM appalachia counties
LEFT JOIN pres_election_data_2016n_appalachia data
ON counties.geoid = data.fips;
