<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<html>
<head>
    <title>规则组修改</title>
</head>
<body>
<form id="modifyGroupform" method="post" data-parsley-validate class="form-horizontal">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden"  name="id" value="${group.id}"/>
  <div class="wrapper wrapper-content animated fadeInRight ecommerce">
    <div class="ibox-content   float-e-margins">
        <div class="row">
            <div class="form-group">
              <label class="col-sm-2 control-label " >规则组名称:</label>
              <div class="col-sm-3 m-b">
                <input class="form-control " type="text" id="groupname" name="groupname" value="${group.groupname}" required>
              </div>
            </div>
        </div>
        <div class="row">
            <div class="form-group">
              <label class="col-sm-2 control-label" >规则类型:</label>
              <div class="col-sm-3 m-b">
                  <dict:select dictcode="category" id="grouptype" name="grouptype"  nullLabel="请选择" nullOption="true" cssClass="form-control" value="${group.grouptype}"></dict:select>
              </div>
            </div>
        </div>
        <div class="row">
            <div class="form-group">
              <label class="col-sm-2 control-label" >生效时间:</label>
              <div class="col-sm-3 m-b">
                  <input type="text" name="effdate"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="form-control Wdate" id="effdate" value="${group.effdate}" required />
              </div>
            </div>
        </div>
        <div class="row">
            <div class="form-group">
              <label class="col-sm-2 control-label" >失效时间:</label>
              <div class="col-sm-3 m-b">
                  <input type="text" name="expdate"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="form-control Wdate" id="expdate" value="${group.expdate}" required />
              </div>
            </div>
        </div>
        <div class="row">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="status">状态:</label>
                <div class="col-sm-3">
                    <dict:select dictcode="status" id="status" name="status" escapeValue="02,03,99,04,05" nullLabel="请选择" nullOption="true" cssClass="form-control" value="${group.status}"></dict:select>
                </div>
            </div>
        </div>
        <c:if test="${rolename=='SUPERMODIFIER'||rolename=='MODIFIER'}">
        <div class="row">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="channel">渠道产品:</label>
                <div class="col-sm-7">
                    <div class="panel panel-default panel-body" id="channel">
                        <c:forEach items="${list}" var="channel" varStatus="all" >
                            <input type="hidden" name="channels[${all.index}].channelCode" value="${channel.dictionaryCode.code}" >
                            <a data-toggle="collapse" href="#faq${channel.dictionaryCode.code}" aria-expanded="true">
                                    ${channel.dictionaryCode.name}
                            </a>
                            <div id="faq${channel.dictionaryCode.code}" class="panel-collapse collapse">
                                <div class="faq-answer">
                                    <table>
                                        <tbody>
                                        <c:forEach items="${channel.dictionaryCodes}" var="dic" varStatus="i">
                                            <c:if test="${i.count%8==0}">
                                                <tr>
                                            </c:if>
                                            <td>
                                                <input type="checkbox" name="channels[${all.index}].mercCode" value="${dic.code}"  <c:if test="${dic.dictname=='1'}">checked</c:if> thirdFlag="${channel.dictionaryCode.code}"" disabledFlag>${dic.name}
                                            </td>
                                            <c:if test="${i.count%8==0}">
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            </c:if>

        <div class="row query-div">
          <input type="button" id="submitAdd" class="btn btn-w-m btn-success" value="修改">&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="button" id="back" class="btn btn-w-m btn-default" value="取消">
        </div>
      </div>
    </div>
  </div>
</form>
</body>
<div id="siteMeshJavaScript">
  <script type="text/javascript" >
      var csrfToken="${_csrf.token}";
      var csrfHeaderName="${_csrf.headerName}";
      $(function(){
          $("#submitAdd").click(function(){
            subRuleAdd();
          });
          $("#back").click(function(){
              window.location.href="${ctxPath}/group/toQueryGroup";
          });
      });

      function subRuleAdd(){
          var initparsley=$("#modifyGroupform").parsley();
          $("#modifyGroupform").ajaxSubmit({
              type:'post',
              dataType: 'json',
              beforeSubmit:function(){
                  return initparsley.validate();
              },
              url: '${ctxPath}/api/1/group/updateGroup',
              success: function(data,textStatus,jqXHR){
                  if(data.code==200){
                      bootbox.alert("修改成功！", function () {
                          window.location.href="${ctxPath}/group/toQueryGroup";
                      });
                  }else{
                      bootbox.alert("修改失败！");
                  }
              }
          });
      }
      $("input[thirdFlag]").click(function(){
          if($(this).is(":checked")){
              var checkid = $(this).attr("thirdFlag");
              $("input[thirdFlag]").each(function (){
                  if($(this).attr("thirdFlag")!=checkid){
                      $(this).attr("checked",false);
                  }
              });
          }
      });
  </script>
</div>
</html>
