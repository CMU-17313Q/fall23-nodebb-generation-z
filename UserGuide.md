Note: Before testing anything out, we would like you to run the redis-server, and put redis-cli in the terminal, and flushall all data. Then run ./nodebb setup and ./nodebb start.
Working features:

**Feature 1:** 
- As a user, I want to make posts of a certain type (type is the group you want to make the post for).
- If you select the type to be public, it wont show up on the groups homepage that you are a part of. But if you select a certain group (for e.g., Administrator), the post would show up on administrator group's page.

- ***How to use and user test:***
This user story can be tested out through creating at least 2 users on the local server. One of the users should create 2 groups and then add him/her self and the other user to both the groups. Now the first user should create a new post. Once the dialogue box appears on the screen the user can see a dropdown menu where they can select the either public(wont show up on any group's page), or a certain group that the user is a part of. Once a certain group is selected and the post only would be displayed visible in the specified group, no other posts would show up. This can be further tested through checking the other groups that the user is a part of and they will not see their group-specific posts on the other group's pages. 

- ***Automated test cases:***
	- We first tested if the "type" attribute is present for the post object, and if it is updated to the type that is given as an argument for the post.create function. We tested it this way, because there is no way to mimic the action of selecting a type in the composer form using a testcase. The testcase can be found in this file ->  from lines .
	- We also modified a testcase in the test/controllers.js that checks if correct posts are being displayed in the group page or not. Here, I added the attribute "type" to the post being craeted and type was same as group's name. Hence, the test post with the correct group name was displayed in the group' page indicating that our filtration of groups by attribute "type" in group's controller works appropriately. The testcase can be found in this file -> test/posts.js from lines 188 -208.

**Feature 2:**
- As a student, I want to make anonymous posts, so that I can ask question without any fear of judgement.

- ***How to use and user test:***
This feature can be tested out through creating at least 2 users on the local server. The first user when making the announcement they can see a checkbox “post anonymously” on the post composer that shows up when clicking on "New Topic". If the user checks the box, it will make sure that the name and the profile icon on the announcement made is not visible to other people. The user themselves would be able to see their name and profile icon, but any other user would neither see their name nor their icon. THis can be tested by going over the topics list that are displayed when one clicks on the category. When an anonyomus post is clicked, even the post display hides the user icon and user display name. Even in the groups page that diaplay the latest posts of the group members, if there is an anonymous post made specific to a group, the anonymous user's name and profile icon are not visible.

- ***Automated test cases:***
	- We first tested if the "isAnonymous" attribute is present for the post object, and if it is updated to be true if its given as a true argument for the post.create function. We tested it this way, because there is no way to mimic the action of checking the checkbox to post anonymously in the composer form using a testcase. 
	- We also tested in the same testcase, that the displayname of the user is indeed updated to be "anonymous" when the isAnonymous field is true.
	- Both these tests were done in the same test case. The testcase can be found in this file -> test/posts.js from lines 164- 185.

Incomplete features:

**Feature:** 
- As an instructor, I want to endorse posts, so that posts can be verified.

- ***How to use and user test:***
  This feature was not able to be implemented completely. Only back-end changes were completed. However front-end could not be synced to the back-end. So, there is no way to test it. One can run redis-cli in the terminal and view that "endorsed_by_Instructor" is a field in post object and "endorsed" is a field in topic object

- ***Automated test cases:***
	- We tested if the "endorsed_by_Instructor" is a field in post object and "endorsed" is a field in topic object. We tested it this way, because the front-end logic has not been implemented, hence no functionalilty based testcases were added. The testcase for the presence of field can be found in this file -> test/posts/uploads.js  from lines 417-426 for posts and test/topics/events.js from line 105-114 for topics.


