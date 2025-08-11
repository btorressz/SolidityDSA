// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UniqueCharacters {
    // Function to check if a string has all unique characters
    function hasAllUniqueCharacters(string memory str) public pure returns (bool) {
        bytes memory strBytes = bytes(str);
        if (strBytes.length > 256) {
            return false; // More characters than the total number of unique ASCII values
        }

        bool[256] memory charSet;
        for (uint i = 0; i < strBytes.length; i++) {
            uint8 charIndex = uint8(strBytes[i]);
            if (charSet[charIndex]) {
                return false; // Character already encountered
            }
            charSet[charIndex] = true;
        }

        return true;
    }
}
