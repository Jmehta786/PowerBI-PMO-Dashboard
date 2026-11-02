// Budgets – allocated vs spent per project
let
    Source = Excel.Workbook(File.Contents(DataFilePath), null, true),
    Budgets_Sheet = Source{[Item = "Budgets", Kind = "Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Budgets_Sheet, [PromoteAllScalars = true]),
    #"Changed Type" = Table.TransformColumnTypes(
        #"Promoted Headers",
        {
            {"BudgetID", type text},
            {"ProjectID", type text},
            {"AllocatedBudget", Int64.Type},
            {"SpentToDate", Int64.Type},
            {"RemainingBudget", Int64.Type}
        }
    )
in
    #"Changed Type"
