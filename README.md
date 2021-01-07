## Notes

* Mostly batch jobs, the data only needs to be scraped every few hours, so processing can occur in between games/days/rounds

## Pulling initial data

Run the jobs in order to scrape the initial data:

1. `TeamScraperJob`
2. `PlayerScraperJob`
3. `GameScraperJob`
4. `GameStatsScraperJob`

Alternatively, just run `RunAllJob`
