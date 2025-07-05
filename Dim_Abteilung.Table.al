table 123456783 Dim_Abteilung
{
    Caption = 'Dimension_Abteilung';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Abteilung"; Code[20])
        {
            Caption = 'Abteilung';
        }
        field(2; "Abteilungsname"; Text[100])
        {
            Caption = 'Abteilungsname';
        }
        field(3; "Standort"; Text[100])
        {
            Caption = 'Standort';
        }
    }
    keys
    {
        key(PK; "Abteilung")
        {
            Clustered = true;
        }
    }
}
