// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WaterBottles {
    // Function to calculate the total number of bottles you can drink
    function totalBottles(int numBottles, int numExchange) public pure returns (int) {
        int totalDrank = 0;
        int currentFull = numBottles;
        int emptyBottles = 0;

        while (currentFull > 0) {
            // Drink all full bottles
            totalDrank += currentFull;
            
            // All current full bottles become empty
            emptyBottles += currentFull;
            
            // Exchange empty bottles for new full bottles
            currentFull = emptyBottles / numExchange;
            
            // Update the number of empty bottles left after exchange
            emptyBottles %= numExchange;
        }

        return totalDrank;
    }
}
