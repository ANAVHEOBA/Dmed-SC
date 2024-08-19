require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

const { ALCHEMY_URL, PRIVATE_KEY, WEAVEDB_API_URL } = process.env;

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
    sepolia: {
      url: ALCHEMY_URL,  // Use Alchemy URL for Goerli
      accounts: [PRIVATE_KEY],
      chainId: 11155111,
    },
    mainnet: {
      url: "https://eth-mainnet.alchemyapi.io/v2/your-api-key",
      accounts: [PRIVATE_KEY],
      chainId: 1,
    },
  },
};
