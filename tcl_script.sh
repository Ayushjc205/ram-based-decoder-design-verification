#!/bin/bash

mkdir -p coverage

tests=(
    ram_random_test
    ram_block_boundary_test
    ram_full_sweep_test
    ram_walking1_data_test
    ram_walking0_data_test
    ram_walking1_addr_test
    ram_walking0_addr_test
    ram_same_addr_overwrite_test
    ram_toggle_addr_test
    ram_checkerboard_test
    ram_block_isolation_test
    ram_allzero_test
    ram_allone_test
    ram_read_before_write_test
    ram_constrained_weighted_test
)

echo "========================================="
echo "      STARTING RAM REGRESSION TEST"
echo "========================================="

for test in "${tests[@]}"
do
    echo
    echo "========================================="
    echo "Running Test : $test"
    echo "========================================="

    mkdir -p coverage/$test

    ncverilog \
        -sv \
        +access+rwc \
        -coverage all \
        +assertcover \
        -covworkdir coverage/$test \
        *.sv \
        +TESTNAME=$test

    if [ $? -ne 0 ]; then
        echo "ERROR: $test FAILED"
    else
        echo "$test PASSED"
    fi
done

echo
echo "========================================="
echo "REGRESSION COMPLETE"
echo "========================================="

echo
echo "Coverage databases generated in:"
echo "coverage/"
