require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");
require("dotenv").config();
const SHARDEUM_RPC = process.env.SHARDEUM_RPC;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "hardhat",
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    liberty: {
      url: SHARDEUM_RPC,
      accounts: [PRIVATE_KEY],
      chainId: 8081,
    },
  },
  
};
