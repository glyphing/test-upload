# Upload test

Example upload with
```bash
$ meteor add gly:upload-server
$ meteor add gly:upload-jquery
```

The goal is to transfer a token from the client to the server using the provided
template context variable *formData*.

The token is used to identify the user and on server side the files are saved
under a directory with the *username* ad subpath.
