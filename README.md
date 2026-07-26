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


- `shopsphere_customers`
https://raw.githubusercontent.com/VikiTarasova/final_project_shopsphere/refs/heads/main/data/shopsphere_customers.csv 

- `shopsphere_products`
https://raw.githubusercontent.com/VikiTarasova/final_project_shopsphere/refs/heads/main/data/shopsphere_products.csv

- `shopsphere_orders`
https://raw.githubusercontent.com/VikiTarasova/final_project_shopsphere/refs/heads/main/data/shopsphere_orders.csv 

- `shopsphere_order_items`
https://raw.githubusercontent.com/VikiTarasova/final_project_shopsphere/refs/heads/main/data/shopsphere_order_items.csv

- `shopsphere_marketing`
https://raw.githubusercontent.com/VikiTarasova/final_project_shopsphere/refs/heads/main/data/shopsphere_marketing.csv 

---

# 🎯 Business-Ziel

Der CEO benötigt Antworten auf die wichtigsten strategischen Fragen:

- Welche Marketingkanäle erzielen den höchsten Return on Investment (ROI)?
- Wer sind die wertvollsten Kunden des Unternehmens?
- Welche Produktkategorien generieren tatsächlichen Gewinn und welche nur einen hohen Umsatz?
- Welche Regionen besitzen das größte Wachstumspotenzial?
- Hat das neue Checkout-Design das Kundenverhalten verbessert?

# 🔎 Analyseschritte

## 1. SQL: Datenaufbereitung

Mithilfe von SQL wurden analytische Datensätze erstellt:

- Umsatz, Anzahl der Bestellungen und durchschnittlicher Bestellwert nach Regionen und Jahren;
- Top-10-Kunden nach Ausgaben;
- Analyse der Produktkategorien nach Umsatz, Marge und Retourenquote;
- Segmentierung der Kunden mit überdurchschnittlichen Ausgaben;
- Analyse des ROI der Marketingkanäle.

**Verwendete SQL-Techniken:**

- JOIN
- GROUP BY
- HAVING
- Subqueries
- Aggregationen

---

# 📈 Tableau Visualisierungen

Es wurden 6 zentrale Visualisierungen erstellt:

## 1. Seasonality Analysis  
## 2. Marketing Performance: Budget vs. ROI  
## 3. Product Category Analysis  
## 4. Regional Growth Analysis  
## 5. Customer Pareto Analysis  
## 6. Device & Channel Analysis

**Link:**  
Tableau Public: **(<div class='tableauPlaceholder' id='viz1785056658113' style='position: relative'><noscript><a href='#'><img alt=' ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Sh&#47;ShopSphereBusinessPerformanceAnalysis&#47;Dashboard1&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='ShopSphereBusinessPerformanceAnalysis&#47;Dashboard1' /><param name='tabs' value='yes' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Sh&#47;ShopSphereBusinessPerformanceAnalysis&#47;Dashboard1&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /><param name='filter' value='publish=yes' /></object></div>                <script type='text/javascript'>                    var divElement = document.getElementById('viz1785056658113');                    var vizElement = divElement.getElementsByTagName('object')[0];                    if ( divElement.offsetWidth > 800 ) { vizElement.style.minWidth='1366px';vizElement.style.maxWidth='100%';vizElement.style.minHeight='818px';vizElement.style.maxHeight=(divElement.offsetWidth*0.75)+'px';} else if ( divElement.offsetWidth > 500 ) { vizElement.style.minWidth='1366px';vizElement.style.maxWidth='100%';vizElement.style.minHeight='818px';vizElement.style.maxHeight=(divElement.offsetWidth*0.75)+'px';} else { vizElement.style.width='100%';vizElement.style.minHeight='2100px';vizElement.style.maxHeight=(divElement.offsetWidth*1.77)+'px';}                     var scriptElement = document.createElement('script');                    scriptElement.src = 'https://public.tableau.com/javascripts/api/viz_v1.js';                    vizElement.parentNode.insertBefore(scriptElement, vizElement);                </script>)**

# 🧪 A/B-Test: Checkout-Experiment

**Testzeitraum:**  
ab dem 1. Juni 2024

**Verglichen wurden:**

- **Variante A** — alter Checkout
- **Variante B** — neuer Checkout

---

# 💡 Zentrale Business-Erkenntnisse

1. Marketingbudget stärker auf **Organic, Influencer und Referral** ausrichten.

2. **Beauty** als profitabelste Kategorie weiter ausbauen.

3. **Electronics** aufgrund der niedrigen Marge und der hohen Retourenquote optimieren.

4. Fokus auf die **Bindung der Top-5%-Kunden** legen.

5. Den neuen Checkout schrittweise einführen, beginnend mit **Neukunden**.
