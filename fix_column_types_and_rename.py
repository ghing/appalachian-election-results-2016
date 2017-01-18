#!/usr/bin/env python

import csv

import sys
import agate

if __name__ == "__main__":
    column_types = (
        # County
        agate.data_types.text.Text(),
        # State
        agate.data_types.text.Text(),
        # FIPS
        agate.data_types.text.Text(),
        # Total votes
        agate.data_types.number.Number(),
        # Clinton
        agate.data_types.number.Number(),
        # Trump
        agate.data_types.number.Number(),
    )
    data = agate.Table.from_csv(sys.stdin, column_types=column_types)\
        .rename({'a': 'County', 'b': 'State'})
    writer = csv.writer(sys.stdout, quoting=csv.QUOTE_NONNUMERIC)
    header = [c.name for c in data.columns]
    writer.writerow(header)
    for row in data:
        writer.writerow(row)
