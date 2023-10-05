<div class="clearfix post-header">
    <div class="icon pull-left">
        <a href="<!-- IF posts.user.userslug -->{config.relative_path}/user/{posts.user.userslug}<!-- ELSE -->#<!-- ENDIF posts.user.userslug -->">
            {buildAvatar(posts.user, "sm2x", true, "", "user/picture")}
            <i component="user/status" class="fa fa-circle status {posts.user.status}" title="[[global:{posts.user.status}]]"></i>
        </a>
    </div>

    <small class="pull-left">
        <strong>
            <a href="<!-- IF posts.user.userslug -->{config.relative_path}/user/{posts.user.userslug}<!-- ELSE -->#<!-- ENDIF posts.user.userslug -->" itemprop="author" data-username="{posts.user.username}" data-uid="{posts.user.uid}">{posts.user.displayname}</a>
        </strong>

        <!-- IMPORT partials/topic/badge.tpl -->

        <!-- IF posts.user.banned -->
        <span class="label label-danger">[[user:banned]]</span>
        <!-- ENDIF posts.user.banned -->

        <span class="visible-xs-inline-block visible-sm-inline-block visible-md-inline-block visible-lg-inline-block">
            <!-- IF posts.toPid -->
            <a component="post/parent" class="btn btn-xs btn-default hidden-xs" data-topid="{posts.toPid}" href="{config.relative_path}/post/{posts.toPid}"><i class="fa fa-reply"></i> @<!-- IF posts.parent.username -->{posts.parent.username}<!-- ELSE -->[[global:guest]]<!-- ENDIF posts.parent.username --></a>
            <!-- ENDIF posts.toPid -->

            <span>
                <!-- IF posts.user.custom_profile_info.length -->
                &#124;
                {{{each posts.user.custom_profile_info}}}
                {posts.user.custom_profile_info.content}
                {{{end}}}
                <!-- ENDIF posts.user.custom_profile_info.length -->
            </span>
        </span>

    </small>
    <small class="pull-right">
        <span class="bookmarked"><i class="fa fa-bookmark-o"></i></span>
    </small>
    <small class="pull-right">
        <i component="post/edit-indicator" class="fa fa-pencil-square<!-- IF privileges.posts:history --> pointer<!-- END --> edit-icon <!-- IF !posts.editor.username -->hidden<!-- ENDIF !posts.editor.username -->"></i>

        <small data-editor="{posts.editor.userslug}" component="post/editor" class="hidden">[[global:last_edited_by, {posts.editor.username}]] <span class="timeago" title="{posts.editedISO}"></span></small>

        <span class="visible-xs-inline-block visible-sm-inline-block visible-md-inline-block visible-lg-inline-block">
            <a class="permalink" href="{config.relative_path}/post/{posts.pid}"><span class="timeago" title="{posts.timestampISO}"></span></a>
        </span>
    </small>
</div>

<br />

<div class="content" component="post/content" itemprop="text">
    {posts.content}
</div>

<div class="post-footer">
    {{{ if posts.user.signature }}}
    <div component="post/signature" data-uid="{posts.user.uid}" class="post-signature">{posts.user.signature}</div>
    {{{ end }}}

    <div class="clearfix">
    {{{ if !hideReplies }}}
    <a component="post/reply-count" data-target-component="post/replies/container" href="#" class="threaded-replies no-select pull-left {{{ if !posts.replies.count }}}hidden{{{ end }}}">
        <span component="post/reply-count/avatars" class="avatars {{{ if posts.replies.hasMore }}}hasMore{{{ end }}}">
            {{{each posts.replies.users}}}
            {buildAvatar(posts.replies.users, "xs", true, "")}
            {{{end}}}
        </span>

        <span class="replies-count" component="post/reply-count/text" data-replies="{posts.replies.count}">{posts.replies.text}</span>
        <span class="replies-last hidden-xs">[[topic:last_reply_time]] <span class="timeago" title="{posts.replies.timestampISO}"></span></span>

        <i class="fa fa-fw fa-chevron-right" component="post/replies/open"></i>
        <i class="fa fa-fw fa-chevron-down hidden" component="post/replies/close"></i>
        <i class="fa fa-fw fa-spin fa-spinner hidden" component="post/replies/loading"></i>
    </a>
    {{{ end }}}

    <div class = "encaps-button"><button id = "endorsing" class="endorseButton">Endorse</button></div>
    <! --- The modal pop up --->
    <div class="modal" id="myModal">
        <h2 style="text-align: center; font-style: italic;">Endorse this question ?</h2>
        <br>
        <!-- Checkbox option -->
        <div>
            <label class="checkbox-label">
                <input type="checkbox" id="endorseCheckbox"> Yes
            </label>
        </div>
        <br>
        <!-- Checkbox for "Cancel" -->
        <div>
            <label class="checkbox-label">
                <input type="checkbox" id="cancelCheckbox"> Cancel
            </label>
        </div>
    </div>

    <small class="pull-right">
        <!-- IMPORT partials/topic/reactions.tpl -->
        <span class="post-tools">
            <a component="post/endorse" href="#" id = "endorseButton" class="no-select <!-- IF !privileges.topics:reply -->hidden<!-- ENDIF !privileges.topics:reply -->">Endorse</a>
            <a component="post/reply" href="#" class="no-select <!-- IF !privileges.topics:reply -->hidden<!-- ENDIF !privileges.topics:reply -->">[[topic:reply]]</a>
            <a component="post/quote" href="#" class="no-select <!-- IF !privileges.topics:reply -->hidden<!-- ENDIF !privileges.topics:reply -->">[[topic:quote]]</a>
        </span>

        <!-- IF !reputation:disabled -->
        <span class="votes">
            <a component="post/upvote" href="#" class="<!-- IF posts.upvoted -->upvoted<!-- ENDIF posts.upvoted -->">
                <i class="fa fa-chevron-up"></i>
            </a>

            <span component="post/vote-count" data-votes="{posts.votes}">{posts.votes}</span>

            <!-- IF !downvote:disabled -->
            <a component="post/downvote" href="#" class="<!-- IF posts.downvoted -->downvoted<!-- ENDIF posts.downvoted -->">
                <i class="fa fa-chevron-down"></i>
            </a>
            <!-- ENDIF !downvote:disabled -->
        </span>
        <!-- ENDIF !reputation:disabled -->

        <!-- IMPORT partials/topic/post-menu.tpl -->
    </small>
    </div>
    <div component="post/replies/container"></div>
    <div>
    <style>
        .endorseButton {
            display: inline-block;
            padding: 8px 18px;
            background-color: white; /* Default blue color */
            color: #000000;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .endorseButton:hover {
            background-color: #555; /* Grey color on hover */
        }
        .encaps-button {
            text-align: right;
            margin-top: 20px;
        }
        .endorseButton.red {
            background-color: #ff0000; /* Red color when set with the 'red' class */
        }
        .checkbox-label {
            text-align: center;
        }
        .modal h2 {
            margin-bottom: 10px;
        }
        .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            width: 350px; /* Adjust the width as needed */
            height: 200px; /* Adjust the height as needed */
            padding: 20px;
            border: 2px solid #000; /* Black outline */
            border-radius: 5px;
            z-index: 2;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
        }
        .endorseButton {
            display: inline-block;
            padding: 8px 18px;
            background-color: white; /* Default blue color */
            color: #000000;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .endorseButton:hover {
            background-color: #555; /* Grey color on hover */
        }
        .encaps-button {
            text-align: right;
            margin-top: 20px;
        }
        .endorseButton.red {
            background-color: #ff0000; /* Red color when set with the 'red' class */
        }
    </style>
    <script>
        // variable that assigns the status of endorsed to false
        let endorseStat = false;
        // Store the original button text and class
        const endorseButtonText = document.getElementById("endorsing").textContent;
        const endorseButtonClass = document.getElementById("endorsing").className;
        const button = document.getElementById("endorsing");
        button.addEventListener("click", function(){
            document.getElementById("myModal").style.display = "block";
        });
        function closeModal() {
            document.getElementById("myModal").style.display = "none";
        }
        document.getElementById("endorseCheckbox").addEventListener("change", function () {
                if (this.checked) {
                    // if the checkbox is pressed the status of the resolve becomes true
                    endorseStatus = true;
                    // If the Checkbox is checked
                    document.getElementById("endorsing").textContent = "Someone thinks this is a good response!";
                    document.getElementById("endorsing").classList.add("red");
                    document.getElementById("endorsing").disabled = true;
                    localStorage.setItem(`topic:${tid}_endorsed`, 'true');
                    updateButtonAppearance(tid); 
                    // Send an HTTP GET request to a URL formed by appending "/isResolved" to the current page's URL
                    fetch(window.location.href + "/isEndorsed", {
                        method: 'GET', 
                            headers: {
                            'Accept': 'application/json', 
                            'Content-Type': 'application/json' 
                            }
                    })
                    .then(response => response.json()) 
                    .then(data => {
                        // Handle the response from the server if needed
                        console.log(data); 
                    })
                    .catch(error => {
                        console.error('Error:', error); // Log the error to the console
                    });
                    closeModal();
                }
        });
        document.getElementById("cancelCheckbox").addEventListener("change", function () {
            if (this.checked) {
                document.getElementById("endorsing").textContent = endorseButtonText;
                document.getElementById("myButton").className = endorseButtonClass;
                document.getElementById("myButton").disabled = false;
                closeModal(); 
            }
        });
        function isPostEndorsed(tid) {
            return localStorage.getItem(`topic:${tid}_resolved`) === 'true';
        }

        // Function to update the button appearance based on the resolved state of a question
        function updateButtonAppearance(tid) {
            const button = document.getElementById('endorsing');
            if (isPostEndorsed(tid)) {
                button.textContent = "Someone thinks this is a good response";
                button.classList.add("red");
                button.disabled = true;
            } else {
                button.textContent = endorseButtonText;
                button.className = endorseButtonClass;
                button.disabled = false;
            }
        }

    </script>
    </div>
</div>