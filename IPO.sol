// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IPO {
    struct Project {
        uint profit;
        uint capitalRequired;
    }

    function maximizeCapital(uint k, uint initialCapital, uint[] memory profits, uint[] memory capital) public pure returns (uint) {
        uint n = profits.length;
        Project[] memory projects = new Project[](n);

        // Populate the projects array
        for (uint i = 0; i < n; i++) {
            projects[i] = Project(profits[i], capital[i]);
        }

        uint currentCapital = initialCapital;

        // Main loop to select projects up to k times
        for (uint i = 0; i < k; i++) {
            int selectedProjectIndex = -1;
            uint maxProfit = 0;

            // Select the project with the maximum profit that can be started with the current capital
            for (uint j = 0; j < n; j++) {
                if (projects[j].capitalRequired <= currentCapital && projects[j].profit > maxProfit) {
                    selectedProjectIndex = int(j);
                    maxProfit = projects[j].profit;
                }
            }

            // If no project is selectable, break the loop
            if (selectedProjectIndex == -1) {
                break;
            }

            // Add the profit from the selected project to the capital
            currentCapital += maxProfit;

            // Mark the selected project as no longer available by setting its profit to 0
            projects[uint(selectedProjectIndex)].profit = 0;
        }

        return currentCapital;
    }
}
