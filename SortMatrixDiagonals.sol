// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/// @title Sort matrix diagonals
contract SortMatrixDiagonals {
    /// @notice Sorts the diagonals of a square matrix as described
    /// @param grid n x n matrix (rows must be same length)
    /// @return out the sorted matrix
    function sortMatrix(int256[][] memory grid) external pure returns (int256[][] memory out) {
        uint256 n = grid.length;
        require(n > 0, "empty matrix");
        uint256 rowLen = grid[0].length;
        require(rowLen == n, "must be square");
        for (uint256 r = 1; r < n; r++) {
            require(grid[r].length == n, "ragged rows");
        }

        // Bottom-left triangle (including main diagonal) → descending
        for (uint256 i = n; i > 0; i--) {
            _processDiagonal(i - 1, 0, n, grid, true);
        }

        // Top-right triangle (exclude main diagonal) → ascending
        for (uint256 j = 1; j < n; j++) {
            _processDiagonal(0, j, n, grid, false);
        }

        return grid;
    }

    /// @dev Collects a diagonal starting at (i,j), sorts it, and writes it back
    function _processDiagonal(
        uint256 i,
        uint256 j,
        uint256 n,
        int256[][] memory grid,
        bool descending
    ) internal pure {
        // length = min(n - i, n - j)
        uint256 lenI = n - i;
        uint256 lenJ = n - j;
        uint256 len = lenI < lenJ ? lenI : lenJ;

        // collect
        int256[] memory diag = new int256[](len);
        for (uint256 k = 0; k < len; k++) {
            diag[k] = grid[i + k][j + k];
        }

        // sort
        _insertionSort(diag, descending);

        // write back
        for (uint256 k = 0; k < len; k++) {
            grid[i + k][j + k] = diag[k];
        }
    }

    /// @dev In-place insertion sort (asc/desc)
    function _insertionSort(int256[] memory a, bool desc) internal pure {
        uint256 n = a.length;
        for (uint256 i = 1; i < n; i++) {
            int256 key = a[i];
            uint256 j = i;
            if (desc) {
                // sort high → low
                while (j > 0 && a[j - 1] < key) {
                    a[j] = a[j - 1];
                    unchecked { j--; }
                }
            } else {
                // sort low → high
                while (j > 0 && a[j - 1] > key) {
                    a[j] = a[j - 1];
                    unchecked { j--; }
                }
            }
            a[j] = key;
        }
    }
}
