table 123456781 Dim_Zeitpunkt
{
    Caption = 'Dimension_Zeitpunkt';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Datum ID"; Date)
        {
            Caption = 'Datum ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Tag"; Integer)
        {
            Caption = 'Tag';
            DataClassification = ToBeClassified;
        }
        field(3; "Monat"; Integer)
        {
            Caption = 'Monat';
        }
        field(4; "Jahr"; Integer)
        {
            Caption = 'Jahr';
        }
        field(5; "Quartal"; Code[10])
        {
            Caption = 'Quartal';
        }
        field(6; "Wochentag"; Option)
        {
            OptionCaption = 'Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday;
        }
        field(7; "Arbeitstag"; Boolean)
        {
            Caption = 'Arbeitstag';
        }
    }
    keys
    {
        key(PK; "Datum ID")
        {
            Clustered = true;
        }
    }
}
