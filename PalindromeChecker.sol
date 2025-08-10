// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalindromeChecker {
    // Function to check if the provided string is a palindrome
    function isPalindrome(string memory text) public pure returns (bool) {
        bytes memory textBytes = bytes(text);  // Convert string to bytes for manipulation
        uint len = textBytes.length;

        // Only need to check up to the middle of the string
        for (uint i = 0; i < len / 2; i++) {
            if (textBytes[i] != textBytes[len - i - 1]) {
                return false;  // Early return if any mismatch is found
            }
        }

        return true;  // If no mismatches are found, it's a palindrome
    }
}
