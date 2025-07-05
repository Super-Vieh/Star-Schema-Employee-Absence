page 123456783 Dim_Abteilung_Page
{
    ApplicationArea = All;
    Caption = 'Dim_Abteilung_P';
    PageType = List;
    SourceTable = Dim_Abteilung;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Abteilung; Rec.Abteilung)
                {
                    Caption = 'Abteilung';
                }
                field(Abteilungsname; Rec.Abteilungsname)
                {
                    Caption = 'Abteilungsname';
                }
                field(Standort; Rec.Standort)
                {
                    Caption = 'Standort';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(filldimabteilung)
            {
                trigger OnAction()
                var
                    DimFillCodeunit: Codeunit "Dim_Fill";
                begin
                    DimFillCodeunit.filldimabteilung();
                    CurrPage.Update(true);
                end;
            }
            action(cleartable)
            {
                trigger OnAction()
                var
                    DimAbteilung: Record "Dim_Abteilung";
                begin
                    DimAbteilung.DeleteAll();
                end;
            }
        }
    }
}
