# Inhaltsverzeichnis

- Diagramme
  - Volles Diagramm
  - ASFT
  - PSFT
  - TFT
  - Bericht
- Tabellen Definition
  - ASFT
  - PSFT
  - Berichtstabelle
  - Hilfstabelle
  - Abteilungsdimension
  - Mitarbeiterdimension
  - Zeitpunktdimension
  - Zeitraumdimension
- Links zu den Rohdatentabellen
  - Employee
  - Dimension Value
  - Employee Absence
  - Cause of Absence
  - Date
  - Base Calendar Change


# Diagramme

| Diagramm | Beschreibung |
| :--- | :--- |
| **Volles Diagramm** | Diagramm 1. Ist das Diagramm welches einem die Übersicht geben sollte und die für die Dimensionstabellen notwendige Rohdatentabellen zeifen|
| **ASFT** | Diagramm 2. Ist das Diagramm zur Erstellung der ASFT und Zeigt die Notwendigen Tabellen (Roh- und Dimensionstabellen) die zur Erstellung dieser gebraucht werden|
| **PSFT** | Diagramm 3. Ist das Diagramm zur Erstellung der PSFT und Zeigt die Notwendigen Tabellen (Roh-, Hilfs- und Dimensionstabellen) die zur Erstellung dieser gebraucht werden|
| **TFT**  | Diagramm 4. Ist das Diagramm zur Erstellung der TFT und Zeigt die Notwendigen Tabellen (Roh- und Dimensionstabellen  die zur Erstellung dieser gebraucht werden Dieses Diagramm wird jedoch im Code __Nicht__ implementiert |
| **Jahresbericht** | Diagramm 5. Ist das Diagramm welches den Bericht hat. Er zeigt das Endergebniss der Analyse und die Notwendigen Tabellen(Roh-, Hilfs-, Fakten- und Dimensionstabellen) die zur Erstellung dieser gebraucht werden|

### **Volles Diagramm**


![Übersicht : Visualisierung der Datenflüsse](./Modelle/Ba%20Visualisierung%20der%20Datenflüsse.drawio.svg)

### **ASFT**


![Befüllung der ASFT](./Modelle/Ba%20befüllung%20der%20ASFT.drawio.svg)

### **PSFT**

![Befüllung der PSFT](./Modelle/Ba%20befüllung%20der%20PSFT.drawio.svg)

### **TFT**

![Befüllung der TFT](./Modelle/Ba%20befüllung%20der%20TFT.drawio.svg)

### **Berichtstabelle**

![Befüllung des Berichts](./Modelle/Ba%20erstellung%20des%20Jahresberichts.drawio.svg)


# Tabellendefinition

### Tabelle: ASFT

`ASFT_Tabelle_Abwesenheit`

| Feldname | Datentyp |
| :--- | :--- |
| **Eintrags ID** | Integer |
| Employee No. | Code[20] |
| From Date | Date |
| To Date | Date |
| Global Dimension 1 Code | Code[20] |
| Absence Reason Code | Code[10] |
| Duration | Decimal |
| Number of Mondays | Integer |


### Tabelle: PSFT

`PSFT_Tabelle_Abwesenheiten`

| Feldname | Datentyp |
| :--- | :--- |
| **Monat ID** | Code[10] |
| **Abteilung** | Code[20] |
| Anzahl Abwesenheiten | Integer |
| Anzahl Urlaub | Integer |
| Anzahl Krank | Integer |
| Gesammttage abwesend | Decimal |
| Mögliche Arbeitstage | Decimal |



### Tabelle: Berichtstabelle

`Berrichtstabelle`



| Feldname | Datentyp |
| :--- | :--- |
| **Deparment ID** | Code[20] |
| Abteilung Name | Text[100] |
| **Monats ID** | Code[20] |
| ArbeitstageMontags | Decimal |
| KrankheitstageMontags | Decimal |
| KrankenstandMontags | Decimal |

### Tabelle: Hilfstabelle

 `Hilfstabelle`

| Feldname | Datentyp |
| :--- | :--- |
| Employee no. | Code[20] |
| **Eintrags ID** | Integer |
| Tag ID | Integer |
| **Date** | Date |
| Abwesenheitsgrund | Code[10] |
| Dauer | Decimal |
| Abteilung | Code[20] |


### Tabelle: Dim_Abteilung

`Dimension_Abteilung`


| Feldname | Datentyp |
| :--- | :--- |
| **Abteilung** | Code[20] |
| Abteilungsname | Text[100] |
| Standort | Text[100] |

### Tabelle: Dim_Mitarbeiter

`Dimension_Mitarbeiter`

| Feldname | Datentyp |
| :--- | :--- |
| **Mitarbeiter ID** | Code[20] |
| Abteilung | Code[20] |
| JobTitel | Text[100] |

### Tabelle: Dim_Zeitpunkt

 `Dimension_Zeitpunkt`

| Feldname | Datentyp |
| :--- | :--- |
| **Datum ID** | Date |
| Tag | Integer |
| Monat | Integer |
| Jahr | Integer |
| Quartal | Code[10] |
| Wochentag | Option |
| Arbeitstag | Boolean |

### Tabelle: Dim_Zeitraum

`Dimension_Zeitraumt`

| Feldname | Datentyp |
| :--- | :--- |
| **Monat ID** | Code[20] |
| Monat | Integer |
| Quartal | Code[10] |
| Jahr | Integer |
| Startdatum | Date |
| Enddatum | Date |

# Links zu den Rohdatentabellen

- [Employee](https://learn.microsoft.com/en-us/dynamics365/business-central/application/base-application/table/microsoft.humanresources.employee.employee)
- [Dimension Value](https://learn.microsoft.com/en-us/dynamics365/business-central/application/base-application/table/microsoft.finance.dimension.dimension-value)
- [Employee Absence](https://learn.microsoft.com/en-us/dynamics365/business-central/application/base-application/table/microsoft.humanresources.absence.employee-absence)
- [Cause of Absence](https://learn.microsoft.com/en-us/dynamics365/business-central/application/base-application/table/microsoft.humanresources.absence.cause-of-absence)
- [Date](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-date-virtual-table)
- [Base Calendar Change](https://learn.microsoft.com/en-us/dynamics365/business-central/application/base-application/table/microsoft.foundation.calendar.base-calendar-change)
