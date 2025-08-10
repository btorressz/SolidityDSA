// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KthSmallestPrimeFraction {
    struct Fraction {
        uint numerator;
        uint denominator;
        // Utilizing a form of fixed-point arithmetic to store comparison value
        uint sortValue; 
    }

    // Function to find the k-th smallest fraction
    function findKthSmallestFraction(uint[] memory arr, uint k) public pure returns (uint, uint) {
        uint len = arr.length;
        Fraction[] memory fractions = new Fraction[]((len * (len - 1)) / 2);
        uint index = 0;

        // Generate all possible fractions
        for (uint i = 0; i < len; i++) {
            for (uint j = i + 1; j < len; j++) {
                // Store the fraction and its sort value based on a multiplier to avoid decimals
                fractions[index] = Fraction({
                    numerator: arr[i],
                    denominator: arr[j],
                    sortValue: arr[i] * 100000 / arr[j] // Simple fixed-point representation
                });
                index++;
            }
        }

        // Simplistic selection sort to find the k-th element (not efficient for large arrays)
        for (uint i = 0; i < k; i++) {
            for (uint j = i + 1; j < fractions.length; j++) {
                if (fractions[j].sortValue < fractions[i].sortValue) {
                    (fractions[i], fractions[j]) = (fractions[j], fractions[i]);
                }
            }
        }

        // Return the k-th smallest fraction
        return (fractions[k-1].numerator, fractions[k-1].denominator);
    }
}
