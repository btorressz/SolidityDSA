// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleRequire {
    function subtract(uint256 a, uint256 b) public pure returns (uint256) {
        // Check for overflow
        require(a > b, "Overflow error");
        return a - b;
    }
}
