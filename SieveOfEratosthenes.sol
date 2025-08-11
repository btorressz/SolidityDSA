// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SieveOfEratosthenes {
    // Function to execute the Sieve of Eratosthenes
    function findPrimes(uint n) public pure returns (bool[] memory) {
        require(n > 1, "Enter a number greater than 1.");

        bool[] memory isPrime = new bool[](n + 1); // Array to keep track of prime statuses
        for (uint i = 2; i <= n; i++) {
            isPrime[i] = true; // Initialize all indices > 1 as true
        }

        // Implement the Sieve of Eratosthenes
        for (uint p = 2; p * p <= n; p++) {
            if (isPrime[p] == true) {
                // Marking multiples of p as false indicating not prime
                for (uint i = p * p; i <= n; i += p) {
                    isPrime[i] = false;
                }
            }
        }

        return isPrime; // This array will hold the primality status of each number up to n
    }
}
