
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract ContainerWithMostWater {
    function maxArea(int[] memory height) public pure returns (int) {
        uint left = 0;
        uint right = height.length - 1;
        int maxArea = 0;

        while (left < right) {
            int h = int(height[left] < height[right] ? height[left] : height[right]);
            int w = int(right - left);
            int currentArea = h * w;
            if (currentArea > maxArea) {
                maxArea = currentArea;
            }
            if (height[left] < height[right]) {
                left++;
            } else {
                right--;
            }
        }
        return maxArea;
    }
}
