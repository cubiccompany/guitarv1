<#import "parts/common.ftl" as c>

<@c.page>
    <h5>${username}</h5>
    <form  method="post" class="form-request">
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Password:</label>
            <div class="col-sm-6">
                <input type="password" name="password"  class="form-control" placeholder="Password" />
            </div>
        </div>

        <!--new-->

        <div class="form-group row" >
            <label class="col-sm-2 col-form-label">number:</label>
            <div class="col-sm-6">
                <input type="text" name="number"  placeholder="number" class="form-control" value="${number!''}"/>
            </div>
        </div>

        <!--end new-->
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button class="btn btn-primary" type="submit"> Сохранить </button>
    </form>
</@c.page>