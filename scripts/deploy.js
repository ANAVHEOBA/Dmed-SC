async function main() {
  
  const DeDoctor = await hre.ethers.getContractFactory("DeDoctor");
  const deDoctor = await DeDoctor.deploy();

  await deDoctor.deployed();

  console.log(
    `DeDoctor contract deployed to ${deDoctor.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
