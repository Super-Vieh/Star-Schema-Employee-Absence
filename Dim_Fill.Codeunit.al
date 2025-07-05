codeunit 123456780 Dim_Fill
{
    procedure fillDimZeitraum()
    var
        DimZeitraum: Record "Dim_Zeitraum";
        Date_quartal: Record "Date";
        Date: Record Date;
    begin

        Date.Reset();
        Date.SetRange("Period Type", Date."Period Type"::Month);
        Date.SetRange("Period Start", 20200101D, 20261231D);
        //Hardcoded Range for Date From 01.01.2020 to 31.12.2026
        //Because there are they are the relevant dates
        if Date.FindFirst() then begin
            // Find the first date it means that the Date is allready presend and one has to
            // update it, to avoid duplicates
            // If that date does not exist, then it will be created
            repeat
                if DimZeitraum.Get(extrahiereMonatID(Date)) then begin
                    DimZeitraum."Monat ID" := extrahiereMonatID(Date);
                    DimZeitraum."Monat" := Date2DMY(Date."Period Start", 2);
                    DimZeitraum."Quartal" := extrahiereQuartal(Date."Period Start");
                    DimZeitraum."Jahr" := Date2DMY(Date."Period Start", 3);
                    DimZeitraum."Startdatum" := Date."Period Start";
                    DimZeitraum."Enddatum" := Date."Period End";
                    if (DimZeitraum."Monat ID" <> '') and (DimZeitraum."Monat" <> 0) and (DimZeitraum."Jahr" <> 0) and (DimZeitraum."Startdatum" <> 0D) and (DimZeitraum."Enddatum" <> 0D) then DimZeitraum.Modify(true);
                end
                else begin
                    DimZeitraum.Init();
                    DimZeitraum."Monat ID" := extrahiereMonatID(Date);
                    DimZeitraum."Monat" := Date2DMY(Date."Period Start", 2);
                    DimZeitraum."Quartal" := extrahiereQuartal(Date."Period Start");
                    DimZeitraum."Jahr" := Date2DMY(Date."Period Start", 3);
                    DimZeitraum."Startdatum" := Date."Period Start";
                    DimZeitraum."Enddatum" := Date."Period End";
                    if (DimZeitraum."Monat ID" <> '') and (DimZeitraum."Monat" <> 0) and (DimZeitraum."Jahr" <> 0) and (DimZeitraum."Startdatum" <> 0D) and (DimZeitraum."Enddatum" <> 0D) then DimZeitraum.Insert(true);
                end;
            until Date.Next() = 0;
        end;
    end;

    procedure fillDimZeitpunkt()
    // this function does not updates duplicates it ignores them 
    var
        DimZeitpunkt: Record "Dim_Zeitpunkt";
        Date: Record "Date";
        Kalender: Record "Base Calendar Change";
    begin
        Date.Reset();
        Date.SetRange("Period Type", Date."Period Type"::Date);
        Date.SetRange("Period Start", 20200101D, 20261231D);
        Kalender.SetRange("Base Calendar Code", 'DE');
        // the kombination of findfirst and next is possible but inneficient
        // Creates all the normaldates
        if Date.FindFirst() then begin
            repeat
                if not DimZeitpunkt.Get(Date."Period Start") then begin
                    DimZeitpunkt.Init();
                    DimZeitpunkt."Datum ID" := Date."Period Start";
                    DimZeitpunkt."Tag" := Date2DMY(Date."period Start", 1);
                    DimZeitpunkt."Monat" := Date2DMY(Date."period Start", 2);
                    DimZeitpunkt."Jahr" := Date2DMY(Date."period Start", 3);
                    DimZeitpunkt."Quartal" := extrahiereQuartal(Date."period Start");
                    DimZeitpunkt."Wochentag" := extrahieretag(Date);
                    DimZeitpunkt."Arbeitstag" := extrahiereArbeitstag(Date);
                    DimZeitpunkt.Insert(true);
                end;
            until Date.Next() = 0;
        end;
        // Updates the normaldates to incorporate the exeptions
        // Same issue with the findfirst and next
        if Kalender.FindFirst() then begin
            repeat
                if DimZeitpunkt.Get(Kalender."Date") then begin
                    DimZeitpunkt."Arbeitstag" := false;
                    DimZeitpunkt.Modify(true);
                end;
            until Kalender.Next() = 0;
        end;
    end;

    procedure fillDimAbteilung()
    var
        DimAbteilung: Record "Dim_Abteilung";
        Abt: Record "Dimension Value";
    begin
        if Abt.FindSet() then
            repeat begin
                Abt.SetRange("Dimension Code", 'ABTEILUNG');
                DimAbteilung.Abteilung := Abt.Code;
                if not DimAbteilung.Get(DimAbteilung.Abteilung) then begin
                    DimAbteilung.Init();
                    DimAbteilung.Abteilung := Abt.Code;
                    DimAbteilung.Abteilungsname := Abt.Name;
                    DimAbteilung.Insert(true);
                end;
            end until Abt.Next() = 0;
    end;

    procedure fillDimMitarbeiter()
    var
        DimMitarbeiter: Record "Dim_Mitarbeiter";
        Emp: Record Employee;
    begin
        if Emp.FindSet() then
            repeat begin
                DimMitarbeiter."Mitarbeiter ID" := Emp."No.";
                if not DimMitarbeiter.Get(DimMitarbeiter."Mitarbeiter ID") then begin
                    DimMitarbeiter.Init();
                    DimMitarbeiter."Mitarbeiter ID" := Emp."No.";
                    DimMitarbeiter.Abteilung := Emp."Global Dimension 1 Code";
                    DimMitarbeiter.JobTitel := Emp."Job Title";
                    DimMitarbeiter.Insert();
                end;
            end;
            until Emp.Next() = 0;
    end;

    local procedure extrahieretag(Datum: Record "Date"): Option
    var
        Wochentag: Option Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
    begin
        case Datum."Period No." of
            1:
                Wochentag := Wochentag::Monday;
            2:
                Wochentag := Wochentag::Tuesday;
            3:
                Wochentag := Wochentag::Wednesday;
            4:
                Wochentag := Wochentag::Thursday;
            5:
                Wochentag := Wochentag::Friday;
            6:
                Wochentag := Wochentag::Saturday;
            7:
                Wochentag := Wochentag::Sunday;
        end;
        exit(Wochentag);
    end;

    local procedure extrahiereArbeitstag(Datum: Record "Date"): Boolean
    begin
        // This function pelimenary sorts days into workdays and non-workdays
        case Datum."Period No." of
            1, 2, 3, 4, 5:
                exit(true); // Montag bis Freitag sind Arbeitstage
            6, 7:
                exit(false); // Samstag und Sonntag sind keine Arbeitstage
        end;
    end;

    local procedure extrahiereMonatID(var Date: Record Date): Code[20]
    var
        // This function extracts the month ID from the Date record
        Jahr: Integer;
        Monat: Integer;
    begin
        if Date."Period Type" <> Date."Period Type"::Month then exit(Format(0));
        Jahr := Date2DMY(Date."Period Start", 3);
        Monat := Date2DMY(Date."Period Start", 2);
        exit(Format(Jahr * 100 + Monat));
    end;

    local procedure extrahiereQuartal(Date: Date): Code[10]
    var
        Jahr: Integer;
        Monat: Integer;
    begin
        // This function extracts the quarter from the Date record 
        // by mathing the months to their respective quarters
        Jahr := Date2DMY(Date, 3);
        Monat := Date2DMY(Date, 2);
        case Monat of
            1, 2, 3:
                exit('Q1 ' + Format(Jahr));
            4, 5, 6:
                exit('Q2 ' + Format(Jahr));
            7, 8, 9:
                exit('Q3 ' + Format(Jahr));
            10, 11, 12:
                exit('Q4 ' + Format(Jahr));
            else
                exit('');
        end;
    end;

    procedure FillHilfstabelle()
    // this function fill a helping table with the employee absence data
    // It transforms the employee absence data from a timespan format to a daily format
    var
        Hilfstabelle: Record Hilfstabelle;
        Date: Record Date;
        Employeeabsence: Record "Employee Absence";
        i: Integer;
        Employee: Record Employee;
        Ende: Date;
    begin
        Hilfstabelle.Reset();
        Employeeabsence.Reset();
        if Employeeabsence.FindSet() then begin
            repeat
                Date.Reset();
                i := 0;
                if Employeeabsence."To Date" = 0D then
                    Ende := Employeeabsence."From Date"
                else
                    Ende := Employeeabsence."To Date";
                Date.SetRange("Period Start", Employeeabsence."From Date", Ende);
                if Date.FindSet() then begin
                    repeat
                        i := i + 1;
                        // this is a artifakt from the debugging phase
                        // it is not needed anymore
                        Hilfstabelle.Init();
                        Hilfstabelle."Employee no." := Employeeabsence."Employee No.";
                        Hilfstabelle."Eintrags ID" := Employeeabsence."Entry No.";
                        Hilfstabelle."Tag ID" := i;
                        Hilfstabelle."Date" := Date."Period Start";
                        Hilfstabelle."Abwesenheitsgrund" := Employeeabsence."Cause of Absence Code";
                        Hilfstabelle."Dauer" := Employeeabsence."Quantity (Base)";
                        Employee.SetRange("No.", Hilfstabelle."Employee no.");
                        if Employee.FindSet() then begin
                            Hilfstabelle.Abteilung := Employee."Global Dimension 1 Code";
                        end;
                        if not Hilfstabelle.Get(Hilfstabelle."Eintrags ID", Hilfstabelle."Date") then begin
                            Hilfstabelle.Insert(true);
                        end;
                    until Date.Next() = 0;
                end;
            until Employeeabsence.Next() = 0;
        end;
    end;

    procedure clearDims()
    // this function clears all the dimension tables
    // It is used to reset the dimensions before filling them with new data
    var
        DimZeitraum: Record Dim_Zeitraum;
        DimZeitpunkt: Record Dim_Zeitpunkt;
        DimAbteilung: Record Dim_Abteilung;
        DimMitarbeiter: Record Dim_Mitarbeiter;
    begin
        DimZeitraum.DeleteAll();
        DimZeitpunkt.DeleteAll();
        DimAbteilung.DeleteAll();
        DimMitarbeiter.DeleteAll();
    end;

    procedure resetDims()
    // this function deletes all the dimension tables  using the clearDims function
    // and then fills them with the proper fillDimension functions
    begin
        clearDims();
        fillDimAbteilung();
        fillDimMitarbeiter();
        fillDimZeitpunkt();
        fillDimZeitraum();
    end;

    procedure fillDims()
    // this function just fill all the dimension tables 
    //it should only be used after the clearDims function
    begin
        fillDimAbteilung();
        fillDimMitarbeiter();
        fillDimZeitpunkt();
        fillDimZeitraum();
    end;
}
