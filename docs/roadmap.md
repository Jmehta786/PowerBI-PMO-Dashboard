# Roadmap

[← Back to README](../README.md)

Planned improvements for the next version of the dashboard.

## Report

- [ ] **Show months in calendar order on the line chart.** The axis is currently sorted by the `Active Projects` value. Fix: put `DateTable[YearMonth]` on the axis (it sorts as 2024-01, 2024-02, …), or add `MonthNo = MONTH(DateTable[Date])`, set *Sort by column* on `Month` to `MonthNo`, then choose *Sort axis → Month → Ascending*.
- [ ] **Count milestones in the milestone chart.** Its value is currently Count of `Projects[StartDate]`. Filters flow from Projects to Milestones but not back, so that count does not change with milestone status. Use `Total Milestones = COUNTROWS(Milestones)` as the value instead.
- [ ] **Add KPI cards** for Budget Utilisation %, Open High-Impact Risks and Delayed Milestones % (measures ready in [`proposed-measures.dax`](../dax/proposed-measures.dax)).
- [ ] **Add a risk heat map** (Impact × Probability matrix) next to the risk chart.
- [ ] **Remove the small overlap** between the milestone chart and the line chart.
- [ ] **Add tooltips** showing remaining budget and RAG status on the budget bars.

## Model

- [ ] **Replace implicit aggregations with explicit measures** (`Total Allocated Budget`, `Total Spent`, `Total Risks`, …) so the logic is reusable and formatted in one place.
- [ ] **Mark `DateTable` as the date table** and turn off *Auto date/time* to remove the hidden `LocalDateTable_*` tables and shrink the model.
- [ ] **Offer a slicer-aware active projects line** (`Active Projects (Selected)`) so the trend follows the selected projects.
- [ ] **Point the source at the repo** by using the `DataFilePath` parameter from [`power-query/`](../power-query/) in the .pbix.
- [ ] **Save as a Power BI Project (.pbip)** so model and report changes show up as readable diffs on GitHub.

## Data

- [ ] **Align milestone dates with project windows.** 9 of 30 milestones are planned outside their project's start–end dates (see [data validation](data-dictionary.md#data-validation-checks)).
- [ ] **Split milestone status into two fields:** completion (`Complete` / `Open`) and timeliness (`On Time` / `Late`), and add a slippage-in-days KPI (`Avg Milestone Slippage (days)`).
- [ ] **Add monthly spend history** so budget burn can be trended over time, not just shown as a snapshot.
