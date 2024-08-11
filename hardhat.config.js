require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

const WEAVEDB_API_URL = process.env.WEAVEDB_API_URL;
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
    goerli: {
      url: WEAVEDB_API_URL,  // Use the correct variable here
      accounts: [PRIVATE_KEY],
      chainId: 5,
    },
    mainnet: {
      url: "https://eth-mainnet.alchemyapi.io/v2/your-api-key",
      accounts: [PRIVATE_KEY],
      chainId: 1,
    },
  },
};
