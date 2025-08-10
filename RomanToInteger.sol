// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanToInteger {
    mapping(string => uint) romanValues;

    constructor() {
        romanValues["I"] = 1;
        romanValues["V"] = 5;
        romanValues["X"] = 10;
        romanValues["L"] = 50;
        romanValues["C"] = 100;
        romanValues["D"] = 500;
        romanValues["M"] = 1000;
    }

    function romanToInt(string memory s) public view returns (uint) {
        bytes memory romans = bytes(s);

        uint integer = 0;
        for (uint i = 0; i < romans.length; i++) {
            uint value = romanValues[string(abi.encodePacked(romans[i]))];
            if (i + 1 < romans.length && value < romanValues[string(abi.encodePacked(romans[i + 1]))]) {
                integer -= value;
            } else {
                integer += value;
            }
        }
        return integer;
    }
}
