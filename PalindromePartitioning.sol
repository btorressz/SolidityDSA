// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalindromePartitioning {
    // Event to emit the results because returning a 2D dynamic array from a function is not straightforward in Solidity
    event PartitionResult(string[] partition);

    // Main function to find all palindromic partitions
    function findAllPartitions(string memory s) public {
        string[] memory path = new string[](bytes(s).length);
        findPartitions(s, 0, path, 0);
    }

    // Helper function to recursively find partitions
    function findPartitions(string memory s, uint start, string[] memory path, uint index) private {
        // If the start index reaches the string's length, we found a valid partition
        if (start == bytes(s).length) {
            string[] memory validPartition = new string[](index);
            for (uint i = 0; i < index; i++) {
                validPartition[i] = path[i];
            }
            emit PartitionResult(validPartition);
            return;
        }

        // Try every possible end index for the substring starting from 'start'
        for (uint end = start; end < bytes(s).length; end++) {
            if (isPalindrome(s, start, end)) {
                path[index] = substring(s, start, end + 1);
                findPartitions(s, end + 1, path, index + 1);
            }
        }
    }

    // Check if the substring s[start...end] is a palindrome
    function isPalindrome(string memory s, uint start, uint end) private pure returns (bool) {
        bytes memory sBytes = bytes(s);
        while (start < end) {
            if (sBytes[start] != sBytes[end]) {
                return false;
            }
            start++;
            end--;
        }
        return true;
    }

    // Extracts a substring from string s from start index to end index (exclusive)
    function substring(string memory s, uint start, uint end) private pure returns (string memory) {
        bytes memory stringBytes = bytes(s);
        bytes memory result = new bytes(end - start);
        for (uint i = start; i < end; i++) {
            result[i - start] = stringBytes[i];
        }
        return string(result);
    }
}
