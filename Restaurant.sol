// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Restaurant {
    struct Customer {
        uint arrival;
        uint time;
    }

    // Calculate total waiting time and the number of customers
    function calculateWaitingTime(Customer[] memory customers) public pure returns (uint totalWaitingTime, uint count) {
        uint currentEnd = 0;

        for (uint i = 0; i < customers.length; i++) {
            uint arrival = customers[i].arrival;
            uint time = customers[i].time;

            // Chef starts preparing food once he's idle or when the customer arrives, whichever is later
            uint start = currentEnd > arrival ? currentEnd : arrival;
            currentEnd = start + time;

            // Waiting time is the time when the chef finishes minus the arrival time
            totalWaitingTime += currentEnd - arrival;
        }

        count = customers.length;
        return (totalWaitingTime, count);
    }
}
