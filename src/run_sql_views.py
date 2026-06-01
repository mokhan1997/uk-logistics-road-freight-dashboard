from pathlib import Path
import sqlite3
import pandas as pd


# Define project paths
PROJECT_ROOT = Path(__file__).resolve().parents[1]
DATABASE_PATH = PROJECT_ROOT / "data" / "processed" / "uk_logistics_road_freight.db"
SQL_FILE_PATH = PROJECT_ROOT / "sql" / "03_views_for_powerbi.sql"


def main():
    """
    Run SQL views against the local SQLite database.
    """

    if not DATABASE_PATH.exists():
        raise FileNotFoundError(
            f"Database not found: {DATABASE_PATH}. "
            "Run src/create_sqlite_database.py first."
        )

    if not SQL_FILE_PATH.exists():
        raise FileNotFoundError(f"SQL file not found: {SQL_FILE_PATH}")

    print("Connecting to SQLite database...")
    print(f"Database path: {DATABASE_PATH}")

    connection = sqlite3.connect(DATABASE_PATH)

    print("Reading SQL views file...")
    sql_script = SQL_FILE_PATH.read_text(encoding="utf-8")

    print("Creating SQL views...")
    connection.executescript(sql_script)

    views = pd.read_sql_query(
        """
        SELECT name
        FROM sqlite_master
        WHERE type = 'view'
        ORDER BY name;
        """,
        connection
    )

    print("\nViews created:")
    print(views)

    print("\nView row counts:")
    for view_name in views["name"]:
        row_count = pd.read_sql_query(
            f'SELECT COUNT(*) AS row_count FROM "{view_name}";',
            connection
        )
        print(f"{view_name}: {row_count.loc[0, 'row_count']} rows")

    connection.close()

    print("\nSQL views created successfully.")


if __name__ == "__main__":
    main()