// Replace this with your deployed Remix contract address on Sepolia / Base Sepolia!
export const CONTRACT_ADDRESS = "0x7dd0de223e953c5d650a78471e6d000dc6d780ed";

export const CONTRACT_ABI = [
  "function name() view returns (string)",
  "function symbol() view returns (string)",
  "function admin() view returns (address)",
  "function locked(uint256 tokenId) view returns (bool)",
  "function studentPoints(address) view returns (uint256)",
  "function totalCohortPoints() view returns (uint256)",
  "function currentGrantRound() view returns (uint256)",
  "function roundTotalPool() view returns (uint256)",
  "function hasClaimedInRound(uint256, address) view returns (bool)",
  "function issueSoulboundBadge(address _student, string _skillName, uint256 _points) external",
  "function transferFrom(address from, address to, uint256 tokenId) external pure",
  "function fundGrantPool() external payable",
  "function getClaimableGrant(address _student) view returns (uint256)",
  "function claimGrant() external",
  "function startNewRound() external payable",
  "function getStudentBadges(address _student) view returns (tuple(uint256 id, address student, string skillName, uint256 points, uint256 timestamp)[])"
];