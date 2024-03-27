<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--TODO: After Friends & Groups are implemented, further development of this page will have to be done
          to support interactions with those objects--%>
<html>
<head>
    <title>MUIC Talk</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../styles/styles.css">
</head>
<body>
<div class="container mt-4">
    <nav class="navbar navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand"><strong>MUIC Talk</strong></a>
            <div>
                <a class="btn btn-primary" type="button" href="/"><i class="fa fa-home"></i> &nbsp; Home </a>
                <a class="btn btn-primary" type="button" href="/"><i class="fa fa-calendar"></i> &nbsp; Schedule </a>
                <a class="btn btn-primary" type="button" href="/chat"><i class="fa fa-comments"></i> &nbsp; Chats </a>
            </div>
            <div>
                <a class="btn btn-primary btn-w40" type="button" href="/logout"><i class="fa fa-sign-out"></i></a>
            </div>
        </div>
    </nav>
    <nav class="navbar navbar-light">
        <div class="container-fluid">
            <div class="user-profile pull-left">
                <img src="../Images/default_img.png" class="circle" alt="User profile picture">
                <p><strong>${displayname}</strong> <br> ${username}</p>
            </div>
            <div class="pull-right">
                <a class="btn btn-primary btn-w40" type="button" href="/user/edit"><i class="fa fa-cog"></i></a>
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
                <tr style="vertical-align: middle;">
                    <td><h3><strong>Groups</strong></h3></td>
                    <td style="padding-right: 12px">
                        <div class="container-fliud pull-right">
                            <a class="btn btn-primary btn-w40" type="button" href="/"><i class="fa fa-plus"></i></a>
                            <a class="btn btn-primary btn-w40" type="button" href="/"><i class="fa fa-pencil"></i></a>
                        </div>
                    </td>
                </tr>
                <tr style="height: 100px;">
                    <c:if test="${empty groups}">
                        <td style="vertical-align: middle;" colspan="100%"><p>You're not in any groups! :(</p></td>
                    </c:if>
                    <c:if test="${not empty groups}">
                        <td colspan="100%">
                            <table class="table">
                                <tbody>
                                <c:forEach var="group" items="${groups}">
                                    <tr>
                                        <td>${group}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </td>
                    </c:if>
                </tr>
                <tr style="vertical-align: middle;">
                    <td><h3><strong>Friends</strong></h3></td>
                    <td style="padding-right: 12px">
                        <div class="container-fliud pull-right">
                            <button class="btn btn-primary btn-w40" type="button"
                                    data-bs-toggle="modal" data-bs-target="#add-friend">
                                <i class="fa fa-plus"></i>
                            </button>
<%--                            Pop up for adding friends--%>
                            <div class="modal fade" id="add-friend" tabindex="-1"
                                 aria-labelledby="exampleModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="exampleModalLabel">Add Friend</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                        </div>

                                        <div class="modal-body my-4">
                                            <form action="/user/add" method="post">
                                                <div class="input-group mb-4 input-group-md">
                                                    <span class="input-group-text" id="friendUser" style="width: 40px"><i class="fa fa-user"></i></span>
                                                    <input type="text" class="form-control py-2"
                                                           name="friendUser" placeholder="uXXXXXXX"
                                                           aria-label="Friend Username" aria-describedby="friendUser"
                                                           autocomplete="off">
                                                </div>
                                                <div class="modal-footer d-grid gap-2">
                                                    <button class="btn btn-primary" type="submit" ><i class="fa fa-save"></i> &nbsp; Add</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
<%--                            <a class="btn btn-primary btn-w40" type="button" href="/"><i class="fa fa-plus"></i></a>--%>
                            <a class="btn btn-primary btn-w40" type="button" href="/"><i class="fa fa-pencil"></i></a>
                        </div>
                    </td>
                </tr>
                <tr style="height: 100px;">
                    <c:if test="${empty friends}">
                        <td style="vertical-align: middle;" colspan="100%"><p>You don't have any friends! :(</p></td>
                    </c:if>
                    <c:if test="${not empty friends}">
                        <td colspan="100%">
                            <table class="table">
                                <tbody>
                                <c:forEach var="friend" items="${friends}">
                                    <tr>
                                        <td>${friend.username}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </td>
                    </c:if>
                </tr>
            </table>
        </div>
    </div>
</div>
</body>
</html>
