// Risks – risk register per project
// The sheet loaded without detected headers, so columns are typed as
// text first, then headers are promoted and the final types applied.
let
    Source = Excel.Workbook(File.Contents(DataFilePath), null, true),
    Risks_Sheet = Source{[Item = "Risks", Kind = "Sheet"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(
        Risks_Sheet,
        {
            {"Column1", type text}, {"Column2", type text}, {"Column3", type text},
            {"Column4", type text}, {"Column5", type text}, {"Column6", type text}
        }
    ),
    #"Promoted Headers" = Table.PromoteHeaders(#"Changed Type", [PromoteAllScalars = true]),
    #"Changed Type1" = Table.TransformColumnTypes(
        #"Promoted Headers",
        {
            {"RiskID", type text},
            {"ProjectID", type text},
            {"RiskDescription", type text},
            {"Impact", type text},
            {"Probability", type text},
            {"Status", type text}
        }
    )
in
    #"Changed Type1"
