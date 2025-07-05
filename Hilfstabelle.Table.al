table 123456784 Hilfstabelle
{
    Caption = 'Hilfstabelle';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee no."; Code[20])
        {
            Caption = 'Mitarbeiter ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Eintrags ID"; Integer)
        {
            Caption = 'Eintrags ID';
            DataClassification = ToBeClassified;
        }
        field(3; "Tag ID"; Integer)
        {
            Caption = 'Tag ID';
            DataClassification = ToBeClassified;
        }
        field(4; "Date"; Date)
        {
            Caption = 'Datum';
            DataClassification = ToBeClassified;
        }
        field(6; "Abwesenheitsgrund"; Code[10])
        {
            Caption = 'Abwesenheitsgrund';
            DataClassification = ToBeClassified;
            TableRelation = "Cause of Absence".Code;
        }
        field(7; "Dauer"; Decimal)
        {
            Caption = 'Dauer in Tagen';
            DataClassification = ToBeClassified;
        }
        field(8; "Abteilung"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Eintrags ID", "Date")
        {
            Clustered = true;
        }
    }
}
