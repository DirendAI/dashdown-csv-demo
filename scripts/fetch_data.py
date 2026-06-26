#!/usr/bin/env python3
"""Fetch the Datablist sample CSVs this dashboard runs on.

The files are large — the 2,000,000-row customers CSV is ~333 MB uncompressed,
above GitHub's 100 MB per-file limit — so they are **not** committed to the repo.
This script downloads them on demand (locally and in CI) into ``data/``.

Source: https://github.com/datablist/sample-csv-files (links are Google Drive
ids). Some links serve a zip archive; we detect the ``PK`` magic and extract the
single CSV inside transparently.

Usage:  python scripts/fetch_data.py
It is idempotent — a dataset that already exists in ``data/`` is left untouched.
"""
from __future__ import annotations

import shutil
import sys
import zipfile
from pathlib import Path

import gdown

DATA = Path(__file__).resolve().parent.parent / "data"

# view name -> (Google Drive id, human label).  Sizes: customers ~2M rows /
# 333 MB, organizations & products ~1M rows / 135 MB & 155 MB.
FILES: dict[str, tuple[str, str]] = {
    "customers.csv":     ("1IXQDp8Um3d-o7ysZLxkDyuvFj9gtlxqz", "customers (2,000,000 rows)"),
    "organizations.csv": ("1uaUCN5vAMVz73RgfJykJzzlIq2yQTlYB", "organizations (1,000,000 rows)"),
    "products.csv":      ("1u5t7wfkWDW4W2TYJDuh1m0pa-7E0_Sr3", "products (1,000,000 rows)"),
}


def fetch(target: str, file_id: str, label: str) -> None:
    dest = DATA / target
    if dest.exists() and dest.stat().st_size > 0:
        print(f"✓ {target} already present ({dest.stat().st_size / 1e6:.0f} MB) — skipping")
        return

    print(f"↓ downloading {label} → {target}")
    tmp = DATA / (target + ".download")
    gdown.download(id=file_id, output=str(tmp), quiet=False)

    # Some Drive links serve a zip; extract the single CSV inside if so.
    with open(tmp, "rb") as fh:
        is_zip = fh.read(2) == b"PK"
    if is_zip:
        with zipfile.ZipFile(tmp) as z:
            inner = z.namelist()[0]
            with z.open(inner) as src, open(dest, "wb") as out:
                shutil.copyfileobj(src, out)
        tmp.unlink()
    else:
        tmp.rename(dest)

    print(f"✓ {target} ready ({dest.stat().st_size / 1e6:.0f} MB)")


def main() -> int:
    DATA.mkdir(parents=True, exist_ok=True)
    for target, (file_id, label) in FILES.items():
        fetch(target, file_id, label)
    print("\nAll datasets ready in", DATA)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
