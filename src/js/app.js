var cancelFee = 1000000000000000000;
App = {
  web3Provider: null,
  contracts: {},

  init: async function() {
    
    // /* // Load pets.
    $.getJSON('../books.json', function(data) {
      var booksRow = $('#booksRow');
      var bookTemplate = $('#bookTemplate');

      for (var i = 0; i < data.length; i ++) {
        var bookData = data[i];
        bookTemplate.find('.panel-title').text(bookData.title + ' (' + bookData.id + ')');
        bookTemplate.find('img').attr('src', bookData.imgurl);
        bookTemplate.find('.book-title').text(bookData.title);
        bookTemplate.find('.book-publisheddate').text(bookData.publishedDate);
        bookTemplate.find('.book-authers').text(bookData.author);
        bookTemplate.find('.panel-book').attr('id', 'panel-book' + bookData.id);
        bookTemplate.find('.btn-rent').attr('data-id', bookData.id);
        bookTemplate.find('.btn-rent').attr('data-rentalfee', bookData.rentalfee);
        bookTemplate.find('.btn-rent').attr('data-deposit', bookData.deposit);
        bookTemplate.find('.btn-rent').attr('data-systemfee', bookData.systemfee);
        bookTemplate.find('.btn-cancel').attr('data-id', bookData.id);
        bookTemplate.find('.btn-cancel').attr('data-rentalfee', bookData.rentalfee);
        bookTemplate.find('.btn-cancel').attr('data-deposit', bookData.deposit);
        bookTemplate.find('.btn-cancel').attr('data-systemfee', bookData.systemfee);
        bookTemplate.find('.btn-ok').attr('data-id', bookData.id);
        bookTemplate.find('.btn-ok').attr('data-rentalfee', bookData.rentalfee);
        bookTemplate.find('.btn-ok').attr('data-deposit', bookData.deposit);
        bookTemplate.find('.btn-ok').attr('data-systemfee', bookData.systemfee);
        bookTemplate.find('.btn-error').attr('data-id', bookData.id);
        bookTemplate.find('.btn-error').attr('data-rentalfee', bookData.rentalfee);
        bookTemplate.find('.btn-error').attr('data-deposit', bookData.deposit);
        bookTemplate.find('.btn-error').attr('data-systemfee', bookData.systemfee);
        bookTemplate.find('.btn-late').attr('data-id', bookData.id);
        bookTemplate.find('.btn-late').attr('data-rentalfee', bookData.rentalfee);
        bookTemplate.find('.btn-late').attr('data-deposit', bookData.deposit);
        bookTemplate.find('.btn-late').attr('data-systemfee', bookData.systemfee);
        bookTemplate.find('.btn-late').attr('data-latefee', bookData.latefee);
        booksRow.append(bookTemplate.html());
      }
    });
    // */

    // TODO 시스템 수수료, 취소 수수료 저장

    return await App.initWeb3();
  },

  initWeb3: async function() {
    /*
    * Replace me...
    */
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
    /*
    $.getJSON('Adoption.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract
      var AdoptionArtifact = data;
      App.contracts.Adoption = TruffleContract(AdoptionArtifact);

      // Set the provider for our contract
      App.contracts.Adoption.setProvider(App.web3Provider);

      // Use our contract to retrieve and mark the adopted pets
      return App.markAdopted();
    });
    */
    
   $.getJSON('RentalBook.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract
      var RentalBookArtifact = data;
      App.contracts.RentalBook = TruffleContract(RentalBookArtifact);

      // Set the provider for our contract
      App.contracts.RentalBook.setProvider(App.web3Provider);

      // Use our contract to retrieve and mark the adopted pets
      return App.markRented();
    });

    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', '.btn-rent', App.handleRent);
    $(document).on('click', '.btn-cancel', App.handleCancel);
    $(document).on('click', '.btn-ok', App.handleOK);
    $(document).on('click', '.btn-error', App.handleError);
    $(document).on('click', '.btn-late', App.handleLate);
    $(document).on('click', '.btn-register', App.handleRegister);
  },

  /*
  markAdopted: function(adopters, account) {
    var adoptionInstance;

    App.contracts.Adoption.deployed().then(function(instance) {
      adoptionInstance = instance;

      return adoptionInstance.getAdopters.call();
    }).then(function(adopters) {
      for (i = 0; i < adopters.length; i++) {
        if (adopters[i] !== '0x0000000000000000000000000000000000000000') {
          $('.panel-pet').eq(i).find('button').text('Success').attr('disabled', true);
        }
      }
    }).catch(function(err) {
      console.log(err.message);
    });
  },
  */

  markRented: function() {
    var rentalBookInstance;

    App.contracts.RentalBook.deployed().then(function(instance) {
      rentalBookInstance = instance;

      return rentalBookInstance.getRentedBook.call();
    }).then(function(ids) {
      for (i = 0; i < ids.length; i++) {
        $('#panel-book' + ids[i]).find('button.btn-rent').attr('disabled', true);
      }
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  /*
  handleAdopt: function(event) {
    event.preventDefault();

    var petId = parseInt($(event.target).data('id'));

    var adoptionInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.Adoption.deployed().then(function(instance) {
        adoptionInstance = instance;

        // Execute adopt as a transaction by sending account
        return adoptionInstance.adopt(petId, {from: account, value: 1000000000000000000});
      }).then(function(result) {
        return App.markAdopted();
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  }
  */

  handleRent: function(event) {
    event.preventDefault();

    var dataId = parseInt($(event.target).data('id'));
    var rentalFee = parseInt($(event.target).data('rentalfee'));
    var deposit = parseInt($(event.target).data('deposit'));

    var rentalBookInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.RentalBook.deployed().then(function(instance) {
        rentalBookInstance = instance;

        // Execute adopt as a transaction by sending account
        return rentalBookInstance.borrowBook(dataId, {from: account, value: rentalFee + deposit});
      }).then(function(result) {
        return App.markRented();
      }).catch(function(err) {
        console.log(err.message);
      });
    });
    
  },

  handleCancel: function(event) {
    event.preventDefault();

    var dataId = parseInt($(event.target).data('id'));

    var rentalBookInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.RentalBook.deployed().then(function(instance) {
        rentalBookInstance = instance;

        // Execute adopt as a transaction by sending account
        return rentalBookInstance.cancelRental(dataId, {from: account, value: cancelFee});
      }).then(function(result) {
        return App.markRented();
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  },

  handleOK: function(event) {
    event.preventDefault();

    var dataId = parseInt($(event.target).data('id'));

    var rentalBookInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.RentalBook.deployed().then(function(instance) {
        rentalBookInstance = instance;

        // Execute adopt as a transaction by sending account
        return rentalBookInstance.returnedBook(dataId, {from: account});
      }).then(function(result) {
        return App.markRented();
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  },

  handleError: function(event) {
    event.preventDefault();

    var dataId = parseInt($(event.target).data('id'));

    var rentalBookInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.RentalBook.deployed().then(function(instance) {
        rentalBookInstance = instance;

        // Execute adopt as a transaction by sending account
        return rentalBookInstance.returnedBookInAbnormal(dataId, {from: account});
      }).then(function(result) {
        return App.markRented();
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  },

  handleLate: function(event) {
    event.preventDefault();

    var dataId = parseInt($(event.target).data('id'));
    var latefee = parseInt($(event.target).data('latefee'));
    var rentalBookInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.RentalBook.deployed().then(function(instance) {
        rentalBookInstance = instance;

        // Execute adopt as a transaction by sending account
        return rentalBookInstance.returnedBookWithLateFee(dataId, latefee, {from: account});
      }).then(function(result) {
        return App.markRented();
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
