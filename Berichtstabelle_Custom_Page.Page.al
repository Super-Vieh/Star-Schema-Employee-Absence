page 123456788 Berichtstabelle_Custom_Page
{
    ApplicationArea = All;
    Caption = 'Berichtstabelle_Custom_Page';
    PageType = List;
    SourceTable = Berichtstabelle;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Deparment ID"; Rec."Deparment ID")
                {
                    Caption = 'Abteilung';
                    TableRelation = Dim_Abteilung.Abteilung;
                }
                field("Abteilung Name"; Rec."Abteilung Name")
                {
                    Caption = 'Abteilungsname';
                    TableRelation = Dim_Abteilung.Abteilungsname;
                }
                field("Monats ID"; Rec."Monats ID")
                {
                    Caption = 'Monat';
                    TableRelation = Dim_Zeitraum."Monat ID";
                }
                field(ArbeitstageMontags; Rec.ArbeitstageMontags)
                {
                    Caption = 'Arbeitstage Montags';
                }
                field(KrankheitstageMontags; Rec.KrankheitstageMontags)
                {
                    Caption = 'Krankheitstage Montags';
                }
                field(KrankenstandMontags; Rec.KrankenstandMontags)
                {
                    Caption = 'Krankenstand Montags';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(fillBericht)
            {
                Caption = 'Fill Bericht';
                ApplicationArea = All;
                Image = Process;
                ToolTip = 'Füllt die Berichtstabelle mit den berechneten Kennzahlen.';

                trigger OnAction()
                var
                    DimZeitraum: Record Dim_Zeitraum;
                    DimZeitpunkt: Record Dim_Zeitpunkt;
                    DimAbteilung: Record Dim_Abteilung;
                    DimMitarbeiter: Record Dim_Mitarbeiter;
                    Hilfstabelle: Record Hilfstabelle;
                    bericht: Record Berichtstabelle;
                    AnzahlMitarbeiter: Integer;
                    AnzahlArbeitsmontageImMonat: Integer;
                    KrankheitstageAnMontagen: Decimal;
                    KrankheitstageAnWochentagen: Decimal;
                    AnzahlArbeitstageImMonat: Integer;
                begin
                    DimZeitraum.SetRange("Monat ID", '202412', '202501');
                    if DimZeitraum.FindSet() then
                        repeat
                            DimAbteilung.Reset();
                            if DimAbteilung.FindSet() then
                                repeat
                                    bericht.Init();
                                    bericht."Deparment ID" := DimAbteilung.Abteilung;
                                    bericht."Abteilung Name" := DimAbteilung.Abteilungsname;
                                    bericht."Monats ID" := DimZeitraum."Monat ID";
                                    bericht.Insert();
                                until DimAbteilung.Next() = 0;
                        until DimZeitraum.Next() = 0;
                    if bericht.FindSet() then
                        repeat
                            if DimZeitraum.Get(bericht."Monats ID") then begin
                                // the number of employees in the department are counted
                                DimMitarbeiter.Reset();
                                DimMitarbeiter.SetRange(Abteilung, bericht."Deparment ID");
                                AnzahlMitarbeiter := DimMitarbeiter.Count();
                                // the number of mondays in the month are counted that are workdays
                                DimZeitpunkt.Reset();
                                DimZeitpunkt.SetRange("Datum ID", DimZeitraum.Startdatum, DimZeitraum.Enddatum);
                                DimZeitpunkt.SetRange(Wochentag, DimZeitpunkt.Wochentag::Monday);
                                DimZeitpunkt.SetRange(Arbeitstag, true);
                                AnzahlArbeitsmontageImMonat := DimZeitpunkt.Count();
                                bericht.ArbeitstageMontags := AnzahlMitarbeiter * AnzahlArbeitsmontageImMonat;
                                // 
                                KrankheitstageAnMontagen := 0;
                                if DimZeitpunkt.FindSet() then
                                    repeat
                                        Hilfstabelle.Reset();
                                        Hilfstabelle.SetRange("Eintrags ID", 672, 681);
                                        Hilfstabelle.SetRange("Date", DimZeitpunkt."Datum ID");
                                        Hilfstabelle.SetRange("Abwesenheitsgrund", 'KRANK');
                                        Hilfstabelle.SetRange(Abteilung, bericht."Deparment ID");
                                        KrankheitstageAnMontagen := KrankheitstageAnMontagen + Hilfstabelle.Count();
                                    until DimZeitpunkt.Next() = 0;
                                bericht.KrankheitstageMontags := KrankheitstageAnMontagen;
                                bericht.KrankenstandMontags := bericht.KrankheitstageMontags / bericht.ArbeitstageMontags;
                                DimZeitpunkt.Reset();
                                DimZeitpunkt.SetRange("Datum ID", DimZeitraum.Startdatum, DimZeitraum.Enddatum);
                                DimZeitpunkt.SetFilter(Wochentag, '<>%1', DimZeitpunkt.Wochentag::Monday);
                                DimZeitpunkt.SetRange(Arbeitstag, true);
                                bericht.Modify(true);
                            end;
                        until bericht.Next() = 0;
                    CurrPage.Update(true);
                end;
            }
            action(clearBericht)
            {
                Caption = 'Clear Bericht';
                ApplicationArea = All;
                Image = Delete;
                ToolTip = 'Löscht alle Einträge aus der Berichtstabelle.';

                trigger OnAction()
                var
                    bericht: Record Berichtstabelle;
                begin
                    bericht.DeleteAll();
                    CurrPage.Update(true);
                end;
            }
        }
    }
}
