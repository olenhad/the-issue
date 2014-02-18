redirectToProfile = (user) ->
	console.log user 
	#window.location = '/auth/facebook/callback' if response.authResponse

fetchUserData = () ->
	FB.api '/me', (fbresponse) ->
    	console.log fbresponse
    	findUser fbresponse.email,
    		(user) ->
    			if user
    				console.log("user = ", user)
    				redirectToProfile(user)
    			else
    				registerUser(fbresponse)
    		
    	

registerUser = (fbUser) ->
	$.post('/api/users',
			{
				user: {
					name: fbUser.name,
					email: fbUser.email,
					auth_type: 'facebook',	
				}
			})
			.done (data) ->
				console.log "registered ", data
				redirectToProfile(data.user)
			.error (res) ->
				console.log res
				document.write(res.responseText)

findUser = (email, callback) ->
	$.get('/api/users/search',
			{'email': email}
		)
		.done callback


main = () ->
	$("#fb-login-button").click (event) ->
		FB.getLoginStatus (response) ->
			if response.status == "connected"
				window.location = '/auth/facebook/callback?' + $.param({ signed_request: response.authResponse.signedRequest }) if response.authResponse
			else
				FB.login(
					(response) ->
	            		if response.authResponse 
	            			console.log "Logged in!"
	            			window.location = '/auth/facebook/callback?'+$.param({ signed_request: response.authResponse.signedRequest }) if response.authResponse
	            			#fetchUserData()
	            		else
	            			console.log "Error!"

	            	{scope : 'email'}
	            	)

$(document).ready ->
    console.log "fuck this hard"
    $.ajaxSetup { cache: true }
    $.getScript( 
        '//connect.facebook.net/en_UK/all.js',
        () ->  
            FB.init {appId: window.appConfig.FB_APP_ID}
            console.log "WOHOOO: #{FB}"
            main()

    )		

