<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>MUIC Talk</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <style>
        .circle {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .user-profile {
            display: grid;
            align-items: center;
            grid-template-columns: 1fr 1fr 1fr;
            column-gap: 5px;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <nav class="navbar navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand"><strong>MUIC Talk</strong></a>
            <div class="container-fliud pull-left">
                <a class="btn btn-gray" type="button" href="/"><i class="fa fa-home"></i> &nbsp; Home </a>
                <a class="btn btn-gray" type="button" href="/"><i class="fa fa-calendar"></i> &nbsp; Schedule </a>
                <a class="btn btn-gray" type="button" href="/"><i class="fa fa-comments"></i> &nbsp; Chats </a>
            </div>
            <div class="container-fliud pull-right">
                <a class="btn btn-gray" type="button" href="/"><i class="fa fa-bars"></i> &nbsp; Settings</a>
                <a class="btn btn-gray" type="button" href="/"><i class="fa fa-sign-out"></i> &nbsp; Logout</a>
            </div>
        </div>
    </nav>
    <nav class="navbar navbar-light">
        <div class="container-fluid">
            <div class="user-profile pull-left">
                <img src="../Images/default_img.png" class="circle" alt="Default profile picture">
                <p><strong>${displayname}</strong> <br> ${username}</p>
            </div>
        </div>
    </nav>
    <div class="row">
        <div class="col-12">
            <c:if test="${not empty message}">
                <c:choose>
                    <c:when test="${hasError}">
                        <div class="alert alert-danger" role="alert">
                                ${message}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-success" role="alert">
                                ${message}
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <table class="table">
                <tr>
                    <td><h3><strong>Groups</strong></h3></td>
                    <td style="width: 15%;"> <a class="btn btn-gray" type="button" href="/" title="Join Groups"><i class="fa fa-plus"></i> &nbsp; Join Groups</a>  </td>
                    <td style="width: 15%;"> <a class="btn btn-gray" type="button" href="/" title="Edit Groups"><i class="fa fa-pencil"></i> &nbsp; Edit Groups</a>  </td>
                </tr>
                <tr style="height: 100px;">
                    <td style="vertical-align: middle;"><p>You're not in any groups! :(</p></td>
                </tr>
                <tr>
                    <td><h3><strong>Friends</strong></h3></td>
                    <td style="width: 15%;"> <a class="btn btn-gray" type="button" href="/" title="Add Friends"><i class="fa fa-user-plus"></i> &nbsp; Add Friends</a>  </td>
                    <td style="width: 15%;"> <a class="btn btn-gray" type="button" href="/" title="Edit Friends"><i class="fa fa-pencil"></i> &nbsp; Edit Friends</a>  </td>
                </tr>
                <tr style="height: 100px;">
                    <td style="vertical-align: middle;"><p>You have no friends! :(</p></td>
                </tr>
            </table>
        </div>
    </div>
</div>
</body>
</html>