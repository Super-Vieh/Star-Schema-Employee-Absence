page 123456785 PSFT_Page
{
    ApplicationArea = All;
    Caption = 'PSFT_Page';
    PageType = List;
    SourceTable = PSFT;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Monat ID"; Rec."Monat ID")
                {
                    Caption = 'Monat ID';
                }
                field("Abteilung"; Rec.Abteilung)
                {
                    Caption = 'Abteilung';
                }
                field("Anzahl Abwesenheiten"; Rec."Anzahl Abwesenheiten")
                {
                    Caption = 'Anzahl Abwesenheiten';
                }
                field("Anzahl Urlaub"; Rec."Anzahl Urlaub")
                {
                    Caption = 'Anzahl Urlaub';
                }
                field("Anzahl Krank"; Rec."Anzahl Krank")
                {
                    Caption = 'Anzahl Krank';
                }
                field("Gesammttage abwesend"; Rec."Gesammttage abwesend")
                {
                    Caption = 'Gesamttage abwesend';
                }
                field("Mögliche Arbeitstage"; Rec."Mögliche Arbeitstage")
                {
                    Caption = 'Mögliche Arbeitstage';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(fillPSFT)
            {
                Caption = 'Fill PSFT';

                trigger OnAction()
                var
                    TabFill: Codeunit "Table_Fill";
                    DimFill: Codeunit "Dim_Fill";
                begin
                    DimFill.fillDims();
                    TabFill.fillPSFT();
                    CurrPage.Update(true);
                end;
            }
            action(clearTable)
            {
                Caption = 'Clear Table';
                Image = Delete;

                trigger OnAction()
                var
                    PSFT: Record PSFT;
                begin
                    PSFT.DeleteAll();
                end;
            }
            action(cleardims)
            {
                trigger OnAction()
                var
                    DimFill: Codeunit "Dim_Fill";
                begin
                    DimFill.clearDims();
                end;
            }
            action(resetHilfstabelle)
            {
                trigger OnAction()
                var
                    DimFill: Codeunit Dim_Fill;
                    HT: Record Hilfstabelle;
                begin
                    HT.DeleteAll();
                    DimFill.FillHilfstabelle();
                end;
            }
        }
    }
}
