# deletes all but x most recent posts from a tumblr blog.
# may be used to age off posts.

import pytumblr

postsToKeep=15

tumblr_client = pytumblr.TumblrRestClient(
    '<consumer_key>',
    '<consumer_secret>',
    '<oauth_token>',
    '<oauth_secret>',
)

while(tumblr_client.posts("blogname").get("total_posts",{}) > postsToKeep):
	try:
		for post in tumblr_client.posts("blogname",offset=postsToKeep,limit=1).get("posts",{}):
			tumblr_client.delete_post("blogname",post.get("id",{}))
	except:
		break
