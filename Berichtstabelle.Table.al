table 123456787 Berichtstabelle
{
    Caption = 'Berrichtstabelle';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Deparment ID"; Code[20])
        {
            Caption = 'Abteilung ID';
            DataClassification = ToBeClassified;
            TableRelation = Dim_Abteilung.Abteilung;
        }
        field(2; "Abteilung Name"; Text[100])
        {
            Caption = 'Abteilungsname';
            DataClassification = ToBeClassified;
        }
        field(3; "Monats ID"; Code[20])
        {
            Caption = 'Monats ID';
            DataClassification = ToBeClassified;
            TableRelation = Dim_Zeitraum."Monat ID";
        }
        field(4; "ArbeitstageMontags"; Decimal)
        {
            Caption = 'Arbeitstage';
            DataClassification = ToBeClassified;
        }
        field(5; "KrankheitstageMontags"; Decimal)
        {
            Caption = 'KrankheitstageMontags';
            DataClassification = ToBeClassified;
        }
        field(6; "KrankenstandMontags"; Decimal)
        {
            Caption = 'KrankenstandMontags';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "deparment ID", "Monats ID")
        {
            Clustered = true;
        }
    }
}
