page 123456782 Dim_Mitarbeiter_Page
{
    ApplicationArea = All;
    Caption = 'Dim_Mitarbeiter_P';
    PageType = List;
    SourceTable = Dim_Mitarbeiter;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Mitarbeiter ID"; Rec."Mitarbeiter ID")
                {
                    Caption = 'Mitarbeiter ID';
                }
                field(Abteilung; Rec.Abteilung)
                {
                    Caption = 'Abteilung';
                }
                field(JobTitel; Rec.JobTitel)
                {
                    Caption = 'JobTitel';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(filldimmitarbeiter)
            {
                trigger OnAction()
                var
                    DimFillCodeunit: Codeunit Dim_Fill;
                begin
                    DimFillCodeunit.filldimmitarbeiter();
                    CurrPage.Update(true);
                end;
            }
            action(cleartable)
            {
                trigger OnAction()
                var
                    DimMitarbeiter: Record "Dim_Mitarbeiter";
                begin
                    DimMitarbeiter.DeleteAll();
                end;
            }
        }
    }
}
