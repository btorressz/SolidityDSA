// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReversePrefix {
    // Function to reverse the prefix of the word up to and including the first occurrence of ch
    function reversePrefix(string memory word, bytes1 ch) public pure returns (string memory) {
        bytes memory strBytes = bytes(word);
        int idx = -1;

        // Find the first occurrence of the character ch
        for (uint i = 0; i < strBytes.length; i++) {
            if (strBytes[i] == ch) {
                idx = int(i);
                break;
            }
        }

        // If the character ch is not found, return the original word
        if (idx == -1) {
            return word;
        }

        // Reverse the substring from 0 to idx (inclusive)
        for (uint i = 0; i <= uint(idx) / 2; i++) {
            bytes1 temp = strBytes[i];
            strBytes[i] = strBytes[uint(idx) - i];
            strBytes[uint(idx) - i] = temp;
        }

        return string(strBytes);
    }
}
