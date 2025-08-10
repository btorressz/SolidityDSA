// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RobotCollisions {
    struct Robot {
        int position;
        uint health;
        bool isRight;
    }

    // Main function to determine the health of the robots after all collisions
    function finalRobotHealths(int[] memory positions, uint[] memory healths, string memory directions) public pure returns (uint[] memory) {
        uint n = positions.length;
        Robot[] memory robots = new Robot[](n);
        uint[] memory survivors = new uint[](n); // Track the health of survivors by their original index

        // Initialize the robots array
        for (uint i = 0; i < n; i++) {
            robots[i] = Robot({
                position: positions[i],
                health: healths[i],
                isRight: bytes(directions)[i] == 'R'
            });
            survivors[i] = healths[i]; // Initialize with original healths
        }

        // Sort robots by position to simulate collisions
        sortRobots(robots);

        // Array to track active robots
        uint[] memory active = new uint[](n);
        uint activeCount = 0;

        // Initialize active robots
        for (uint i = 0; i < n; i++) {
            // Process collisions
            while (activeCount > 0 && ((robots[i].isRight && !robots[active[activeCount - 1]].isRight) || (robots[i].position == robots[active[activeCount - 1]].position))) {
                uint last = active[activeCount - 1];
                if (robots[i].position == robots[last].position) { // Same position, different directions
                    if (robots[i].health == robots[last].health) {
                        // Both die
                        survivors[last] = 0;
                        survivors[i] = 0;
                        activeCount--;
                    } else if (robots[i].health > robots[last].health) {
                        // i survives, last dies
                        survivors[last] = 0;
                        robots[i].health -= robots[last].health;
                        activeCount--;
                    } else {
                        // last survives, i dies
                        survivors[i] = 0;
                        robots[last].health -= robots[i].health;
                        break;
                    }
                } else {
                    // No more collisions possible
                    break;
                }
            }
            if (survivors[i] > 0) {
                active[activeCount++] = i; // Add to active list if still alive
            }
        }

        // Filter and return the survivors' healths
        uint count = 0;
        for (uint i = 0; i < n; i++) {
            if (survivors[i] > 0) {
                survivors[count++] = survivors[i];
            }
        }

        uint[] memory result = new uint[](count);
        for (uint i = 0; i < count; i++) {
            result[i] = survivors[i];
        }
        return result;
    }

    // Helper function to sort robots by position
    function sortRobots(Robot[] memory robots) private pure {
        // Simple insertion sort
        for (uint i = 1; i < robots.length; i++) {
            Robot memory key = robots[i];
            uint j = i;
            while (j > 0 && robots[j - 1].position > key.position) {
                robots[j] = robots[j - 1];
                j--;
            }
            robots[j] = key;
        }
    }
}
