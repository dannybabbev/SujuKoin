pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/SujuKoin.sol";

contract TestSujuKoin {
  function test(){
    SujuKoin sujuKoin = new SujuKoin();

    uint exp = 1000000;

    Assert.equal(sujuKoin.balanceOf(tx.origin), exp, 'Owner has total supply');
  }

}
