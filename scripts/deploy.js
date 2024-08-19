const hre = require("hardhat");
const WeaveDB = require("weavedb-sdk");
const ethers = require("ethers");

async function main() {
  try {
    // Deploy the DeDoctor contract
    const DeDoctor = await hre.ethers.getContractFactory("DeDoctor");
    const deDoctor = await DeDoctor.deploy();
    await deDoctor.deployed();

    console.log(`DeDoctor contract deployed to ${deDoctor.address}`);

    // Initialize WeaveDB
    const db = new WeaveDB({
      contractTxId: "DznefHbFhcyqyjZ0aNGqsWwkjcwRDlraUR72EkXames",
    });

    await db.init();

    // Example: Interact with WeaveDB (store the contract address)
    await db.set("DeDoctorContracts", { address: deDoctor.address });

    console.log("DeDoctor contract address stored in WeaveDB");
  } catch (error) {
    console.error("Error in main function:", error);
    process.exitCode = 1;
  }
}

main();
