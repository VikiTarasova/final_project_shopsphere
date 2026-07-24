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
