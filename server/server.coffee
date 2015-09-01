Fiber = Npm.require 'fibers'

Meteor.startup ->
  UploadServer.init
    tmpDir: process.env.PWD + '/.uploads/tmp'
    uploadDir: process.env.PWD + '/.uploads/'
    checkCreateDirectories: true
    validateRequest: (req,res) ->
      return null
    validateFile: (file) ->
      return null
    getDirectory: (fileInfo, formData) ->
      console.log '>>>> getDirectory'
      dir = ''
      Fiber( ->
        u = Meteor.users.findOne({"uploadToken.token": formData.uploadToken.token })
        if u
          dir = u.username
      ).run()
      console.log '[token,dir]:[', formData.uploadToken,',', dir,']'
      return dir
    getFileName: (fileInfo, formData) ->
      return fileInfo.name
  return


# upload token, for upload&download authentification
Accounts.onLogin (info) ->
  # info.user contains the logged in userId
  time0 = new Date().getTime()
  if ( (not info.user.uploadToken ) or ( time0 - info.user.uploadToken.timestamp > 30 * 1000 ) )
    uploadToken = {
      timestamp: time0
      token: Random.id()
    }
    Meteor.users.update {_id: info.user._id}, $set: uploadToken: uploadToken
Meteor.publish 'userUploadToken', ->
  if @userId
    return Meteor.users.find {_id: @userId}, fields: uploadToken: 1
  else
    @ready()


Meteor.startup ->
  if Meteor.users.find().count() is 0
    userId = Accounts.createUser
      username: 'test'
      email: 'test@example.com'
      password: 'test'
      profile:
        first_name: 'test'
        last_name: ''
        email: ''
