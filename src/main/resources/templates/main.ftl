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
    <div class="collapse <#if ad??>show</#if>" id="collapseExample">
        <div class="form-group mt-3">
            <form method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <input type="text" class="form-control ${(textError??)?string('is-invalid', '')}"
                           value="<#if ad??>${ad.text}</#if>" name="text" placeholder="Введите описание" />
                    <#if textError??>
                        <div class="invalid-feedback">
                            ${textError}
                        </div>
                    </#if>
                </div>
                <div class="form-group">
                    <input type="text" class="form-control"
                           value="<#if ad??>${ad.tag}</#if>" name="tag" placeholder="Тэг">
                    <#if tagError??>
                        <div class="invalid-feedback">
                            ${tagError}
                        </div>
                    </#if>
                </div>
                <!--new-->
                <div class="form-group">
                        <input type="tel" id="phone" maxlength="11" class="form-control" name="number" placeholder="8999 999 99 99"/>
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

    <script src="https://ajax.googleapis.com/ajax/libs/jquere/3.2.1/jquery.min.js"></script>
    <script src="static/js/jquery.maskedinput.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#phone").mask("+7 (999) 999-99-99")
        })
    </script>
</@c.page>