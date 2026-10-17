// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC5192 {
    event Locked(uint256 tokenId);
    function locked(uint256 tokenId) external view returns (bool);
}

contract SoulboundGrantRouter is IERC5192 {
    string public name = "SPPU Proof-of-Skill SBT";
    string public symbol = "SPPU-SBT";
    address public admin;
    uint256 public nextTokenId;

    struct Badge {
        uint256 id;
        address student;
        string skillName;
        uint256 points;
        uint256 timestamp;
    }

    mapping(uint256 => address) public ownerOf;
    mapping(address => uint256) public studentPoints;
    mapping(address => Badge[]) public studentBadges;
    uint256 public totalCohortPoints;

    uint256 public currentGrantRound = 1;
    uint256 public roundTotalPool;
    mapping(uint256 => mapping(address => bool)) public hasClaimedInRound;

    event BadgeMinted(address indexed student, uint256 tokenId, string skillName, uint256 points);
    event GrantPoolFunded(address indexed sponsor, uint256 amount, uint256 roundTotal);
    event GrantClaimed(address indexed student, uint256 payout, uint256 round);

    constructor() { admin = msg.sender; }

    function locked(uint256 tokenId) external view override returns (bool) {
        require(ownerOf[tokenId] != address(0), "Token does not exist");
        return true;
    }

    function issueSoulboundBadge(address _student, string memory _skillName, uint256 _points) external {
        uint256 tokenId = ++nextTokenId;
        ownerOf[tokenId] = _student;
        studentPoints[_student] += _points;
        totalCohortPoints += _points;
        studentBadges[_student].push(Badge(tokenId, _student, _skillName, _points, block.timestamp));
        emit Locked(tokenId);
        emit BadgeMinted(_student, tokenId, _skillName, _points);
    }

    function transferFrom(address, address, uint256) external pure {
        revert("ERC5192: Soulbound token cannot be transferred");
    }

    function fundGrantPool() external payable {
        roundTotalPool += msg.value;
        emit GrantPoolFunded(msg.sender, msg.value, roundTotalPool);
    }

    function getClaimableGrant(address _student) public view returns (uint256) {
        if (totalCohortPoints == 0 || studentPoints[_student] == 0 || hasClaimedInRound[currentGrantRound][_student]) return 0;
        return (roundTotalPool * studentPoints[_student]) / totalCohortPoints;
    }

    function claimGrant() external {
        uint256 payout = getClaimableGrant(msg.sender);
        require(payout > 0, "No claimable grant");
        hasClaimedInRound[currentGrantRound][msg.sender] = true;
        (bool success, ) = payable(msg.sender).call{value: payout}("");
        require(success, "Transfer failed");
        emit GrantClaimed(msg.sender, payout, currentGrantRound);
    }

    function getStudentBadges(address _student) external view returns (Badge[] memory) {
        return studentBadges[_student];
    }
}