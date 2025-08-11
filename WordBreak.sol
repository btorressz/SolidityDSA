// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WordBreak {
    // Check if the string can be segmented into the words from the dictionary
function canSegment(string memory s, string[] memory wordDict) public pure returns (bool) {
        bytes memory sBytes = bytes(s);
        bool[] memory dp = new bool[](sBytes.length + 1);
        dp[0] = true;

        for (uint i = 1; i <= sBytes.length; i++) {
            for (uint j = 0; j < i; j++) {
                if (dp[j] && isInDict(subBytesToString(sBytes, j, i), wordDict)) {
                    dp[i] = true;
                    break;
                }
            }
        }

        return dp[sBytes.length];
    }

    // Helper function to convert a portion of bytes array to string
    function subBytesToString(bytes memory sBytes, uint start, uint end) private pure returns (string memory) {
        bytes memory result = new bytes(end - start);
        for (uint i = start; i < end; i++) {
            result[i - start] = sBytes[i];
        }
        return string(result);
    }

    // Helper function to check if a word is in the dictionary
    function isInDict(string memory word, string[] memory dict) private pure returns (bool) {
        for (uint i = 0; i < dict.length; i++) {
            if (keccak256(bytes(word)) == keccak256(bytes(dict[i]))) {
                return true;
            }
        }
        return false;
    }
}
