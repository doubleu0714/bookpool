App = {
  web3Provider: null,
  contracts: {},

  init: async function() {

    return await App.initWeb3();
  },

  initWeb3: async function() {
    // Modern dapp browsers...
    if (window.ethereum) {
      App.web3Provider = window.ethereum;
      try {
        // Request account access
        await window.ethereum.enable();
      } catch (error) {
        // User denied account access...
        console.error("User denied account access")
      }
    }
    // Legacy dapp browsers...
    else if (window.web3) {
      App.web3Provider = window.web3.currentProvider;
    }
    // If no injected web3 instance is detected, fall back to Ganache
    else {
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
    }
    web3 = new Web3(App.web3Provider);

    return App.initContract();
  },

  initContract: function() {
   $.getJSON('RentalBook.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract
      var RentalBookArtifact = data;
      App.contracts.RentalBook = TruffleContract(RentalBookArtifact);

      // Set the provider for our contract
      App.contracts.RentalBook.setProvider(App.web3Provider);

      // Use our contract to retrieve and mark the adopted pets
      // TODO return App.markAdopted();
    });

    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', '.btn-register', App.handleRegister);
  },


  handleRegister: function(event) {
    event.preventDefault();

    var isbn = $('#text-isbn').val();
    var deposit = $('#text-deposit').val();
    var rentalFee = $('#text-rentalfee').val();
    var systemfee = 0;
    var rentalBookInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.RentalBook.deployed()
      .then(function(instance) {
        rentalBookInstance = instance;
        return rentalBookInstance.getSystemFee.call();
      }).then(function(result) {
        systemfee = result;
        return rentalBookInstance.registerBookInfo(deposit, rentalFee, {from: account, value: result});
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  }
};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
