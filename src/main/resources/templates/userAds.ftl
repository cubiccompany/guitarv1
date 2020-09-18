<#import "parts/common.ftl" as c>


<@c.page>
    <#if isCurrentUser>
    <#include "parts/adEdit.ftl" />
    </#if>

    <#include "parts/adList.ftl" />
</@c.page>