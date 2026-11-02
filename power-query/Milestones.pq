// Milestones – planned vs actual dates per project milestone
let
    Source = Excel.Workbook(File.Contents(DataFilePath), null, true),
    Milestones_Sheet = Source{[Item = "Milestones", Kind = "Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Milestones_Sheet, [PromoteAllScalars = true]),
    #"Changed Type" = Table.TransformColumnTypes(
        #"Promoted Headers",
        {
            {"MilestoneID", type text},
            {"ProjectID", type text},
            {"MilestoneName", type text},
            {"PlannedDate", type date},
            {"ActualDate", type date},
            {"Status", type text}
        }
    )
in
    #"Changed Type"
