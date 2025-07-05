page 123456781 Dim_Zeitpunkt_Page
{
    ApplicationArea = All;
    Caption = 'Dim_Zeitpunkt_P';
    PageType = List;
    SourceTable = Dim_Zeitpunkt;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Datum ID"; Rec."Datum ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID des Datums.';
                }
                field("Tag"; Rec.Tag)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tag des Datums.';
                }
                field("Monat"; Rec.Monat)
                {
                    ApplicationArea = All;
                    ToolTip = 'Monat des Datums.';
                }
                field("Jahr"; Rec.Jahr)
                {
                    ApplicationArea = All;
                    ToolTip = 'Jahr des Datums.';
                }
                field("Quartal"; Rec.Quartal)
                {
                    ApplicationArea = All;
                    ToolTip = 'Quartal des Datums.';
                }
                field(Wochentag; Rec.Wochentag)
                {
                    ApplicationArea = All;
                    ToolTip = 'Wochentag des Datums.';
                }
                field("Arbeitstag"; Rec.Arbeitstag)
                {
                    ApplicationArea = All;
                    ToolTip = 'Gibt an, ob der Tag ein Arbeitstag ist.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(filldimzeitpunkt)
            {
                trigger OnAction()
                var
                    DimFillCodeunit: Codeunit "Dim_Fill"; // ID und Name deiner Codeunit
                begin
                    DimFillCodeunit.filldimzeitpunkt();
                    CurrPage.Update(true);
                end;
            }
            action(cleartable)
            {
                trigger OnAction()
                var
                    DimZeitpunkt: Record "Dim_Zeitpunkt";
                begin
                    DimZeitpunkt.DeleteAll();
                end;
            }
        }
    }
}
