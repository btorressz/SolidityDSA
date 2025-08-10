// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Fibonacci {
    // Function to return the nth Fibonacci number using an iterative approach
    function fibonacciIterative(uint n) public pure returns (uint) {
        if (n == 0) return 0;
        if (n == 1) return 1;

        uint previous = 0;
        uint current = 1;
        uint next;

        for (uint i = 2; i <= n; i++) {
            next = previous + current;
            previous = current;
            current = next;
        }

        return current;
    }
}
