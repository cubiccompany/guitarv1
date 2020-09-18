<#include "security.ftl">

<div class="card-columns">
    <#list ads as ad>

            <div class="card my-3">
                <#if ad.filename??>
                    <img src="static/images/${ad.filename}" class="card-img-top" alt="...">
                </#if>
                <div class="m-2">
                    <span>${ad.text}</span><br>
                    <i>#${ad.tag}</i>

                </div>
                <div class="card-footer text-muted">
                    <a href="/user-add/${ad.author.id}">${ad.authorName}</a>
                    <#if ad.author.id == currentUserId>
                        <a class="btn btn-primary" href="/user-add/${ad.author.id}?ad=${ad.id}">
                            Изменить
                        </a>
                    </#if>
                </div>
            </div>
    <#else>
        No ad
    </#list>
</div>