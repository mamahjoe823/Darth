# Public Good Pledges

A simple, decentralized application built on Stacks for making public, immutable pledges to do good in the world.

## The Vision: Solving World Problems with Accountability

Many of the world's problems require collective action and commitment. This project provides a foundational tool to foster that commitment. Instead of using blockchain for financial transactions, we use its core strengths—immutability and transparency—to create a global, public ledger of good intentions.

When an individual, a community, or a company makes a pledge on-chain, it's recorded forever. This creates powerful social accountability and serves as a public record to inspire others to act.

**This is a starting point for:**
*   **Environmental Pledges:** "I will plant 20 trees this year."
*   **Community Pledges:** "Our neighborhood will clean up the local park every month."
*   **Corporate Pledges:** "Our company will donate 500 volunteer hours to charity."

## How It Works

The project is built around a single, simple Clarity smart contract (`contracts/public-pledges.clar`).

### Core Functions

*   `(make-pledge (text (string-utf8 256)))`: Allows any principal (user) to make a public pledge. The pledge text is stored on the blockchain, linked to their address. It returns the unique ID of the new pledge.
*   `(get-pledge (id uint))`: A read-only function to retrieve the details of a specific pledge by its ID.
*   `(get-pledge-count)`: A read-only function that returns the total number of pledges ever made.

### Data Storage

*   `pledges` map: Stores the pledge data, including the pledger's address, the pledge text, and the block height at which it was made.
*   `pledge-id-counter`: A simple counter to ensure every pledge gets a unique, sequential ID.

## Getting Started

This project uses Clarinet for development and testing.

### Prerequisites

*   Clarinet
*   Node.js and npm

### 1. Installation

Clone the repository and install the `npm` dependencies:

```bash
npm install
```

### 2. Running Tests

The project comes with a full suite of unit tests to ensure the contract functions as expected. To run the tests:

```bash
npm test
```

You should see all tests passing.

### 3. Interacting via the Console

You can interact with the contract directly using the Clarinet console.

1.  Start the console:
    ```bash
    clarinet console
    ```

2.  Make a pledge from the deployer's account:
    ```clarity
    ::> (contract-call? .public-pledges make-pledge u"I will help one person learn to code.")
    (ok u1)
    ```

3.  Retrieve the pledge you just made:
    ```clarity
    ::> (contract-call? .public-pledges get-pledge u1)
    (some {block-height: u2, pledger: ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM, text: u"I will help one person learn to code."})
    ```

## Next Steps & Future Vision

This contract is a foundational layer. The real power comes from what is built on top of it.

*   **Build a Frontend:** A simple web application where users can connect their wallets to make and view pledges from around the world.
*   **Add Features:** Extend the contract to allow pledgers to mark their pledges as "Completed," or allow for community verification of pledges.
*   **Campaigns:** Create functions that allow an organization to launch a "pledge campaign" that others can join.