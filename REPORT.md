# 📊 ShopSphere: Analyse eines globalen Marktplatzes

## 🎯 Business-Anforderung

Der CEO wendet sich an das Analytics-Team:

> "Wir wachsen, aber ich verstehe unser Geschäft noch nicht vollständig.  
> Wohin fließen unsere Marketingausgaben und sind sie effektiv?  
> Wer sind unsere wertvollsten Kunden?  
> Welche Kategorien sind tatsächlich profitabel und welche erzeugen nur den Eindruck von Umsatz?  
> Welche Regionen haben das größte Wachstumspotenzial?  
> Hat das Experiment mit dem neuen Checkout funktioniert?"

Das Ziel der Analyse ist es, datenbasierte Antworten auf diese Fragen zu liefern und ein verständliches Analytics-Dashboard für strategische Entscheidungen zu erstellen.

---

# 📌 Projekt

**ShopSphere** ist ein globaler Marktplatz, der Produkte in verschiedenen Kategorien und Regionen verkauft.

Im Rahmen der Analyse wurden folgende Bereiche untersucht:

- Effektivität der Marketingkanäle;
- Kundenverhalten und Customer Value;
- Profitabilität der Produktkategorien;
- regionale Umsatzentwicklung;
- Beitrag der wertvollsten Kunden;
- Ergebnisse des A/B-Tests zum neuen Checkout-Design.

---

# 🗂️ Datenquellen

Verwendete Tabellen:

| Tabelle | Beschreibung |
|---|---|
| `shopsphere_customers` | Kundeninformationen |
| `shopsphere_products` | Produkte, Kategorien und Margen |
| `shopsphere_orders` | Bestellungen und finanzielle Kennzahlen |
| `shopsphere_order_items` | Details zu einzelnen Bestellpositionen |
| `shopsphere_marketing` | Marketingausgaben und Performance der Kanäle |


## 📁 Repository Structure

| Bereich | Beschreibung | Link |
|---|---|---|
| README | Projektbeschreibung, Zielsetzung und Übersicht | [README.md](README.md) |
| SQL | Analyse-Abfragen und Berechnungen | [queries.sql](sql/queries.sql) |
| Data | Rohdaten aus dem ShopSphere-Datensatz (Original-CSV-Tabellen) | [data](data/) |
| Processed Data | Ergebnisse der SQL-Abfragen und vorbereitete Tabellen für Analysen und Visualisierungen | [data1](data/data1/) |
| Report | Business Insights, Analysen und strategische Empfehlungen | [REPORT.md](REPORT.md) |

# Block 1. SQL: Datenaufbereitung (JOIN, Aggregationen, Subqueries)

In diesem Block wurde die Datenaufbereitung und erste Business-Analyse mit SQL durchgeführt.  
Ziel war es, Daten aus verschiedenen Tabellen zusammenzuführen, zentrale Kennzahlen zu berechnen und Analyse-Datensätze für die spätere Visualisierung in Tableau vorzubereiten.

Verwendete SQL-Techniken:

- **JOIN / LEFT JOIN**  
  Verknüpfung der Tabellen:
  - `shopsphere_orders`
  - `shopsphere_customers`
  - `shopsphere_order_items`
  - `shopsphere_products`
  - `shopsphere_marketing`

- **GROUP BY**  
  Aggregation der Daten nach:
  - Regionen
  - Kunden
  - Produktkategorien
  - Marketingkanälen

- **Aggregationsfunktionen**
  - `SUM()` → Berechnung von Umsatz, Budget und Kundenausgaben
  - `COUNT(DISTINCT)` → Anzahl eindeutiger Bestellungen
  - `AVG()` → Durchschnittswerte wie Warenkorb, Marge und Retourenrate

- **ORDER BY / LIMIT**  
  Ermittlung der Top-Kunden nach Umsatz.

- **Subqueries**  
  Identifikation von Kunden mit überdurchschnittlichen Ausgaben.

- **Berechnung von Business-KPIs**
  - Average Order Value
  - Return Rate
  - ROI
  - CTR
  - Conversion Rate
  - Cost per Conversion


Der vollständige SQL-Code mit allen Abfragen:

📂 **SQL — Analyse-Abfragen und Berechnungen:**  
 [queries.sql](sql/queries.sql)


---

## 1.1. Umsatz, Bestellungen und Ø-Warenkorb nach Region und Jahr

Die Tabellen `shopsphere_orders` und `shopsphere_customers` wurden mit einem **LEFT JOIN** verbunden.

Berechnet wurden:

- Gesamtumsatz (`SUM(net_amount)`)
- Anzahl der Bestellungen (`COUNT(DISTINCT order_id)`)
- durchschnittlicher Bestellwert (`AVG(net_amount)`)

Die Aggregation erfolgte nach:

- Region
- Bestelldatum

**Hinweis:**  
Die SQL-Abfrage liefert die Werte auf Datumsebene.  
Die zusätzliche Gruppierung nach Jahren sowie die Analyse der Jahresentwicklung wurden anschließend in Tableau durchgeführt.


---

## 1.2. Top-10 Kunden nach Ausgaben

Zur Identifikation der wertvollsten Kunden wurden die Tabellen:

`shopsphere_customers` + `shopsphere_orders`

verbunden.

Berechnet wurden:

- Gesamtausgaben pro Kunde (`SUM(net_amount)`)
- Anzahl der Bestellungen (`COUNT(DISTINCT order_id)`)
- Region
- Akquisitionskanal (`acquisition_chan`)

Durch:

```sql```

```ORDER BY total_spent DESC ```

LIMIT 10 

## 1.3. Kategorien: Umsatz, Marge und Retouren

Für die Produktanalyse wurden die Tabellen:

- `shopsphere_order_items`
- `shopsphere_products`
- `shopsphere_orders`

über **JOIN** miteinander verbunden.

Berechnet wurden je Produktkategorie:

- Kategorieumsatz (`SUM(line_total)`)
- durchschnittliche Marge (`AVG(margin_pct)`)
- Retourenrate (`AVG(is_returned)`)

Die Ergebnisse ermöglichen einen direkten Vergleich der Produktkategorien hinsichtlich Umsatz, Profitabilität und Retourenquote.

**Hinweis:**  
Die SQL-Abfrage liefert die grundlegenden Kennzahlen je Kategorie. Die weiterführende Analyse der Zusammenhänge zwischen Umsatz, Marge und Retourenquote sowie die Visualisierung wurden anschließend in Tableau durchgeführt.

---

## 1.4. Kunden über Durchschnittsausgaben

Zur Identifikation besonders wertvoller Kunden wurden **Subqueries** verwendet.

Berechnungsschritte:

1. Ermittlung der Gesamtausgaben pro Kunde (`SUM(net_amount)`).
2. Berechnung der durchschnittlichen Kundenausgaben über alle Kunden (`AVG(total_spent)`).
3. Auswahl aller Kunden mit Ausgaben oberhalb dieses Durchschnittswerts.

Ausgegeben wurden:

- Kunden-ID
- Region
- Land
- Akquisitionskanal
- Gesamtausgaben

**Hinweis:**  
Die SQL-Abfrage liefert die Liste aller Kunden mit überdurchschnittlichen Ausgaben. Die Anzahl dieser Kunden sowie ihr Anteil am Gesamtumsatz wurden anschließend in Tableau berechnet.

---

## 1.5. Marketingkanäle: Budget, Umsatz und ROI

Für die Analyse der Marketingkanäle wurde die Tabelle `shopsphere_marketing` verwendet.

Berechnet wurden:

- Gesamtbudget (`SUM(budget)`)
- zugerechneter Umsatz (`SUM(attributed_reven)`)
- ROI (`Umsatz / Budget`)

Zusätzlich wurden weitere Marketing-KPIs berechnet:

- Impressions
- Clicks
- Conversions
- CTR (`Clicks / Impressions`)
- Conversion Rate (`Conversions / Clicks`)
- Cost per Conversion (`Budget / Conversions`)

Die Ergebnisse ermöglichen einen direkten Vergleich der Effizienz verschiedener Marketingkanäle.

**Hinweis:**  
Die SQL-Abfrage stellt die Basiskennzahlen für jeden Marketingkanal bereit. Die weitere Bewertung der Kanäle, das Ranking nach ROI sowie die Ableitung von Business Insights und Empfehlungen erfolgten anschließend in Tableau.
