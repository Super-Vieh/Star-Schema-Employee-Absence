codeunit 123456781 Table_Fill
{
    procedure fillasft()
    var
        ASFT: Record ASFT;
        EmpAbs: Record "Employee Absence";
    begin
        // The time period for which the data is filled is set to 2024-01-01 to 2025-12-31
        // The Reason ist the Tasks specification
        EmpAbs.SetRange("From Date", 20240101D, 20251231D);
        if EmpAbs.FindSet() then begin
            repeat begin
                // If the entry does not exist in the ASFT table, it is created
                if not ASFT.Get(EmpAbs."Entry No.") then begin
                    ASFT.Init();
                    ASFT."Eintrags ID" := EmpAbs."Entry No.";
                    ASFT."Employee No." := EmpAbs."Employee No.";
                    ASFT."From Date" := EmpAbs."From Date";
                    ASFT."To Date" := EmpAbs."To Date";
                    ASFT."Global Dimension 1 Code" := getAbteilung(EmpAbs."Employee No.");
                    ASFT."Absence Reason Code" := EmpAbs."Cause of Absence Code";
                    ASFT.Duration := EmpAbs."Quantity (Base)";
                    ASFT."Number of Mondays" := numOfMon(EmpAbs);
                    ASFT.Insert();
                end;
            end until EmpAbs.Next() = 0;
        end;
    end;

    local procedure getAbteilung(mid: Code[20]): Code[20]
    // This function retrieves the department from the depart using the employee
    var
        DimMitarbeiter: Record Dim_Mitarbeiter;
    begin
        DimMitarbeiter.SetRange("Mitarbeiter ID", mid);
        // the filter statement is unnessary
        if DimMitarbeiter.Get(mid) then begin
            exit(DimMitarbeiter.Abteilung);
        end;
    end;

    procedure numOfMon(employeeabsence: Record "Employee Absence"): Integer
    var
        DimZeitpunkt: Record "Dim_Zeitpunkt";
        num: Integer;
    begin
        if employeeabsence."To Date" = 0D then begin
            // If the to date is emtpy the it means that the employee abscense is only one day
            DimZeitpunkt.SetRange("Datum ID", employeeabsence."From Date");
        end
        else begin
            DimZeitpunkt.SetRange("Datum ID", employeeabsence."From Date", employeeabsence."To Date");
        end;
        DimZeitpunkt.SetRange("Wochentag", DimZeitpunkt.Wochentag::Monday);
        DimZeitpunkt.SetRange("Arbeitstag", true);
        if DimZeitpunkt.FindSet() then begin
            exit(DimZeitpunkt.Count);
        end;
    end;

    procedure fillpsft()
    var
        PSFT: Record PSFT;
        Zeitraum: Record "Dim_Zeitraum";
        Abteilung: Record "Dim_Abteilung";
    begin
        PSFT.Reset();
        Zeitraum.Reset();
        Abteilung.Reset();
        // everything is reset to ensure that the table is filled correctly
        if Abteilung.FindSet() then begin
            repeat
                Zeitraum.SetRange("Monat ID", '202401', '202512');
                if Zeitraum.FindSet() then begin
                    repeat
                        PSFT.Init();
                        PSFT."Monat ID" := Zeitraum."Monat ID";
                        PSFT."Abteilung" := Abteilung."Abteilung";
                        PSFT."Anzahl Abwesenheiten" := AnzahlAbwesenheiten(Abteilung.Abteilung, Zeitraum.Startdatum, Zeitraum.Enddatum, 1);
                        PSFT."Anzahl Krank" := AnzahlAbwesenheiten(Abteilung.Abteilung, Zeitraum.Startdatum, Zeitraum.Enddatum, 2);
                        PSFT."Anzahl Urlaub" := AnzahlAbwesenheiten(Abteilung.Abteilung, Zeitraum.Startdatum, Zeitraum.Enddatum, 3);
                        PSFT."Gesammttage abwesend" := Gesammttagekrank(Abteilung.Abteilung, Zeitraum.Startdatum, Zeitraum.Enddatum);
                        PSFT."Mögliche Arbeitstage" := countArbeitstage(Abteilung.Abteilung, Zeitraum.Startdatum, Zeitraum.Enddatum);
                        if not PSFT.Get(PSFT."Monat ID", PSFT.Abteilung) then begin
                            PSFT.Insert(true);
                        end;
                    until Zeitraum.Next() = 0;
                end;
            until Abteilung.Next() = 0;
        end;
    end;

    procedure AnzahlAbwesenheiten(Abteilung: Code[20]; Start: Date; Ende: Date; Abwesenheitsgrund: Integer): Integer
    // This function counts the number of absences. it has three different reasons for absence
    // 1 = All Abscences, 2 = Krank, 3 = Urlaub
    // and dending on the needed reason it filters the Employee Absence table 
    var
        EmpAbs: Record "Employee Absence";
        mitarbeiter: Record "Dim_Mitarbeiter";
        Anzahl: Integer;
    begin
        Anzahl := 0;
        mitarbeiter.Reset();
        mitarbeiter.SetRange("Abteilung", Abteilung);
        if mitarbeiter.FindSet() then
            repeat
                EmpAbs.Reset();
                EmpAbs.SetFilter("From Date", '>=%1&<=%2', Start, Ende);
                EmpAbs.SetRange("Employee no.", mitarbeiter."Mitarbeiter ID");
                if EmpAbs.FindSet() then
                    case Abwesenheitsgrund of
                        1:
                            begin
                            end;
                        2:
                            begin
                                EmpAbs.SetRange("Cause of Absence Code", 'KRANK');
                            end;
                        3:
                            begin
                                EmpAbs.SetRange("Cause of Absence Code", 'URLAUB');
                            end;
                    end;
                Anzahl := Anzahl + EmpAbs.Count();
            until mitarbeiter.Next() = 0;
        exit(Anzahl);
    end;

    procedure Gesammttagekrank(AbtInput: Code[20]; Start: Date; Ende: Date): Integer
    // This function counts the total number of days of employee sickness in a given period and department 
    var
        Hilfstabelle: Record "Hilfstabelle";
        Anzahl: Integer;
    begin
        Anzahl := 0;
        Hilfstabelle.SetFilter("Date", '>=%1&<=%2', Start, Ende);
        Hilfstabelle.SetRange(Abteilung, AbtInput);
        Hilfstabelle.SetRange(Abwesenheitsgrund, 'KRANK');
        if Hilfstabelle.FindSet() then begin
            Anzahl := Anzahl + Hilfstabelle.Count();
        end;
        exit(Anzahl);
    end;

    procedure countArbeitstage(AbtInput: Code[20]; Start: Date; Ende: Date): Integer;
    var
        DimZeitpunkt: Record Dim_Zeitpunkt;
        DimMitarbeiter: Record Dim_Mitarbeiter;
    begin
        DimMitarbeiter.SetRange(Abteilung, AbtInput);
        DimZeitpunkt.SetRange("Datum ID", Start, Ende);
        DimZeitpunkt.SetRange(Arbeitstag, true);
        exit(DimZeitpunkt.Count() * DimMitarbeiter.Count());
    end;
}
