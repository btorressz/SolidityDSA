// SPDX-License-Identifier: MIT
//Successful attempt 
pragma solidity ^0.8.0;

contract ChemicalFormula {
    string private formula;
    mapping(string => uint) private elementCounts;

    function setFormula(string memory _formula) public {
        formula = _formula;
    }

    function parseFormula() public returns (string memory) {
        bytes memory input = bytes(formula);
        uint i = 0;
        uint n = input.length;

        while (i < n) {
            // Parse element name
            string memory element = parseElement(input, i, n);
            i += bytes(element).length;

            // Parse element count
            uint count = parseCount(input, i, n);
            i += countDigits(count);

            // Update element count in mapping
            elementCounts[element] += count;
        }

        return buildResult();
    }

    function parseElement(bytes memory input, uint i, uint n) private pure returns (string memory) {
        string memory element;
        while (i < n && isLowerCase(input[i])) {
            element = string(abi.encodePacked(element, input[i]));
            i++;
        }
        return element;
    }

    function parseCount(bytes memory input, uint i, uint n) private pure returns (uint) {
        uint count = 0;
        while (i < n && isDigit(input[i])) {
            count = count * 10 + (uint8(input[i]) - uint8(bytes1('0')));
            i++;
        }
        return count == 0 ? 1 : count;
    }

    function countDigits(uint number) private pure returns (uint) {
        uint digits = 0;
        while (number != 0) {
            number /= 10;
            digits++;
        }
        return digits;
    }

    function isLowerCase(bytes1 b) private pure returns (bool) {
        return (b >= 'a' && b <= 'z');
    }

    function isDigit(bytes1 b) private pure returns (bool) {
        return (b >= '0' && b <= '9');
    }

    function buildResult() private view returns (string memory) {
        string memory result;
        for (uint i = 0; i < bytes(formula).length; i++) {
            bytes1 b = bytes(formula)[i];
            if (isLowerCase(b)) {
                result = string(abi.encodePacked(result, b));
            }
        }
        return result;
    }

    function getElementCount(string memory element) public view returns (uint) {
        return elementCounts[element];
    }
}

/* // ATTEMPT #1 
pragma solidity ^0.8.0;

contract ChemicalFormula {
    struct ElementCount {
        string element;
        uint count;
    }
     //   string private formula; // Declare and initialize it somewhere else in your contract.


    function isLowerCase(uint8 b) private pure returns (bool) {

        bytes memory input = bytes(formula); //DeclarationError: Undeclared identifier.
 // --> contracts/ChemicalFormula.sol:14:36:
 //  |
//14 |         bytes memory input = bytes(formula);
 //  |                                    ^^^^^^^

        uint n = input.length;
        uint i = 0;
        mapping (string => uint) storage counts;
        string[] memory stack = new string[](n);  // Stack to handle nested parentheses
        uint stackSize = 0;

        while (i < n) {
            if (input[i] == '(') {
                stack[stackSize++] = "(";
                i++;
            } else if (input[i] == ')') {
                i++;
                // Extract multiplier if any
                uint multiplier = 0;
                while (i < n && isDigit(input[i])) {
                    multiplier = multiplier * 10 + (uint8(input[i]) - uint8('0'));
                    i++;
                }
                multiplier = multiplier == 0 ? 1 : multiplier;

                // Pop from stack until '(' and multiply counts
                uint startIndex = stackSize;
                while (keccak256(bytes(stack[startIndex-1])) != keccak256(bytes("("))) {
                    startIndex--;
                }
                for (uint j = startIndex; j < stackSize; j++) {
                    string memory element = stack[j];
                    counts[element] *= multiplier;
                }
                stackSize = startIndex;  // Reset stack to '(' position
            } else {
                // Parse element and its count
                string memory element = "";
                element = string(abi.encodePacked(element, input[i]));
                i++;
                while (i < n && isLowerCase(input[i])) {
                    element = string(abi.encodePacked(element, input[i]));
                    i++;
                }
                uint count = 0;
                while (i < n && isDigit(input[i])) {
                    count = count * 10 + (uint8(input[i]) - uint8('0'));
                    i++;
                }
                count = count == 0 ? 1 : count;
                counts[element] += count;
                stack[stackSize++] = element;  // Push element to stack
            }
        }

        // Construct the result string from counts
        string memory result = "";
        string[] memory keys = new string[](stackSize);
        uint keysCount = 0;
        for (uint k = 0; k < stackSize; k++) {
            if (counts[stack[k]] > 0) {
                keys[keysCount++] = stack[k];
            }
        }
        sort(keys, keysCount);  // Sort keys alphabetically

        for (uint k = 0; k < keysCount; k++) {
            string memory key = keys[k];
            result = string(abi.encodePacked(result, key));
            if (counts[key] > 1) {
                result = string(abi.encodePacked(result, uintToString(counts[key])));
            }
        }

        return result;
    }

    function isLowerCase(uint8 b) public pure returns (bool) {
        return b >= 'a' && b <= 'z';
    }

    function isDigit(bytes1 b) public pure returns (bool) {
        return b >= '0' && b <= '9';
    }

    // Sort strings alphabetically (simple insertion sort for demonstration)
    function sort(string[] memory array, uint size) private pure {
        for (uint i = 1; i < size; i++) {
            string memory key = array[i];
            uint j = i;
            while (j > 0 && keccak256(bytes(array[j - 1])) > keccak256(bytes(key))) {
                array[j] = array[j - 1];
                j--;
            }
            array[j] = key;
        }
    }

    function uintToString(uint v) private pure returns (string memory str) {
        if (v == 0) {
            return "0";
        }
        uint maxlength = 100;
        bytes memory reversed = new bytes(maxlength);
        uint i = 0;
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[i++] = bytes1(uint8(48 + remainder));
        }
        bytes memory s = new bytes(i);  // i is the length of the final string
        for (uint j = 0; j < i; j++) {
            s[j] = reversed[i - j - 1];  // reverse the string
        }
        str = string(s);
    }
}
*/