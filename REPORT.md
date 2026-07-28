<details>
<summary>📊 <b>ShopSphere: Analyse eines globalen Marktplatzes</b></summary>

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
| Tableau Dashboard | Interaktives Executive Dashboard mit KPI, Visualisierungen und Filtern | [Open Dashboard](https://public.tableau.com/views/ShopSphereBusinessPerformanceAnalysis/Dashboard1) |
| Presentation | Interaktive HTML-Präsentation mit Tableau-Visualisierungen, Analyseergebnissen und strategischen Empfehlungen | [Open Presentation](ShopSphere_Executive_Pr%C3%A4sentation.html) |
| Report | Business Insights, Analysen und strategische Empfehlungen | [REPORT.md](REPORT.md) |

</details>

<details>
<summary>🗄️ <b>Block 1. SQL: Datenaufbereitung (JOIN, Aggregationen, Subqueries)</b></summary>

# 🗄️ Block 1. SQL: Datenaufbereitung (JOIN, Aggregationen, Subqueries)

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

```ORDER BY total_spent DESC``` 
```LIMIT 10```

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

</details>


<details>
<summary>📊 <b>Block 2. Visualisierungen in Tableau</b></summary> 
  
# Block 2. Visualisierungen in Tableau
## 2.1. Saisonalität

Zur Analyse der Saisonalität wurde ein **Liniendiagramm des Gesamtumsatzes nach Monaten** für den Zeitraum **2022–2024** erstellt.

Die Visualisierung zeigt die Umsatzentwicklung im Jahresverlauf und ermöglicht die Identifikation saisonaler Schwankungen.

### Erkenntnisse

Die Analyse des Liniendiagramms zeigt eine **deutliche Saisonalität**. Ab **Oktober** steigen die Umsätze kontinuierlich an, wobei der **höchste Umsatz im Dezember** erreicht wird. Dieses Muster lässt sich wahrscheinlich durch die erhöhte Kaufaktivität während der Feiertage sowie durch saisonale Marketingkampagnen erklären.

### Business Insight

Das Unternehmen sollte Lagerbestände, Marketingbudget und logistische Ressourcen frühzeitig auf die Hochsaison ausrichten. Die Analyse zeigt, dass das **4. Quartal die umsatzstärkste und profitabelste Periode für ShopSphere** ist und daher besonderes Potenzial für Umsatzwachstum bietet.

> 📊 **Visualisierung:** *Monatlicher Gesamtumsatz (2022–2024)*  
[![Monatlicher Gesamtumsatz](https://github.com/user-attachments/assets/13eef798-f285-4d92-b2a9-46946a356f71)](https://public.tableau.com/views/ShopSphereBusinessPerformanceAnalysis/UmsatztrendSaisonalitt?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)


## 2.2. Marketing: Budget vs. ROI

Zur Bewertung der Marketingeffizienz wurde eine Visualisierung erstellt, die **Marketingbudget und Return on Investment (ROI)** der einzelnen Marketingkanäle miteinander vergleicht.

Die Darstellung ermöglicht es, die Beziehung zwischen Investitionshöhe und Marketingeffizienz zu analysieren und zu bewerten, ob das Budget sinnvoll verteilt ist.

### Erkenntnisse

Die Analyse zeigt, dass die größten Marketingbudgets in **Paid Search** (450,96 Tsd. USD) und **Social Ads** (286,49 Tsd. USD) investiert wurden. Diese Kanäle generieren zwar den höchsten zugeschriebenen Umsatz (598,70 Tsd. USD bzw. 589,54 Tsd. USD), erzielen jedoch einen deutlich geringeren ROI als einige Kanäle mit wesentlich kleineren Budgets.

Die höchsten ROI-Werte wurden erreicht von:

- **Organic** – ROI **8,02**
- **Email** – ROI **6,50**
- **Influencer** – ROI **4,62**

### Business Insight

Die Ergebnisse zeigen Optimierungspotenzial bei der Budgetverteilung. Eine stärkere Investition in besonders rentable Kanäle wie **Organic**, **Email** und **Influencer** kann die Marketingeffizienz erhöhen. Gleichzeitig bleiben **Paid Search** und **Social Ads** wichtige Kanäle, um ein hohes Verkaufsvolumen und eine breite Reichweite sicherzustellen.

> 📊 **Visualisierung:** *Marketingbudget vs. ROI nach Marketingkanal*  

[<img width="221" height="253" alt="Marketingkanäle: Budget, Umsatz und ROI" src="https://github.com/user-attachments/assets/ec5642f8-2468-4ceb-bd29-c37d57c00671">](https://public.tableau.com/views/ShopSphereBusinessPerformanceAnalysis/MarketingkanleBudgetUmsatzundROI?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)


## 2.3. Produktkategorien: Umsatz vs. Profitabilität

Zur Bewertung der Wirtschaftlichkeit der Produktkategorien wurde ein **Scatter-/Bubble-Chart** erstellt. Dabei stellt die **X-Achse den Umsatz**, die **Y-Achse die durchschnittliche Marge** dar, während die **Größe der Blasen die Retourenquote** repräsentiert.

Die Visualisierung ermöglicht die Identifikation besonders profitabler Kategorien sowie von Kategorien mit Optimierungspotenzial.

### Erkenntnisse

#### Hidden Champions

**Beauty**
- Höchste Marge (**55 %**) bei gleichzeitig niedriger Retourenquote (**10,4 %**).
- Bietet großes Potenzial für Skalierung und zusätzliche Marketinginvestitionen.

**Sports**
- Gute Balance zwischen Umsatz (**343 Tsd. €**), Marge (**30 %**) und niedriger Retourenquote (**8,6 %**).
- Zeigt weiteres Wachstumspotenzial.

**Home & Kitchen**
- Sehr gute Kombination aus hohem Umsatz und Profitabilität.
- **35 % Marge** bei einer niedrigen Retourenquote (**10,3 %**).
- Kann sich zu einem der wichtigsten Wachstumstreiber entwickeln.

#### Kategorien mit Optimierungspotenzial

**Electronics**
- Höchster Umsatz aller Kategorien.
- Gleichzeitig die niedrigste Marge (**12 %**) und eine hohe Retourenquote (**15,6 %**).
- Optimierung der Preisstrategie, Einkaufskonditionen und Produktqualität empfehlenswert.

**Clothing**
- Hohe Marge (**45 %**), jedoch die höchste Retourenquote (**16,1 %**).
- Mögliche Ursachen sind Größenprobleme, ungenaue Produktbeschreibungen oder abweichende Kundenerwartungen.

### Business Insight

Die Kategorien **Beauty**, **Sports** und **Home & Kitchen** können als **„Hidden Champions“** bezeichnet werden. Sie kombinieren überdurchschnittliche Margen mit vergleichsweise niedrigen Retourenquoten und bieten das größte Potenzial für profitables Wachstum. **Electronics** erzielt zwar den höchsten Umsatz, weist aufgrund der geringen Marge und hohen Retouren jedoch die niedrigste Profitabilität auf und sollte daher gezielt optimiert werden.

> 📊 **Visualisierung:** *Umsatz vs. Marge mit Retourenquote nach Produktkategorie*
[<img width="681" height="377" alt="Umsatz vs. Marge mit Retourenquote nach Produktkategorie" src="https://github.com/user-attachments/assets/5c79e00c-b9ec-4b85-b7c8-8a114d6b408e">](https://public.tableau.com/views/ShopSphereBusinessPerformanceAnalysis/KategorienUmsatzMargeundRetouren?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
<img width="218" height="347" alt="image" src="https://github.com/user-attachments/assets/8f06ce84-5b4b-4f6c-950b-0b7463e39ea8" />


## 2.4. Umsatzentwicklung nach Regionen

Zur Analyse der regionalen Entwicklung wurde ein **Multi-Line-Chart** erstellt, das den **Gesamtumsatz nach Regionen** im Zeitraum **2022–2024** darstellt.

Die Visualisierung zeigt die Umsatzentwicklung der einzelnen Regionen und ermöglicht den Vergleich von Wachstumstrends sowie die Identifikation besonders dynamischer oder stagnierender Märkte.

### Erkenntnisse

**Southeast Asia**
- Zeigt das stärkste Wachstum aller Regionen.
- Der Umsatz stieg von **12,7 Tsd. € (2022)** auf **613,9 Tsd. € (2024)**.
- Der hohe durchschnittliche Bestellwert (**303 €**) und das starke Umsatzwachstum weisen auf ein erhebliches Entwicklungspotenzial hin.

**North America**
- Umsatzstärkste Region im Jahr **2024** mit **718,7 Tsd. €**.
- Deutliches Wachstum gegenüber **80,2 Tsd. €** im Jahr 2022.
- Bleibt einer der wichtigsten Wachstumstreiber des Unternehmens.

**Europe**
- Stetige und stabile Umsatzentwicklung.
- Umsatzanstieg von **100,8 Tsd. € (2022)** auf **545,6 Tsd. € (2024)**.
- Bildet eine verlässliche Grundlage für das Geschäft.

**Latin America**
- Starkes Wachstum von **12,1 Tsd. € (2022)** auf **321,4 Tsd. € (2024)**.
- Bietet gutes Skalierungspotenzial, liegt jedoch weiterhin hinter den umsatzstärksten Regionen.

**Middle East**
- Positive Entwicklung mit **281,1 Tsd. € Umsatz** im Jahr 2024.
- Bleibt jedoch die kleinste Region und verfügt über weiteres Wachstumspotenzial.

### Business Insight

**North America** ist der wichtigste Umsatzmarkt des Unternehmens, während **Southeast Asia** die höchste Wachstumsdynamik und das größte Entwicklungspotenzial aufweist. **Europe** sorgt für stabile Umsätze, **Latin America** entwickelt sich kontinuierlich weiter und **Middle East** könnte durch gezielte Marketing- und Vertriebsmaßnahmen zusätzliches Wachstum erzielen.

> 📊 **Visualisierung:** *Umsatzentwicklung nach Regionen (2022–2024)*

[<img width="230" height="348" alt="Umsatzentwicklung nach Regionen (2022–2024)" src="https://github.com/user-attachments/assets/ea957076-0699-470a-8718-80eba09dc80c">](https://public.tableau.com/views/ShopSphereBusinessPerformanceAnalysis/UmsatzentwicklungnachRegionen?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)


## 2.5. Kundenbeitrag (Pareto-Analyse)

Zur Analyse der Umsatzverteilung wurde eine **Pareto-Visualisierung** erstellt. Sie zeigt, welchen Anteil des Gesamtumsatzes die wertvollsten Kunden im Vergleich zur übrigen Kundengruppe generieren.

Die Visualisierung verdeutlicht die Konzentration des Umsatzes und unterstützt die Identifikation besonders wertvoller Kundensegmente.

### Erkenntnisse

- Die **Top 5 % der Kunden** generieren **1,218 Mio. € Umsatz**, was **35,07 % des Gesamtumsatzes** entspricht.
- Die verbleibenden **95 % der Kunden** erwirtschaften **64,93 % des Gesamtumsatzes**.

Die Ergebnisse zeigen eine deutliche Umsatzkonzentration auf eine vergleichsweise kleine Gruppe besonders wertvoller Kunden.

### Business Insight

Die **Top 5 % der Kunden** stellen das wichtigste Kundensegment dar und sollten durch personalisierte Angebote, exklusive Loyalty-Programme und gezielte Maßnahmen zur Kundenbindung langfristig gehalten werden.

Gleichzeitig bietet das breite Kundensegment der übrigen **95 %** erhebliches Entwicklungspotenzial. Durch gezielte Marketingmaßnahmen, Cross-Selling und Up-Selling können mehr Kunden zu hochwertigen Stamm- und VIP-Kunden entwickelt werden.

> 📊 **Visualisierung:** *Pareto-Analyse – Umsatzanteil der Top-5-%-Kunden*

[<img width="608" height="350" alt="Pareto-Analyse – Umsatzanteil der Top-5-%-Kunden" src="https://github.com/user-attachments/assets/df3fe9a2-4c05-41cd-9b1a-02e6766e398b">](https://public.tableau.com/views/ShopSphereBusinessPerformanceAnalysis/Pareto-AnalyseTop5-Kunden?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)


## 2.6. Einfluss von Marketingkanal und Gerät auf den durchschnittlichen Bestellwert

Als zusätzliche Analyse wurde der **Einfluss von Marketingkanal und Endgerät auf den durchschnittlichen Bestellwert (Average Order Value)** untersucht.

Die Visualisierung kombiniert **Marketingkanal**, **Gerätetyp**, **durchschnittlichen Bestellwert**, **Umsatz** und **Retourenquote**, um besonders profitable Kombinationen sowie Optimierungspotenziale zu identifizieren.

### Erkenntnisse

**Mobile** generiert über alle Marketingkanäle hinweg den höchsten Umsatz:

- **Organic** – **454 Tsd. €**
- **Paid Search** – **372 Tsd. €**
- **Social Ads** – **356 Tsd. €**

Damit ist Mobile der wichtigste Umsatztreiber und bietet das größte Potenzial für zukünftige Marketinginvestitionen.

Die höchsten durchschnittlichen Bestellwerte wurden erzielt durch:

- **Influencer + Tablet** – **0,35 Tsd. €**
- **Email + Desktop** – **0,33 Tsd. €**
- **Paid Search + Tablet** – **0,32 Tsd. €**

Diese Kombinationen eignen sich besonders für die Vermarktung hochwertiger oder margenstarker Produkte.

Die effizienteste Kombination ist:

- **Paid Search + Tablet**
  - Ø Bestellwert: **0,32 Tsd. €**
  - Retourenquote: **6 %**

Die höchsten Retourenquoten wurden festgestellt bei:

- **Referral + Tablet** – **14 %**
- **Email + Desktop / Tablet** – **12 %**

Diese Segmente sollten hinsichtlich Produktangebot, Zielgruppe und Rücksendegründen genauer untersucht werden.

### Business Insight

**Mobile** sollte weiterhin als wichtigster Umsatzkanal im Fokus der Marketingstrategie stehen. Gleichzeitig bieten **Tablet- und Desktop-Nutzer** aufgrund ihres höheren durchschnittlichen Bestellwerts Potenzial für Premium-Produkte und gezielte Cross- bzw. Up-Selling-Kampagnen. Besonders erfolgreiche Kombinationen wie **Paid Search + Tablet** können als Best Practice für zukünftige Marketingmaßnahmen dienen, während Segmente mit hohen Retourenquoten gezielt optimiert werden sollten.

> 📊 **Visualisierung:** *Einfluss von Marketingkanal und Gerät auf den Ø Bestellwert*

[<img width="679" height="378" alt="Einfluss von Marketingkanal und Gerät auf den Ø Bestellwert" src="https://github.com/user-attachments/assets/a2ab81c0-d935-498d-819b-f431e0390915">](https://public.tableau.com/views/ShopSphereBusinessPerformanceAnalysis/Dashboard2?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

</details>


<details>
<summary>🏢 <b>Block 3. CEO Dashboard</b></summary>
  
# Block 3. CEO Dashboard

Für die finale Präsentation der Analyseergebnisse wurde ein **interaktives CEO Dashboard** erstellt.  
Das Dashboard fasst die wichtigsten Business-Kennzahlen sowie die zentralen Erkenntnisse aus den vorherigen Analysephasen zusammen.

Ziel des Dashboards ist es, dem Management einen schnellen und strukturierten Überblick über den aktuellen Geschäftszustand zu geben:

- Welche Faktoren treiben den Umsatz?
- Welche Bereiche entwickeln sich positiv?
- Wo bestehen Optimierungspotenziale?

> 📊 **Tableau Dashboard:**  
> 📊 **Visualisierung:** *CEO Dashboard – ShopSphere Business Performance Analyse*

[<img width="680" height="383" alt="CEO Dashboard – ShopSphere Business Performance Analyse" src="https://github.com/user-attachments/assets/4c674c74-4f8f-4678-8faa-68938f3138b4">](https://public.tableau.com/views/ShopSphereBusinessPerformanceAnalysis/Dashboard1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

---

## Struktur des Dashboards

### KPI-Übersicht

Der obere Bereich des Dashboards zeigt die wichtigsten Kennzahlen für einen schnellen Management-Überblick:

- Gesamtumsatz
- Anzahl der Bestellungen
- Durchschnittlicher Bestellwert
- Retourenquote
- Anzahl der Kunden
- Durchschnittliche Marge

Diese KPIs ermöglichen eine schnelle Bewertung der aktuellen Geschäftsentwicklung.

---

## Zentrale Analysebereiche

### Umsatztrend & Saisonalität

Analyse der Umsatzentwicklung über den gesamten Zeitraum.

**Ziel:**
- Identifikation saisonaler Schwankungen;
- Erkennen von Umsatzspitzen;
- Planung von Marketing- und operativen Ressourcen.

---

### Marketingkanäle: Budget, Umsatz und ROI

Bewertung der Performance verschiedener Marketingkanäle.

**Ziel:**
- Vergleich von Investitionen und Ergebnissen;
- Identifikation besonders effizienter Kanäle;
- Optimierung der Budgetverteilung.

---

### Top-3 Kategorien nach Marge

Analyse der profitabelsten Produktkategorien.

**Ziel:**
- Identifikation margenstarker Wachstumsbereiche;
- Unterstützung strategischer Entscheidungen im Produktportfolio.

---

### Umsatzentwicklung nach Regionen

Analyse der regionalen Umsatzentwicklung über die Zeit.

**Ziel:**
- Erkennen wachsender Märkte;
- Identifikation von Regionen mit weiterem Entwicklungspotenzial.

---

### Pareto-Analyse: Top-5%-Kunden

Analyse des Umsatzbeitrags der wertvollsten Kundengruppe.

**Ziel:**
- Verständnis der Umsatzkonzentration;
- Entwicklung gezielter Kundenbindungsmaßnahmen.

---

# Aufbau-Logik des Dashboards

Das Dashboard folgt einer **Management-Story von oben nach unten**:

## 1. Aktueller Geschäftsstatus – „Wie entwickelt sich das Unternehmen?“

Die KPI-Karten liefern einen schnellen Überblick über:

- Umsatzentwicklung;
- Kundenbasis;
- Profitabilität;
- Verkaufsqualität.

---

## 2. Umsatztreiber – „Welche Faktoren beeinflussen die Ergebnisse?“

Die Analysebereiche zeigen, welche Faktoren das Geschäftswachstum bestimmen:

- saisonale Trends;
- Marketingeffizienz;
- profitable Kategorien;
- regionale Entwicklung.

---

## 3. Strategischer Fokus – „Wo sollte investiert werden?“

Die Kombination aus Marketing-, Kategorie-, Regionen- und Kundenanalyse zeigt konkrete Bereiche für zukünftige Maßnahmen:

- effiziente Marketingkanäle ausbauen;
- profitable Produktbereiche stärken;
- Wachstumsmärkte entwickeln;
- wertvolle Kunden langfristig binden.

---

# Wichtigste Erkenntnisse für das Management

## 1. Das Geschäft zeigt eine klare Saisonalität

Der höchste Umsatz wird im **4. Quartal**, insbesondere im **Dezember**, erzielt.  
Marketingaktivitäten, Lagerbestände und operative Ressourcen sollten frühzeitig auf die Hochsaison vorbereitet werden.

---

## 2. Höheres Marketingbudget bedeutet nicht automatisch höhere Effizienz

Die Analyse zeigt, dass Kanäle mit den größten Investitionen nicht zwingend den höchsten ROI erzielen.

Eine gezielte Anpassung der Budgetverteilung kann die Marketingeffizienz verbessern.

---

## 3. Wachstum wird durch bestimmte Segmente getragen

Das größte Entwicklungspotenzial liegt in:

- wachstumsstarken Regionen;
- profitablen Produktkategorien;
- wertvollen Kundensegmenten.

Gezielte Investitionen in diese Bereiche können langfristiges profitables Wachstum unterstützen.

</details>


<details>
<summary>🎯 <b>Block 4. Strategische Business Cases</b></summary>
  
# Block 4. Strategische Business Cases

## Case A. Wohin sollte das Marketingbudget investiert werden?

Zur Beantwortung dieser Fragestellung wurden die Marketingkanäle anhand von zwei zentralen Kennzahlen analysiert:

- **ROI (Return on Investment)** – Effizienz der Marketinginvestitionen.
- **LTV (Customer Lifetime Value)** – Langfristiger Wert der gewonnenen Kunden.

Ziel der Analyse war es, Marketingkanäle zu identifizieren, die sowohl kurzfristig profitabel als auch langfristig wertvolle Kunden generieren.

> 📊 **Tableau Dashboard:** *Marketingkanäle: Budget, Umsatz und ROI*

[<img width="223" height="259" alt="Marketingkanäle: Budget, Umsatz und ROI" src="https://github.com/user-attachments/assets/73b3499c-f50a-4b1b-a0cd-fe0068e93b33">](https://public.tableau.com/views/ShopSphereBusinessPerformanceAnalysis/MarketingkanleBudgetUmsatzundROI?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)


> 📊 **Visualisierung:** *Durchschnittlicher Customer Lifetime Value (LTV) nach Akquisitionskanal*

[<img width="355" height="122" alt="Durchschnittlicher Customer Lifetime Value (LTV) nach Akquisitionskanal" src="https://github.com/user-attachments/assets/c68b737e-9898-470f-ae26-7c6c5c40f19c">](https://public.tableau.com/views/ShopSphereBusinessPerformanceAnalysis/DurchschnittlicherLTVnachAkquisitionskanal?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

---

## 🔎 Erkenntnisse

- Die größten Marketingbudgets entfallen auf **Paid Search (450,96 Tsd. USD)** und **Social Ads (286,49 Tsd. USD)**. Trotz ihres hohen Umsatzbeitrags zählen sie zu den Kanälen mit dem niedrigsten ROI.

- Den höchsten ROI erzielen:
  - **Organic** – **8,02**
  - **Email** – **6,50**
  - **Influencer** – **4,62**

- Die Kunden mit dem höchsten Customer Lifetime Value werden über folgende Kanäle gewonnen:
  - **Influencer** – **1.985,73 USD**
  - **Referral** – **1.791,82 USD**

- **Organic** weist die ausgewogenste Performance auf und kombiniert einen sehr hohen **ROI (8,02)** mit einem hohen **LTV (1.316,13 USD)**.

---

## 💡 Business-Empfehlungen

- Das Marketingbudget für **Organic**, **Influencer** und **Referral** schrittweise erhöhen.
- Das aktuelle Budget für **Email** beibehalten, da dieser Kanal eine hohe Effizienz bei moderaten Investitionen zeigt.
- Die Ausgaben für **Paid Search** und **Social Ads** optimieren, ohne deren Reichweite vollständig zu reduzieren, da sie weiterhin wesentlich zum Verkaufsvolumen beitragen.

---

## ⚠️ Risiken

- **Organic** bietet nur begrenzte Möglichkeiten für eine kurzfristige Skalierung.
- Der Erfolg von **Influencer Marketing** hängt stark von der Auswahl geeigneter Kooperationspartner ab.
- Eine zu starke Budgetreduzierung bei **Paid Search** und **Social Ads** könnte kurzfristig die Neukundengewinnung und den Gesamtumsatz negativ beeinflussen.

---

## 📌 Fazit

Eine nachhaltige Marketingstrategie sollte **ROI und Customer Lifetime Value gemeinsam** berücksichtigen.

Während der ROI die kurzfristige Rentabilität der Marketingmaßnahmen bewertet, zeigt der LTV den langfristigen wirtschaftlichen Wert der gewonnenen Kunden. Die Kombination beider Kennzahlen ermöglicht eine effizientere Budgetverteilung und unterstützt ein profitables sowie nachhaltiges Unternehmenswachstum.

## Case B. Welche Produktkategorien sind wirklich profitabel?
<img width="316" height="110" alt="image" src="https://github.com/user-attachments/assets/e9c94cba-eed2-4b82-bee9-ef01350e840c" />

Zur Bewertung der Profitabilität der Produktkategorien wurde eine vergleichende Analyse anhand von drei zentralen Kennzahlen durchgeführt:

- **Umsatz**
- **durchschnittliche Marge**
- **Retourenquote**

Ziel der Analyse war es, Produktkategorien mit dem größten Gewinnpotenzial zu identifizieren und Bereiche mit Optimierungsbedarf aufzudecken.

---

## 🔎 Erkenntnisse

- **Electronics** erzeugt eine **„Illusion des Umsatzvolumens“**. Mit **2,10 Mio. USD Umsatz** ist diese Kategorie zwar umsatzstärkster Bereich, weist jedoch die **niedrigste durchschnittliche Marge (12 %)** sowie eine der höchsten **Retourenquoten (15,6 %)** auf. Hohe Verkaufszahlen führen daher nicht automatisch zu hoher Profitabilität.

- **Beauty** ist die profitabelste Kategorie. Trotz eines vergleichsweise geringen Umsatzes von **168,6 Tsd. USD** erzielt sie die **höchste Marge (55 %)** bei einer moderaten **Retourenquote (10,4 %)**.

- **Sports** und **Toys** zeigen ebenfalls eine ausgewogene Kombination aus Marge und niedriger Retourenquote und leisten damit einen stabilen Beitrag zur Profitabilität.

---

## 💎 Hidden Champion

Die Kategorie **Beauty** kann als **„Hidden Champion“** bezeichnet werden.

Obwohl sie nur einen vergleichsweise kleinen Umsatz erzielt, kombiniert sie die höchste Marge mit einer niedrigen Retourenquote und bietet damit das größte Potenzial für profitables Wachstum.

---

## 💡 Business-Empfehlungen

- Marketinginvestitionen für die Kategorie **Beauty** erhöhen und das Produktsortiment gezielt ausbauen.
- Die Verkaufsstrategie für **Electronics** optimieren, insbesondere durch Maßnahmen zur Margensteigerung und Reduzierung der Retourenquote.
- Die Entwicklung der Kategorien **Sports** und **Toys** weiter fördern, da sie stabile und profitable Ergebnisse liefern.

---

## 📌 Fazit

Die Bewertung von Produktkategorien ausschließlich anhand des Umsatzes reicht für fundierte Geschäftsentscheidungen nicht aus.

Erst die gemeinsame Analyse von **Umsatz**, **Marge** und **Retourenquote** ermöglicht eine realistische Beurteilung der Wirtschaftlichkeit. Dadurch lassen sich sowohl umsatzstarke, aber wenig profitable Kategorien als auch besonders attraktive Investitionsmöglichkeiten identifizieren.

## Case C. Rabatte und wertvolle Kunden

Zur Beantwortung dieser Fragestellung wurde der Einfluss von **Rabatten auf das Kaufverhalten** sowie der **Umsatzbeitrag der wertvollsten Kunden** analysiert.

Ziel der Analyse war es zu bewerten, ob hohe Rabatte langfristige Kundenbindung fördern und welche Kundensegmente den größten Beitrag zum Unternehmenserfolg leisten.

---

## 🔎 Erkenntnisse
<img width="241" height="109" alt="image" src="https://github.com/user-attachments/assets/2646183b-86ab-4f2f-af64-b03247407c83" />

- Kunden, deren durchschnittlicher Rabatt **über 20 %** liegt, tätigen im Durchschnitt lediglich **2,17 Bestellungen**, während alle übrigen Kunden durchschnittlich **4,35 Bestellungen** aufgeben.

- Dies deutet darauf hin, dass hohe Rabatte vor allem **Einmalkäufe fördern**, jedoch nur begrenzt zur langfristigen Kundenbindung beitragen.

- Die **Top 5 % der Kunden** erwirtschaften einen erheblichen Anteil des Gesamtumsatzes und stellen damit das wertvollste Kundensegment des Unternehmens dar.

- Den größten Beitrag innerhalb dieser Kundengruppe leisten die Marketingkanäle:
  - **Influencer** – **28,25 %**
  - **Organic** – **24,29 %**
  - **Referral** – **16,28 %**

- Die wertvollsten Kunden stammen überwiegend aus den Regionen **Europe**, **North America** und **Southeast Asia**.
  
> 📊 **Tableau:** *Analyse des Beitrags der Top-5%-Kunden*

[<img width="554" height="193" alt="A/B-Test – Einfluss des Checkout-Designs auf den Ø Bestellwert" src="https://github.com/user-attachments/assets/ed0d062d-45b9-4bab-ac40-f3cebc2623db">](https://public.tableau.com/views/ShopSphereBusinessPerformanceAnalysis/8_92?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

[<img width="134" height="88" alt="A/B-Test – Detailanalyse Checkout-Varianten" src="https://github.com/user-attachments/assets/00aa94c2-084c-45c5-b282-5e4592e28f01">](https://public.tableau.com/views/ShopSphereBusinessPerformanceAnalysis/8_92?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

---

## 💡 Business-Empfehlungen

- Hohe Rabatte gezielt zur **Neukundengewinnung** einsetzen und nicht als primäres Instrument der Kundenbindung nutzen.

- Zur Steigerung der Wiederkaufsrate verstärkt in **Loyalitätsprogramme**, **personalisierte Angebote** und **CRM-Kommunikation** investieren.

- Marketingbudgets verstärkt auf die Kanäle **Influencer**, **Organic** und **Referral** ausrichten, da diese die profitabelsten Kunden gewinnen.

---

## 📌 Fazit

Hohe Rabatte fördern kurzfristig den Erstkauf, tragen jedoch nur begrenzt zur langfristigen Kundenbindung bei.

Den größten Unternehmenswert schafft eine vergleichsweise kleine Gruppe besonders wertvoller Kunden. Eine nachhaltige Wachstumsstrategie sollte daher nicht nur auf die Neukundengewinnung, sondern insbesondere auf die **Bindung und Weiterentwicklung der profitabelsten Kundensegmente** durch personalisierte Maßnahmen und Loyalty-Programme ausgerichtet sein.  
</details>

<details>
<summary>🧪 <b>Block 5. Statistisches Denken: A/B-Experiment</b></summary>
  
# 🧪 Block 5. Statistisches Denken: A/B-Experiment

## Analyse des Checkout-Experiments

Es wurde ein **A/B-Test eines neuen Checkout-Designs** durchgeführt. Dabei erhielt die Hälfte der Bestellungen die alte Version (**Variant A**), während die andere Hälfte die neue Version (**Variant B**) nutzte.

Ziel der Analyse war es, nicht nur Durchschnittswerte zu vergleichen, sondern zu untersuchen, **für welche Kundengruppen die Änderung tatsächlich einen Mehrwert erzeugt**.

---

## 🔎 Vergleich des durchschnittlichen Bestellwerts zwischen Variant A und Variant B

> 📊 **Visualisierung:** *A/B-Test: Ø Bestellwert*

[<img width="609" height="341" alt="A/B-Test: Ø Bestellwert" src="https://github.com/user-attachments/assets/953734b7-319d-44a1-8699-967377cacc5c">](https://public.tableau.com/views/ShopSphereBusinessPerformanceAnalysis/AB-TestBestellwert?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)


Auf den ersten Blick zeigt **Variant B** ein besseres Ergebnis. Der Unterschied zwischen den beiden Varianten über den gesamten Testzeitraum ist jedoch relativ gering:

| Variante | Durchschnittlicher Bestellwert |
|---|---:|
| Variant A | 281,72 USD |
| Variant B | 287,27 USD |

Die Differenz beträgt lediglich **5,55 USD**.

Auf Basis des Gesamtdurchschnitts kann daher keine eindeutige Aussage getroffen werden, dass das neue Checkout-Design für alle Kunden einen signifikanten Vorteil bietet.

Für eine fundierte Bewertung wurde zusätzlich eine Segmentanalyse durchgeführt.

---

# 👥 Analyse nach Kundensegmenten

Nach der Aufteilung der Kunden in **neue Kunden** und **Bestandskunden** zeigte sich ein unterschiedlicher Einfluss der neuen Checkout-Version.

| Kundengruppe | Variant A | Variant B | Veränderung |
|---|---:|---:|---:|
| Neue Kunden | 223,30 USD | 266,21 USD | **+19 %** |
| Wiederkehrende Kunden | 286,24 USD | 288,85 USD | **+ <1 %** |

### Erkenntnisse

Das neue Checkout-Design zeigt den größten positiven Effekt bei **neuen Kunden**.

- Der durchschnittliche Bestellwert steigt bei neuen Kunden um **19 %**.
- Bei wiederkehrenden Kunden ist die Verbesserung mit weniger als **1 %** nahezu vernachlässigbar.

Dies zeigt, dass der Gesamtdurchschnitt die wichtigen Unterschiede zwischen Kundensegmenten verdeckt.

---

## 💡 Business-Empfehlung

Die Einführung von **Variant B** sollte zunächst auf **neue Kunden** fokussiert werden, da diese Gruppe den größten positiven Effekt zeigt.

Vor einem vollständigen Rollout für alle Nutzer sollten jedoch weitere Analysen durchgeführt werden:

- statistische Signifikanz der Ergebnisse prüfen;
- Einfluss auf die Conversion Rate analysieren;
- Abbruchrate im Checkout-Prozess untersuchen;
- Unterschiede nach Regionen und Geräten bewerten.

---

## ⚠️ Risiken einer falschen Interpretation von A/B-Tests

A/B-Testergebnisse können durch eine selektive Darstellung beeinflusst werden.

### Um Variant B erfolgreicher erscheinen zu lassen, könnte man:

- nur Zeiträume zeigen, in denen Variant B besser abschneidet;
- positive Trends nach August hervorheben;
- Skalierungen von Diagrammen verwenden, die Unterschiede visuell übertreiben.

### Um Variant B schlechter darzustellen, könnte man:

- ausschließlich wiederkehrende Kunden betrachten, bei denen der Effekt kaum vorhanden ist;
- den positiven Effekt bei neuen Kunden ignorieren.

Eine korrekte Analyse muss daher immer alle relevanten Kundensegmente berücksichtigen.

---

## 📌 Fazit

Der Gesamtdurchschnitt allein reicht nicht aus, um die Wirkung einer Produktänderung zu bewerten.

Variant B zeigt **keine deutliche Verbesserung für alle Nutzergruppen**, erzielt jedoch einen klaren positiven Effekt bei **neuen Kunden (+19 % durchschnittlicher Bestellwert)**.

Die richtige Schlussfolgerung lautet daher nicht:

> „Variant B ist für alle Kunden besser.“

Sondern:

> „Das neue Checkout-Design bietet einen nachweisbaren Mehrwert für neue Kunden und sollte nach Bestätigung der statistischen Signifikanz gezielt für dieses Segment ausgerollt werden.“

Hohe Rabatte fördern kurzfristig den Erstkauf, tragen jedoch nur begrenzt zur langfristigen Kundenbindung bei.

Den größten Unternehmenswert schafft eine vergleichsweise kleine Gruppe besonders wertvoller Kunden. Eine nachhaltige Wachstumsstrategie sollte daher nicht nur auf die Neukundengewinnung, sondern insbesondere auf die **Bindung und Weiterentwicklung der profitabelsten Kundensegmente** durch personalisierte Maßnahmen und Loyalty-Programme ausgerichtet sein.


</details>

<details>
<summary>🎯 <b>Empfehlungen für den CEO</b></summary>
  
# 🎯 Empfehlungen für den CEO

Basierend auf den Ergebnissen der SQL-Analyse, Tableau-Visualisierungen und strategischen Business Cases wurden folgende Handlungsempfehlungen abgeleitet:

---

## 1. Marketingbudget gezielt optimieren

Das Marketingbudget sollte stärker auf Kanäle mit hoher Effizienz und langfristigem Kundenwert ausgerichtet werden.

**Empfehlung:**

- Investitionen in **Organic**, **Influencer** und **Referral** erhöhen.
- Diese Kanäle zeigen die beste Kombination aus:
  - hohem ROI;
  - hohem Customer Lifetime Value (LTV).
- Budgets für **Paid Search** und **Social Ads** sollten hinsichtlich Effizienz und Zielgruppenansprache optimiert werden.

---

## 2. Profitabilität der Produktkategorien steigern

Die Kategorie **Beauty** sollte als strategischer Wachstumsbereich ausgebaut werden.

**Empfehlung:**

- Sortiment und Marketingaktivitäten für **Beauty** erweitern.
- Die Kategorie bietet aufgrund der **höchsten Marge** bei gleichzeitig moderater Retourenquote großes Wachstumspotenzial.

**Optimierungspotenzial:**

- **Electronics** sollte genauer analysiert werden, da die Kategorie zwar den höchsten Umsatz generiert, jedoch durch:
  - niedrige Marge;
  - hohe Retourenquote

  eine geringere Profitabilität aufweist.

---

## 3. Wertvolle Kunden langfristig binden

Die umsatzstärksten Kundensegmente stellen einen wesentlichen Beitrag zum Unternehmenserfolg dar.

**Empfehlung:**

- Entwicklung gezielter Kundenbindungsmaßnahmen:
  - Loyalty-Programme;
  - personalisierte Angebote;
  - exklusive Kundenvorteile;
  - Referral-Programme.

Ziel ist es, Wiederkäufe zu erhöhen und den langfristigen Kundenwert (LTV) zu steigern.

---

## 4. Rabatte strategisch einsetzen

Die Analyse zeigt, dass Kunden mit hohen durchschnittlichen Rabatten deutlich weniger Wiederholungskäufe tätigen.

**Empfehlung:**

- Rabatte primär zur **Neukundengewinnung** einsetzen.
- Rabatte nicht als Hauptinstrument für langfristige Kundenbindung verwenden.
- Für Bestandskunden stärker auf personalisierte Angebote und Mehrwertprogramme setzen.

---

## 5. Einführung des neuen Checkout-Designs schrittweise durchführen

Der A/B-Test zeigt, dass das neue Checkout-Design (**Variant B**) besonders bei **Neukunden** einen positiven Effekt erzielt.

**Empfehlung:**

- Schrittweise Einführung des neuen Checkouts, zunächst mit Fokus auf Neukunden.
- Vor einem vollständigen Rollout weitere Kennzahlen analysieren:

  - Conversion Rate;
  - Abschlussquote im Checkout-Prozess;
  - Unterschiede nach Regionen;
  - Unterschiede nach Endgeräten.

---

# 📌 Gesamtfazit

Die Analyse zeigt, dass nachhaltiges Wachstum nicht ausschließlich durch höhere Umsätze entsteht, sondern durch eine gezielte Kombination aus:

- effizientem Marketingbudget;
- profitablen Produktkategorien;
- langfristiger Kundenbindung;
- datenbasierten Produktentscheidungen.

Durch die Umsetzung dieser Maßnahmen kann ShopSphere die Marketingeffizienz steigern, profitable Segmente ausbauen und langfristig nachhaltiges Wachstum sichern.
</details>
