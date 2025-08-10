// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeStringsAlternately {
    function mergeAlternately(string memory word1, string memory word2) public pure returns (string memory) {
        bytes memory b1 = bytes(word1);
        bytes memory b2 = bytes(word2);
        bytes memory merged = new bytes(b1.length + b2.length);
        uint i = 0;
        uint j = 0;
        uint k = 0;

        // Merge characters alternately
        while (i < b1.length && j < b2.length) {
            merged[k++] = b1[i++];
            merged[k++] = b2[j++];
        }

        // Append the remainder of the longer string
        while (i < b1.length) {
            merged[k++] = b1[i++];
        }
        while (j < b2.length) {
            merged[k++] = b2[j++];
        }

        return string(merged);
    }
}
