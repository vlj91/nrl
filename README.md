## Notes

* Mostly batch jobs, the data only needs to be scraped every few hours, so processing can occur in between games/days/rounds

## Pulling initial data

Run the jobs in order to scrape the initial data:

1. `TeamScraperJob`
2. `PlayerScraperJob`
3. `GameScraperJob`
4. `GameStatsScraperJob`

Alternatively, just run `RunAllJob`

## Things

### `GET /predictions/accuracy`

Returns the current model validation accuracy:

```json
{"accuracy_percent":82.73}
```

### `GET /predictions/probability/:id`

Returns the probabilities of each side winning a game. Provide game_id:

```json
{"away": 0.08881750275339861, "draw": 0.002411944486199366, "home": 0.9087705527604021}
```

### `GET /prediction/:id`

Returns the predicted winner of a game. Provide game_id:

```json
{"predicted_winner":"home"}
```
