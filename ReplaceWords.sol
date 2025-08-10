// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReplaceWords {
    function replaceWords(string[] memory dictionary, string memory sentence) public pure returns (string memory) {
        // Sort dictionary to ensure shortest roots come first
        quickSort(dictionary, 0, int(dictionary.length - 1));

        // Split sentence into words
        string[] memory words = splitSentence(sentence);
        string[] memory replacedWords = new string[](words.length);

        // Replace words
        for (uint i = 0; i < words.length; i++) {
            string memory shortestReplacement = words[i]; // Default to the word itself
            uint shortestLength = bytes(shortestReplacement).length;

            for (uint j = 0; j < dictionary.length; j++) {
                string memory root = dictionary[j];
                if (startsWith(words[i], root) && bytes(root).length < shortestLength) {
                    shortestReplacement = root;
                    shortestLength = bytes(root).length;
                }
            }

            replacedWords[i] = shortestReplacement;
        }

        // Join words back to form the final sentence
        return joinWords(replacedWords);
    }

    function quickSort(string[] memory arr, int left, int right) internal pure {
        int i = left;
        int j = right;
        if (i == j) return;
        string memory pivot = arr[uint(left + (right - left) / 2)];
        while (i <= j) {
            while (keccak256(bytes(arr[uint(i)])) < keccak256(bytes(pivot))) i++;
            while (keccak256(bytes(arr[uint(j)])) > keccak256(bytes(pivot))) j--;
            if (i <= j) {
                (arr[uint(i)], arr[uint(j)]) = (arr[uint(j)], arr[uint(i)]);
                i++;
                j--;
            }
        }
        if (left < j)
            quickSort(arr, left, j);
        if (i < right)
            quickSort(arr, i, right);
    }

    function splitSentence(string memory sentence) internal pure returns (string[] memory) {
        return split(sentence, " ");
    }

    function split(string memory source, string memory delimiter) internal pure returns(string[] memory) {
        bytes memory sourceBytes = bytes(source);
        uint delimiterLength = bytes(delimiter).length;

        uint wordCount = 1;
        for (uint i = 0; i < sourceBytes.length; i++) {
            if (sourceBytes[i] == delimiter[0]) {
                wordCount++;
            }
        }

        string[] memory splitArray = new string[](wordCount);
        uint256 wordIndex = 0;
        bytes memory word = "";
        for(uint i = 0; i < sourceBytes.length; i++) {
            if (sourceBytes[i] != delimiter[0]) {
                word = abi.encodePacked(word, sourceBytes[i]);
            } else {
                splitArray[wordIndex] = string(word);
                word = "";
                wordIndex++;
            }
        }
        splitArray[wordIndex] = string(word);
        
        return splitArray;
    }

    function startsWith(string memory fullString, string memory prefix) internal pure returns (bool) {
        bytes memory fullStringBytes = bytes(fullString);
        bytes memory prefixBytes = bytes(prefix);
        if (prefixBytes.length > fullStringBytes.length) {
            return false;
        }
        for (uint i = 0; i < prefixBytes.length; i++) {
            if (fullStringBytes[i] != prefixBytes[i]) {
                return false;
            }
        }
        return true;
    }

    function joinWords(string[] memory words) internal pure returns (string memory) {
        string memory sentence = words[0];
        for (uint i = 1; i < words.length; i++) {
            sentence = string(abi.encodePacked(sentence, " ", words[i]));
        }
        return sentence;
    }
}
