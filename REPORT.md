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

# Block 2. Visualisierungen in Tableau

## 2.1. Saisonalität

Zur Analyse der Saisonalität wurde ein **Liniendiagramm des Gesamtumsatzes nach Monaten** für den Zeitraum **2022–2024** erstellt.

Die Visualisierung zeigt die Umsatzentwicklung im Jahresverlauf und ermöglicht die Identifikation saisonaler Schwankungen.

### Erkenntnisse

Die Analyse des Liniendiagramms zeigt eine **deutliche Saisonalität**. Ab **Oktober** steigen die Umsätze kontinuierlich an, wobei der **höchste Umsatz im Dezember** erreicht wird. Dieses Muster lässt sich wahrscheinlich durch die erhöhte Kaufaktivität während der Feiertage sowie durch saisonale Marketingkampagnen erklären.

### Business Insight

Das Unternehmen sollte Lagerbestände, Marketingbudget und logistische Ressourcen frühzeitig auf die Hochsaison ausrichten. Die Analyse zeigt, dass das **4. Quartal die umsatzstärkste und profitabelste Periode für ShopSphere** ist und daher besonderes Potenzial für Umsatzwachstum bietet.

> 📊 **Visualisierung:** *Monatlicher Gesamtumsatz (2022–2024)*  
> *(Tableau-Dashboard / Screenshot hier einfügen)*

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
> *(Tableau-Dashboard / Screenshot hier einfügen)*

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
> *(Tableau-Dashboard / Screenshot hier einfügen)*

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
> *(Tableau-Dashboard / Screenshot hier einfügen)*

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
> *(Tableau-Dashboard / Screenshot hier einfügen)*

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
> *(Tableau-Dashboard / Screenshot hier einfügen)*

# Block 3. CEO Dashboard

Für die finale Präsentation der Analyseergebnisse wurde ein **interaktives CEO Dashboard** erstellt.  
Das Dashboard fasst die wichtigsten Business-Kennzahlen sowie die zentralen Erkenntnisse aus den vorherigen Analysephasen zusammen.

Ziel des Dashboards ist es, dem Management einen schnellen und strukturierten Überblick über den aktuellen Geschäftszustand zu geben:

- Welche Faktoren treiben den Umsatz?
- Welche Bereiche entwickeln sich positiv?
- Wo bestehen Optimierungspotenziale?

> 📊 **Tableau Dashboard:**  
> *(Link zu Tableau Public hier einfügen)*

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
