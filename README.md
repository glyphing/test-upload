# Upload test

I use the packages
```bash
$ meteor add tomi:upload-server
$ meteor add tomi:upload-jquery
```

The goal is to transfer a token from the client to the server using the provided
template context variable *formData*.

I observe that the in the html the reactivity is working well. Indeed the token
is delivered in a second moment (after the subscription is ready) and the html
contains the correct token (property *data-form-data* of the *input* tag):
```html
<input type="file" class="jqUploadclass" data-form-data="{"uploadToken":"h9yswgraTLqxyyz4o"}">
```

On the server side, in the log, I can observe that instead of the token I get the
initialisation value (empty string).

Nevertheless the problem should be on the client side, because I noticed in the xhr
data that the token is missing.

How could the package *tomi:upload-jquery* be patched to overcome this issue?
