<ul component="posts" class="posts-list" data-nextstart="{nextStart}">
    {{{each posts}}}
        {{{if !../isPublic}}}
            <!-- IMPORT partials/posts_list_item.tpl -->
        {{{end}}}
    {{{end}}}
</ul>
<div component="posts/loading" class="loading-indicator text-center hidden">
    <i class="fa fa-refresh fa-spin"></i>
</div>