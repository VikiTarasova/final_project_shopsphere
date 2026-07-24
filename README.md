# final_project_shopsphere
Abschlussprojekt des Kurses ShopSphere: Analysen für globale Marktplätze
# ShopSphere: Analyse eines globalen Marktplatzes

## 📊 Projektbeschreibung

Ein umfassendes Analyseprojekt für den globalen E-Commerce-Marktplatz ShopSphere.  
Ziel ist es, die wichtigsten Wachstumsfaktoren des Unternehmens zu untersuchen: die Effizienz der Marketingkanäle, den Kundenwert, die Profitabilität der Produktkategorien, die regionale Entwicklung sowie den Einfluss eines neuen Checkout-Designs durch ein A/B-Experiment.

Im Projekt wurde der vollständige Analyseprozess durchgeführt:

**SQL → Datenaufbereitung → Tableau-Visualisierung → Business-Analyse → strategische Empfehlungen**

**Tools:**
- **SQL (SQLite)** — Verknüpfung von Tabellen, Aggregationen, Unterabfragen
- **Tableau Public** — interaktive Visualisierungen und CEO-Dashboard
- **Statistical Thinking** — Analyse eines A/B-Experiments

---

# 📂 Daten

**Quelle:** ShopSphere Marketplace Dataset

**Analysezeitraum:** **2022–2024**

Die Daten sind in 5 miteinander verbundenen Tabellen organisiert:

| Tabelle | Beschreibung |
|---------|--------------|
| customers | Kundendaten (Kunden-ID, Region, Akquisitionskanal, Registrierungsdatum) | https://raw.githubusercontent.com/VikiTarasova/final_project_shopsphere/refs/heads/main/data/shopsphere_customers.csv 

| products | Produktkatalog (Produkt-ID, Kategorie, Preis, Marge) |
https://raw.githubusercontent.com/VikiTarasova/final_project_shopsphere/refs/heads/main/data/shopsphere_products.csv

| orders | Bestellungen (Bestell-ID, Kunde, Datum, Umsatz, Status) | 
https://raw.githubusercontent.com/VikiTarasova/final_project_shopsphere/refs/heads/main/data/shopsphere_orders.csv 

| order_items | Produkte innerhalb der Bestellungen (Menge, Preis, Produkt-ID) |https://raw.githubusercontent.com/VikiTarasova/final_project_shopsphere/refs/heads/main/data/shopsphere_order_items.csv

| marketing | Marketingkampagnen (Kanal, Budget, Kosten, Performance-Kennzahlen) | https://raw.githubusercontent.com/VikiTarasova/final_project_shopsphere/refs/heads/main/data/shopsphere_marketing.csv 

---

# 🎯 Business-Ziel

Der CEO benötigt Antworten auf die wichtigsten strategischen Fragen:

- Welche Marketingkanäle erzielen den höchsten Return on Investment (ROI)?
- Wer sind die wertvollsten Kunden des Unternehmens?
- Welche Produktkategorien generieren tatsächlichen Gewinn und welche nur einen hohen Umsatz?
- Welche Regionen besitzen das größte Wachstumspotenzial?
- Hat das neue Checkout-Design das Kundenverhalten verbessert?
