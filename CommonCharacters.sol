// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CommonCharacters {
    function findCommonCharacters(string[] memory words) public pure returns (string memory) {
        // Initialize min frequency array with large number assuming max word length is 100
        uint[26] memory minFreq;
        for (uint i = 0; i < 26; i++) {
            minFreq[i] = 100;
        }

        // Process each word to update min frequencies
        for (uint i = 0; i < words.length; i++) {
            uint[26] memory freq = getFrequency(bytes(words[i]));
            for (uint j = 0; j < 26; j++) {
                if (freq[j] < minFreq[j]) {
                    minFreq[j] = freq[j];
                }
            }
        }

        // Build the result string based on minimum frequencies
        bytes memory result;
        for (uint i = 0; i < 26; i++) {
            bytes1 char = bytes1(uint8(i + uint8(97)));
            for (uint j = 0; j < minFreq[i]; j++) {
                 return string(result);
            }
        }

        return string(result);
    }

    // Helper function to count frequency of each character in a word
    function getFrequency(bytes memory word) private pure returns (uint[26] memory freq) {
        for (uint i = 0; i < word.length; i++) {
            uint index = uint(uint8(word[i]) - 97); // 'a' is ASCII 97
            freq[index]++;
        }
    }
}
/*Warning: Unreachable code.
  --> contracts/CommonCharacters.sol:26:46:
   |
26 |             for (uint j = 0; j < minFreq[i]; j++) {
   |                                              ^^^
   Warning: Unused local variable.
  --> contracts/CommonCharacters.sol:25:13:
   |
25 |             bytes1 char = bytes1(uint8(i + uint8(97)));
   |             ^^^^^^^^^^^

*/
