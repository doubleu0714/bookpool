const RentalBook = artifacts.require("RentalBook");

module.exports = function(deployer) {
  deployer.deploy(RentalBook);
};
