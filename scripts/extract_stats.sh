awk '
BEGIN {
    print "cycle,current_time,advect_sec,aggregates,percent,max_strain,avg_strain"
}

/Start cycle/ {
    match($0, /Start cycle[[:space:]]+([0-9]+)/, a)
    cycle = a[1]
}

/Current time/ {
    match($0, /Current time = *([^ ,]+)/, a)
    current_time = a[1]
}

/Advection ok/ {
    match($0, /\(([[:space:]]*[0-9.]+)[[:space:]]*sec\)/, a)
    gsub(/^[[:space:]]+/, "", a[1])
    advect_sec = a[1]
}

/Number of aggregates/ { 
    match($0, /= *([0-9]+)/, a)
    aggregates = a[1]
}

/Percentage of aggregates/ {
    match($0, /= *([0-9.]+)[[:space:]]*%/, a)
    percent = a[1]
}

/Maximum strain/ {
    match($0, /= *([^ ]+)/, a)
    max_strain = a[1]
}

/Average strain/ {
    match($0, /= *([^ ]+)/, a)
    avg_strain = a[1]

    printf "%s,%s,%s,%s,%s,%s,%s\n",
        cycle, current_time, advect_sec,
        aggregates, percent, max_strain, avg_strain
}
' $1 > strain_evolution_statistics.csv