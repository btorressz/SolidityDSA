// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BalloonBurst {
    // Function to return the minimum number of arrows to burst all balloons
    function findMinArrows(int[][] memory points) public pure returns (uint) {
        if (points.length == 0) return 0;

        // Sort the intervals based on their end values
        quickSort(points, 0, int(points.length - 1));

        int arrows = 1;  // Start with one arrow
        int arrowPosition = points[0][1];  // Position to shoot the first arrow

        // Iterate through the sorted balloon intervals
        for (uint i = 1; i < points.length; i++) {
            // If the start of the next balloon is greater than where the last arrow was shot
            if (points[i][0] > arrowPosition) {
                arrows++;  // Need another arrow
                arrowPosition = points[i][1];  // Update the arrow position to the end of the current balloon
            }
        }

        return arrows;
    }

    // Quick sort implementation to sort intervals based on their end values
    function quickSort(int[][] memory arr, int left, int right) internal pure {
        int i = left;
        int j = right;
        if (i == j) return;
        int pivot = arr[uint(left + (right - left) / 2)][1];
        while (i <= j) {
            while (arr[uint(i)][1] < pivot) i++;
            while (pivot < arr[uint(j)][1]) j--;
            if (i <= j) {
                (arr[uint(i)], arr[uint(j)]) = (arr[uint(j)], arr[uint(i)]);
                i++;
                j--;
            }
        }
        if (left < j)
            quickSort(arr, left, j);
        if (i < right)
            quickSort(arr, i, right);
    }
}
