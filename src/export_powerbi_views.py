from pathlib import Path
import sqlite3
import pandas as pd


# Define project paths
PROJECT_ROOT = Path(__file__).resolve().parents[1]
DATABASE_PATH = PROJECT_ROOT / "data" / "processed" / "uk_logistics_road_freight.db"
EXPORT_PATH = PROJECT_ROOT / "data" / "processed" / "powerbi_views"


def main():
    """
    Export all SQLite views into CSV files for Power BI.
    """

    if not DATABASE_PATH.exists():
        raise FileNotFoundError(
            f"Database not found: {DATABASE_PATH}. "
            "Run src/create_sqlite_database.py first."
        )

    EXPORT_PATH.mkdir(parents=True, exist_ok=True)

    connection = sqlite3.connect(DATABASE_PATH)

    views = pd.read_sql_query(
        """
        SELECT name
        FROM sqlite_master
        WHERE type = 'view'
        ORDER BY name;
        """,
        connection
    )

    if views.empty:
        raise ValueError(
            "No SQL views found in the database. "
            "Run src/run_sql_views.py first."
        )

    export_log = []

    print("Exporting SQL views for Power BI...")
    print(f"Export folder: {EXPORT_PATH}")

    for view_name in views["name"]:
        print("\n" + "=" * 80)
        print(f"Exporting view: {view_name}")

        query = f'SELECT * FROM "{view_name}";'
        df = pd.read_sql_query(query, connection)

        output_file = EXPORT_PATH / f"{view_name}.csv"
        df.to_csv(output_file, index=False)

        export_log.append({
            "view_name": view_name,
            "output_file": output_file.name,
            "rows": df.shape[0],
            "columns": df.shape[1],
            "file_size_mb": round(output_file.stat().st_size / (1024 * 1024), 2)
        })

        print(f"Exported: {output_file.name}")
        print(f"Rows: {df.shape[0]} | Columns: {df.shape[1]}")

    export_log_df = pd.DataFrame(export_log)

    export_log_df.to_csv(
        EXPORT_PATH / "powerbi_export_log.csv",
        index=False
    )

    connection.close()

    print("\nPower BI view exports completed successfully.")
    print("\nExport log:")
    print(export_log_df)


if __name__ == "__main__":
    main()