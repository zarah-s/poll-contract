// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract Poll {
    uint256 currentId;
    struct PollData {
        uint256 id;
        address creator;
        string title;
        string[] options;
    }

    // struct PollResult {
    //     uint256 id;
    //     uint optionIndex;
    // }

    mapping(address => mapping(uint256 => bool)) hasVoted;

    mapping(uint256 => PollData) polls;
    mapping(uint256 => uint[]) results;

    function createPoll(
        string[] calldata _options,
        string calldata _title
    ) external {
        currentId += 1;
        polls[currentId] = PollData(currentId, msg.sender, _title, _options);
    }

    function vote(uint256 _pollId, uint _optionIndex) external {
        require(_pollId <= currentId, "Poll don't exist");
        PollData memory poll = polls[_pollId];
        require(_optionIndex < poll.options.length, "Option does not exist");
        bool _hasVoted = hasVoted[msg.sender][_pollId];
        require(!_hasVoted, "Already voted");
        results[_pollId].push(_optionIndex);
        hasVoted[msg.sender][_pollId] = true;
    }

    function getResults(uint _pollId) external view returns (uint[] memory) {
        return results[_pollId];
    }

    function getPoll(uint _pollId) external view returns (PollData memory) {
        return polls[_pollId];
    }
}
