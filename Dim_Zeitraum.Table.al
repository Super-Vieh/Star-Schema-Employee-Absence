table 123456780 Dim_Zeitraum
{
    Caption = 'Dimension_Zeitraum';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Monat ID"; Code[20])
        {
            Caption = 'Monat ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Monat"; Integer)
        {
            Caption = 'Monat';
            DataClassification = ToBeClassified;
        }
        field(3; "Quartal"; Code[10])
        {
            Caption = 'Quartal';
            DataClassification = ToBeClassified;
        }
        field(4; "Jahr"; Integer)
        {
            Caption = 'Jahr';
            DataClassification = ToBeClassified;
        }
        field(5; "Startdatum"; Date)
        {
            Caption = 'Startdatum';
            DataClassification = ToBeClassified;
        }
        field(6; "Enddatum"; Date)
        {
            Caption = 'Enddatum';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Monat ID")
        {
            Clustered = true;
        }
    }
}
