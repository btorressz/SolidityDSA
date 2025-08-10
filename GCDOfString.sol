 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GCDOfString {
    // Function to find the greatest common divisor of two strings
    function gcdOfStrings(string memory str1, string memory str2) public pure returns (string memory) {
        // Convert strings to bytes for easier manipulation
        bytes memory b1 = bytes(str1);
        bytes memory b2 = bytes(str2);

        // Use the Euclidean algorithm adapted for strings
        while (b1.length != b2.length) {
            if (b1.length > b2.length) {
                (b1, b2) = (b2, b1); // Ensure b1 is always the shorter string
            }
            // Check if b2 starts with b1
            bool mismatch = false;
            for (uint i = 0; i < b1.length; i++) {
                if (b1[i] != b2[i]) {
                    mismatch = true;
                    break;
                }
            }
            if (mismatch) {
                return ""; // No common divisor if there's a mismatch
            }
            // Reduce the size of the longer string
            b2 = sliceBytes(b2, b1.length, b2.length);
        }

        // After loop, both strings must be equal if they have a common divisor
        return string(b1);
    }

    // Helper function to slice bytes arrays
    function sliceBytes(bytes memory b, uint startIndex, uint endIndex) private pure returns (bytes memory) {
        bytes memory result = new bytes(endIndex - startIndex);
        for (uint i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = b[i];
        }
        return result;
    }
}
