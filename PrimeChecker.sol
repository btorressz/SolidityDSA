// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PrimeChecker {
    // Function to check if a number is prime
    function isPrime(uint num) public pure returns (bool) {
        if (num <= 1) {
            return false;  // 0 and 1 are not prime numbers
        }
        if (num <= 3) {
            return true;  // 2 and 3 are prime numbers
        }
        if (num % 2 == 0 || num % 3 == 0) {
            return false;  // Exclude multiples of 2 and 3
        }
        for (uint i = 5; i * i <= num; i += 6) {
            if (num % i == 0 || num % (i + 2) == 0) {
                return false;  // Check divisibility starting from 5
            }
        }
        return true;  // If no divisors were found, num is prime
    }
}
