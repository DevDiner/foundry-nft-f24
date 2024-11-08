//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;


// This part of the script is used to mint the NFT programmatically.

import{Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script{

    string  public constant CORGI = "ipfs://bafybeifddk7c6wct42qgb6hu7qschtut67htakosntbthzfxzykjpvltre.ipfs.dweb.link?filename=corgi.json";

    function run() external{ 
        
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployed);

    }
    
    function mintNftOnContract(address contractAddress) public {
        
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(CORGI);
        vm.stopBroadcast();
    }


}