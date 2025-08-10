// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FarmlandFinder {
    uint[][] public land;
    bool[][] visited;
    uint[][] public groups;

    constructor(uint[][] memory _land) {
        land = _land;
        visited = new bool[][](_land.length);
        for (uint i = 0; i < _land.length; i++) {
            visited[i] = new bool[](_land[0].length);
        }
    }

    function findGroups() public {
        uint m = land.length;
        uint n = land[0].length;
        for (uint i = 0; i < m; i++) {
            for (uint j = 0; j < n; j++) {
                if (land[i][j] == 1 && !visited[i][j]) {
                    exploreGroup(i, j, m, n);
                }
            }
        }
    }

    function exploreGroup(uint startRow, uint startCol, uint m, uint n) private {
        uint minRow = startRow;
        uint maxRow = startRow;
        uint minCol = startCol;
        uint maxCol = startCol;
        uint[] memory queueRow = new uint[](m * n);
        uint[] memory queueCol = new uint[](m * n);
        uint qIndex = 0;
        uint qSize = 1;
        queueRow[0] = startRow;
        queueCol[0] = startCol;
        visited[startRow][startCol] = true;

        while (qIndex < qSize) {
            uint r = queueRow[qIndex];
            uint c = queueCol[qIndex];
            qIndex++;

            // Check all four possible directions
            int[2] memory directions = [int(-1), 1];
            for (uint d = 0; d < 2; d++) {
                uint newR = r + uint(int(r) + directions[d]);
                uint newC = c + uint(int(c) + directions[d]);
                if (newR < m && newC < n && land[newR][newC] == 1 && !visited[newR][newC]) {
                    visited[newR][newC] = true;
                    queueRow[qSize] = newR;
                    queueCol[qSize] = newC;
                    qSize++;
                    if (newR < minRow) minRow = newR;
                    if (newR > maxRow) maxRow = newR;
                    if (newC < minCol) minCol = newC;
                    if (newC > maxCol) maxCol = newC;
                }
            }
        }
        groups.push([minRow, minCol, maxRow, maxCol]);
    }

    function getGroups() public view returns (uint[][] memory) {
        return groups;
    }
}
