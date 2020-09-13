<#import "parts/common.ftl" as c>

<@c.page>
    <#if add.filename??>
        <img src="/static/images/${add.filename}" class="rounded mx-auto d-block" alt="...">
    </#if>
    <div class="d-flex justify-content-center" class="mx-auto">
        <span>${add.text}</span>
        <i>${add.tag}</i>
    </div>
    <div class="d-flex justify-content-center" class="mx-auto">
        ${add.authorName}
        ${add.number}
    </div>
</@c.page>