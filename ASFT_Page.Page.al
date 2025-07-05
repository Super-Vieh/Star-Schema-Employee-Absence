page 123456786 ASFT_Page
{
    ApplicationArea = All;
    Caption = 'ASFT_P';
    PageType = List;
    SourceTable = ASFT;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry ID"; Rec."Eintrags ID")
                {
                    Caption = 'Eintrags ID';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Caption = 'Mitarbeiter ID';
                }
                field("From Date"; Rec."From Date")
                {
                    Caption = 'Startdatum';
                }
                field("To Date"; Rec."To Date")
                {
                    Caption = 'Enddatum';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Abteilung';
                }
                field("Absence Reason Code"; Rec."Absence Reason Code")
                {
                    Caption = 'Abwesenheitsgrund';
                }
                field(Duration; Rec.Duration)
                {
                    Caption = 'Dauer in Tagen';
                }
                field("Number of Mondays"; Rec."Number of Mondays")
                {
                    Caption = 'Anzahl an Montagen';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(fillasft)
            {
                trigger OnAction()
                var
                    FTFill: Codeunit Table_Fill;
                begin
                    FTFill.fillasft();
                    CurrPage.Update(true);
                end;
            }
            action(clearASFT)
            {
                trigger OnAction()
                var
                    ASFT: Record ASFT;
                begin
                    ASFT.DeleteAll();
                end;
            }
        }
    }
}
