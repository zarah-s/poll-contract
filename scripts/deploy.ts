import { ethers } from "hardhat";

async function main() {


  const poll = await ethers.deployContract("Poll");

  await poll.waitForDeployment();

  console.log(
    `Poll deployed to ${poll.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
