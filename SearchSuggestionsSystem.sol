// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SearchSuggestionsSystem {
    // Function to simulate the search suggestion system
    function searchSuggestions(string[] memory products, string memory searchWord)
        public
        pure
        returns (string[][] memory)
    {
        // Assume products are sorted lexicographically already
        uint len = bytes(searchWord).length;
        string[][] memory results = new string[][](len);
        
        for (uint i = 0; i < len; i++) {
            // Create a prefix of the searchWord up to the i-th character
            string memory prefix = substring(searchWord, 0, i + 1);
            uint count = 0;

            // Array to hold up to 3 matches
            string[] memory matches = new string[](3);
            
            for (uint j = 0; j < products.length && count < 3; j++) {
                // Check if the product starts with the prefix
                if (startsWith(products[j], prefix)) {
                    matches[count] = products[j];
                    count++;
                }
            }

            // Store only the found matches in the results array
            string[] memory temp = new string[](count);
            for (uint k = 0; k < count; k++) {
                temp[k] = matches[k];
            }
            results[i] = temp;
        }
        
        return results;
    }

    // Helper function to check if a string starts with a given prefix
    function startsWith(string memory str, string memory prefix) private pure returns (bool) {
        bytes memory strBytes = bytes(str);
        bytes memory prefixBytes = bytes(prefix);
        if (strBytes.length < prefixBytes.length) {
            return false;
        }
        for (uint i = 0; i < prefixBytes.length; i++) {
            if (strBytes[i] != prefixBytes[i]) {
                return false;
            }
        }
        return true;
    }

    // Helper function to get a substring from start to end
    function substring(string memory str, uint startIndex, uint endIndex) private pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex - startIndex);
        for (uint i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = strBytes[i];
        }
        return string(result);
    }
}
