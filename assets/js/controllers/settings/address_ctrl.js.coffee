walletApp.controller "AddressCtrl", ($scope, Wallet, $log, $state, $stateParams, $filter, $translate) ->
  $scope.address = {address: null}
  $scope.accounts = Wallet.accounts
  $scope.show = {watchOnly: false, editLabel: false}
  $scope.errors = {label: null}
  $scope.newLabel = null
  
  $scope.url = null
  
  $scope.$watch "address.address", (newValue) ->
    if newValue?
      $scope.url = 'bitcoin://' + newValue
        
  $scope.signMessage = () ->
    window.confirm("Coming soon")  
    
  $scope.changeLabel = (label, successCallback, errorCallback) ->
    $scope.errors.label = null
    
    success = () ->
      $scope.show.editLabel = false
      successCallback()
      
    error = (error) ->
      $translate("INVALID_CHARACTERS_FOR_LABEL").then (translation) ->      
        $scope.errors.label = translation
      errorCallback()
    
    Wallet.changeLegacyAddressLabel($scope.address, label, success, error)
    
  #################################
  #           Private             #
  #################################
    
  $scope.didLoad = () ->
    $scope.addressBook = Wallet.addressBook
    $scope.status    = Wallet.status
    $scope.settings = Wallet.settings
  
  $scope.$watchCollection "accounts()", () ->
    # Is it a legacy address?
    address = $filter("getByProperty")("address", $stateParams.address, Wallet.legacyAddresses())
    
    $scope.address = address
    $scope.newLabel = address.label
          
  # First load:      
  $scope.didLoad()