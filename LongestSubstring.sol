
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LongestSubstring {
    // Function to find the length of the longest substring without repeating characters
    function lengthOfLongestSubstring(string memory s) public pure returns (uint) {
        bytes memory strBytes = bytes(s);
        uint n = strBytes.length;

        // Array to store the last index of every character seen so far
        // We use 256 to cover all ASCII characters
        uint[256] memory lastSeen;
        
        uint maxLength = 0;
        uint left = 0;

        for (uint right = 0; right < n; right++) {
            bytes1 currentChar = strBytes[right];
            uint asciiIndex = uint(uint8(currentChar)); // Convert character to its ASCII index

            // If the character is found in the array and its index is within the current window
            if (lastSeen[asciiIndex] != 0 && lastSeen[asciiIndex] > left) {
                left = lastSeen[asciiIndex]; // Move the left side of the window
            }

            // Update or add the current character's position to the array
            lastSeen[asciiIndex] = right + 1; // Store indices as 1-based to distinguish from default 0
            maxLength = max(maxLength, right - left + 1);
        }

        return maxLength;
    }

    // Helper function to determine the maximum of two numbers
    function max(uint a, uint b) private pure returns (uint) {
        return a > b ? a : b;
    }
}


/*pragma solidity ^0.8.0;

contract LongestSubstring {
    // Function to find the length of the longest substring without repeating characters
    function lengthOfLongestSubstring(string memory s) public pure returns (uint) {
        bytes memory strBytes = bytes(s);
        uint n = strBytes.length;
        
        // This will store the last index of every character seen so far.
        mapping(bytes1 => uint) memory indexMap;
        uint maxLength = 0;
        uint left = 0;

        for (uint right = 0; right < n; right++) {
            bytes1 currentChar = strBytes[right];

            // If the character is found in the map and its index is within the current window
            if (indexMap[currentChar] != 0 && indexMap[currentChar] > left) {
                left = indexMap[currentChar]; // move the left side of the window
            }

            // Update or add the current character's position to the map
            indexMap[currentChar] = right + 1; // store indices as 1-based to distinguish from default 0
            maxLength = max(maxLength, right - left + 1);
        }

        return maxLength;
    }

    // Helper function to determine the maximum of two numbers
    function max(uint a, uint b) private pure returns (uint) {
        return a > b ? a : b;
    }
}
*/