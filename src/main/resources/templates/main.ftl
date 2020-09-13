<#import "parts/common.ftl" as c>

<@c.page>
    <div class="form-row">
        <div class="form-group col-md-6">
            <form method="get" action="/main" class="form-inline">
                <input type="text" name="filter" class="form-control" value="${filter?ifExists}" placeholder="Search by tag">
                <button type="submit" class="btn btn-primary ml-2">Search</button>
            </form>
        </div>
    </div>

    <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
        Добавить объявление
    </a>
    <div class="collapse" id="collapseExample">
        <div class="form-group mt-3">
            <form method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <input type="text" class="form-control" name="text" placeholder="Введите описание" />
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" name="tag" placeholder="Тэг">
                </div>
                <!--new-->
                <div class="form-group">
                    <input type="text" class="form-control" name="number" placeholder="Номер">
                </div>
                <div class="form-group">
                    <div class="custom-file">
                        <input type="file" name="file" id="customFile">
                        <label class="custom-file-label" for="customFile">Добавить изображение</label>
                    </div>
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Добавить</button>
                </div>
            </form>
        </div>
    </div>

    <div class="card-columns">
        <#list ads as ad>
            <a href="/add/${ad.id}">
                <div class="card my-3">
                    <#if ad.filename??>
                        <img src="static/images/${ad.filename}" class="card-img-top" alt="1">
                    </#if>
                    <div class="m-2">
                        <span>${ad.text}</span>
                        <i>${ad.tag}</i>

                    </div>
                    <div class="card-footer text-muted">
                        ${ad.authorName}
                    </div>
                </div>
            </a>
        <#else>
            No ad
        </#list>
    </div>
</@c.page>