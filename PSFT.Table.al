table 123456785 PSFT
{
    Caption = 'PSFT_Tabelle_Abwesenheiten';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Monat ID"; Code[10])
        {
            Caption = 'Monat ID';
            DataClassification = ToBeClassified;
            TableRelation = Dim_Zeitraum."Monat ID";
        }
        field(2; "Abteilung"; Code[20])
        {
            Caption = 'Abteilung';
            DataClassification = ToBeClassified;
            TableRelation = Dim_Abteilung.Abteilung;
        }
        field(3; "Anzahl Abwesenheiten"; Integer)
        {
            Caption = 'Anzahl Abwesenheiten';
            DataClassification = ToBeClassified;
        }
        field(4; "Anzahl Urlaub"; Integer)
        {
            Caption = 'Anzahl Urlaub';
            DataClassification = ToBeClassified;
        }
        field(5; "Anzahl Krank"; Integer)
        {
            Caption = 'Anzahl Krank';
            DataClassification = ToBeClassified;
        }
        field(6; "Gesammttage abwesend"; Decimal)
        {
            Caption = 'Gesamttage abwesend';
            DataClassification = ToBeClassified;
        }
        field(7; "Mögliche Arbeitstage"; Decimal)
        {
            Caption = 'Mögliche Arbeitstage';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Monat ID", "Abteilung")
        {
            Clustered = true;
        }
    }
}
