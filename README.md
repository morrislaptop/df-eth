# Dark Forest Smart Contracts

## Development Guide

### Folder setup

All of our smartcontract related code are located in the `/eth` directory.

- `/eth/contracts` contains the smartcontract code written in solidity
- `/eth/test` contains the test for the smartcontract written in Javascript

### Installing Core Dependencies

- Node (v14.15.x)
- Yarn (Javascript Package Manager)

#### Installing The Correct Node Version Using NVM

Dark Forest is built and tested using Node.js v14.15.x and might not run properly on other Node.js versions. We recommend using NVM to switch between multiple Node.js version on your machine.

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
nvm install
```

After the installation is finished, you can run `node --version` to verify that you are running v14.15.x

#### Installing Yarn & Other Dev Dependencies

Refer to [Yarn's official documentation](https://classic.yarnpkg.com/en/docs/install) for the installation guide.

After you have Yarn installed, run `yarn` to install dev dependencies:

### Run Locally

To run the tests run `yarn test`

To deploy contracts locally, you'll need to run 2 commands:

1. Start a node by running `yarn hardhat:node`
2. Then (in another terminal) deploy contracts by running `yarn hardhat:dev deploy --whitelist false`

You can import the private key of one of the accounts `hardhat node` created and funded, which are printed when you started the node such as:

```
Account #0: 0x1c0f0af3262a7213e59be7f1440282279d788335 (100 ETH)
Private Key: 0x044c7963e9a89d4f8b64ab23e02e97b2e00dd57fcb60f316ac69b77135003aef

Account #1: 0xe8170282c5bc6e7c5b2d984cd5d897a05e0afafb (100 ETH)
Private Key: 0x523170aae57904f24ffe1f61b7e4ff9e9a0ce7557987c2fc034eacb1c267b4ae

Account #2: 0x3097403b64fe672467345bf159f4c9c5464bd89e (100 ETH) - DEPLOYER
Private Key: 0x67195c963ff445314e667112ab22f4a7404bad7f9746564eb409b9bb8c6aed32
```

## Player

1. Modify node_modules/@darkforest_eth/contracts/typechain/index.d.ts manually with DarkForestPlayer
2. Run the node - `hardhat:node`
3. Deploy the game - `yarn hardhat:dev deploy --whitelist false`
4. Deploy the player - `yarn compile && yarn hardhat:dev player --core-address 0x6A88Da94d58973C8e69F533cb0CeDb6425551387`
5. Enter player contract address when starting the game - `0x9b25D251D785902e52ee79a328282217C02Bdc76`
