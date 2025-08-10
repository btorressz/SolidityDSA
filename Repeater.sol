// SPDX-License-Identifier: BSD-2-Clause
pragma solidity ^0.8.16;

contract Repeater {
  function multiply(uint8 repeat, string memory pattern) public pure returns (string memory) {
    // Initialize an empty string for the result
    bytes memory repeatedString = new bytes(repeat * bytes(pattern).length);

    uint k = 0; // Index for the resulting string
    for (uint i = 0; i < repeat; i++) {
      // Loop over each character in `pattern` and append to `repeatedString`
      for (uint j = 0; j < bytes(pattern).length; j++) {
        repeatedString[k++] = bytes(pattern)[j];
      }
    }

    // Convert `bytes` back to `string` and return
    return string(repeatedString);
  }
}