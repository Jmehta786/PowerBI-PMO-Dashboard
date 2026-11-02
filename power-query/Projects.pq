// Projects – one row per project (dimension table)
let
    Source = Excel.Workbook(File.Contents(DataFilePath), null, true),
    Projects_Sheet = Source{[Item = "Projects", Kind = "Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Projects_Sheet, [PromoteAllScalars = true]),
    #"Changed Type" = Table.TransformColumnTypes(
        #"Promoted Headers",
        {
            {"ProjectID", type text},
            {"ProjectName", type text},
            {"StartDate", type date},
            {"EndDate", type date},
            {"Status", type text}
        }
    )
in
    #"Changed Type"
