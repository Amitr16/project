const PropertyContract = artifacts.require("PropertyContract");

module.exports = function (deployer) {
  deployer.deploy(PropertyContract);
};
