// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinaryReducer {
    function reduceBinaryToOne(string memory s) public pure returns (uint) {
        bytes memory b = bytes(s);
        uint steps = 0;

        while (b.length != 1 || b[0] != '1') {
            if (b[b.length - 1] == '0') {
                // Even number, divide by 2
                b = slice(b, 0, b.length - 1);
            } else {
                // Odd number, add 1
                bool carry = true;
                for (int i = int(b.length) - 1; i >= 0; i--) {
                    if (b[uint(i)] == '0') {
                        b[uint(i)] = '1';
                        carry = false;
                        break;
                    } else {
                        b[uint(i)] = '0';
                    }
                }
                if (carry) {
                    // All were '1', extend the array by '1' at the start
                    bytes memory newB = new bytes(b.length + 1);
                    newB[0] = '1';
                    for (uint i = 0; i < b.length; i++) {
                        newB[i + 1] = b[i];
                    }
                    b = newB;
                }
            }
            steps++;
        }

        return steps;
    }

    function slice(bytes memory b, uint start, uint length) private pure returns (bytes memory) {
        bytes memory newB = new bytes(length);
        for (uint i = 0; i < length; i++) {
            newB[i] = b[start + i];
        }
        return newB;
    }
}
