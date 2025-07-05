table 123456782 Dim_Mitarbeiter
{
    Caption = 'Dimension_Mitarbeiter';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Mitarbeiter ID"; Code[20])
        {
            Caption = 'Mitarbeiter ID';
        }
        field(2; "Abteilung"; Code[20])
        {
            Caption = 'Abteilung';
            TableRelation = Dim_Abteilung.Abteilung;
        }
        field(3; "JobTitel"; Text[100])
        {
            Caption = 'JobTitel';
        }
    }
    keys
    {
        key(PK; "Mitarbeiter ID")
        {
            Clustered = true;
        }
    }
}
