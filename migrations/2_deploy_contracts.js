var SujuKoin = artifacts.require("./SujuKoin.sol")

module.exports = function(deployer) {
  deployer.deploy(SujuKoin);
};
