// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FizzBuzz {
    // Function to compute the FizzBuzz sequence up to a number n
    function fizzBuzz(uint n) public pure returns (string[] memory) {
        string[] memory output = new string[](n);  // Array to hold the output sequence
        for (uint i = 1; i <= n; i++) {
            // Initialize as an empty string
            string memory result = "";

            // Check for multiples of 3 and 5
            if (i % 3 == 0) {
                result = "Fizz";
            }
            if (i % 5 == 0) {
                result = bytes(result).length > 0 ? string(abi.encodePacked(result, "Buzz")) : "Buzz";
            }

            // If the result is still empty, use the number itself
            if (bytes(result).length == 0) {
                result = uintToString(i);
            }

            // Assign the result to the output array
            output[i-1] = result;
        }
        return output;
    }

    // Helper function to convert uint to string
    function uintToString(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k = k-1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
}
