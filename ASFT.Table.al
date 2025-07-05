table 123456786 ASFT
{
    Caption = 'ASFT_Tabelle_Abwesenheit';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Eintrags ID"; Integer)
        {
            Caption = 'Eintrags ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Mitarbeiter ID';
            DataClassification = ToBeClassified;
            TableRelation = Dim_Mitarbeiter."Mitarbeiter ID";
        }
        field(3; "From Date"; Date)
        {
            Caption = 'Startdatum';
            DataClassification = ToBeClassified;
            TableRelation = Dim_Zeitpunkt."Datum ID";
        }
        field(4; "To Date"; Date)
        {
            Caption = 'Enddatum';
            DataClassification = ToBeClassified;
            TableRelation = Dim_Zeitpunkt."Datum ID";
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Abteilung';
            DataClassification = ToBeClassified;
            TableRelation = Dim_Abteilung.Abteilung;
        }
        field(6; "Absence Reason Code"; Code[10])
        {
            Caption = 'Abwesenheitsgrund';
            DataClassification = ToBeClassified;
            TableRelation = "Cause of Absence".Code;
        }
        field(7; "Duration"; Decimal)
        {
            Caption = 'Dauer in Tagen';
            DataClassification = ToBeClassified;
        }
        field(8; "Number of Mondays"; Integer)
        {
            Caption = 'Anzahl an Montagen';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Eintrags ID")
        {
            Clustered = true;
        }
    }
}
