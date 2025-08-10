// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract Abs {
    function getAbs(int256 _n) public pure returns (int256 result) {
        if (_n < 0) {
            result = -(_n);
        } else {
            result = _n;
        }
    }
}