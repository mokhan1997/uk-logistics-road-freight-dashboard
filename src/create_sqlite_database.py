from pathlib import Path
import re
import sqlite3
import pandas as pd


# Define project paths
PROJECT_ROOT = Path(__file__).resolve().parents[1]
PROCESSED_DATA_PATH = PROJECT_ROOT / "data" / "processed"
DATABASE_PATH = PROCESSED_DATA_PATH / "uk_logistics_road_freight.db"


def clean_table_name(file_name: str) -> str:
    """
    Convert a CSV file name into a safe SQLite table name.
    """
    name = Path(file_name).stem.lower()
    name = re.sub(r"[^a-z0-9]+", "_", name)
    name = re.sub(r"_+", "_", name)
    name = name.strip("_")

    if not name:
        name = "table_unknown"

    if name[0].isdigit():
        name = f"table_{name}"

    return name


def main():
    """
    Create a SQLite database from all processed CSV files.
    """

    if not PROCESSED_DATA_PATH.exists():
        raise FileNotFoundError(f"Processed data folder not found: {PROCESSED_DATA_PATH}")

    csv_files = sorted([
        file for file in PROCESSED_DATA_PATH.iterdir()
        if file.is_file() and file.suffix.lower() == ".csv"
    ])

    if not csv_files:
        raise FileNotFoundError(
            "No processed CSV files found. Run notebooks/02_data_cleaning.ipynb first."
        )

    print("Creating SQLite database...")
    print(f"Database path: {DATABASE_PATH}")
    print(f"Processed CSV files found: {len(csv_files)}")

    connection = sqlite3.connect(DATABASE_PATH)

    catalog_rows = []
    used_table_names = set()

    for file in csv_files:
        print("\n" + "=" * 80)
        print(f"Loading file: {file.name}")

        try:
            df = pd.read_csv(file, low_memory=False)

            base_table_name = clean_table_name(file.name)
            table_name = base_table_name

            counter = 1
            while table_name in used_table_names:
                counter += 1
                table_name = f"{base_table_name}_{counter}"

            used_table_names.add(table_name)

            df.to_sql(
                table_name,
                connection,
                if_exists="replace",
                index=False
            )

            catalog_rows.append({
                "table_name": table_name,
                "source_file": file.name,
                "rows": df.shape[0],
                "columns": df.shape[1],
                "file_size_mb": round(file.stat().st_size / (1024 * 1024), 2),
                "column_names": ", ".join(df.columns.astype(str).tolist()[:20])
            })

            print(f"Created table: {table_name}")
            print(f"Rows: {df.shape[0]} | Columns: {df.shape[1]}")

        except Exception as error:
            catalog_rows.append({
                "table_name": "ERROR",
                "source_file": file.name,
                "rows": None,
                "columns": None,
                "file_size_mb": round(file.stat().st_size / (1024 * 1024), 2),
                "column_names": str(error)
            })

            print(f"Could not load file: {file.name}")
            print(f"Error: {error}")

    catalog_df = pd.DataFrame(catalog_rows)

    catalog_df.to_sql(
        "database_table_catalog",
        connection,
        if_exists="replace",
        index=False
    )

    catalog_df.to_csv(
        PROCESSED_DATA_PATH / "database_table_catalog.csv",
        index=False
    )

    tables = pd.read_sql_query(
        """
        SELECT name
        FROM sqlite_master
        WHERE type = 'table'
        ORDER BY name;
        """,
        connection
    )

    print("\n" + "=" * 80)
    print("Tables created:")
    print(tables)

    print("\nRow counts:")
    for table_name in tables["name"]:
        row_count = pd.read_sql_query(
            f'SELECT COUNT(*) AS row_count FROM "{table_name}";',
            connection
        )
        print(f"{table_name}: {row_count.loc[0, 'row_count']} rows")

    connection.close()

    print("\nSQLite database created successfully.")
    print("Database table catalog exported locally.")


if __name__ == "__main__":
    main()