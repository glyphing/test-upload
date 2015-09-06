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
  callbacks: ->
    instance = Template.instance()
    return {
      getDynamicFormData: ->
        return {
          uploadToken: instance.uploadToken.get()
          ciao: 'miao'
        }
    }
