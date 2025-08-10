// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CountTriplets {
    function countTriplets(uint[] memory arr) public pure returns (uint) {
        uint n = arr.length;
        uint[] memory prefix = new uint[](n + 1);
        mapping(uint => uint) counts;
        mapping(uint => uint) total;

        uint result = 0;
        
        // Compute the prefix XOR
        for (uint i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] ^ arr[i];
        }

        // Count triplets
        for (uint k = 0; k < n; k++) {
            if (counts[prefix[k + 1]] > 0) {
                result += counts[prefix[k + 1]] * k - total[prefix[k + 1]];
            }
            counts[prefix[k]]++;
            total[prefix[k]] += k;
        }

        return result;
    }
}
