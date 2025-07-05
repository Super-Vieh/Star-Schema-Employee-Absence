page 123456780 Dim_Zeitraum_Page
{
    ApplicationArea = All;
    Caption = 'Dimension_Zeitraum_Page';
    PageType = List;
    SourceTable = Dim_Zeitraum;

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
                field(Monat; Rec.Monat)
                {
                    Caption = 'Monat';
                }
                field(Quartal; Rec.Quartal)
                {
                    Caption = 'Quartal';
                }
                field(Jahr; Rec.Jahr)
                {
                    Caption = 'Jahr';
                }
                field(Startdatum; Rec.Startdatum)
                {
                    Caption = 'Startdatum';
                }
                field(Enddatum; Rec.Enddatum)
                {
                    Caption = 'Enddatum';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(fillDimZeitraum)
            {
                trigger OnAction()
                var
                    DimFillCodeunit: Codeunit "Dim_Fill";
                begin
                    DimFillCodeunit.fillDimZeitraum();
                    CurrPage.Update(true);
                end;
            }
            action(clearDimZeitraum)
            {
                trigger OnAction()
                var
                    DimZeitraum: Record "Dim_Zeitraum";
                begin
                    DimZeitraum.DeleteAll();
                end;
            }
        }
    }
}
