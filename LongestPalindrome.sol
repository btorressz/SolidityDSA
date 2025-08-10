/ SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LongestPalindrome {
    function longestPalindrome(string memory s) public pure returns (uint) {
        // Use a mapping to count occurrences of each character
        mapping(bytes1 => uint) freq;
        bytes memory b = bytes(s);
        uint n = b.length;

        // Count each character
        for (uint i = 0; i < n; i++) {
            freq[b[i]]++;
        }

        uint length = 0;
        bool hasOdd = false;

        // Calculate the length of the longest palindrome
        for (uint i = 0; i < 256; i++) {  // Iterate through possible ASCII values
            bytes1 char = bytes1(uint8(i));
            uint count = freq[char];

            if (count == 0) continue;

            if (count % 2 == 0) {
                length += count;
            } else {
                length += count - 1;  // Add the largest even number less than count
                hasOdd = true;
            }
        }

        // If there was any odd count, add one character to the center of the palindrome
        if (hasOdd) {
            length += 1;
        }

        return length;
    }
}

