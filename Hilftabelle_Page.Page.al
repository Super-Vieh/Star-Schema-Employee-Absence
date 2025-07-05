page 123456784 Hilftabelle_Page
{
    ApplicationArea = All;
    Caption = 'Hilfstabelle_page';
    PageType = List;
    SourceTable = Hilfstabelle;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Employee no."; Rec."Employee no.")
                {
                    ApplicationArea = All;
                    ToolTip = 'The number of the employee.';
                    Caption = 'Mitarbeiter_Nr.';
                }
                field("Eintrags ID"; Rec."Eintrags ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'The entry number of the absence record.';
                    Caption = 'Eintrags_Nr.';
                }
                field("Tag ID"; Rec."Tag ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'The ID of the day.';
                    Caption = 'Tag_ID';
                }
                field("Datum"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'The date of the entry.';
                    Caption = 'Datum';
                }
                field("abwesenheitsgrund"; Rec."Abwesenheitsgrund")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reason for the absence.';
                    Caption = 'Abwesenheitsgrund';
                }
                field(Abteilung; Rec.Abteilung)
                {
                    ApplicationArea = All;
                    Caption = 'Abteilung';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(fillhilfstabelle)
            {
                Caption = 'Fill Hilfstabelle';

                trigger OnAction()
                var
                    HilfstabelleFillCodeunit: Codeunit Dim_Fill;
                begin
                    HilfstabelleFillCodeunit.fillhilfstabelle();
                    CurrPage.Update(true);
                end;
            }
            action(cleartable)
            {
                Caption = 'Clear Hilfstabelle';
                Image = Delete;

                trigger OnAction()
                var
                    Hilfstabelle: Record "Hilfstabelle";
                begin
                    Hilfstabelle.DeleteAll();
                    CurrPage.Update(true);
                end;
            }
        }
    }
}
