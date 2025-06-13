# silverscreen
masterschool project
# 🎬 Movie Performance Analytics (dbt Project)

This dbt project analyzes movie transactions and rental costs across different locations and months.  
It builds a clean and validated data mart model for reporting on key business KPIs: ticket sales, rental costs, and revenue.

---

## 📌 Project Goals

- ✅ Combine transactional and rental data per movie, month, and location
- ✅ Handle missing rental data using imputation from previous months
- ✅ Build a final **mart** model with enriched movie catalogue metadata
- ✅ Ensure data quality through column-level and custom tests
- ✅ Enable reliable business reporting

---

---

## 🧠 Business Logic

### Rental Cost Filling

To handle missing rental cost data (which can occur if no rental data is recorded in a given month), we applied this logic:

- `LEFT JOIN` was used to combine transactional and rental data
- `LAG()` function helped us retrieve the rental value from the previous month for the same movie and location
- `COALESCE()` was used to **fill missing values** with the previous month's rental cost

This results in a more complete dataset and avoids gaps in reporting.

---

## 📊 Final Model: `mart_movies`

This is the final output model used for reporting and visualization.

| Column         | Description                                                   |
|----------------|---------------------------------------------------------------|
| `movie_id`     | Unique identifier for the movie                               |
| `movie_title`  | Title of the movie                                             |
| `genre`        | Genre (e.g., Action, Comedy)                                   |
| `studio`       | Production studio                                              |
| `month`        | Financial month (e.g., `2024-04`)                              |
| `location`     | Cinema location                                                |
| `rental_cost`  | Monthly rental cost (filled from previous month if missing)   |
| `tickets_sold` | Number of tickets sold                                         |
| `revenue`      | Total transaction revenue                                      |

---

## ✅ Tests Included

### Column-level tests

- `not_null` on all essential fields
- `>= 0` validation on `rental_cost`, `tickets_sold`, and `revenue`

### Custom tests

| Test Name                     | Description                                                 |
|------------------------------|-------------------------------------------------------------|
| `test_revenue_but_no_tickets`| Detects revenue with no tickets                             |
| `test_tickets_but_no_revenue`| Detects tickets sold but no revenue                         |
| `test_duplicate_keys`        | Detects duplicates by `(movie_id, month, location)`         |

---

## 🧪 Tools & Technologies

- **dbt Core**
- **SQL (BigQuery / Snowflake compatible)**
- **Jinja (macros)**
- **dbt-utils** package

---

## 📘 Documentation

To build and serve the documentation locally:

```bash
dbt docs generate
dbt docs serve
