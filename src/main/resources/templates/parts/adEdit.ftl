
<a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
    Добавить оъявление
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

            <div class="form-group">
                <div class="custom-file">
                    <input type="file" name="file" id="customFile">
                    <label class="custom-file-label" for="customFile">Добавить изображение</label>
                </div>
            </div>

            <!--new-->
            <div class="form-group">
                <input type="tel" id="phone" maxlength="11" class="form-control" name="number" placeholder="8999 999 99 99"/>
            </div>

            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <input type="hidden" name="id" value="<#if ad??>${ad.id}</#if>" />
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Сохранить</button>
            </div>
        </form>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquere/3.2.1/jquery.min.js"></script>
<script src="static/js/jquery.maskedinput.min.js"></script>
<script>
    $(document).ready(function () {
        $("#phone").mask("+7 (999) 999-99-99")
    })
</script>