Template.manageUsersImport.onCreated ->
  self = @
  @uploadToken = new ReactiveVar ''

  self.autorun ->
    subscription = self.subscribe 'userUploadToken'
    if subscription.ready()
      if Meteor.user()
        if Meteor.user().uploadToken
          self.uploadToken.set Meteor.user().uploadToken.token


Template.manageUsersImport.helpers
  getFormData: ->
    return { uploadToken: Template.instance().uploadToken.get() }
#    console.log Template.instance().uploadToken.get()
#    return { uploadToken: 'ciao' }
