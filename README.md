# 🛡️ SPPU Proof-of-Skill Grant Router (EIP-5192 × Ethereum CROPS)

**EFDEVCON × SPPU Hackathon Submission**

## 🔗 Live Deployment & On-Chain Details
* **Live Vercel App URL:** `https://sppu-soulbound-grants.vercel.app/` 
* **Network:** Ethereum Sepolia Testnet
* **Deployed Smart Contract Address (Contract ID):** `0x7dd0de223e953c5d650a78471e6d000dc6d780ed` 
* **Verified Deployer / Admin Wallet:** `0x7dd0de223e953c5d650a78471e6d000dc6d780ed`
* **Sepolia Explorer:** [View on Sepolia Etherscan](https://sepolia.etherscan.io/address/0x7dd0de223e953c5d650a78471e6d000dc6d780ed)

---

## 🚀 Project Overview
Distributing student micro-grants, lab bounties, and campus public-goods funding today relies on slow, centralized manual committees—or suffers from **Sybil attacks and wallet farming** when using transferable tokens.

**SPPU Proof-of-Skill Grant Router** uses **EIP-5192 Minimal Soulbound Tokens (SBTs)** paired with an **autonomous proportional grant distribution smart contract (`SoulboundGrantRouter.sol`)** to route public goods funding trustlessly based on verifiable student reputation weights.

## 🌾 Alignment with Ethereum CROPS Framework
- **C — Censorship Resistance:** Permissionless smart-contract grant claims (`claimGrant()`) with zero gatekeepers.
- **R — Resilience (Anti-Capture):** EIP-5192 Soulbound lock (`locked(tokenId) == true`) prevents buying/pooling badges across wallets.
- **O — Openness:** 100% transparent on-chain proportional formula: `Payout = Pool × (Student SBT Points ÷ Total Cohort Points)`.
- **P — Privacy:** Pseudonymous ZK-ready student credential verification without exposing private student PII.
- **S — Security:** Bytecode-level `transferFrom()` revert and per-round double-claim protection (`hasClaimedInRound`).

## 💻 Tech Stack & Local Setup
- **Smart Contract:** Solidity `^0.8.20` (`contracts/SoulboundGrantRouter.sol`)
- **Frontend:** React (Vite), Ethers.js v6, Lucide Icons (`frontend/`)

```bash
cd frontend
npm install
npm run dev