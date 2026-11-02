# Data dictionary

[← Back to README](../README.md)

Source workbook: [`data/pmo-data.xlsx`](../data/pmo-data.xlsx), one sheet per table. CSV copies are in [`data/csv/`](../data/csv/).

## Projects (10 rows)

| Column | Type | Description | Example |
|---|---|---|---|
| ProjectID | Text (key) | Unique project identifier | `P001` |
| ProjectName | Text | Project name | Website Redesign |
| StartDate | Date | Project start date | 2024-01-10 |
| EndDate | Date | Planned project end date | 2024-06-30 |
| Status | Text | RAG health status: `Green`, `Amber`, `Red` | Green |

## Budgets (10 rows, one per project)

| Column | Type | Description | Example |
|---|---|---|---|
| BudgetID | Text (key) | Unique budget line identifier | `B001` |
| ProjectID | Text | Links to Projects | `P001` |
| AllocatedBudget | Whole number | Total approved budget | 50,000 |
| SpentToDate | Whole number | Amount spent so far | 32,000 |
| RemainingBudget | Whole number | AllocatedBudget − SpentToDate | 18,000 |

## Milestones (30 rows, three per project)

| Column | Type | Description | Example |
|---|---|---|---|
| MilestoneID | Text (key) | Unique milestone identifier | `M001` |
| ProjectID | Text | Links to Projects | `P001` |
| MilestoneName | Text | `Milestone 1`, `Milestone 2` or `Milestone 3` | Milestone 1 |
| PlannedDate | Date | Baseline date | 2024-02-10 |
| ActualDate | Date | Date achieved | 2024-02-11 |
| Status | Text | `On Time`, `Delayed`, `Completed` | On Time |

## Risks (16 rows)

| Column | Type | Description | Example |
|---|---|---|---|
| RiskID | Text (key) | Unique risk identifier | `R001` |
| ProjectID | Text | Links to Projects | `P001` |
| RiskDescription | Text | Short description of the risk | Scope creep |
| Impact | Text | `High`, `Medium`, `Low` | Medium |
| Probability | Text | `High`, `Medium`, `Low` | Low |
| Status | Text | `Open`, `Closed` | Open |

## DateTable (calculated in DAX)

| Column | Type | Expression | Example |
|---|---|---|---|
| Date | Date | `CALENDAR(MIN(Projects[StartDate]), MAX(Projects[EndDate]))` | 2024-01-05 |
| Month | Text | `FORMAT(DateTable[Date], "MMM")` | Jan |
| Year | Whole number | `YEAR(DateTable[Date])` | 2024 |
| YearMonth | Text | `FORMAT(DateTable[Date], "YYYY-MM")` | 2024-01 |

---

## Data validation checks

These checks were run on the source data.

| Check | Result |
|---|---|
| Primary keys are unique in all four tables | ✅ Pass |
| No blank values in any table | ✅ Pass |
| Every `ProjectID` in Budgets, Milestones and Risks exists in Projects | ✅ Pass |
| Every project has a budget line, milestones and at least one risk | ✅ Pass |
| `RemainingBudget = AllocatedBudget − SpentToDate` on every row | ✅ Pass |
| `SpentToDate ≤ AllocatedBudget` (no overspend) | ✅ Pass |
| `EndDate ≥ StartDate` for every project | ✅ Pass |
| Milestone planned dates fall inside their project's start–end window | ⚠️ 9 of 30 fall outside (e.g. Analytics Dashboard runs Jun–Jul but has milestones in Jan, Apr and Aug) |
| Milestone `Status` uses one consistent scale | ⚠️ Mixes *timeliness* (`On Time`, `Delayed`) with *completion* (`Completed`) |

The two flagged items are addressed on the [roadmap](roadmap.md).
