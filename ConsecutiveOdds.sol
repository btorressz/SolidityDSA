// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ConsecutiveOdds {
    // Function to check for three consecutive odd numbers in an array
    function hasThreeConsecutiveOdds(uint[] memory arr) public pure returns (bool) {
        // If the array has less than 3 elements, it's impossible to have three consecutive odds
        if (arr.length < 3) {
            return false;
        }
        
        // Check each set of three consecutive numbers
        for (uint i = 0; i <= arr.length - 3; i++) {
            if (isOdd(arr[i]) && isOdd(arr[i + 1]) && isOdd(arr[i + 2])) {
                return true;
            }
        }
        
        return false; // If no three consecutive odds were found
    }
    
    // Helper function to determine if a number is odd
    function isOdd(uint num) private pure returns (bool) {
        return num % 2 == 1;
    }
}
