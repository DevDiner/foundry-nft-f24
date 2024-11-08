//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";

contract BasicNftTest  is Test{

    DeployBasicNft public deployer ;
    BasicNft public basicNft ;
    address public USER = makeAddr("user");
    string  public constant CORGI = "ipfs://bafybeiexiddg5ubbg2o3aa5x5toyoz6qoi3mpxwal2uhvibu2vxvkqs22i.ipfs.dweb.link?filename=corgi.json";

    function setUp() public{
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public {
        string memory expectedName ="Doggie";
        string memory actualName = basicNft.name();
        //since strings are arrays and arrays cant "==", we have to convert them into bytes by hashing them
        assert( keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));

    }

    function testCanMintAndHaveABalance()public {
        vm.prank(USER);
        basicNft.mintNft(CORGI);

        assert(basicNft.balanceOf(USER)==1);
        assert(keccak256(abi.encodePacked(CORGI))== keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }

    function testTokenURIIsCorrect() public {
        vm.prank(USER);
        basicNft.mintNft(CORGI);

        assert(keccak256(abi.encodePacked(basicNft.tokenURI(0))) == keccak256(abi.encodePacked(CORGI)));
    }

}