// import { DarkForestCore as DarkForestPlayer } from '@darkforest_eth/contracts/typechain';
import { DarkForestPlayer } from '@darkforest_eth/contracts/typechain';
import { subtask, task, types } from 'hardhat/config'
import { HardhatRuntimeEnvironment } from 'hardhat/types';

task('player', 'deploy the player contract')
  .addParam('coreAddress', 'Address of the core contract')
  .setAction(deploy);

async function deploy(args: { coreAddress: string }, hre: HardhatRuntimeEnvironment) 
{    
    const [deployer] = await hre.ethers.getSigners()
    
    const DarkForestPlayer = await hre.ethers.getContractFactory('DarkForestPlayer');
    const darkForestPlayer = await DarkForestPlayer.deploy(
      deployer.address,
      args.coreAddress,
    ) as DarkForestPlayer;

    await darkForestPlayer.deployed()
    
    console.log('Player deployed to ' + darkForestPlayer.address + ' by ' + deployer.address);
}
