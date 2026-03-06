// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title ProofOfLearning
 * @dev Stores hashes of student achievements on Antigravity L1
 */
contract ProofOfLearning {
    
    struct Achievement {
        bytes32 contentHash;  // Hash of the curriculum/sprint completed
        uint256 timestamp;
        address student;
    }

    mapping(address => Achievement[]) public studentAchievements;

    event AchievementRecorded(address indexed student, bytes32 indexed contentHash, uint256 timestamp);

    function recordAchievement(bytes32 _contentHash) external {
        Achievement memory newAchievement = Achievement({
            contentHash: _contentHash,
            timestamp: block.timestamp,
            student: msg.sender
        });
        
        studentAchievements[msg.sender].push(newAchievement);
        
        emit AchievementRecorded(msg.sender, _contentHash, block.timestamp);
    }

    function getAchievements(address _student) external view returns (Achievement[] memory) {
        return studentAchievements[_student];
    }
}
