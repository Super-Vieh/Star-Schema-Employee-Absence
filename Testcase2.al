
page 123456789 Testcase2
{
    ApplicationArea = All;
    Caption = 'Mitarbeiter Abwesenheit Test Case 2';
    PageType = List;
    SourceTable = "Employee Absence";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'The number of the employee.';
                    Caption = 'Mitarbeiter_Nr.';
                }


                field("Absence Type"; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'The entry number of the absence record.';
                    Caption = 'Eintrags_Nr.';
                }

                field("Start Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'The start date of the absence.';
                    Caption = 'Von_Datum';
                }

                field("End Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'The end date of the absence.';
                    Caption = 'Bis_Datum';
                }



                field("Cause of Absence Code"; Rec."Cause of Absence Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reason for the absence.';
                    Caption = 'Abwesenheitsgrund';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Provides a description for the absence.';
                    Caption = 'Beschreibung';
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity of the absence, e.g., number of hours or days.';
                    Caption = 'Menge';
                }

                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unit of measure for the quantity.';
                    Caption = 'Einheitencode';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(FehlerhafteEinträgeidentifizieren)
            {
                ApplicationArea = All;
                Caption = 'Fehlerhafte Einträge finden';
                ToolTip = 'Ausfürung des Test Case 2';


                trigger OnAction()
                begin

                    Message('Test Case 2 ausführen');
                    "finde_fehlerhafte_einträge"();

                end;
            }
            action(BefülledieASFT)
            {
                ApplicationArea = All;
                Caption = 'Befülle ASFT';
                ToolTip = 'Füllt die ASFT Tabelle mit den Daten aus der Employee Absence Tabelle';

                trigger OnAction()
                var
                    ASFT_Fill_Codeunit: Codeunit "Table_Fill";
                begin
                    ASFT_Fill_Codeunit.fillasft();

                end;
            }
            action(BefüllediePSFT)
            {
                ApplicationArea = All;
                Caption = 'Befülle PSFT';
                ToolTip = 'Füllt die PSFT Tabelle mit den Daten aus der Employee Absence Tabelle';

                trigger OnAction()
                var
                    PSFT_Fill_Codeunit: Codeunit "Table_Fill"; // ID und Name deiner Codeunit
                begin
                    PSFT_Fill_Codeunit.fillpsft()

                end;
            }
        }
    }






    local procedure finde_fehlerhafte_einträge()
    var
        EmployeeAbsence_1: Record "Employee Absence";
        EmployeeAbsence_2: Record "Employee Absence";
        enddatum1: Date;
        enddatum2: Date;
        test: Record Date;

    begin
        // Here are two for loops used to compare the Employee Absence records with each other.
        // The first loop iterates through the Employee Absence records and the second loop compares each record with all other records.
        if EmployeeAbsence_1.FindFirst() then begin
            repeat
                if EmployeeAbsence_2.FindFirst() then begin
                    repeat

                        // Hier wird geprüft ob die TO Date einträge Null sind. Wenn ja dann wird das Enddatum auf das From Date gesetzt
                        // Der Grund dafür ist dass, Null als 0D gespecihert wird und 0D als unendlich kleine Zahl gespeichert wird. Das Schaft Probleme bei der Berechnung
                        if EmployeeAbsence_1."To Date" = 0D then begin
                            enddatum1 := EmployeeAbsence_1."From Date";
                        end else begin
                            enddatum1 := EmployeeAbsence_1."To Date";
                        end;

                        if EmployeeAbsence_2."To Date" = 0D then begin
                            enddatum2 := EmployeeAbsence_2."From Date";
                        end else begin
                            enddatum2 := EmployeeAbsence_2."To Date";
                        end;
                        //This is innefficiant but it works
                        //It should be implemented with filters
                        if ((EmployeeAbsence_1."From Date" <= enddatum2) and (enddatum1 >= EmployeeAbsence_2."From Date")) and
                            (EmployeeAbsence_1."Entry No." <> EmployeeAbsence_2."Entry No.") and
                            (EmployeeAbsence_1."Employee No." = EmployeeAbsence_2."Employee No.") and
                            (EmployeeAbsence_1."Cause of Absence Code" <> 'TAGFREI') and
                            (EmployeeAbsence_2."Cause of Absence Code" <> 'TAGFREI') then begin

                            Message('Fehlerhafter Eintrag gefunden: Bei Mitarbeiter Nr.: %1\Konflikt zwischen Eintrag %2 (vom %3 bis %4) und Eintrag %5 (vom %6 bis %7)',
                                    EmployeeAbsence_1."Employee No.",
                                    EmployeeAbsence_1."Entry No.",
                                    EmployeeAbsence_1."From Date",
                                    enddatum1,
                                    EmployeeAbsence_2."Entry No.",
                                    EmployeeAbsence_2."From Date",
                                    enddatum2);
                        end;
                    until EmployeeAbsence_2.Next() = 0;
                end;

            until EmployeeAbsence_1.Next() = 0;
        end;
    end;
}
// IF one had to implement the same functionality in a different way,
// Loop all records in the Employee Absence1 table 
// Filter out all records that have the same emplyee number and habe the cause of absence code 'TAGFREI'
// and filter out all 
