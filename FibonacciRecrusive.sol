// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FibonacciRecrusive {
    // Function to return the nth Fibonacci number using a recursive approach
    function fibonacciRecursive(uint n) public pure returns (uint) {
        if (n == 0) return 0;
        if (n == 1) return 1;
        return fibonacciRecursive(n - 1) + fibonacciRecursive(n - 2);
    }
}
