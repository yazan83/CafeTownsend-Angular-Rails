describe 'MainController', ->

  beforeEach module('cafeTownsend')
  beforeEach module('test')

  beforeEach inject ($rootScope, $controller, MockFactory) ->

    @mockFactory = MockFactory
    @scope = $rootScope.$new()
    @viewState = @mockFactory.viewState()
    @sessionService = @mockFactory.sessionService()

    # controller factory
    @createController = ->
      $controller "MainController",
        $scope: @scope
        SessionService: @sessionService
        ViewState: @viewState

  afterEach ->

  it 'is injectable', ->
    controller = @createController()
    expect(controller).not.to.be(undefined)

  describe 'init()', ->
    it 'stores instance of ViewState to scope', ->
      @createController()
      expect(@scope.viewState).to.be(@viewState)

  describe 'user status', ->
    it 'stores status into a scope object', ->
      @sessionService.authorized.returns true
      @createController()
      expect(@scope.authorized()).to.be.ok()
      @sessionService.authorized.returns false
      expect(@scope.authorized()).not.to.be.ok()
