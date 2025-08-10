// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeIntervals {
    struct Interval {
        uint start;
        uint end;
    }

    // Function to merge intervals
    function merge(Interval[] memory intervals) public pure returns (Interval[] memory) {
        if (intervals.length <= 1) {
            return intervals;
        }

        // Sort intervals by the start time
        sort(intervals);

        Interval[] memory merged = new Interval[](intervals.length);
        uint count = 0;

        // Initialize the first interval as the current interval to be merged
        merged[count] = intervals[0];

        for (uint i = 1; i < intervals.length; i++) {
            Interval memory current = intervals[i];
            // Check if the current interval overlaps with the last added interval
            if (current.start <= merged[count].end) {
                // If it overlaps, merge the current interval with the last added interval
                merged[count].end = max(merged[count].end, current.end);
            } else {
                // If not overlapping, add the current interval as new and move to the next
                count++;
                merged[count] = current;
            }
        }

        // Resize the merged array to the correct count
        Interval[] memory finalMerged = new Interval[](count + 1);
        for (uint i = 0; i <= count; i++) {
            finalMerged[i] = merged[i];
        }

        return finalMerged;
    }

    // Helper function to perform the sort (using bubble sort for simplicity)
    function sort(Interval[] memory intervals) internal pure {
        bool swapped;
        do {
            swapped = false;
            for (uint i = 1; i < intervals.length; i++) {
                if (intervals[i - 1].start > intervals[i].start) {
                    (intervals[i - 1], intervals[i]) = (intervals[i], intervals[i - 1]);
                    swapped = true;
                }
            }
        } while (swapped);
    }

    // Helper function to find the maximum of two numbers
    function max(uint a, uint b) private pure returns (uint) {
        return a > b ? a : b;
    }
}
