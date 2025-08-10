pragma solidity ^0.8.0;

contract RelativeRanks {
    struct Score {
        uint score;
        uint index;
    }

    // Function to find relative ranks
    function findRelativeRanks(uint[] memory scores) public pure returns (string[] memory) {
        uint n = scores.length;
        Score[] memory scoreStructs = new Score[](n);
        string[] memory ranks = new string[](n);

        // Populate the array of structs
        for (uint i = 0; i < n; i++) {
            scoreStructs[i] = Score(scores[i], i);
        }

        // Sort scores in descending order using a simple bubble sort
        for (uint i = 0; i < n; i++) {
            for (uint j = 0; j < n - i - 1; j++) {
                if (scoreStructs[j].score < scoreStructs[j + 1].score) {
                    (scoreStructs[j], scoreStructs[j + 1]) = (scoreStructs[j + 1], scoreStructs[j]);
                }
            }
        }

        // Assign ranks based on sorted scores
        for (uint i = 0; i < n; i++) {
            // Convert rank to string and assign to the original index
            if (i == 0) {
                ranks[scoreStructs[i].index] = "Gold Medal";
            } else if (i == 1) {
                ranks[scoreStructs[i].index] = "Silver Medal";
            } else if (i == 2) {
                ranks[scoreStructs[i].index] = "Bronze Medal";
            } else {
                ranks[scoreStructs[i].index] = uint2str(i + 1);
            }
        }

        return ranks;
    }

    function uint2str(uint _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
}
