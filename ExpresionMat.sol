// SPDX-License-Identifier: BSD-2-Clause
pragma solidity ^0.8.16;

contract ExpresionMat {
    function expressionMatter(int a, int b, int c) public pure returns (int) {
        // Check that inputs are within the specified range
        require(a >= 1 && a <= 10, "a is out of range");
        require(b >= 1 && b <= 10, "b is out of range");
        require(c >= 1 && c <= 10, "c is out of range");

        int[] memory results = new int[](5);
        
        // Calculate all possible combinations
        results[0] = a + b + c; // a + b + c
        results[1] = a * b * c; // a * b * c
        results[2] = a * (b + c); // a * (b + c)
        results[3] = (a + b) * c; // (a + b) * c
        results[4] = a + b * c; // a + (b * c), though not explicit in parentheses, order of operations applies

        // Initialize max as the first result for comparison
        int max = results[0];

        // Iterate over the results to find the maximum value
        for (uint i = 1; i < results.length; i++) {
            if (results[i] > max) {
                max = results[i];
            }
        }

        // Return the maximum result
        return max;
    }
}