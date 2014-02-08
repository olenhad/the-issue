fetchUserData = () ->
	FB.api '/me', (response) ->
    	console.log response

registerUser = (fbUser) ->
	$.post('/api/users/create',
			{
				name: fbUser.name,
				email: fbUser.email,
				type: 'fb',
				
			})

main = () ->
	$("#fb-login-button").click (event) ->
		FB.getLoginStatus (response) ->
			if response.status == "connected"
				fetchUserData()
			else
				FB.login(
					(response) ->
	            		if response.authResponse 
	            			console.log "Logged in!"
	            			fetchUserData()
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
            FB.init {appId: '608873879182214'}
            console.log "WOHOOO: #{FB}"
            main()

    )		

