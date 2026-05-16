# 🎓 LearnPulse — AI-Powered Student Productivity & Behavioral Analytics Dashboard

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Python](https://img.shields.io/badge/Python-3.10-3776AB?style=for-the-badge&logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-2.1-150458?style=for-the-badge&logo=pandas&logoColor=white)
![SQLAlchemy](https://img.shields.io/badge/SQLAlchemy-2.0-red?style=for-the-badge)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-F37626?style=for-the-badge&logo=jupyter&logoColor=white)

> **An end-to-end Data Analytics project** that tracks student engagement, productivity, burnout risk, focus trends, learning consistency, and efficiency — powered by Python, MySQL, SQL, and Power BI.

---

## 📌 Problem Statement

Educational platforms generate vast behavioral data but lack the tools to extract actionable intelligence from it. Students burn out silently, focus declines go unnoticed, and struggling learners receive no early intervention — because traditional reporting systems are static, reactive, and surface-level.

**LearnPulse** solves this with a full analytics pipeline: raw data → Python preprocessing → MySQL database → SQL analytics → Power BI dashboard — delivering real-time behavioral insights for educators and administrators.

---

## 🖥️ Dashboard Preview

<img width="791" height="439" alt="image" src="https://github.com/user-attachments/assets/76076483-9634-40fa-a7d5-3bd719c79734" />


---

## 🎯 Project Objectives

- Analyze **1,000 students** across 18 behavioral and performance dimensions
- Detect **burnout risk** (48.1% of students flagged at risk)
- Classify students into **behavioral profiles**: Consistent, Struggling, Overachiever
- Track **focus trends**, **streak-based consistency**, and **learning efficiency**
- Surface **AI-driven insights** through an interactive Power BI dashboard
- Build a complete data pipeline from Kaggle datasets to dashboard deployment

---

## 🏗️ Project Architecture

```
┌─────────────────────────────────────────────────────────┐
│              SOURCE: Kaggle Datasets (2–3 files)        │
│              Originally in Excel / CSV format           │
└──────────────────────┬──────────────────────────────────┘
                       │  Python (Pandas) — Merge & Convert
┌──────────────────────▼──────────────────────────────────┐
│              DATA PREPROCESSING (learnpulse.ipynb)      │
│  Rename columns → Remove duplicates → Type casting      │
│  Outlier detection → Feature engineering → Encoding     │
└──────────────────────┬──────────────────────────────────┘
                       │  SQLAlchemy — df.to_sql()
┌──────────────────────▼──────────────────────────────────┐
│              MySQL DATABASE (learnpulse)                 │
│              Table: students (18+ columns)              │
└──────────────────────┬──────────────────────────────────┘
                       │  15 SQL Analytical Queries
┌──────────────────────▼──────────────────────────────────┐
│              SQL ANALYTICS (learnpulse.sql)             │
│  KPIs · Segmentation · Focus Trends · Burnout Risk      │
└──────────────────────┬──────────────────────────────────┘
                       │  Power BI — Get Data → MySQL
┌──────────────────────▼──────────────────────────────────┐
│              POWER BI DASHBOARD                         │
│  10+ Visuals · KPI Cards · Slicers · Insight Banners   │
└─────────────────────────────────────────────────────────┘
```

---

## 📁 Project Structure

```
LearnPulse/
│
├── learnpulse_dataset.csv          # Final analytics-ready dataset (1,000 students, 18 cols)
├── learnpulse.ipynb                # Python notebook: cleaning, engineering, MySQL push
├── learnpulse.sql                  # 15 SQL analytical queries
│
├── powerbi/
│   └── LearnPulse_Dashboard.pbix  # Power BI dashboard file
│
├── dashboard_preview.png           # Dashboard screenshot
└── README.md                       # This file
```

---

## 📊 Dataset Overview

| Property | Value |
|---|---|
| Total Records | 1,000 students |
| Total Features | 18 columns |
| Source | Kaggle (2–3 datasets merged) |
| Original Format | Excel → Converted to CSV via Python |

### Column Reference

| Column | Type | Description |
|---|---|---|
| `user_id` | String | Unique student identifier (STU_0001 … STU_1000) |
| `profile` | Categorical | Student type: consistent / struggling / overachiever |
| `study_hours` | Float | Daily average study hours (range: 0.5 – 8.71) |
| `focus_score` | Float | Attention and focus metric (0 – 100) |
| `completed_videos` | Integer | Total videos completed on platform |
| `breaks` | Float | Average daily breaks taken |
| `active_days` | Integer | Monthly active days on platform |
| `streak_length` | Integer | Consecutive active learning days (0 – 30) |
| `consistency_index` | Float | Regularity score (0 – 100) |
| `learning_efficiency` | Float | Output per unit of time invested |
| `productivity_score` | Float | Overall productivity metric (0 – 100) |
| `focus_trend` | Float | Directional change in focus over time |
| `burnout_risk` | Binary | 1 = at risk, 0 = healthy |
| `completion_status` | Binary | 1 = course completed, 0 = incomplete |
| `efficiency_ratio` | Float | Productivity per study hour |
| `break_overload` | Binary | 1 = excessive breaks detected |
| `engagement_score` | Float | Platform interaction score (0 – 100) |
| `positive_momentum` | Binary | 1 = upward performance trend |

---

## 🐍 Python Workflow (learnpulse.ipynb)

### Step 1 — Load & Inspect
```python
import pandas as pd, numpy as np
df = pd.read_csv("learnpulse_dataset.csv")
print(df.shape)        # (1000, 18)
print(df.isnull().sum())
```

### Step 2 — Rename Columns
```python
df.columns = [
    'user_id', 'profile', 'daily_study_hours', 'focus_score',
    'completed_videos', 'daily_breaks', 'monthly_active_days',
    'streak_length', 'consistency_index', 'learning_efficiency',
    'productivity_score', 'focus_growth', 'is_burnout_risk',
    'course_completed', 'efficiency_ratio', 'is_break_overload',
    'engagement_score', 'has_positive_momentum'
]
```

### Step 3 — Clean Data
```python
df.drop_duplicates(inplace=True)
binary_cols = ['is_burnout_risk', 'course_completed', 'is_break_overload', 'has_positive_momentum']
for col in binary_cols:
    df[col] = df[col].astype(int)
```

### Step 4 — Outlier Detection (IQR Method)
```python
for col in df.select_dtypes(include=np.number).columns:
    Q1, Q3 = df[col].quantile(0.25), df[col].quantile(0.75)
    IQR = Q3 - Q1
    outliers = df[(df[col] < Q1 - 1.5*IQR) | (df[col] > Q3 + 1.5*IQR)]
    print(f"{col}: {len(outliers)} outliers")
```

### Step 5 — Feature Engineering
```python
df['productivity_per_hour'] = df['productivity_score'] / df['study_hours']
df['video_completion_rate'] = df['completed_videos'] / df['active_days']
df['healthy_learning_pattern'] = np.where(
    (df['burnout_risk'] == 0) & (df['consistency_index'] > 70), 1, 0
)
```

### Step 6 — Profile Encoding
```python
df = pd.get_dummies(df, columns=['profile'], drop_first=True)
```

### Step 7 — Push to MySQL
```python
from sqlalchemy import create_engine
engine = create_engine("mysql+pymysql://root:password@localhost:3306/learnpulse")
df.to_sql("students", engine, if_exists="replace", index=False)
```

---

## 🗄️ SQL Queries Overview (learnpulse.sql)

| # | Query Purpose | Output |
|---|---|---|
| Q1 | Platform-level KPIs | Avg study hours, productivity, engagement, focus |
| Q2 | Burnout distribution | At-risk (481) vs healthy (519) count |
| Q3 | Top 10 performers | Ranked by productivity score |
| Q4 | Profile-wise averages | Overachiever vs Struggling vs Consistent |
| Q5 | Burnout risk students | Filtered list sorted by productivity |
| Q7 | Study hour buckets | Productivity grouped by hour range |
| Q8 | Focus trend classes | Rapid Improvement / Stable Growth / Declining |
| Q9 | Efficiency leaderboard | Top 15 by learning efficiency |
| Q10 | Consistency vs productivity | Correlation table |
| Q11 | Healthy learning pattern | Count and avg productivity |
| Q12 | Break overload impact | Focus and engagement effect |
| Q13 | Engagement leaders | Top 20 by engagement score |
| Q14 | Momentum and completion | Completion rate by momentum flag |
| Q15 | Student segmentation | Elite / Burnout / Irregular / Average |

### Highlight — Student Segmentation (Q15)
```sql
SELECT 
    CASE
        WHEN productivity_score >= 75 AND engagement_score >= 75 THEN 'Elite Learners'
        WHEN burnout_risk = 1 AND productivity_score >= 60       THEN 'Burnout Risk Performers'
        WHEN consistency_index < 40                              THEN 'Irregular Learners'
        ELSE 'Average Learners'
    END AS student_segment,
    COUNT(*) AS total_students
FROM students
GROUP BY student_segment;
```

### Highlight — Focus Trend Classification (Q8)
```sql
SELECT 
    CASE
        WHEN focus_trend > 5             THEN 'Rapid Improvement'
        WHEN focus_trend BETWEEN 0 AND 5 THEN 'Stable Growth'
        ELSE 'Declining Focus'
    END AS focus_category,
    COUNT(*) AS total_students
FROM students
GROUP BY focus_category;
```

---

## 📈 Key Metrics From Dashboard

| KPI | Value | Signal |
|---|---|---|
| Total Students | 1,000 | Full platform cohort |
| Avg Study Hours | 3.75 hrs/day | Moderate load |
| Avg Productivity Score | 54.79 / 100 | Below 70 target |
| Avg Engagement Score | 56.41 / 100 | Needs improvement |
| Avg Focus Score | 65.92 / 100 | Critically low |
| Course Completion Rate | 63.9% | Below 70% threshold |
| Burnout Risk | 481 students (48.1%) | Nearly half at risk |
| Positive Momentum | 611 students (61.1%) | Moderate recovery |
| Overachievers | 251 (25.1%) | High performers |
| Struggling | 351 (35.1%) | Need intervention |
| Consistent | 398 (39.8%) | Core stable group |

---

## 💡 Key Insights

- **48.1% of students are at burnout risk** — the most critical platform-wide finding
- **Overachievers** outperform other profiles despite similar study hours — indicating quality of engagement matters more than quantity
- **Break overload** (183 students) correlates with lower focus and engagement scores
- **Streak length** is the strongest predictor of consistency — students with streaks above 15 days show significantly higher completion rates
- **Efficiency ratio peaks at 3–5 study hours/day** then drops, proving diminishing returns from excessive studying
- **Positive momentum** students have a substantially higher course completion rate than zero-momentum peers
- **Struggling students** average a consistency index below 40, making them the primary target for early intervention

---

## 🚀 How to Run

### Prerequisites
- Python 3.10+, MySQL 8.0+, Power BI Desktop
- `pip install pandas numpy sqlalchemy pymysql jupyter`

### Steps
```bash
# 1. Clone
git clone https://github.com/yourusername/LearnPulse.git
cd LearnPulse

# 2. Open notebook and update MySQL credentials
jupyter notebook learnpulse.ipynb

# 3. Run all cells — this cleans data and pushes to MySQL

# 4. Run SQL queries
mysql -u root -p learnpulse < learnpulse.sql

# 5. Open Power BI → Get Data → MySQL → learnpulse database
```

---

## 🧠 Skills Demonstrated

- **Python** — Pandas ETL, NumPy, IQR outlier detection, one-hot encoding, SQLAlchemy
- **SQL** — CASE logic, GROUP BY, multi-condition segmentation, bucket analysis
- **MySQL** — DB creation, table design, `df.to_sql()` integration
- **Power BI** — DAX measures, slicers, KPI cards, conditional formatting, drill-through
- **Analytics** — Burnout detection, efficiency indexing, focus trend classification, behavioral segmentation
- **Data Engineering** — Full pipeline from raw Kaggle data to live BI dashboard

---

## 🔮 Future Improvements

- Predictive dropout model using scikit-learn (logistic regression / random forest)
- Real-time data ingestion via scheduled Python scripts or Apache Kafka
- Power BI Service deployment for browser-accessible sharing
- Integration with live LMS APIs (Moodle, Canvas) for real student data
- Automated burnout alert emails to educators

---

## 👤 Author

PANKAJ KUMAR SAINI
- 💼 [Gmail](sainipankaj9456@gmail.com)
- 💼 [Gmail2](2023UEE1275@mnit.ac.in)

---

## 📄 License

MIT License — free to use with attribution.

---

> ⭐ If this project helped you, give it a star!
