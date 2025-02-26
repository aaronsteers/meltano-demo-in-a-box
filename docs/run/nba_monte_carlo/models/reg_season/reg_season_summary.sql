

  create  table
    "main"."reg_season_summary__dbt_tmp"
  as (
    -- depends-on: "main"."main"."reg_season_end"







SELECT
    winning_team AS team,
    E.conf,
    ROUND(AVG(wins),1) AS avg_wins,
    V.win_total AS vegas_wins,
    ROUND(AVG(V.win_total) - AVG(wins), 1) AS elo_vs_vegas,
    ROUND(PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY wins ASC), 1) AS wins_5th,
    ROUND(PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY wins ASC), 1) AS wins_95th,
    COUNT(*) FILTER (WHERE made_playoffs = 1 AND made_play_in = 0) AS made_postseason,
    COUNT(*) FILTER (WHERE made_play_in = 1) AS made_play_in,
    ROUND(PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY season_rank ASC), 1) AS seed_5th,
    ROUND(AVG(season_rank), 1) AS avg_seed,
    ROUND(PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY season_rank ASC), 1) AS seed_95th

FROM "main"."main"."reg_season_end" E

    LEFT JOIN "main"."main"."vegas_wins" V ON V.team = E.winning_team
GROUP BY ALL
  );

